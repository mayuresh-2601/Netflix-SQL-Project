-- SCHEMAS of Netflix.

-- Create Database For My Project Data Analysis.

create database if not exists netflix_project;

use netflix_project;

-- Create Table for netflix.

CREATE TABLE netflix(
   show_id      VARCHAR(5) NOT NULL PRIMARY KEY
  ,type         VARCHAR(7) NOT NULL
  ,title        VARCHAR(104) NOT NULL
  ,director     VARCHAR(208)
  ,cast         VARCHAR(771)
  ,country      VARCHAR(123)
  ,date_added   DATE 
  ,release_year INTEGER  NOT NULL
  ,rating       VARCHAR(8)
  ,duration     VARCHAR(10)
  ,listed_in    VARCHAR(79) NOT NULL
  ,description  VARCHAR(248) NOT NULL
);

-- Show all Netflix catalog data to begin initial analysis.
select * from netflix;
