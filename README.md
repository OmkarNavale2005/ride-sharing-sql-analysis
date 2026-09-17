# ride-sharing-sql-analysis
SQL-based analysis of a ride-sharing platform using MySQL, relational database design, joins, constraints, subqueries and window functions.

# 🚗 Ride Sharing SQL Analysis

## 📌 Project Overview

This project analyzes a ride-sharing platform using **MySQL** and relational data from riders, drivers, rides, vehicles, locations, payments, ratings, and promotional codes.

The objective of the project is to demonstrate how SQL can be used to organize relational data, connect multiple tables, perform data analysis, and answer business-related questions.

## 🗂️ Database Tables

The database contains the following tables:

* Riders
* Drivers
* Rides
* Vehicles
* Locations
* Payments
* Ratings
* Promo Codes
* Promo Usage

## 🔗 Database Relationships

Primary keys and foreign keys were implemented to connect the tables and maintain relationships between related records.

Examples include:

* Rides → Riders
* Rides → Drivers
* Vehicles → Drivers
* Rides → Locations
* Payments → Rides
* Ratings → Rides
* Promo Usage → Rides
* Promo Usage → Promo Codes

## 🛠️ SQL Concepts Used

This project demonstrates:

* SELECT statements
* WHERE conditions
* ORDER BY
* LIMIT
* UPDATE
* ALTER TABLE
* GROUP BY
* Aggregate functions
* AND / OR / NOT operators
* INNER JOIN
* LEFT JOIN
* RIGHT JOIN
* Subqueries
* Window functions
* RANK()
* ROW_NUMBER()
* CASE statements
* Primary Keys
* Foreign Keys
* NOT NULL constraints
* UNIQUE constraints
* CHECK constraints
* Indexes

## 📊 Analysis Performed

Some of the business questions analyzed include:

* What are the top 10 most expensive rides?
* How many rides are completed or cancelled?
* Which vehicle types have the most completed rides?
* What is the total revenue by city?
* Which drivers have the highest number of completed rides?
* Which rides have fares above the average fare?
* Which drivers have above-average ratings?
* Which riders have completed more than 10 rides?
* How can drivers be ranked according to revenue?
* How can drivers be ranked within each city?
* How can rides be categorized according to fare and distance?

## 💻 Tools & Technologies

* MySQL
* MySQL Workbench
* SQL
* CSV Dataset

## 📁 Project Structure

```text
ride-sharing-sql-analysis/
│
├── data/
├── sql/
├── screenshots/
└── README.md
```

## 🎯 Key Learning Outcomes

Through this project, I practiced designing relationships between multiple tables and writing SQL queries for data analysis.

The project helped me understand how SQL can be applied to real-world business scenarios involving customers, drivers, rides, revenue, payments, ratings, and promotions.

## 👨‍💻 Author

**Omkar Navale**

Data Analyst | Data Science Graduate

Skills: SQL | Excel | Python | Power BI | Statistics | Machine Learning
