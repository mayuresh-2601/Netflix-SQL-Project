-- Netflix Data Analysis using SQL
-- 30 business problems  mysql solutions
-- netflix sql project (simple version for mysql workbench)

use netflix_project;

-- 1. count the number of movies vs tv shows 
select type, count(*) as total_count
from netflix
group by type;

-- 2. find the most common rating for movies and tv shows 

select type, rating, count(*) as total_count
from netflix
group by type, rating
order by total_count desc;


-- 3. list all movies released in a specific year (example: 2020) 
select *
from netflix
where type = 'movie'
  and release_year = 2020;


-- 4. find the top 5 countries with the most content (simple version) 
select country, count(*) as total_content
from netflix
where country is not null and country <> ''
group by country
order by total_content desc
limit 5;


-- 5. identify the longest movie 
select title, duration
from netflix
where type = 'movie'
order by cast(substring_index(duration,' ',1) as unsigned) desc
limit 1;


-- 6. find content added in the last 5 years 
select title, date_added
from netflix
where date_added >= date_sub(curdate(), interval 5 year);


-- 7. find all content by director “rajiv chilaka” 
select *
from netflix
where director like '%rajiv chilaka%';


-- 8. list all tv shows with more than 5 seasons
select title, duration
from netflix
where type = 'tv show'
  and cast(substring_index(duration,' ',1) as unsigned) > 5;


-- 9. count the number of content items in each genre (simple using listed_in) 
select listed_in, count(*) as total_count
from netflix
group by listed_in
order by total_count desc;


-- 10. top 5 years with highest number of india releases 
select release_year, count(*) as total_titles
from netflix
where country like '%india%'
group by release_year
order by total_titles desc
limit 5;


-- 11. list all movies that are documentaries
select *
from netflix
where type = 'movie'
  and listed_in like '%documentary%';


-- 12. find all content without a director 
select *
from netflix
where director is null or trim(director) = '';


-- 13. count movies actor “salman khan” appeared in last 10 years 
select count(*) as salman_khan_movies
from netflix
where type = 'movie'
  and `cast` like '%salman khan%'
  and release_year >= year(curdate()) - 10;


-- 14. top 10 actors in movies produced in india (simple contains match) 
select `cast`, count(*) as total_movies
from netflix
where type = 'movie'
  and country like '%india%'
group by `cast`
order by total_movies desc
limit 10;


-- 15. categorize content as good/bad using keywords "kill" or "violence" 
select
    case
        when lower(description) like '%kill%' 
          or lower(description) like '%violence%' then 'bad'
        else 'good'
    end as category,
    count(*) as total_content
from netflix
group by category;


-- 16. find the oldest content available on netflix
select title, release_year
from netflix
order by release_year
limit 1;


-- 17. find the newest content added to netflix 
select title, date_added
from netflix
order by date_added desc
limit 1;


-- 18. identify the shortest movie 
select title, duration
from netflix
where type = 'movie'
order by cast(substring_index(duration,' ',1) as unsigned)
limit 1;


-- 19. find the top 10 genres globally (simple using listed_in) 
select listed_in, count(*) as total
from netflix
group by listed_in
order by total desc
limit 10;


-- 20. count how many content items were released before 2000 
select count(*) as total_old_content
from netflix
where release_year < 2000;


-- 21. find the number of tv shows released each decade 
select
    (release_year div 10) * 10 as decade,
    count(*) as total_tv_shows
from netflix
where type = 'tv show'
group by decade
order by decade;


-- 22. identify countries producing more tv shows than movies (simple version) 
select country,
    sum(case when type='tv show' then 1 else 0 end) as total_tv,
    sum(case when type='movie' then 1 else 0 end) as total_movies
from netflix
group by country
having total_tv > total_movies;


-- 23. find the average duration of tv shows (in seasons) 
select avg(cast(substring_index(duration,' ',1) as unsigned)) as avg_seasons
from netflix
where type = 'tv show';


-- 24. find the average duration of movies (in minutes) 
select avg(cast(substring_index(duration,' ',1) as unsigned)) as avg_minutes
from netflix
where type = 'movie';


-- 25. list all content available in multiple countries (contains comma) 
select *
from netflix
where country like '%,%';


-- 26. find all content with love/romance/relationship keywords in description 
select *
from netflix
where lower(description) like '%love%'
   or lower(description) like '%romance%'
   or lower(description) like '%relationship%';


-- 27. find all thriller keyword content: crime, killer, mystery 
select *
from netflix
where lower(description) like '%crime%'
   or lower(description) like '%killer%'
   or lower(description) like '%mystery%';


-- 28. find directors who directed more than 3 movies (simple contains match) 
select director, count(*) as movie_count
from netflix
where type = 'movie'
  and director is not null
group by director
having movie_count > 3
order by movie_count desc;


-- 29. find actors who appeared in content from at least 3 countries (simple) 
select `cast`, count(distinct country) as country_count
from netflix
where `cast` is not null
group by `cast`
having country_count >= 3
order by country_count desc;


-- 30. find which country produces the highest number of documentaries 
select country, count(*)  total_docs
from netflix
where listed_in like '%documentary%'
group by country
order by total_docs desc
limit 1;


/* 
categorize the content based on the keywords 'kill' and 'violence'.
label content with these keywords as 'bad' and all others as 'good'.
count how many items fall into each category.
*/

select case when lower(description) like '%kill%'
or lower(description) like '%violence%' then 'bad'
else 'good'end  category,
count(*)  total_items
from netflix
group by category;



-- End of reports.

