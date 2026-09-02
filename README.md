# E-Commerce Funnel & Revenue Performance Analysis

## Project Overview

This project is an end-to-end e-commerce funnel and revenue analysis built using **SQL Server and Power BI**.

The project starts with importing raw customer event data from a CSV file into SQL Server, followed by SQL-based funnel analysis, customer journey analysis, traffic-source performance analysis, and revenue analysis. The SQL analysis tables are then connected to Power BI to build an interactive single-page business dashboard.

Power BI DAX calculated tables were also created to transform SQL results into formats required for funnel and conversion-rate visualizations.

## Business Problem

An e-commerce business wants to understand how customers move through the purchase journey and identify opportunities to improve conversion and revenue performance.

The analysis addresses the following questions:

- How many users reach each stage of the funnel?
- Where do the largest customer drop-offs occur?
- What is the overall conversion rate?
- Which traffic sources generate stronger purchase conversion?
- How long does it take customers to move through the funnel?
- How much revenue is generated from completed purchases?
- What actions can improve customer conversion and revenue efficiency?

## End-to-End Project Workflow

### Step 1 — Data Import

The raw `user_events.csv` dataset was imported into **Microsoft SQL Server**.

The dataset contains customer event information including:

- Event ID
- User ID
- Event Type
- Event Date
- Product ID
- Amount
- Traffic Source

### Step 2 — SQL Server Analysis

SQL Server was used to analyze the customer funnel and generate analysis tables.

The five funnel stages analyzed were:

1. Page View
2. Add to Cart
3. Checkout
4. Payment
5. Purchase

### Step 3 — SQL Analysis

The project uses Common Table Expressions (CTEs) and conditional aggregation to calculate:

- Funnel stage users
- Stage-to-stage conversion rates
- Traffic-source conversion performance
- Customer journey time
- Revenue and order metrics

### Step 4 — Connect SQL Server to Power BI

The SQL Server database was connected to **Power BI**.

The analysis tables generated using SQL were imported into Power BI for visualization.

### Step 5 — Power BI Dashboard

A single-page Power BI dashboard was created to communicate the main business findings.

The dashboard contains:

- Total Visitors
- Total Buyers
- Total Revenue
- Average Order Value
- Overall Conversion Rate
- Customer Funnel
- Funnel Stage Conversion Rate
- Purchase Conversion by Traffic Source
- Customer Journey Metrics
- Revenue Efficiency Metrics
- Business Recommendations

### Step 6 — DAX Calculated Tables

DAX calculated tables were created in Power BI to structure SQL results for visualization.

Two calculated tables were created:

- `Funnel_Chart`
- `Funnel_Conversion_Rate`

These tables were used to create the customer funnel and funnel-stage conversion visuals.

## Key Performance Indicators

| Metric | Value |
|---|---:|
| Total Visitors | 5,000 |
| Total Buyers | 826 |
| Total Orders | 826 |
| Total Revenue | $87,975.11 |
| Average Order Value | $106.51 |
| Overall Conversion Rate | 16.52% |

## Customer Journey Metrics

| Metric | Average Time |
|---|---:|
| View → Cart | 11.16 minutes |
| Cart → Purchase | 13.47 minutes |
| Total Journey | 24.63 minutes |

## Key Insights

- 5,000 users entered the e-commerce funnel and 826 completed a purchase.
- The overall visitor-to-purchase conversion rate was 16.52%.
- The View → Cart stage represents an important opportunity to improve customer engagement.
- Email generated the strongest purchase conversion among the analyzed traffic sources.
- The average customer journey from initial view to purchase was approximately 24.63 minutes.
- Average revenue per buyer was $106.51.

## Business Recommendations

### 1. Improve Product Discovery

Optimize product pages, search, and navigation to improve View → Cart conversion.

### 2. Prioritize High-Converting Channels

Focus marketing efforts on channels with stronger purchase conversion rates while monitoring acquisition costs.

### 3. Reduce Funnel Drop-Offs

Investigate friction between View → Cart and Cart → Purchase to improve overall customer conversion.

## SQL Concepts Used

- Common Table Expressions (CTEs)
- CASE statements
- COUNT DISTINCT
- Conditional aggregation
- Aggregate functions
- GROUP BY
- ORDER BY
- DATEDIFF
- ROUND
- CAST
- NULLIF

## Power BI & DAX

Power BI was used to build the final dashboard and communicate the analysis through interactive visuals.

DAX calculated tables were created to structure funnel-stage data:

- `Funnel_Chart`
- `Funnel_Conversion_Rate`

The `.pbix` file contains the complete Power BI implementation, including the dashboard, data model, Power Query transformations, and DAX calculations.

## Tools & Technologies

- Microsoft SQL Server
- SQL
- Power BI
- Power Query
- DAX
- CSV

## Project Structure

```text
ecommerce-funnel-analysis-sql-powerbi/
│
├── README.md
│
├── Data/
│   └── user_events.csv
│
├── SQL/
│   └── funnel_analysis.sql
│
├── PowerBI/
│   └── ecommerce_funnel_dashboard.pbix
│
└── Images/
    └── ecommerce_funnel_dashboard.png
