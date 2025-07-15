--- CTE (서브쿼리 가독성 있는 버젼)
--- 쿼리 안에서 잠깐 쓰는'임시테이블' LIKE lambda함수? 
--- 서브쿼리 대체해 쿼리의 가독성 높이기 
--- 가독성, 구조화 초점, 일회성 임시결과물 

---WITH절로 임시결과 정의 (임시view 선언) 1개 이상 CTE 먼저 선언! 
---메인쿼리에서 가져다 씀 

--- 예시 : 각 대륙에서 인구가 가장 많은 국가의 정보 찾기

-- 1. 대륙별 최대 인구를 계산하는 CTE를 정의합니다.
WITH ContinentMaxPopulation AS (
    SELECT
        Continent,
        MAX(Population) AS max_pop
    FROM
        country
    GROUP BY
        Continent
)
-- 2. 메인 쿼리에서 원본 country 테이블과 CTE를 조인합니다.
SELECT
    c.Continent,
    c.Name,
    c.Population
FROM
    country c
JOIN
    ContinentMaxPopulation AS cmp 
    ON c.Continent = cmp.Continent -- 대륙이 같고
	AND c.Population = cmp.max_pop -- 해당 국가의 인구가 그 대륙의 최대 인구와 같은 경우
WHERE c.Population > 0 -- 각 대륙별 가장 인구가 많은 나라(0값 없이 추출 가능)
ORDER BY
    c.Continent;

--- CTE 활용시, 단계별 / 논리적 접근 가능 -> 이해가 쉽다 
--- 서브쿼리와 같은 결과긴 함 
