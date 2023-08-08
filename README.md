# [SQL - BigQuery - Google Sheets] theLook eCommerce - How to increase website conversion rate?

## I. Introduction

This project aims to explore data by using SQL on [Google BigQuery](https://cloud.google.com/bigquery), quick visualize data by using Google Sheet, draw significant insights and give recommendations for the business question: ***How to increase the website conversion rate?***


## II. Dataset Access

The dataset is [theLook eCommerce](https://console.cloud.google.com/marketplace/product/bigquery-public-data/thelook-ecommerce), stored on BigQuery Public Data. TheLook is a fictitious eCommerce clothing site developed by the [Looker](https://cloud.google.com/looker?hl=en_US) team.  The contents of this dataset are synthetic, and are provided to industry practitioners for the purpose of product discovery, testing, and evaluation.

 To access the dataset, follow these steps:
* Log in to your Google Cloud Platform account and create a new project.
* Navigate to the BigQuery console and select your newly created project.
* In the navigation panel, select "Add Data", scroll down to "Additional Sources", select "Public Datasets".
* Search for **"theLook eCommerce"**, then select "View Dataset" . The public project `bigquery-public-data` will appear on the navigation panel, click toggle node to display all the datasets and find **"theLook eCommerce"** dataset.
* Click toggle node next to the dataset and choose **"events"** table to open it.

## III. Analysis

In this project, I will explore data from the last 12 months, from **Aug 2022** to **Jul 2023**. All sessions calculation are based on **session begin time**.

### QUERY #01: Total Sessions by browser

* SQL code

![image](https://github.com/mytrannn22/Increase-website-conversion-rate/assets/140190425/eb0e1c33-247a-46a8-8062-ae627d2f0c1b)

* Query results

![image](https://github.com/mytrannn22/Increase-website-conversion-rate/assets/140190425/a156bcf2-f778-48ed-9c26-0c8760cc9374)

![image](https://github.com/mytrannn22/Increase-website-conversion-rate/assets/140190425/0cc5db03-7f44-436a-960e-0c6e415d3d70)

**Insight:** Chrome is by far the most popular browser.

**Recommendation:** We should prioritize Chrome on the improvement of website compatibility and performance, and focus marketing efforts on it to ensure that the website is accessible to as many users as possible.

### QUERY #02.1: Bounce Rate by Visitor Type
Bounce rate is the percentage of visitors who leave the website after viewing only one page. It is calculated by dividing the number of single-page sessions (max sequence number = 1) by the total number of sessions. This metric indicates how well the website is meeting the needs of visitors.

* SQL code

![image](https://github.com/mytrannn22/Increase-website-conversion-rate/assets/140190425/c2dd3aba-75b8-4976-9d61-93713a1073e4)

* Query results

![image](https://github.com/mytrannn22/Increase-website-conversion-rate/assets/140190425/28ecf6fc-e580-4548-9e18-5116ed0eec96)

**Insight:** 
* All bounce sessions are made solely by guests.
* Bounce rate among guests is 25%, 75% of guests do more than one action on the web.

**Recommendation:** 
* Encourage guests to register to become members: Make the registration process easy and straightforward with simple form and clear instructions. Highlight the benefits of membership: discounts, vouchers, more accurate recommended products, personalize experiences, etc.
* Keep guests stay longer: Make sure website loads quickly, use attractive images, videos and content, improve UX/UI so that the web is easy to navigate and understand.

### QUERY #02.2: Bounce Rate by Traffic source

* SQL code

![image](https://github.com/mytrannn22/Increase-website-conversion-rate/assets/140190425/df2414ac-9862-4186-b939-f5fad62c25e4)

* Query results

![image](https://github.com/mytrannn22/Increase-website-conversion-rate/assets/140190425/0685b2e3-e80e-436c-b47b-7f3f119ebd00)

**Insight:** Bounce rates are relatively the same for all traffic sources, around 13%.

### QUERY #02.3: Bounce Rate by Browser

* SQL code

![image](https://github.com/mytrannn22/Increase-website-conversion-rate/assets/140190425/fc5d26f2-8eb1-411f-a779-b31a36872452)

* Query results

![image](https://github.com/mytrannn22/Increase-website-conversion-rate/assets/140190425/368660ad-4077-4d85-9c6c-07c62deec398)

**Insight:** Bounce rates are relatively the same for all browser, around 13%.

### QUERY #03: Event type of Bounce Session

* SQL code

![image](https://github.com/mytrannn22/Increase-website-conversion-rate/assets/140190425/6bb1bbc0-33bb-4949-8ce7-3df9113bcd1d)

* Query results

![image](https://github.com/mytrannn22/Increase-website-conversion-rate/assets/140190425/23c049ab-1be0-444e-9955-a86967551007)

**Insight:**  All bounce sessions bounced after viewing a product.

**Recommendation:** 
* Encourage visitors to view more products: suggest relevant products, recommend hot trend items, use engaging content and high quality product images and videos.
* Encourage visitors to take further actions - add to cart and purchase: Use effective calls to action, make it clear and straightforward.

### QUERY #04: Total Sessions, Purchase Sessions and Conversion Rate by Traffic source

* SQL code

![image](https://github.com/mytrannn22/Increase-website-conversion-rate/assets/140190425/f46d8496-f666-4e6c-9cc3-d1806fe83a5a)

* Query results

![image](https://github.com/mytrannn22/Increase-website-conversion-rate/assets/140190425/72eaa7b6-2bd2-4a32-8c70-d53d9eaa9820)

![image](https://github.com/mytrannn22/Increase-website-conversion-rate/assets/140190425/47877a92-2d8b-45be-9a7e-25b11ff5b408)

**Insight:** Most traffic come from email, organic drives the least traffic. Conversion rates do not differ among traffic sources, all around 46-47%.

**Recommendation:** Review marketing compaigns conducted in the same time frame and compare their budgets to the total traffic and conversions to evaluate the effectiveness of marketing campaigns, allocate budget accordingly, optimize campaigns and improve the results.

### QUERY #05: Number of Sessions thoughout purchase process:  view product – add to cart - purchase

* SQL code

![image](https://github.com/mytrannn22/Increase-website-conversion-rate/assets/140190425/ddca9708-5e8d-4cda-ab8d-39516029f60a)

* Query results

![image](https://github.com/mytrannn22/Increase-website-conversion-rate/assets/140190425/5c5face5-becf-475f-bc4f-c3048b78271b)

![image](https://github.com/mytrannn22/Increase-website-conversion-rate/assets/140190425/62b5ac17-1a72-4277-a072-6150f25494ab)

![image](https://github.com/mytrannn22/Increase-website-conversion-rate/assets/140190425/449f652c-f937-4ff4-b679-8ecd6ff349e2)

Take out the month and we have the figures for the whole last 12 months.

![image](https://github.com/mytrannn22/Increase-website-conversion-rate/assets/140190425/ed122aba-d45e-40ce-8152-a6b4a894c7fe)

**Insight:**
* All sessions view at least 1 product.
* Generally, around 73% sessions that view product will add to cart, and 63% of those sessions will complete the purchase.
* Total sessions, sessions that view product, add to cart and purchase increase gradually over time, except for a slight drop in Feb 2023. The last month – Jul 2023 records significantly growth in these figures, may be resulted from the summer campaign?
* Cart abandonment rate is inversely correlated with conversion rate (quite obvious), the former decreases nearly a half over 12 months (47% to 24%), while the later increases considerably from 36% to reach over 62% in July 2023.

**Recommendation:**  To increase conversion rate, we should increase the total visits to website, encourage visitors to view (more) products, add (more) to cart and purchase (more).

### QUERY #06: Session Duration (by visitor type) in minutes

* SQL code

![image](https://github.com/mytrannn22/Increase-website-conversion-rate/assets/140190425/db71eeb2-458c-4c1e-97dc-f349518bc439)

* Query results

![image](https://github.com/mytrannn22/Increase-website-conversion-rate/assets/140190425/bf322116-0642-43b8-be03-5fd02b729fb2)

![image](https://github.com/mytrannn22/Increase-website-conversion-rate/assets/140190425/3af9a07d-367f-4fda-b4a3-a9ba4bed048f)

![image](https://github.com/mytrannn22/Increase-website-conversion-rate/assets/140190425/fa92e1e1-bd4f-4555-b6a4-6d1038541a1b)

**Insight:**
* Session Duration differs dramatically between visitor types.
* All bounce sessions  (duration = 0) are taken by guest. The majority of guests bounce. The rest of them spend less than 1 hour on the web. The number of sessions that do not bounce distribute relatively even, with a small peak at 29 mins.
* Most of members spend 3-10 mins for each session on our website. There is a noticeably pattern: some members keep the session and come back on some of the days after the first day they start the session, at relatively the same time *(60mins x 24h = 1440mins, 60mins x 48h = 2880mins, etc.)*. This range from 1 - 4 days.

**Recommendation:** 
* Decrease bounce sessions in guests.
* For members, use pop-up content or remind message to encourage them to continue their purchases.

### QUERY #07: Time spent on each event

*Note: only take into account event that has another following event and exclude bounce sessions.*

* SQL code

![image](https://github.com/mytrannn22/Increase-website-conversion-rate/assets/140190425/4e51b92c-eb76-41bc-be01-101d42758c71)

* Query results

![image](https://github.com/mytrannn22/Increase-website-conversion-rate/assets/140190425/24a4f528-0642-4834-a836-95d95de47897)

**Insight:** 
* It’s quite surprised that guests (exclude those who bounce) spend noticeably more time on department and product than members , with ~3.6mins on each event type, this can indicate that they are interested in our products, and are likely to register to become members.
* Members spend lots of time on cart (~3.4h), why? Do they concern about product, price or anything else?

**Recommendation:** 
* Use pop-up message to encourage members to check out their purchase processes to ultilize discounts, vouchers, etc. as they will be expired soon.

### QUERY #08: Number of products viewed in sessions that have product view event

*Note: Assume each distinct uri product/… point to different product.*

* SQL code

![image](https://github.com/mytrannn22/Increase-website-conversion-rate/assets/140190425/a7cc0b67-1c9b-4c9a-abc8-0d6a6f6ba7af)

* Query results

![image](https://github.com/mytrannn22/Increase-website-conversion-rate/assets/140190425/4431a09f-0ee4-41ec-b9d4-8434ac4bb328)

![image](https://github.com/mytrannn22/Increase-website-conversion-rate/assets/140190425/547e335d-e8ad-4441-9373-89c9e1b56c06)

**Insight:** Most sessions view only 1 product, the maximum number of products viewed in a session is only 4

**Recommendation:** 
* Make it easier for users to view and find products: product filters and categories, clear and relevant keywords.
* Make product images and discription more attractive and appealing.
* Suggest products that are relevant to what they’ve recently viewed.

### QUERY #09: Number of items added into cart in sessions that add product to cart

* SQL code

![image](https://github.com/mytrannn22/Increase-website-conversion-rate/assets/140190425/6b5a01c0-3866-4771-bc88-bec1df848727)

* Query results

![image](https://github.com/mytrannn22/Increase-website-conversion-rate/assets/140190425/fa722e39-19d3-4ff3-afdf-37be6a78b405)

![image](https://github.com/mytrannn22/Increase-website-conversion-rate/assets/140190425/a4d8ae76-0e0a-4fd5-a58d-8102a8b9bde2)

**Insight:** The pattern of adding to cart is quite similar to viewing product. Most sessions add only 1 product to cart, the maximum number of products viewed in a session is only 4.

**Recommendation:** 
* Make it easier for users to add products to their cart, improve checkout process to be more a clear and concise.
* Use exit-intent popups: these popups will appear when users are about to leave the website. We may use it to offer discounts or simply encourage users to add more products to their cart or complete the check out process.
* Personalize product recommendations based on users’ demographics, preferences (history search), suggest products that are relevant to those in their cart.

### QUERY #10: Total purchases per user that made (a) purchase(s)

Purchase frequency is a significant factor that can help to improve conversion rate as in general, customers who buy more often are more likely to convert on a given visit. This is because they are already familiar with the website and the products, and they are more likely to be confident in their purchase decision.

* SQL code

![image](https://github.com/mytrannn22/Increase-website-conversion-rate/assets/140190425/616b8ad0-2a01-43c7-8382-1cbb79c227c4)

* Query results

![image](https://github.com/mytrannn22/Increase-website-conversion-rate/assets/140190425/a52bc760-a6a9-45d3-994f-a0f94023a920)

![image](https://github.com/mytrannn22/Increase-website-conversion-rate/assets/140190425/6611065a-4e4e-4520-bcf1-0c13daa0a6b0)

![image](https://github.com/mytrannn22/Increase-website-conversion-rate/assets/140190425/2185bb44-406c-486d-9d89-1f729d902f4d)

**Insight:** Most users purchase only once.

**Recommendation:** 
* Personalize marketing messages that are relevant to customers’ interests and past purchases.
* Personalize the shopping experience: recommend products to customers based on their past purchases or searching history.
* Offer loyalty programs: reward customers for their repeat purchases and encourage them to buy more.
* Run promotions and discounts exclusively for members?
* Develop cashback or discount voucher program for the next order, valid for a certain period of time.

## IV. Conclusion

### Significant Insights:

100% sessions visiting our website view product. Generally, around 73% sessions that view product will add to cart, and 63% of those sessions will complete the purchase. 

Conversion rates do not differ among traffic sources or browsers.

The conversion rate has increased significantly from 36% in August 2022 to reach over 62% in July 2023. 

1. Visit site:
* Visit: Chrome is the most popular browsers with over 50% of total sessions. Email and Adwords bring the most traffic to website. 
* Bounce session: All bounce sessions are viewing product and they are taken solely by guests. 25% of guests will bounce. 
* Session duration: differs dramatically between visitor types. All guests spend less than 1 hour for each session, whereas sessions taken by members can last upto 4 days, in which most of time is spent on cart.
2. View product: All sessions visiting our website view product. Most sessions view only 1 product, the maximum number of products viewed in a session is only 4.
3. Add to cart: Most sessions add only 1 product to cart, the maximum number of products viewed in a session is only 4.
4. Purchase: Most customers purchase only once. Returning customers account for nearly a half of total customers.

### Recommendations:

To increase conversion rate, we should focus on increasing sessions thoughout each stage of sales process:

1. Visit site:

Increase visit: Prioritize Chrome on website compatibility and focus marketing efforts on that Chrome to ensure that the website is accessible to as many users as possible.

Decrease bounce sessions: 
* Encourage guests to register: Make the registration process easy and straightforward, highlight the benefits of membership.
* Keep guests stay longer: Improve web loading time, improve UX/UI.
* Encourage visitor to view more products or take further actions - add to cart and purchase: clear and concise call-to-actions with strong verbs. 

2. View product:  
* Make it easier for visitors to view and find products: improve product filters and categories, clear and relevant keywords.
* Make product images and discription more attractive and engaging.
* Suggest relevant products to what they’ve recently viewed, recommend hot trend items.

3. Add to cart:
* Improve checkout process to be more a clear and concise, make it easier for users to add products to their cart.
* Use exit-intent popups to offer discounts or simply encourage users to add more products to their cart or complete the check out process.
* Personalize product recommendations based on users’ demographics, preferences (history search).

4. Purchase: 
* Use pop-up message to encourage members to complete their purchase processes to ultilize discounts, vouchers, etc. as they will be expired soon.
* Personalize marketing messages and shopping experiences: recommend products to customers based on their past purchases or searching history.
* Offer loyalty programs: Run promotions and discounts exclusively for repeating customers, offer cashback or discount voucher for the next purchases, valid for a certain period of time.

### Next steps:

Review the marketing campaigns, sales performance, financial reports and related documents to find out why total web visits and conversion rate decrease in Feb 2023, and why we do well on Jul 2023 to optimize campaigns and improve results.
