# 🍕 Pizza Sales Analysis using PostgreSQL

## 📌 Project Overview

This project analyzes a pizza restaurant's sales data using **PostgreSQL**. It demonstrates SQL skills such as table creation, joins, aggregation, window functions, ranking, and revenue analysis to generate business insights from transactional data.

The project is suitable for beginners and intermediate learners who want to practice SQL for data analysis and portfolio building.

---

## 📂 Database Schema

The project consists of four relational tables:

### 1. `pizza_types`

Stores information about pizza varieties.

| Column        | Description                                              |
| ------------- | -------------------------------------------------------- |
| pizza_type_id | Unique pizza type ID                                     |
| name          | Pizza name                                               |
| category      | Pizza category (Classic, Chicken, Veggie, Supreme, etc.) |
| ingredients   | Ingredients used                                         |

---

### 2. `pizzas`

Stores pizza sizes and prices.

| Column        | Description                   |
| ------------- | ----------------------------- |
| pizza_id      | Unique pizza ID               |
| pizza_type_id | References pizza_types        |
| size          | Pizza size (S, M, L, XL, XXL) |
| price         | Selling price                 |

---

### 3. `orders`

Stores customer order information.

| Column   | Description     |
| -------- | --------------- |
| order_id | Unique order ID |
| date     | Order date      |
| time     | Order time      |

---

### 4. `order_details`

Stores ordered pizzas and quantities.

| Column           | Description            |
| ---------------- | ---------------------- |
| order_details_id | Unique order detail ID |
| order_id         | References orders      |
| pizza_id         | References pizzas      |
| quantity         | Quantity ordered       |

---

# 📊 SQL Analysis Performed

The project answers several real-world business questions.

### Basic Analysis

* Total number of orders placed
* Total revenue generated
* Highest-priced pizza
* Most commonly ordered pizza size
* Top 5 most ordered pizza types

---

### Intermediate Analysis

* Total quantity sold by pizza category
* Order distribution by hour
* Category-wise pizza distribution
* Average pizzas ordered per day
* Top 3 pizzas by revenue

---

### Advanced Analysis

* Revenue contribution (%) by category
* Cumulative revenue over time
* Top 3 revenue-generating pizzas within each category using Window Functions

---

# 🛠 SQL Concepts Used

* CREATE TABLE
* PRIMARY KEY
* FOREIGN KEY
* INNER JOIN
* Aggregate Functions

  * COUNT()
  * SUM()
  * AVG()
* GROUP BY
* ORDER BY
* LIMIT
* EXTRACT()
* ROUND()
* Window Functions

  * RANK()
  * SUM() OVER()
* Common Table Expressions (CTE concepts)
* Nested Subqueries

---

# 📈 Business Insights

This analysis helps answer questions such as:

* Which pizzas generate the highest revenue?
* Which pizza sizes are most popular?
* Which categories sell the most?
* At what time do customers order the most?
* How does revenue grow over time?
* Which pizzas are top performers within each category?

---

# 💻 Technologies Used

* PostgreSQL
* SQL
* pgAdmin

---

# 📁 Project Structure

```
Pizza-Sales-Analysis/
│
├── pizza_sales.sql        # Database creation and analysis queries
├── README.md              # Project documentation
└── dataset/               # CSV files (optional)
```

---

# 🚀 How to Run

1. Install PostgreSQL.
2. Open pgAdmin or psql.
3. Create a new database.
4. Run the SQL script to create tables.
5. Import the dataset (CSV files if available).
6. Execute the analysis queries.
7. Explore the generated insights.

---

# 🎯 Learning Outcomes

By completing this project, you will gain hands-on experience with:

* Relational database design
* SQL querying
* Data aggregation
* Business analytics
* Revenue analysis
* Window functions
* Portfolio-ready SQL projects

---

# 🤝 Contributing

Contributions are welcome. Feel free to fork this repository, improve the SQL queries, optimize performance, or add more business insights.

---

# 📄 License

This project is intended for educational and portfolio purposes.

---

## ⭐ If you found this project useful, consider giving it a Star on GitHub!
