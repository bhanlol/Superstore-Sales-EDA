# Superstore-Sales-EDA

## Introduction

In this project, we conducted exploratory data analysis (EDA) on sales, profit, consumer, and product data for our favorite (imaginary) superstore, Superstore! Using SQL (MySQL) and functions such as subqueries and CTEs, joins, window functions, etc., various valuable insights were extracted and subsequently visualized on a Tableau dashboard. These insights can be used to identify opporunities to increase revenue and profits and pinpoint areas/products for divestment.

## Table of Contents

superstore_eda.sql (MySQL):
- EDA
- File linked above

Power BI Dashbaord:
- Revenue insights and KPIs
- File linked above

Tableau Dashboard:
- [Superstore Sales Dashboard](https://public.tableau.com/app/profile/brandon.han3861/viz/SuperstoreSalesDashboard_16947664303160/Dashboard1)

Data Retrieved From:
- [Superstore Dataset](https://www.kaggle.com/datasets/vivek468/superstore-dataset-final)

## Recommendations

### Products

Our **technology** and **office supplies** product categories have profit margins of 17.39% and 17.13%, respectively. Our **furniture** product category has a meager profit margin of 2.32%. Taking a deeper dive into these categories, the **bookcases** and **tables** sub-categories within the **furniture** category have profit margins of -3.02% and -8.56%, respectively. The **supplies** sub-category within the **office supplies** category is the only other sub-category within our product lineup that has a negative profit margin at -2.93%. We should reevaluate how we price and apply discounts to products in these sub-categories, and potentially renegotiate contracts with wholesalers/distributors for these products. To name a few, product ID **OFF-SU-10000432** (supplies), product ID **FUR-TA-10004289** (tables), and product ID **FUR-BO-10001567** (bookcases) have profit margins of -18.75%, -67.31%, and an abysmal -210%, respectively.

### Customers
We may benefit from a loyalty program that keeps loyal customers loyal, and increases purchase frequency from those who may not shop with us as often. 

One curious finding from our EDA shows that our top revenue-grossing customer (customer ID **SM-20320**), provided us with a total profit of approximately -$1980 and a profit margin of -7.91%. A quick look into his purchase history shows that only 2 of his 15 purchases were made **without** a discount, which brings us to our next recommendation...

### Discounts

Our total profits from orders without discounts amount to $317,184. On the other hand, discounted orders have lost us $34,326. The aforementioned customer with customer ID **SM-20320** is a prime example that points to our discount strategy being too aggressive. We may need to cut back on the discounts we provide.

### Seasonality

Quarter 4 sees significantly higher totals in both revenue and profits, possibly due to holiday shopping. We may benefit from running strategic marketing campaigns, particularly leading up to Halloween, Thanksgiving and Christmas. We should also optimize our inventory to ensure that we meet the increased product demands, and prioritize proper training for our retail employees to prepare them for the higher foot-traffic.

### Regionality

Revenue seems to have a strong, positive correlation with state population. California, New York, Texas, Pennsylvania, and Florida are 1st, 2nd, 3rd, 5th, and 6th, respectively, in terms of revenue and are the 5 states with the highest populations. Curiously, Washington is 4th in terms of revenue but does not have a particularly high population. It may be a good idea to prioritize inventory allocations towards shipping centers that cater towards these states.
