SELECT *
FROM country
WHERE country. `Continent` = 'Asia';

SELECT Name, Continent
FROM country
WHERE country.`Continent`= 'Europe';

--주석처리 
--쿼리끝 ; 
--대문자 선호 (소문자도 가능) 
--가독성 위하 줄바꿈 해주기(복잡한 조건 고려) 
--공백무관, 똑같이 출력 
--CT+/ 여러줄 주석처리 
/*
여러줄 
주석마련
어때요?
*/
--ct+Ent 


SELECT * FROM country WHERE `Continent` = 'Asia';
-- 가능하지만, 키워드별로 나눠주기


