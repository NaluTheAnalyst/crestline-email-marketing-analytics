# Crestline Co. — Email Marketing Analytics

## Project Overview

Crestline Co. is a fictional fashion and lifestyle ecommerce brand. This project analyses 6 months of email marketing campaign data (January–June 2024) to measure campaign effectiveness, revenue attribution, audience growth, and list health — the kind of analysis an Email Marketing Specialist or Growth Analyst would present to an ecommerce leadership team.

The entire analysis was performed using **Power BI Desktop** across a dataset of 23,000+ email events and 4 tables.

---

## Dataset

| Table | Description | Rows |
|---|---|---|
| `subscribers` | Every subscriber — signup date, source, country, gender, age group, status | 1,500 |
| `campaigns` | Every email campaign — name, type, send date, subject line, total sent | 20 |
| `email_events` | Every event — sent, opened, clicked, converted, bounced, unsubscribed | 23,000+ |
| `orders` | Every order placed via email — value, category, campaign, country | 226 |

### Campaign Types Covered
- **Promotional** — Sale and discount campaigns
- **Newsletter** — Content and editorial campaigns
- **Abandoned Cart** — Triggered recovery emails
- **Welcome Series** — New subscriber onboarding
- **Win-Back** — Re-engagement for inactive subscribers

---

## Business Questions Answered

1. What is the open rate and click-through rate for each campaign?
2. Which campaign type performs best across all key metrics?
3. What is the list health breakdown — Active, Unsubscribed, Bounced?
4. Which campaigns generate the most revenue and what is the Revenue Per Email Sent?
5. What is the conversion rate by campaign type?
6. What are the top performing campaigns overall?
7. How has the subscriber list grown month by month?

---

## Key Findings

1. **Abandoned Cart emails are the highest value campaigns** — They deliver the highest conversion rate and Revenue Per Email Sent despite reaching a smaller audience
2. **Welcome Series has the highest open rate** — New subscribers are the most engaged segment, confirming the importance of a strong onboarding sequence
3. **Win-Back campaigns underperform across all metrics** — Low open rates (~17%) show that disengaged subscribers are difficult to re-engage through discounts alone
4. **Checkout is a key acquisition channel** — It is the second most effective signup source after Website Popup
5. **Promotional campaigns drive the most total revenue** — But their Revenue Per Email Sent is lower than Abandoned Cart, showing that triggered emails are more efficient per send

---

## Strategic Recommendations

| Priority | Recommendation | Based On |
|---|---|---|
| 1 | Invest in Abandoned Cart automation — highest ROI per email sent | Q4, Q5 |
| 2 | Strengthen Welcome Series — highest open rates, strong first-purchase conversion | Q2, Q5 |
| 3 | Review Win-Back strategy — low performance across all metrics | Q2 |
| 4 | Optimise checkout email capture — second largest source of new subscribers | Q7 |
| 5 | Monitor unsubscribe rate per campaign — keep below 0.5% per send | Q1 |

---

## Tools Used

- Power BI Desktop
