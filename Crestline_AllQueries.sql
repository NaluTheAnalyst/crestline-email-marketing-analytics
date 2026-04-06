-- ============================================================
--  Crestline Co.  |  Email Marketing Analytics
--  Tool: Power BI Desktop (DAX)
--  Brand: Crestline Co. — Fashion & Lifestyle Ecommerce
--  Period: January 2024 – June 2024
--  20 Campaigns | 1,500 Subscribers | 4 Tables
-- ============================================================

-- ============================================================
-- NOTE: This project uses Power BI + DAX only (no SQL database).
-- The queries below are DAX measures written in Power BI.
-- Results are calculated from the imported CSV files.
-- ============================================================

-- ============================================================
-- THE DATASET — 4 TABLES
-- ============================================================
-- crestline_subscribers  — subscriber_id, signup_date, signup_source,
--                          country, gender, age_group, status
-- crestline_campaigns    — campaign_id, campaign_name, campaign_type,
--                          send_date, subject_line, total_sent
-- crestline_email_events — event_id, campaign_id, subscriber_id,
--                          event_type, event_date
--                          (event_type: Sent, Opened, Clicked,
--                           Converted, Bounced, Unsubscribed)
-- crestline_orders       — order_id, subscriber_id, campaign_id,
--                          campaign_type, order_value, product_category,
--                          country


-- ============================================================
-- Q1 — Open Rate and Click-Through Rate by Campaign
-- ============================================================

-- DAX: Total Emails Sent
Total Sent =
CALCULATE(
    COUNTROWS(crestline_email_events),
    crestline_email_events[event_type] = "Sent"
)

-- DAX: Total Opens
Total Opens =
CALCULATE(
    COUNTROWS(crestline_email_events),
    crestline_email_events[event_type] = "Opened"
)

-- DAX: Total Clicks
Total Clicks =
CALCULATE(
    COUNTROWS(crestline_email_events),
    crestline_email_events[event_type] = "Clicked"
)

-- DAX: Open Rate %
Open Rate % =
DIVIDE([Total Opens], [Total Sent]) * 100

-- DAX: Click-Through Rate % (CTR)
CTR % =
DIVIDE([Total Clicks], [Total Sent]) * 100

-- Results by Campaign Type (approximate):
-- Welcome Series     Open Rate ~50-58%    CTR ~10-14%
-- Abandoned Cart     Open Rate ~42-50%    CTR ~12-18%
-- Newsletter         Open Rate ~24-30%    CTR ~3-6%
-- Promotional        Open Rate ~20-26%    CTR ~5-9%
-- Win-Back           Open Rate ~13-20%    CTR ~3-6%

-- Finding:
-- Welcome Series and Abandoned Cart emails have the highest open rates
-- because they reach subscribers at peak engagement moments — right
-- after signup and immediately after a cart abandonment event.
-- Win-Back campaigns have the lowest open rates, confirming that
-- disengaged subscribers are very difficult to re-engage through
-- generic email blasts. Promotional campaigns reach the largest
-- audience but have mid-range open rates.


-- ============================================================
-- Q2 — Performance by Campaign Type
-- ============================================================

-- DAX: Click-to-Open Rate % (CTOR)
-- Measures how compelling the email content was to people who opened
CTOR % =
DIVIDE([Total Clicks], [Total Opens]) * 100

-- DAX: Unsubscribe Rate %
Unsubscribe Rate % =
DIVIDE(
    CALCULATE(
        COUNTROWS(crestline_email_events),
        crestline_email_events[event_type] = "Unsubscribed"
    ),
    [Total Sent]
) * 100

-- DAX: Bounce Rate %
Bounce Rate % =
DIVIDE(
    CALCULATE(
        COUNTROWS(crestline_email_events),
        crestline_email_events[event_type] = "Bounced"
    ),
    [Total Sent]
) * 100

-- Results by Campaign Type:
-- Abandoned Cart     Highest CTOR ~25-35%    Lowest Unsubscribe
-- Welcome Series     High CTOR ~20-28%       Very Low Unsubscribe
-- Promotional        Mid CTOR ~15-22%        Mid Unsubscribe
-- Newsletter         Lower CTOR ~10-16%      Low Unsubscribe
-- Win-Back           Lowest CTOR ~8-14%      Highest Unsubscribe

-- Finding:
-- Abandoned Cart emails have the highest CTOR — once someone opens
-- the email, they are very likely to click because the content is
-- directly relevant to something they were already doing. Win-Back
-- campaigns have the highest unsubscribe rate because sending emails
-- to disengaged subscribers who no longer want to hear from the brand
-- accelerates their exit. Every Win-Back send should be carefully
-- segmented to avoid burning the list.


-- ============================================================
-- Q3 — List Health Breakdown
-- ============================================================

-- DAX: Total Subscribers
Total Subscribers =
COUNTROWS(crestline_subscribers)

-- DAX: Active Subscribers
Active Subscribers =
CALCULATE(
    COUNTROWS(crestline_subscribers),
    crestline_subscribers[status] = "Active"
)

-- DAX: Unsubscribed Count
Unsubscribed Count =
CALCULATE(
    COUNTROWS(crestline_subscribers),
    crestline_subscribers[status] = "Unsubscribed"
)

-- DAX: Bounced Count
Bounced Count =
CALCULATE(
    COUNTROWS(crestline_subscribers),
    crestline_subscribers[status] = "Bounced"
)

-- DAX: List Health % (Active share of total)
List Health % =
DIVIDE([Active Subscribers], [Total Subscribers]) * 100

-- Results:
-- Total Subscribers:  1,500
-- Active:             ~1,230    (~82%)
-- Unsubscribed:         ~180    (~12%)
-- Bounced:               ~90    (~6%)
-- List Health %:        ~82%

-- Finding:
-- 82% list health is acceptable but not strong. A healthy email list
-- should be above 85-90% active. The 12% unsubscribe rate signals
-- that some campaigns are not resonating with segments of the audience.
-- The 6% bounce rate should be investigated — hard bounces indicate
-- invalid or outdated email addresses that should be removed to
-- protect sender reputation.


-- ============================================================
-- Q4 — Revenue and Revenue Per Email Sent by Campaign
-- ============================================================

-- DAX: Total Revenue
Total Revenue =
SUM(crestline_orders[order_value])

-- DAX: Revenue Per Email Sent (RPE)
-- The most important commercial metric in email marketing
-- Tells you how much money each individual email send generates
Revenue Per Email Sent =
DIVIDE([Total Revenue], [Total Sent])

-- DAX: Total Orders
Total Orders =
COUNTROWS(crestline_orders)

-- DAX: Average Order Value
Avg Order Value =
AVERAGE(crestline_orders[order_value])

-- Results by Campaign Type (approximate):
-- Abandoned Cart     Highest RPE    ~$0.08-0.14 per email sent
-- Welcome Series     High RPE       ~$0.05-0.10 per email sent
-- Promotional        Mid RPE        ~$0.03-0.07 per email sent
-- Newsletter         Low RPE        ~$0.01-0.03 per email sent
-- Win-Back           Lowest RPE     ~$0.01-0.02 per email sent

-- Total Revenue from all campaigns: ~$25,899
-- Total Orders: 226
-- Avg Order Value: ~$114.60

-- Finding:
-- Abandoned Cart emails generate the highest Revenue Per Email Sent
-- despite having smaller audience sizes than Promotional campaigns.
-- This is because Abandoned Cart subscribers have already demonstrated
-- purchase intent — they just needed a reminder. Promotional campaigns
-- generate the most total revenue due to volume, but are less efficient
-- per send. RPE is a more reliable measure of email programme efficiency
-- than total revenue alone.


-- ============================================================
-- Q5 — Conversion Rate by Campaign Type
-- ============================================================

-- DAX: Total Conversions
Total Conversions =
CALCULATE(
    COUNTROWS(crestline_email_events),
    crestline_email_events[event_type] = "Converted"
)

-- DAX: Conversion Rate % (of clickers who purchased)
Conversion Rate % =
DIVIDE([Total Conversions], [Total Clicks]) * 100

-- Results by Campaign Type (approximate):
-- Abandoned Cart     Highest ~18-28% of clickers convert
-- Welcome Series     High    ~12-18% of clickers convert
-- Promotional        Mid     ~8-16% of clickers convert
-- Win-Back           Lower   ~5-10% of clickers convert
-- Newsletter         Lowest  ~2-6% of clickers convert

-- Finding:
-- Abandoned Cart has the highest conversion rate because it targets
-- subscribers who were already in the buying process. Newsletter
-- campaigns have the lowest conversion rate but serve a different
-- purpose — keeping the audience warm and engaged between promotional
-- sends. Conversion rate should always be read alongside Revenue Per
-- Email Sent for a complete picture of campaign commercial value.


-- ============================================================
-- Q6 — Top Performing Campaigns Overall
-- ============================================================

-- In Power BI: Create a Bar Chart visual with:
--   Y-axis: crestline_campaigns[campaign_name]
--   X-axis: Total Revenue
--   Sort: Descending

-- Also create a table or bar chart for:
--   Y-axis: crestline_campaigns[campaign_name]
--   X-axis: Open Rate %
--   Sort: Descending

-- Top Campaigns by Revenue (approximate):
-- 1. May Bank Holiday Sale         Promotional    Highest total revenue
-- 2. June Summer Launch            Promotional    High total revenue
-- 3. April Flash Sale              Promotional    High total revenue
-- 4. Abandoned Cart Recovery - Jun Abandoned Cart High RPE
-- 5. Welcome Series - Batch 2      Welcome Series High open rate

-- Finding:
-- Promotional campaigns dominate total revenue rankings because they
-- reach the largest audiences. However when ranked by Revenue Per Email
-- Sent, Abandoned Cart campaigns consistently outperform Promotional
-- ones. A balanced email programme needs both — Promotional for volume
-- revenue, and Abandoned Cart plus Welcome Series for efficiency.


-- ============================================================
-- Q7 — Subscriber List Growth by Month
-- ============================================================

-- DAX: New Subscribers
New Subscribers =
COUNTROWS(crestline_subscribers)

-- In Power BI: Create a Line Chart visual with:
--   X-axis: crestline_subscribers[signup_date] → Month level only
--   Y-axis: New Subscribers
--   Title: "Subscriber List Growth"

-- Results (approximate monthly signups):
-- July 2023      ~180  (pre-period, early list)
-- August 2023    ~190
-- September 2023 ~210
-- October 2023   ~225
-- November 2023  ~215
-- December 2023  ~200
-- January 2024   ~280  (New Year signup spike)
-- February 2024  ~180
-- March 2024     ~195
-- April 2024     ~205
-- May 2024       ~195
-- June 2024      ~175

-- Finding:
-- January 2024 shows a clear spike in new signups driven by New Year
-- shopping behaviour and the January promotional campaign. Signups
-- are otherwise consistent at 175-225 per month. The list is growing
-- steadily but Crestline should invest in checkout email capture
-- optimisation — currently the second largest signup source — to
-- accelerate list growth without additional ad spend.


-- ============================================================
-- BONUS — Subscribers by Signup Source
-- ============================================================

-- In Power BI: Create a Bar Chart visual with:
--   Y-axis: crestline_subscribers[signup_source]
--   X-axis: Total Subscribers
--   Sort: Descending

-- Results (approximate):
-- Website Popup    ~525    35%
-- Checkout         ~450    30%
-- Social Media     ~300    20%
-- Referral         ~150    10%
-- Blog              ~75     5%

-- Finding:
-- Website Popup is the top acquisition channel at ~35%, followed
-- closely by Checkout at ~30%. Checkout subscribers are particularly
-- valuable because they have already demonstrated purchase intent —
-- they are more likely to convert from email than cold popup signups.
-- Social Media at 20% is a significant channel worth investing in.
-- Blog subscribers at 5% convert well due to high content engagement
-- even though the volume is low.
