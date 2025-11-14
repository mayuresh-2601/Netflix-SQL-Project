# Netflix Movies and TV Shows Data Analsis Using SQL

![Netflix Logo](https://github.com/mayuresh-2601/Netflix-SQL-Project/blob/main/logo.png)


## 📌 Overview

This project analyzes Netflix's dataset using SQL to uncover meaningful insights.
The goal is to understand content distribution, ratings, genres, global production trends, and patterns hidden within the dataset.

## 🎯 Objectives

Compare Movies vs TV Shows.
Identify common audience ratings.
Explore global content distribution.
Analyze content by country and release year.
Identify longest content, common genres, and director-specific content.
Extract insights using keyword-based categorization.

## 📁 Dataset

The dataset used is publicly available on Kaggle:
Netflix Movies and TV Shows Dataset.

It contains detailed information about titles, cast, directors, rating, duration, genres, and more.

## 🗂️ Schema Used

```sql
DROP TABLE IF EXISTS netflix;
CREATE TABLE netflix
(
    show_id      VARCHAR(5),
    type         VARCHAR(10),
    title        VARCHAR(250),
    director     VARCHAR(550),
    casts        VARCHAR(1050),
    country      VARCHAR(550),
    date_added   VARCHAR(55),
    release_year INT,
    rating       VARCHAR(15),
    duration     VARCHAR(15),
    listed_in    VARCHAR(250),
    description  VARCHAR(550)
);

## 🔍Business Problems & SQL Solutions 

 Count Movies vs TV Shows
```sql
SELECT type, COUNT(*)
FROM netflix
GROUP BY type;

Insight: Understand overall content distribution.


List All Movies Released in a Specific Year (2020 Example)
```sql
SELECT *
FROM netflix
WHERE release_year = 2020;

Insight: Review content by release year.

Top 5 Countries with the Most Content
```sql
SELECT country, COUNT(*) AS total_content
FROM (
  SELECT UNNEST(STRING_TO_ARRAY(country, ',')) AS country
  FROM netflix
) AS t
WHERE country IS NOT NULL
GROUP BY country
ORDER BY total_content DESC
LIMIT 5;

Insight: Shows strongest-producing countries.

Identify the Longest Movie
```sql
SELECT *
FROM netflix
WHERE type = 'Movie'
ORDER BY SPLIT_PART(duration, ' ', 1)::INT DESC;

Insight: Find top long-form content.

Content Added in the Last 5 Years
```sql
SELECT *
FROM netflix
WHERE TO_DATE(date_added, 'Month DD, YYYY') >= CURRENT_DATE - INTERVAL '5 years';

Insight: Shows recent platform growth.

 Content by Director "Rajiv Chilaka"
```sql
SELECT *
FROM (
    SELECT *, UNNEST(STRING_TO_ARRAY(director, ',')) AS director_name
    FROM netflix
) AS t
WHERE director_name = 'Rajiv Chilaka';

Insight: Analyze director-based content.

 Categorize Content as “Good” or “Bad” (Based on Keywords)
```sql
SELECT category, COUNT(*) AS content_count
FROM (
    SELECT CASE
             WHEN description ILIKE '%kill%' OR description ILIKE '%violence%' THEN 'Bad'
             ELSE 'Good'
           END AS category
    FROM netflix
) AS t
GROUP BY category;

Insight: Simple NLP-based content classification.

## 📊 Findings & Conclusion

Netflix hosts a balanced mix of movies and TV shows, with shows growing rapidly.
Certain ratings appear consistently, reflecting Netflix’s broad audience focus.
The United States, India, and the UK contribute large portions of total content.
Content released in recent years shows strong increasing trends, especially post-2018.
Keyword-based classification indicates that Netflix contains both family-friendly and mature content.
Overall, this project demonstrates how SQL can extract deep insights from raw data and support content strategy decisions.

## 👨‍💻 Author – Mayuresh Kasar 

This project is part of my Data Analytics portfolio, showcasing SQL skills used in real business scenarios.
For collaboration or feedback, feel free to connect!
