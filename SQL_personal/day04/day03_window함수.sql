--- 윈도우함수 
--- 각 행 개별정보 유지하며, 데이터 특정부분 기준 집계/순위 계산 
--- 각 행마다 분석된 값 반환 (집계한 다음 붙임)

---GROUP BY 는 집계한 결과만 반환 (그룹당 하나의 행)
---윈도우 함수는 기존데이터에 집계된값 추가 
---즉, 요약없이 기존값 + 집계값 함께 보여줌 (전체결과집합 행의 수 그대로)

---프레임 지정 : 이동평균 구하기 (범위지정)

--전처리 실습 11) 2)번 문제 해결 가능 
--윈도우 함수 사용시, 간편해지는 일이 많다. 
--CTE + 윈도우함수 + 메인쿼리 

WITH df AS (
    SELECT c.`Name`, c.`Continent`, c.`LifeExpectancy`, 
            AVG(c.`LifeExpectancy`) OVER (PARTITION BY c.`Continent`) AS a_le
    FROM country AS c)
SELECT Name, `Continent`,`LifeExpectancy`,
        COALESCE(`LifeExpectancy`,a_le)
FROM df;


---윈도우함수 다양한 함수들 
---집계함수 
--SUM(집계컬럼) OVER (PARTITION BY 그룹컬럼 ORDER BY 정렬컬럼)
--AVG(집계컬럼) OVER (PARTITION BY 그룹컬럼 ORDER BY 정렬컬럼 [ROWS BETWEEN ...])

---누적합계  
SELECT c.`Name`, c.`Population`,
        SUM(c.`Population`) OVER (ORDER BY c.`Population` DESC)
FROM country AS c
WHERE c.`Continent` = 'Asia';

---이동평균 : 보통은 주가에 쓰임 
--- 유럽(Europe) 국가들의 인구를 기준으로, 현재 행의 앞뒤 1개씩(총 3개국)의 이동 평균 인구 계산하기
SELECT
    c.Name, c.Population,
    AVG(c.Population) OVER (
                        ORDER BY c.Population DESC 
                        ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
                        ) AS moving_avg_3
FROM country AS c
WHERE Continent = 'Europe'
LIMIT 5;

--- 순위계산 
--ROW_NUMBER() OVER (PARTITION BY 그룹컬럼 ORDER BY 정렬컬럼)
--RANK() OVER (PARTITION BY 그룹컬럼 ORDER BY 정렬컬럼)
--DENSE_RANK() OVER (PARTITION BY 그룹컬럼 ORDER BY 정렬컬럼)


WITH scores AS (
    SELECT 'A학생' AS name, 95 AS score
    UNION ALL SELECT 'B학생', 90
    UNION ALL SELECT 'C학생', 85
    UNION ALL SELECT 'D학생', 85
    UNION ALL SELECT 'E학생', 85
    UNION ALL SELECT 'F학생', 70
)
SELECT
    name, score,
    ROW_NUMBER() OVER (ORDER BY score DESC) AS row_num,
    RANK()       OVER (ORDER BY score DESC) AS rnk,
    DENSE_RANK() OVER (ORDER BY score DESC) AS dense_rnk
FROM scores;


---NTILE(N) : 등급 나누기 
---- `RANK()`나 `DENSE_RANK()`가 개별 순위를 매기는 것과 달리,
---- `NTILE(N)`은 데이터를 N개의 비슷한 크기로 나눈 뒤 **그룹 순위**를 부여합니다.
---- 예를 들어 `NTILE(4)`는 데이터를 4개의 그룹(사분위)으로 나누고 1, 2, 3, 4 중 하나의 그룹 번호를 할당합니다.

SELECT 
    Name, GNP,
    NTILE(4) OVER (ORDER BY GNP DESC) AS gnp_tier
FROM country
WHERE GNP > 0;


--- 값 구하기 
--- (1) FIRST_VALUE() , LAST_VALUE() 
---FIRST_VALUE(컬럼) OVER (PARTITION BY 그룹컬럼 ORDER BY 정렬컬럼 [ROWS BETWEEN ...])
---LAST_VALUE(컬럼) OVER (PARTITION BY 그룹컬럼 ORDER BY 정렬컬럼 [ROWS BETWEEN ...])

SELECT DISTINCT
    Continent,
    FIRST_VALUE(Name) OVER (PARTITION BY Continent ORDER BY LifeExpectancy DESC) AS highest_le_country,
    LAST_VALUE(Name) OVER (PARTITION BY Continent ORDER BY LifeExpectancy DESC 
									        ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS lowest_le_country
FROM country
WHERE Continent IS NOT NULL AND LifeExpectancy IS NOT NULL;

---(2) LAG(), LEAD() : 현재행에서 N번ㄴ째 이전/이후 컬럼 값 가져오기 
---LAG(컬럼, N, 기본값) OVER (PARTITION BY 그룹컬럼 ORDER BY 정렬컬럼)
---LEAD(컬럼, N, 기본값) OVER (PARTITION BY 그룹컬럼 ORDER BY 정렬컬럼)

SELECT 
    Name, LifeExpectancy,
    LAG(LifeExpectancy, 1, 0) OVER (ORDER BY LifeExpectancy DESC) AS previous_country_le,
    LifeExpectancy - LAG(LifeExpectancy, 1, 0) OVER (ORDER BY LifeExpectancy DESC) AS diff_with_previous
FROM country
WHERE Continent = 'Africa' AND LifeExpectancy IS NOT NULL
LIMIT 5;

---집계함수, 대상열이 인수라 필요 
---순위함수, 함수자체에 인수 불요 (NTILE제외) 
---값 함수, 인수필요 (어떤 컬럼에서 가져올지)