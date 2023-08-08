---------------------------------------------------------------------------------------------------------------------------------
--QUERY 01: TOTAL SESSIONS BY BROWSER
---------------------------------------------------------------------------------------------------------------------------------

SELECT 
  browser, 
  COUNT(session_id) AS total_session
FROM `bigquery-public-data.thelook_ecommerce.events`
WHERE sequence_number = 1 AND created_at BETWEEN PARSE_TIMESTAMP('%Y-%m-%d','2022-08-01') AND PARSE_TIMESTAMP('%Y-%m-%d','2023-08-01')
GROUP BY 1
ORDER BY total_session DESC


---------------------------------------------------------------------------------------------------------------------------------
--QUERY 02.1: BOUNCE RATE BY VISITOR TYPE
---------------------------------------------------------------------------------------------------------------------------------

--query sessions that begin within in the time frame by visitor type
WITH a AS 
(SELECT
  session_id,
  CASE WHEN user_id IS NULL THEN 'guest' ELSE 'member' END AS visitor_type,
  CASE WHEN MAX(sequence_number) = 1 THEN 'Yes' ELSE 'No' END AS is_bounce
FROM `bigquery-public-data.thelook_ecommerce.events`
GROUP BY 1,2
HAVING MIN(created_at) BETWEEN PARSE_TIMESTAMP('%Y-%m-%d','2022-08-01') AND PARSE_TIMESTAMP('%Y-%m-%d','2023-08-01'))

--query total session, bounce session, bounce rate by visitor type by month
SELECT
  visitor_type, 
  COUNT(session_id) AS total_session,
  SUM(CASE WHEN is_bounce = 'Yes' THEN 1 ELSE 0 END) AS bounce_session, 
  ROUND(
    SAFE_DIVIDE(
      SUM(CASE WHEN is_bounce = 'Yes' THEN 1 ELSE 0 END), COUNT(session_id))
  ,4) AS bounce_rate
FROM a
GROUP BY 1


---------------------------------------------------------------------------------------------------------------------------------
--QUERY 02.2: BOUNCE RATE BY TRAFFIC SOURCE
---------------------------------------------------------------------------------------------------------------------------------

--query sessions that begin within in the time frame by traffic source 
WITH a AS 
(SELECT
  session_id,
  traffic_source, 
  CASE WHEN MAX(sequence_number) = 1 THEN 'Yes' ELSE 'No' END AS is_bounce
FROM `bigquery-public-data.thelook_ecommerce.events`
GROUP BY 1,2
HAVING MIN(created_at) BETWEEN PARSE_TIMESTAMP('%Y-%m-%d','2022-08-01') AND PARSE_TIMESTAMP('%Y-%m-%d','2023-08-01'))

--query total session, bounce session, bounce rate by traffic source by month
SELECT
  traffic_source, 
  COUNT(session_id) AS total_session,
  SUM(CASE WHEN is_bounce = 'Yes' THEN 1 ELSE 0 END) AS bounce_session, 
  ROUND(
    SAFE_DIVIDE(
      SUM(CASE WHEN is_bounce = 'Yes' THEN 1 ELSE 0 END), COUNT(session_id)),
  4) AS bounce_rate
FROM a
GROUP BY 1


---------------------------------------------------------------------------------------------------------------------------------
--QUERY 02.3: BOUNCE RATE BY BROWSER
---------------------------------------------------------------------------------------------------------------------------------

--query sessions that begin within in the time frame by browser
WITH a AS 
(SELECT
  session_id,
  browser,
  CASE WHEN MAX(sequence_number) = 1 THEN 'Yes' ELSE 'No' END AS is_bounce
FROM `bigquery-public-data.thelook_ecommerce.events`
GROUP BY 1,2
HAVING MIN(created_at) BETWEEN PARSE_TIMESTAMP('%Y-%m-%d','2022-08-01') AND PARSE_TIMESTAMP('%Y-%m-%d','2023-08-01'))

--query total session, bounce session, bounce rate by browser by month
SELECT
  browser, 
  COUNT(session_id) AS total_session,
  SUM(CASE WHEN is_bounce = 'Yes' THEN 1 ELSE 0 END) AS bounce_session, 
  ROUND(
    SAFE_DIVIDE(
      SUM(CASE WHEN is_bounce = 'Yes' THEN 1 ELSE 0 END), COUNT(session_id)),
  4) AS bounce_rate
FROM a
GROUP BY 1


---------------------------------------------------------------------------------------------------------------------------------
--QUERY 03: EVENT TYPE OF BOUNCE SESSIONS
---------------------------------------------------------------------------------------------------------------------------------

--query all bounce sessions that occur within the time frame
WITH a AS
(SELECT
  session_id
FROM `bigquery-public-data.thelook_ecommerce.events`
GROUP BY 1
HAVING MAX(sequence_number) = 1 AND MIN(created_at) BETWEEN PARSE_TIMESTAMP('%Y-%m-%d','2022-08-01') AND PARSE_TIMESTAMP('%Y-%m-%d','2023-08-01'))

--query event type of bounce session
SELECT
  event_type,
  COUNT(session_id) AS total_bounce_session 
FROM `bigquery-public-data.thelook_ecommerce.events`
WHERE session_id IN (SELECT session_id FROM a)
GROUP BY 1
ORDER BY 2 DESC


---------------------------------------------------------------------------------------------------------------------------------
--QUERY 04: TOTAL SESSIONS, PURCHASE SESSIONS AND CONVERSION RATE BY TRAFFIC SOURCE
---------------------------------------------------------------------------------------------------------------------------------

--query total sessions by traffic source, based on begin time
WITH a AS
(SELECT 
  traffic_source, 
  COUNT(session_id) AS total_session
FROM `bigquery-public-data.thelook_ecommerce.events`
WHERE sequence_number = 1 AND created_at BETWEEN PARSE_TIMESTAMP('%Y-%m-%d','2022-08-01') AND PARSE_TIMESTAMP('%Y-%m-%d','2023-08-01')
GROUP BY 1),

--query purchase sessions in the time frame, based on session begin time
b AS 
(SELECT 
  traffic_source, 
  COUNT(session_id) As purchase_session
FROM `bigquery-public-data.thelook_ecommerce.events`
WHERE event_type= 'purchase' AND session_id IN
  (SELECT session_id
  FROM `bigquery-public-data.thelook_ecommerce.events`
  GROUP BY 1
  HAVING MIN(created_at) BETWEEN PARSE_TIMESTAMP('%Y-%m-%d','2022-08-01') AND PARSE_TIMESTAMP('%Y-%m-%d','2023-08-01'))
GROUP BY 1)

--query total sessions, total purchase session and conversion rate by traffic source
SELECT 
  a.traffic_source, 
  a.total_session, 
  b.purchase_session, 
  ROUND(SAFE_DIVIDE(b.purchase_session, a.total_session), 4) AS conversion_rate
FROM a JOIN b ON a.traffic_source = b.traffic_source
ORDER BY 2 DESC


---------------------------------------------------------------------------------------------------------------------------------
--QUERY 05: NUMBER OF SESSIONS THOUGHOUT PURCHASE PROCESS
---------------------------------------------------------------------------------------------------------------------------------

--query the number of event: product, cart and purchase of all distinct sessions 
WITH cte AS 
(SELECT 
  session_id,
  MIN(created_at) AS session_begin,
  SUM(CASE WHEN event_type = 'product' THEN 1 ELSE 0 END) AS view_product,
  SUM(CASE WHEN event_type = 'cart' THEN 1 ELSE 0 END) AS add_to_cart,
  SUM(CASE WHEN event_type = 'purchase' THEN 1 ELSE 0 END) AS purchase
FROM `bigquery-public-data.thelook_ecommerce.events`
GROUP BY 1
HAVING MIN(created_at) BETWEEN PARSE_TIMESTAMP('%Y-%m-%d','2022-08-01') AND PARSE_TIMESTAMP('%Y-%m-%d','2023-08-01') )

--query the number of sessions that view product, add product to cart and purchase, calculate cart abandonment rate and conversion rate by month
SELECT 
  FORMAT_TIMESTAMP('%Y-%m', session_begin) AS date,
  COUNT(DISTINCT session_id) AS total_session,
  SUM(CASE WHEN view_product > 0 THEN 1 ELSE 0 END) AS session_view_product,
  SUM(CASE WHEN add_to_cart > 0 THEN 1 ELSE 0 END) AS session_add_to_cart,
  SUM(CASE WHEN purchase > 0 THEN 1 ELSE 0 END) AS session_purchase,
  ROUND(
    SAFE_DIVIDE(
      (SUM(CASE WHEN add_to_cart > 0 THEN 1 ELSE 0 END) - SUM(CASE WHEN purchase > 0 THEN 1 ELSE 0 END)),
      SUM(CASE WHEN add_to_cart > 0 THEN 1 ELSE 0 END)),
  4) AS cart_abandonment_rate,
  ROUND(
    SAFE_DIVIDE(
      SUM(CASE WHEN purchase > 0 THEN 1 ELSE 0 END),
      COUNT(DISTINCT session_id)),
  4) AS conversion_rate
FROM cte
GROUP BY 1
ORDER by 1


---------------------------------------------------------------------------------------------------------------------------------
--QUERY 06:  SESSION DURATION (BY VISITOR TYPE) IN MINUTES
---------------------------------------------------------------------------------------------------------------------------------
SELECT 
    session_id,
    CASE WHEN user_id IS NULL THEN 'guest' ELSE 'member' END AS visitor_type,
    DATE_DIFF(MAX(created_at), MIN(created_at), MINUTE) AS session_duration_mins
FROM `bigquery-public-data.thelook_ecommerce.events`
GROUP BY 1,2
HAVING MIN(created_at) BETWEEN PARSE_TIMESTAMP('%Y-%m-%d','2022-08-01') AND PARSE_TIMESTAMP('%Y-%m-%d','2023-08-01')


---------------------------------------------------------------------------------------------------------------------------------
--QUERY 07: TIME SPENT ON EACH EVENT 
---------------------------------------------------------------------------------------------------------------------------------

--query the event duration (amount of time between when that event occurs and the time the following event takes place), excluding event of bounce session.
WITH a AS
(SELECT 
  session_id,
  sequence_number,
  CASE WHEN user_id IS NULL THEN 'guest' ELSE 'member' END AS visitor_type,
  LAG(event_type,1) OVER (PARTITION BY session_id ORDER BY created_at) AS event_type, 
  DATE_DIFF(created_at, LAG(created_at,1) OVER (PARTITION BY session_id ORDER BY created_at), SECOND) AS event_duration_sec
FROM `bigquery-public-data.thelook_ecommerce.events`
WHERE created_at BETWEEN PARSE_TIMESTAMP('%Y-%m-%d','2022-08-01') AND PARSE_TIMESTAMP('%Y-%m-%d','2023-08-01')
AND session_id NOT IN 
  (SELECT session_id 
  FROM `bigquery-public-data.thelook_ecommerce.events`
  GROUP BY 1
  HAVING MAX(sequence_number) = 1 AND MIN(created_at) BETWEEN PARSE_TIMESTAMP('%Y-%m-%d','2022-08-01') AND PARSE_TIMESTAMP('%Y-%m-%d','2023-08-01'))
ORDER BY 1,2)

--query the average time spent on home, department, product and cart, by visitor type
SELECT 
  visitor_type,
  ROUND(AVG(CASE WHEN event_type = 'home' THEN event_duration_sec ELSE 0 END),2) AS time_on_home,
  ROUND(AVG(CASE WHEN event_type = 'department' THEN event_duration_sec ELSE 0 END),2) AS time_on_department,
  ROUND(AVG(CASE WHEN event_type = 'product' THEN event_duration_sec ELSE 0 END),2) AS time_on_product,
  ROUND(AVG(CASE WHEN event_type = 'cart' THEN event_duration_sec ELSE 0 END),2) AS time_on_cart
FROM a
GROUP BY 1


---------------------------------------------------------------------------------------------------------------------------------
--Query 08:  NUMBER OF PRODUCTS VIEWED IN SESSIONS THAT HAVE PRODUCT VIEW EVENT
---------------------------------------------------------------------------------------------------------------------------------

--query the number of product viewed of each session begin within the time frame
WITH a AS 
(SELECT 
  session_id,
  COUNT(uri) AS product_num
FROM `bigquery-public-data.thelook_ecommerce.events`
WHERE event_type = 'product'
GROUP BY 1
HAVING MIN(created_at) BETWEEN PARSE_TIMESTAMP('%Y-%m-%d','2022-08-01') AND PARSE_TIMESTAMP('%Y-%m-%d','2023-08-01'))

--query the total session by the number of products viewed
SELECT
  product_num, 
  COUNT(session_id) AS session_num
FROM a
GROUP BY 1
ORDER BY 1

---------------------------------------------------------------------------------------------------------------------------------
--QUERY 09:  NUMBER OF PRODUCTS ADDED INTO CART IN SESSIONS THAT HAVE ADD INTO CART EVENT
---------------------------------------------------------------------------------------------------------------------------------

--query the number of add to cart event of each session begin within the time frame
WITH a AS 
(SELECT 
  session_id,
  COUNT(session_id) AS items_in_cart
FROM `bigquery-public-data.thelook_ecommerce.events`
WHERE event_type = 'cart'
GROUP BY 1
HAVING MIN(created_at) BETWEEN PARSE_TIMESTAMP('%Y-%m-%d','2022-08-01') AND PARSE_TIMESTAMP('%Y-%m-%d','2023-08-01'))

--query the total session by the number of items added in cart
SELECT
  items_in_cart, 
  COUNT(session_id) AS session_num
FROM a
GROUP BY 1
ORDER BY 1

---------------------------------------------------------------------------------------------------------------------------------
--QUERY 10:  TOTAL PURCHASES PER USER THAT MADE (A) PURCHASE(S)
---------------------------------------------------------------------------------------------------------------------------------

--query all sessions that occur within the time frame, based on session begin time
WITH a AS
(SELECT 
  session_id
FROM `bigquery-public-data.thelook_ecommerce.events`
GROUP BY 1
HAVING MIN(created_at) BETWEEN PARSE_TIMESTAMP('%Y-%m-%d','2022-08-01') AND PARSE_TIMESTAMP('%Y-%m-%d','2023-08-01')),

--query the total purchase(s) per user who made (a) purchase(s)
b AS
(SELECT 
  user_id, 
  COUNT(session_id) AS total_purchase
FROM `bigquery-public-data.thelook_ecommerce.events`
WHERE session_id IN (SELECT session_id FROM a) AND event_type = 'purchase'
GROUP BY 1)

--query the number of users by total purchase times
SELECT 
  total_purchase, 
  COUNT(user_id) AS user_num
FROM b 
GROUP BY 1
ORDER BY 1