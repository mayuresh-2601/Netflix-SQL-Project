# 🎬 **Netflix Movies and TV Shows Data Analysis Using SQL**

![Netflix Logo](https://github.com/mayuresh-2601/Netflix-SQL-Project/blob/main/logo.png)

## 📌 Overview

This project analyzes Netflix’s dataset using SQL to uncover meaningful insights.  
The aim is to understand content distribution, audience ratings, genres, global production trends, and patterns hidden within the data.

## 🎯 Objectives

- Compare Movies vs TV Shows  
- Identify common audience ratings  
- Explore global content distribution  
- Analyze content by country and release year  
- Identify longest content and genre trends  
- Explore director-specific patterns  
- Categorize content using keyword analysis  

## 📁 Dataset

The dataset is publicly available on **Kaggle** under:  
**Netflix Movies and TV Shows Dataset**

It includes details such as:  
✔ Title  
✔ Cast  
✔ Director  
✔ Rating  
✔ Duration  
✔ Genre  
✔ Release Year  
✔ Country  
✔ Description  

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
```

# 🔍 **Business Problems & SQL Solutions**

### **1️⃣ Count Movies vs TV Shows**

```sql
SELECT type, COUNT(*)
FROM netflix
GROUP BY type;
```

### **2️⃣ Movies Released in 2020**

```sql
SELECT *
FROM netflix
WHERE release_year = 2020;
```

### **3️⃣ Top 5 Countries with the Most Content**

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
```

### **4️⃣ Identify the Longest Movie**

```sql
SELECT *
FROM netflix
WHERE type = 'Movie'
ORDER BY SPLIT_PART(duration, ' ', 1)::INT DESC;
```

### **5️⃣ Content Added in the Last 5 Years**

```sql
SELECT *
FROM netflix
WHERE TO_DATE(date_added, 'Month DD, YYYY') >= CURRENT_DATE - INTERVAL '5 years';
```

### **6️⃣ Content by Director “Rajiv Chilaka”**

```sql
SELECT *
FROM (
    SELECT *, UNNEST(STRING_TO_ARRAY(director, ',')) AS director_name
    FROM netflix
) AS t
WHERE director_name = 'Rajiv Chilaka';
```

### **7️⃣ Good vs Bad Content Categorization**

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
```

## 📊 Findings & Conclusion

- Netflix has a strong balance between Movies and TV Shows.  
- Ratings like **TV-MA, TV-14, PG-13** frequently appear.  
- The **United States, India, and the UK** are the biggest contributors.  
- Content additions increased sharply post-2018.  
- Keyword-based classification shows mixed content types.  

## 👨‍💻 **Author – Mayuresh Kasar**

This project is part of my **Data Analytics portfolio**.  
Feel free to connect for collaboration or feedback!
