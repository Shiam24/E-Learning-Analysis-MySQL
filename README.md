# E-Learning-Analysis-MySQL
Data Analytics Module End Assignment 3
# E-Learning Platform Purchases Analysis using MySQL

## Data Analytics – Module-End Assignment 3

### Project Overview
This project analyzes e-learning platform purchase data using MySQL. The main objective is to understand learner purchasing behaviour, course popularity, and category-wise revenue.

### Database Details
**Database Name:** `elearning_analysis`

### Tables Used

1. **learners**
   - learner_id (Primary Key)
   - full_name
   - country

2. **courses**
   - course_id (Primary Key)
   - course_name
   - category
   - unit_price

3. **purchases**
   - purchase_id (Primary Key)
   - learner_id (Foreign Key)
   - course_id (Foreign Key)
   - quantity
   - purchase_date

### Dataset Information
- 5 Learners
- 6 Courses
- 5 Course Categories
- 8 Purchase Records

### SQL Concepts Used
- Database and Table Creation
- Primary Key and Foreign Key
- INSERT and SELECT Statements
- INNER JOIN
- LEFT JOIN
- RIGHT JOIN
- GROUP BY and HAVING
- ORDER BY and LIMIT
- SUM() and COUNT(DISTINCT)
- Revenue Calculation

### Analytical Questions
1. Calculate each learner's total spending.
2. Find the top 3 most purchased courses.
3. Calculate category-wise revenue and unique learners.
4. Identify learners who purchased from multiple categories.
5. Find courses that have never been purchased.

### Key Insights
- Data Analytics generated the highest revenue of 6,000.00.
- SQL for Beginners was the most purchased course with 4 units sold.
- David Lee recorded the highest spending of 5,500.00.
- Cyber Security Basics had no purchases.

### Recommendations
- Focus marketing on high-performing course categories.
- Promote popular courses to attract more learners.
- Introduce course bundles and cross-selling campaigns.
- Offer promotions for courses with zero purchases.

### Project Files
- `elearning_analysis_assignment3.sql` – Complete MySQL script.
- `E_Learning_Analysis_Summary_Report.docx` – Project summary report.

### Conclusion
This project demonstrates how MySQL can be used to manage relational data and generate meaningful business insights through joins, aggregation, and analytical queries.

**Tool Used:** MySQL 8.0

**Project Type:** Data Analytics
