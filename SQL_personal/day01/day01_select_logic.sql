-- Active: 1752194083940@@127.0.0.1@3306@world
USE world;
SHOW TABLES;
DESC country;

SELECT c.Continent AS 대륙, c.Name AS 이름, c.`Population`AS 인구
FROM country c 
WHERE c.Continent = 'Asia'
--WHERE 대륙 = 'Asia'; 
--where의 실행은 SELECT 앞이라 별칭 작동 x 
--> 원래대로 c.Contient='Asia'; 해주어야! c 별칭을 만든 FROM은 맨 앞이라 어께이 

ORDER BY 인구; 
--Orderby는 실행순서가 SELECT 별칭단계 뒤에 오므로, 정상작동!