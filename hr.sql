SELECT
    *
FROM
    employees;

SELECT
    first_name,
    last_name,
    job_id
FROM
    employees;
    

-- 사원번호가 176인 사람의 LAST_NAME 조회
SELECT
    last_name
FROM
    employees
WHERE
    employee_id = 176;
-- 연봉이 12000 이상 되는 직원들의 LAST_NAME, SALARY 조회
SELECT
    last_name,
    salary
FROM
    employees
WHERE
    salary >= 12000;
-- 연봉이 5000에서 12000 범위가 아닌 사람들의 LAST_NAME, SALARY 조회
SELECT
    last_name,
    salary
FROM
    employees
WHERE
    salary < 5000
    OR salary > 12000
ORDER BY
    last_name DESC;--(5000보다 작거나 12000보다크면)
    
    
    
    
    
-- 20, 50번 부서에서 근무하는 모든 사원들의 LAST_NAME, 부서번호를 오름차순으로 조회
SELECT
    last_name,
    department_id
FROM
    employees
WHERE
    department_id IN ( 20, 50 )
ORDER BY
    last_name,
    department_id;
    
    
-- 커미션을 받는 모든 사원들의 LAST_NAME, 연봉, 커미션 조회(연봉의 내림차순, 커미션 내림차순)
SELECT
    last_name,
    salary,
    commission_pct
FROM
    employees
WHERE
    commission_pct > 0
ORDER BY
    salary DESC,
    commission_pct DESC;


-- 연봉이 2500, 3500, 7000이 아니며 직업이 SA_REP나 ST_CLERK인 사원 조회
SELECT
    *
FROM
    employees
WHERE
    salary NOT IN ( 2500, 3500, 7000 )
    AND job_id IN ( 'SA_REP', 'ST_CLERK' );


-- 2008/02/20 ~ 2008/05/01 사이에 고용된 사원들의 last_name, 사번, 고용일자 조회
-- 고용일자 내림차순 정렬 
-- 날짜 표현시 홀따옴표 안에 표현 - OR / 사용 가능
SELECT
    last_name,
    employee_id,
    hire_date
FROM
    employees
WHERE
    hire_date BETWEEN '2008-02-20' AND '2008-05-01'
ORDER BY
    hire_date DESC;
    
    
-- 2004년도에 고용된 사원들 조회 last_name, hire_date 조회
-- 고용일자 오름차순 정렬 
SELECT
    last_name,
    hire_date
FROM
    employees
WHERE
        hire_date >= '2004-01-01'
    AND hire_date <= '2004-12-31'
ORDER BY
    hire_date;
    
    
-- 부서가 20, 50이고 연봉이 5000에서 12000 범위인 사람들의 LAST_NAME, SALARY 조회
SELECT
    department_id,
    salary,
    last_name
FROM
    employees
WHERE
    department_id IN ( 20, 50 )
    AND salary BETWEEN 5000 AND 12000
ORDER BY
    salary;
    
-- LIKE 
-- 2004년도에 고용된 사원들의 last_name, hired_date 조회
-- 고용일자 오름차순 정렬 
SELECT
    *
FROM
    employees
WHERE
    hire_date LIKE '04%'
ORDER BY
    hire_date;

-- LAST_NAME 에 u가 포함된 사원들의 사번, last_name 조회
SELECT
    employee_id,
    last_name
FROM
    employees
WHERE
    last_name LIKE '%u%';

-- LAST_NAME 에 네번째 글자가 a인 사원들의 last_name 조회
SELECT
    last_name
FROM
    employees
WHERE
    last_name LIKE '___a%';

-- LAST_NAME 에 a 혹은 e 글자가 포함된 사원들의 last_name 조회
-- last_name 오름차순 정렬 
SELECT
    last_name
FROM
    employees
WHERE
    last_name LIKE '%a%'
    OR last_name LIKE '%e%'
ORDER BY
    last_name;

-- LAST_NAME 에 a 와 e 글자가 포함된 사원들의 last_name 조회
-- last_name 오름차순 정렬
SELECT
    last_name
FROM
    employees
WHERE
    last_name LIKE '%a%e%'
    OR last_name LIKE '%e%a%'
ORDER BY
    last_name;

-- 매니저(manager_id)가 없는 사람들의 last_name, job_id 조회
SELECT
    last_name,
    job_id
FROM
    employees
WHERE
    manager_id IS NULL
    OR manager_id = ' ';

-- job_id 가 ST_CLERK가 아닌 인 사원의 부서번호 조회(단, 부서 번호가 NULL 인 사원은 제외)
-- 중복을 제거한 후 부서번호만 조회
SELECT DISTINCT
    department_id
FROM
    employees
WHERE
        job_id = 'ST_CLERK'
    AND department_id IS NOT NULL;

-- commission_pct 가 null 이 아닌 사원들 중에서 commission = salary * commission_pct를 구해서
-- employee_id, first_name, job_id 출력
SELECT
    employee_id,
    first_name,
    job_id,
    salary * commission_pct AS commission
FROM
    employees
WHERE
    commission_pct IS NOT NULL;
    
    
-- first_name 이 Curtis인 사람의 first_name, last_name, email, phone_number, job_id를 조회
-- 단, job_id의 결과는 소문자로 출력되도록 한다
SELECT
    first_name,
    last_name,
    email,
    phone_number,
    lower(job_id)
FROM
    employees
WHERE
    first_name = 'Curtis';

--부서번호가 60, 70, 80, 90인 사원들의 employee_id, first_name, hire_date, job_id 조회
-- 단, job_id가 IT_PROG인 사원의 경우 프로그래머로 변경 후 출력
SELECT
    employee_id,
    first_name,
    hire_date,
    replace(job_id, 'IT_PROG', '프로그래머')
FROM
    employees
WHERE
    department_id IN ( 60, 70, 80, 90 );


-- job_id가 AD_PRES, PU_CLERK인 사원들의 employee_id, first_name, last_name, department_id 를 조회
-- 단 사원명은 first_name과 last_name 을 연결하여 출력 
SELECT
    employee_id,
    concat(first_name,
           concat(' ', last_name)),
    department_id
FROM
    employees
WHERE
    job_id IN ( 'AD_PRES', 'PU_CLERK' );
    
    
-- 부서 80의 각 사원에 대해 적용가능한 세율을 표시하시오
SELECT
    last_name,
    salary,
    decode(trunc(salary / 2000, 0),
           0,
           0.00,
           1,
           0.09,
           2,
           0.20,
           3,
           0.30,
           4,
           0.40,
           5,
           0.42,
           6,
           0.44,
           0.45) AS tax_trate
FROM
    employees
WHERE
    department_id = 80;
    

-- 회사 내의 최대 연봉 및 최소 연봉의 차이를 출력
SELECT
    MAX(salary) - MIN(salary) AS sal_gap
FROM
    employees;

-- 매니저로 근무하는 사원들의 총 숫자 출력(매니저 중복제거)
SELECT
    COUNT(DISTINCT manager_id)
FROM
    employees;



-- 서브쿼리
-- LAST_NAME에 u가 포함된 사원들과 동일부서에 근무하는 사원들의 사번, last_name 조회
SELECT
    employee_id,
    last_name
FROM
    employees e1
WHERE
    e1.department_id IN (
        SELECT DISTINCT
            department_id
        FROM
            employees
        WHERE
            last_name LIKE '%u%'
    )
ORDER BY
    e1.employee_id;
    
    
-- job_id가 SA_MAN인 사원들의 최대 연봉보다 높게 받는 사원들의 last_name, job_id, salary 조회
SELECT
    last_name,
    job_id,
    salary
FROM
    employees
WHERE
    salary > (
        SELECT
            MAX(salary)
        FROM
            employees
        WHERE
            job_id = 'SA_MAN'
    );

-- 커미션을 버는 사원들의 부서와 연봉이 동일한 사원들의 last_name, department_id, salary 조회
SELECT
    last_name,
    department_id,
    salary,
    commission_pct
FROM
    employees
WHERE
    ( department_id, salary ) IN (
        SELECT
            department_id, salary
        FROM
            employees
        WHERE
            commission_pct > 0
    );
    
    
-- 회사 전체 평균 연봉보다 더 받는 사원들 중 last_name 에 u가 있는 사원들이 근무하는 부서에서
-- 근무하는 사원들의 employee_id, last_name, salary 조회
SELECT
    employee_id,
    last_name,
    salary
FROM
    (
        SELECT DISTINCT
            department_id
        FROM
            employees
        WHERE
                salary > (
                    SELECT
                        round(AVG(salary),
                              0)
                    FROM
                        employees
                )
            AND last_name LIKE '%u%'
    )         dept,
    employees e
WHERE
    e.department_id = dept.department_id
ORDER BY
    employee_id;
    
-- last_name 이 Davies인 사람보다 나중에 고용된 사원들의 last_name, hire_date 조회
SELECT
    last_name,
    hire_date
FROM
    employees
WHERE
    hire_date > (
        SELECT
            hire_date
        FROM
            employees
        WHERE
            last_name = 'Davies'
    )
ORDER BY
    hire_date;


-- last_name이 King인 사원을 매니저로 두고 있는 모든 사원들의 last_name, salary 조회
SELECT
    last_name,
    salary
FROM
    employees
WHERE
    manager_id IN (
        SELECT
            employee_id
        FROM
            employees
        WHERE
            last_name = 'King'
    );
    
    