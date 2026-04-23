# Practical Coding Using SQL

This project showcases practical SQL and database design skills through a business case for **Urban Eats Café Chain**, a multi-outlet café business. It combines **relational database design** with **SQL-based business analysis** to demonstrate how structured data can support operational reporting and decision-making. The work covers core SQL practice areas including **data modeling, joins, calculations, aggregations, and debugging data issues**.

## Project Overview

The project was developed around the idea of building a database that reflects real café operations across multiple outlets. The database captures key business areas such as:

- outlets
- staff
- shifts and staff scheduling
- customers
- reservations
- products and product categories
- orders and order details
- payments

The design emphasizes **normalization, entity relationships, primary and foreign keys, referential integrity, and business rule enforcement**. It also includes realistic scenarios such as overnight shifts, split payments, cancelled reservations, inactive seasonal products, and walk-in customers.

## Objectives

This project was created to practice and demonstrate:

- SQL querying in a practical business context
- relational database design
- data modeling using fact/entity relationships
- joins across multiple tables
- aggregations and KPI calculations
- source-to-result validation through business logic
- debugging and analysing data issues in transactional datasets

## Database Scope

The database includes the following main entities:

- **OUTLET** – café outlet information
- **STAFF** – employee details linked to outlets
- **SHIFT** – roster and scheduled shift information
- **STAFFSHIFT** – staff assignment to shifts with actual worked hours
- **CUSTOMER** – customer records
- **RESERVATION** – booking information
- **PRODUCT_CATEGORY** – category hierarchy for menu items
- **PRODUCT** – menu product master data
- **ORDERS** – customer orders
- **ORDER_DETAIL** – line-item details for each order
- **PAYMENT** – transaction records linked to orders

## SQL Analysis Included

The project applies SQL to answer business questions in five key areas:

### 1. Menu Popularity and Revenue
Analysed product sales volume and revenue contribution to identify top-performing menu items and underperformers.

### 2. Sales vs Staff Scheduling
Compared sales against staff working hours to assess labour efficiency and support roster planning.

### 3. Customer Retention
Measured repeat customer behaviour to evaluate retention and support loyalty program ideas.

### 4. Outlet Performance
Compared outlets using revenue, order volume, average order value, reservation fulfilment, and cancellations.

### 5. Payment Performance Analysis
Reviewed transaction outcomes such as approvals, declines, refunds, and pending payments to identify reliability issues.

## Skills Demonstrated

- SQL joins
- aggregations
- business calculations
- data validation
- debugging data issues
- relational schema design
- primary key and foreign key design
- many-to-many relationship handling
- hierarchical category modeling
- analytical thinking for BI/reporting scenarios

## Tools and Concepts

- SQL
- relational database design
- normalized schema design
- entity relationship modeling
- business logic validation
- KPI analysis
- transactional data analysis

## Key Takeaways

This project demonstrates how a well-structured database can support both daily operations and management reporting. By combining database design with analytical SQL queries, it shows how raw operational data can be transformed into actionable insights for staffing, sales performance, customer retention, and payment monitoring.

## Repository Purpose

This repository is part of my SQL practice portfolio and reflects hands-on work relevant to data analytics and BI environments. It highlights practical experience in working with structured data, applying SQL to business problems, and designing databases that align with real operational requirements.
