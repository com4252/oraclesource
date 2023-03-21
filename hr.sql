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
select * from employees where hire_date like '04%' order by hire_date;

-- LAST_NAME 에 u가 포함된 사원들의 사번, last_name 조회
select employee_id, last_name from employees where last_name like '%u%';

-- LAST_NAME 에 네번째 글자가 a인 사원들의 last_name 조회
select last_name from employees where last_name like '___a%';

-- LAST_NAME 에 a 혹은 e 글자가 포함된 사원들의 last_name 조회
-- last_name 오름차순 정렬 
select last_name from employees where last_name like '%a%' or last_name like '%e%' order by last_name;

-- LAST_NAME 에 a 와 e 글자가 포함된 사원들의 last_name 조회
-- last_name 오름차순 정렬
select last_name from employees where last_name like '%a%e%' or last_name like '%e%a%' order by last_name;

-- 매니저(manager_id)가 없는 사람들의 last_name, job_id 조회
select last_name, job_id from employees where manager_id is null or manager_id = ' ';

-- job_id 가 ST_CLERK가 아닌 인 사원의 부서번호 조회(단, 부서 번호가 NULL 인 사원은 제외)
-- 중복을 제거한 후 부서번호만 조회
select distinct department_id from employees where job_id = 'ST_CLERK' and department_id is not null;

-- commission_pct 가 null 이 아닌 사원들 중에서 commission = salary * commission_pct를 구해서
-- employee_id, first_name, job_id 출력
select employee_id, first_name, job_id, salary*commission_pct as commission from employees where commission_pct is not null;
