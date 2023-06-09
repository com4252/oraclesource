--scott


--emp 테이블 구성 보기
--필드명(열이름)          제약조건     데이터타입
--  EMPNO(사원번호)    NOT NULL    NUMBER(4)
-- ENAME(사원명),JOB(직책),MGR(직속상관번호),HIREDATE(입사일),SAL(급여),COMM(수당),DEPTNO(부서번호)
-- NUMBER : 소수점 자릿수를 포함해서 지정 가능
-- NUMBER(4) : 4자리 숫자까지 허용, NUMBER(8,2) : 전체자릿수는 8자리이고 소수점 2자리를 포함
-- VARCHAR2 : 가변형 문자열 저장
-- VARCHAR2(10) : 10byte 문자까지 저장가능 
-- DATE : 날짜 데이터

DESC emp;

--DEPTNO(부서번호), DNAME(부서명), LOC(부서위치)
DESC dept;

-- GRADE(급여등급), LOSAL(최소 급여액), HISAL(최대 급여액)
DESC salgrade;


--select : 데이터 조회
-- 조회방식 : 셀렉션(행 단위로 조회), 프로젝션(열단위로조회), 조인(두개이상의 테이블을 사용하여 조회)
--SELECT 열이름1, 열이름2......(조회할 열이 전체라면 *로처리)
--FROM 테이블명;

--1. EMP 테이블의 전체 열을 조회
SELECT
    *
FROM
    emp;

--2. EMP 테이블에서 사원번호, 이름, 급여 등을 조회
SELECT
    empno,
    ename,
    sal
FROM
    emp;


-- 3. DEPT 테이블 전체 조회
SELECT
    *
FROM
    dept;
-- 4. DEPT 테이블 안에 부서번호, 지역만 조회
SELECT
    deptno,
    loc
FROM
    dept;
    
-- 5. EMP 테이블안에 부서번호 조회
SELECT
    deptno
FROM
    emp;
    
-- 6. EMP 테이블 안에 부서번호 조회(단, 중복된 부서 번호는 제거)
SELECT
    deptno
FROM
    emp;
    
    
-- DISTINCT : 중복 제거
SELECT DISTINCT
    deptno
FROM
    emp;

-- 열이 여러 개인 경우( 묶어서 중복이냐 아니냐를 판단)    
SELECT DISTINCT
    job,
    deptno
FROM
    emp;
    
-- 7. 연산
-- 별칭 : 필드에 별칭을 임의로 부여(as 별칭, 혹은 한칸 띄우고 별칭, 별칭에 공백이 있다면 " "묶기)
-- 사원들의 1년 연봉 구하기(SAL*12 + COMM )
SELECT
    empno,
    ename,
    sal,
    comm,
    sal * 12 + comm AS annsal
FROM
    emp;

SELECT
    empno           부서명,
    ename           사원명,
    job             "직 책",
    sal * 12 + comm annsal
FROM
    emp;
    
-- 8. 순서 : ORDER BY 
--         내림차순 => DESC(Descending), 오름차순 => ASC(Ascending)

-- ENAME, SAL 열 추출하고, SAL 내림차순으로 정렬

SELECT
    ename,
    sal
FROM
    emp
ORDER BY
    sal DESC;
    
-- ENAME, SAL 열 추출하고, SAL 오름차순으로 정렬

SELECT
    ename,
    sal
FROM
    emp
ORDER BY
    sal;            --ASC는 생략가능
    
    
-- 전체 내용 출력하고, 결과가 사원번호의 오름차순으로 정렬
SELECT
    *
FROM
    emp
ORDER BY
    empno;
    
    
-- 전체 내용 출력하고, 결과가 부서번호의 오름차순과 급여 내림차순으로 정렬
SELECT
    *
FROM
    emp
ORDER BY   -- 자원을 굉장히 소모, 데이터가 많을수록 시간이 많이걸림(보통 권장하지않음)
    deptno,
    sal DESC;
    
    
-- [실습] emp 테이블의 모든 열 출력
-- empno => employee_no
-- ename => employee_name
-- mgr => manager
-- sal => salary
-- comm => commission
-- deptno => department_no
-- 부서 번호를 기준으로 내림차순으로 정렬하되 부서번호가 같다면 
-- 사원 이름을 기준으로 오름차순 정렬
SELECT
    empno  AS employee_no,
    ename  AS employee_name,
    mgr    AS manager,
    sal    AS salary,
    comm   AS commission,
    deptno AS department_no
FROM
    emp
ORDER BY
    deptno DESC,
    ename ASC;
    
    
-- where : 특정 조건을 기준으로 원하는 행을 조회

-- 부서번호가 30인 데이터만 조회 
SELECT
    *
FROM
    emp
WHERE
    deptno = 30;  -- = : 같다

-- 사원번호가 7782인 사원 조회
SELECT
    *
FROM
    emp
WHERE
    empno = 7782;
    
-- 부서번호가 30이고(AND), 사원직책이 SALESMAN인 정보 조회
SELECT
    *
FROM
    emp
WHERE
        deptno = 30
    AND job = 'SALESMAN';  -- 직책은 대문자로되있어서 대문자로써야함

-- 사원번호가 7499이고, 부서번호가 30인 행 조회
SELECT
    *
FROM
    emp
WHERE
        empno = 7499
    AND deptno = 30;
    
-- 부서번호가 30이거나(OR), 사원직책이 CLERK인 행 조회
SELECT
    *
FROM
    emp
WHERE
    deptno = 30
    OR job = 'CLERK';
    
    
-- 산술 연산자 : +, -, *, /
-- 비교 연산자 : >, >=, <, <=
-- 등가비교연산자 : =, !=, <>, ^= (!=, <>, ^= : A값과 B값이 다를 경우 true, 같은경우 false)
-- 논리부정연산자 : NOT
-- IN 연산자
-- BETWEEN A AND B 연산자 
-- LIKE 연산자와 와일드 카드(_, %)
-- IS NULL 연산자 
-- 집합 연산자 : UNION(합집합-중복제거), UNION ALL(합집합-중복포함, MINUS(차집합), INTERSECT(교집합)

-- 연산자 우선순위
-- 1)산술연산자 *, /
-- 2)산술연산자 +, -
-- 3)비교연산자
-- 4) IS NULL, IS NOT NULL, LIKE, IN....
-- 5) BETWEEN A AND B
-- 6) NOT
-- 7) AND
-- 8) OR
-- 우선순위를 줘야 한다면 소괄호 사용 추천






-- EMP 테이블에서 급여열에 12를 곱한 값이 36000인 행 조회
SELECT
    *
FROM
    emp
WHERE
    sal * 12 = 36000;
    
    
-- ename 이 F 이후의 문자로 시작하는 사원 조회
-- 문자 표현시 ' ' 만 사용
SELECT
    *
FROM
    emp
WHERE
    ename >= 'F';

SELECT
    *
FROM
    emp
WHERE
    ename >= 'FORZ';
    
-- JOB이 MANAGER, SALESMAN, CLERK 사원 조회
SELECT
    *
FROM
    emp
WHERE
    job = 'MANAGER'
    OR job = 'SALESMAN'
    OR job = 'CLERK';

-- sal 이 3000이 아닌 사원 조회
SELECT
    *
FROM
    emp
WHERE
    sal != 3000;

SELECT
    *
FROM
    emp
WHERE
    sal <> 3000;

SELECT
    *
FROM
    emp
WHERE
    sal^= 3000;
    
-- JOB이 MANAGER, SALESMAN, CLERK 사원 조회 ==> IN 연산자
SELECT
    *
FROM
    emp
WHERE
    job IN ( 'MANAGER', 'SALESMAN', 'CLERK' );

-- JOB이 MANAGER, SALESMAN, CLERK 가 아닌 사원 조회
SELECT
    *
FROM
    emp
WHERE
        job != 'MANAGER'
    AND job <> 'SALESMAN'
    AND job^= 'CLERK';

SELECT
    *
FROM
    emp
WHERE
    job NOT IN ( 'MANAGER', 'SALESMAN', 'CLERK' );
    
    
-- 부서 번호가 10, 20 사원조회(in 사용)

SELECT
    *
FROM
    emp
WHERE
    deptno IN ( 10, 20 );

-- 급여가 2000이상 3000이하인 사원 조회
SELECT
    *
FROM
    emp
WHERE
        sal >= 2000
    AND sal <= 3000;
-- BETWEEN 최솟값 AND 최댓값;
SELECT
    *
FROM
    emp
WHERE
    sal BETWEEN 2000 AND 3000;

SELECT
    *
FROM
    emp
WHERE
    sal NOT BETWEEN 2000 AND 3000;    
    
-- LIKE 연산자와 와일드 카드(_, %)
-- _: 어떤 값이든 상관없이 한개의 문자 데이터를 의미
-- %: 길이와 상관없이 (문자 없는 경우도 포함) 모든 문자 데이터를 의미
-- 사원이름이 S로 시작하는 사원 정보 조회
SELECT
    *
FROM
    emp
WHERE
    ename LIKE 'S%';

-- 사원 이름의 두번째 글자가 L인 사원만 조회
SELECT
    *
FROM
    emp
WHERE
    ename LIKE '_L%'; --   _ = 문자 하나
-- 사원 이름에 AM이 포함된 사원만 조회
SELECT
    *
FROM
    emp
WHERE
    ename LIKE '%AM%';
-- 사원 이름에 AM이 포함되지 않은 사원만 조회
SELECT
    *
FROM
    emp
WHERE
    ename NOT LIKE '%AM%';

-- NULL : 데이터 값이 완전히 비어 있는 상태 
--   = 을 사용할 수 없음 is 사용

-- comm 이 null 인 사원 조회
SELECT
    *
FROM
    emp
WHERE
    comm IS NULL;

-- mgr 이 null 인 사원 조회
SELECT
    *
FROM
    emp
WHERE
    mgr IS NULL;

-- mgr 이 null 이 아닌 사원 조회
SELECT
    *
FROM
    emp
WHERE
    mgr IS NOT NULL;


-- 집합 연산자

-- union(동일한 결과값인 경우 중복 제거), union all(중복 포함) : 합집합 

SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
WHERE
    deptno = 10
UNION
SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
WHERE
    deptno = 10;

SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
WHERE
    deptno = 10
UNION ALL
SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
WHERE
    deptno = 10;


-- MINUS
SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
MINUS
SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
WHERE
    deptno = 10;


-- INTERSECT ( 교집합)
SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
INTERSECT
SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
WHERE
    deptno = 10;


-- emp 테이블에서 사원이름이 s로 끝나는 사원 데이터 조회
SELECT
    *
FROM
    emp
WHERE
    ename LIKE '%S';

-- emp 테이블에서 30번 부서에서 근무하는 사원 중에서 직책이 salesman 인 사원의
-- 사원번호, 이름, 급여 조회 (sal 내림차순)
SELECT
    empno,
    ename,
    sal
FROM
    emp
WHERE
        deptno = 30
    AND job = 'SALESMAN'
ORDER BY
    sal DESC;

-- emp 테이블을 사용하여 20,30번 부서에 근무하고 있는 사원중 급여가 2000초과인 사원 조회
-- 사원번호, 이름, 급여, 부서번호 조회
--집합연산자를 사용하는 방식과 사용하지 않는 방식 두가지 사용

-- 집합연산자를 사용하지 않는 경우
SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
WHERE
    deptno IN ( 20, 30 )
    AND sal > 2000;

-- 집합연산자를 사용하는 경우
SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
WHERE
    deptno IN ( 20, 30 )
    AND sal > 2000
MINUS
SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
WHERE
    deptno = 10;

SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
WHERE
        deptno = 20
    AND sal > 2000
UNION
SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
WHERE
        deptno = 30
    AND sal > 2000;

-- 사원이름에 E가 포함되어 있는 30번 부서 사원중 급여가 1000~2000사이가 아닌  사원의 이름
-- 사원번호, 급여, 부서번호를 조회하기
SELECT
    empno,
    ename,
    sal,
    deptno
FROM
    emp
WHERE
    ename LIKE '%E%'
    AND deptno = 30
    AND sal NOT BETWEEN 1000 AND 2000;

-- 추가 수당이 존재하지않으며, 상급자가 있고 직책이 manager, clerk 인 사원중에 사원이름의
-- 두번째 글자가 L이 아닌 사원의 정보 조회
SELECT
    *
FROM
    emp
WHERE
    comm IS NULL
    AND mgr IS NOT NULL
    AND job IN ( 'MANAGER', 'CLERK' )
    AND ename NOT LIKE '_L%';



-- 오라클 함수
-- 오라클에서 기본으로 제공하는 내장 함수와 사용자가 필요에 의해 직접 정의한 사용자 정의 함수 


-- 1. 문자열 함수
-- 1. UPPER, LOWER, INITCAP
-- UPPER : 모두 대문자, LOWER : 모두 소문자, INITCAP : 첫글자만 대문자 
-- LIKE '%ORACLE%' OR LIKE '%oracle%'
SELECT
    ename,
    upper(ename),
    lower(ename),
    initcap(ename)
FROM
    emp;

SELECT
    *
FROM
    emp
WHERE
    upper(ename) = 'FORD';

SELECT
    *
FROM
    emp
WHERE
    upper(ename) LIKE upper('%ford%');


-- 2) LENGTH : 문자열 길이
SELECT
    ename,
    length(ename)
FROM
    emp;

-- 사원 이름의 길이가 5 이상인 사원 조회

SELECT
    ename,
    length(ename)
FROM
    emp
WHERE
    length(ename) >= 5;


-- 한글일 때
-- dual : sys가 소유하는 테이블(임시 연산이나 함수의 결과 값 확인하는 용도)
-- length, lengthb(문자가 사용하는 바이트 수)
-- 영어 : 문자1 => 1byte, 한글 : 문자 1=> 3byte
SELECT
    length('한글'),
    lengthb('한글'),
    lengthb('ab')
FROM
    dual;
    
-- 3) SUBSTR(문자열데이터, 시작위치, 추출길이) : 추출길이 생략가능 
--    문자열 일부 추출

SELECT
    job,
    substr(job, 1, 2),
    substr(job, 3, 2),
    substr(job, 5)
FROM
    emp;


-- ename, 세번째 글자부터 출력
SELECT
    ename,
    substr(ename, 3)
FROM
    emp;

-- 3) INSTR : 문자열 데이터 안에서 특정 문자 위치 찾기
-- INSTR (대상문자열, 위치를 찾으려는 문자열, 대상문자열에서 찾기를 시작할 위치(선택사항), 시작위치에서 찾으려는 문자가 몇번째 인지 지정(선택))

-- HELLO, ORACLE! 문자열에서 L 문자열 찾기
SELECT
    instr('HELLO, ORACLE!', 'L')       AS instr_1,
    instr('HELLO, ORACLE!', 'L', 5)    AS instr_2,
    instr('HELLO, ORACLE!', 'L', 2, 2) AS instr_3
FROM
    dual;
    
    
-- 4) replace : 특정 문자를 다른 문자로 변경
-- replace(문자열데이터, 찾는문자, 변경문자)

-- 010-1234-5678     -를 빈 문자열로 변경/ -를없애기
SELECT
    '010-1234-5678'                    AS 변경전,
    replace('010-1234-5678', '-', ' ') AS replace_1,
    replace('010-1234-5678', '-')      AS replace_2
FROM
    dual;
    
    
-- '이것이 Oracle 이다', '이것이' => This is 변경
SELECT
    '이것이 Oracle 이다'                            AS 변경전,
    replace('이것이 Oracle 이다', '이것이', 'This is') AS 변경후
FROM
    dual;
    
-- 5) concat : 두 문자열 데이터 합치기
SELECT
    concat(empno, ename)
FROM
    emp;

SELECT
    concat(empno,
           concat(':', ename))
FROM
    emp;
    
    
-- || : 문자열 연결 연산자

SELECT
    empno || ename,
    empno
    || ':'
    || ename
FROM
    emp;
    
    
-- 6) TRIM, LTRIM, RTRIM : 공백 포함 특정 문자 제거 
-- ' ORACLE' = 'ORACLE' ==> FALSE
SELECT
    '             이것이        ',
    TRIM('             이것이        ')
FROM
    dual;
    
    
-- 2. 숫자함수
-- 1) ROUND, TRUNC, CEIL, FLOOR, MOD

-- round : 반올림
-- round (숫자, 반올림 위치 (선택))
SELECT
    round(1234.5678)      AS round,     -- 소수점 첫째자리에서 반올림
    round(1234.5678, 0)   AS round0,    -- 소수점 첫째자리에서 반올림
    round(1234.5678, 1)   AS round1,    -- 소수점 둘째자리에서 반올림
    round(1234.5678, 2)   AS round2,    -- 소수점 셋째자리에서 반올림
    round(1234.5678, - 1) AS round_minus1,  -- 자연수 첫째자리에서 반올림
    round(1234.5678, - 2) AS round_minus2   -- 자연수 둘째자리에서 반올림
FROM
    dual;
    
-- trunc : 특정 위치에서 버리는 함수
-- trunc : (숫자, 버림 위치(선택))

SELECT
    trunc(1234.5678)      AS trunc,     -- 소수점 첫째자리에서 버림
    trunc(1234.5678, 0)   AS trunc0,    -- 소수점 첫째자리에서 버림
    trunc(1234.5678, 1)   AS trunc1,    -- 소수점 둘째자리에서 버림
    trunc(1234.5678, 2)   AS trunc2,    -- 소수점 셋째자리에서 버림
    trunc(1234.5678, - 1) AS trunc_minus1,  -- 자연수 첫째자리에서 버림
    trunc(1234.5678, - 2) AS trunc_minus2   -- 자연수 둘째자리에서 버림
FROM
    dual;
    
    
-- ceil(숫자), floor(숫자) : 입력된 숫자와 가까운 큰 정수, 작은 정수

SELECT
    ceil(3.14),
    floor(3.14),
    ceil(- 3.14),
    floor(- 3.14)
FROM
    dual;


-- mod(숫자, 나눌수) : 나머지 값
SELECT
    mod(15, 6),
    mod(10, 2),
    mod(11, 2)
FROM
    dual;


-- 날짜 함수
-- 날짜 데이터 + 숫자 : 날짜 데이터보다 숫자만큼 일 수 이후의 날짜
-- 날짜데이터 - 날짜데이터 : 두 날짜 데이터 간의 일 수 차이

-- 날짜데이터 + 날짜데이터 : 연산불가

-- 1) sysdate 함수 : 오라클 데이터베이스 서버가 설치된 OS의 현재날짜와 시간을 가져옴 
SELECT
    sysdate,
    sysdate - 1 AS yesterday,
    sysdate + 1 AS tomorrow
FROM
    dual;
    

-- 2) add_months(날짜, 더할 개월수) : 몇 개월 이후 날짜 구하기
SELECT
    sysdate,
    add_months(sysdate, 3)
FROM
    dual;
    
    
-- 입사 50주년이 되는 날짜 구하기
-- empno, ename, hiredate, 입사 50주년 날짜
select empno, ename, hiredate, add_months(hiredate, 600) as 입사50주년 from emp


-- 3) MONTHS_BETWEEN : 두 날짜 데이터 간의 날짜 차이를 개월 수로 계산하여 출력
-- 입사 45년 미만인 사원 데이터 조회
-- empno, ename, hiredate
SELECT
    empno,
    ename,
    hiredate
FROM
    emp
WHERE
    months_between(sysdate, hiredate) < 540;


-- 현재 날짜와 6개월 후 날짜가 출력
SELECT
    sysdate,
    add_months(sysdate, 6)
FROM
    dual;

SELECT
    empno,
    ename,
    hiredate,
    sysdate,
    months_between(hiredate, sysdate)        AS months1,
    months_between(sysdate, hiredate)        AS months2,
    trunc(months_between(sysdate, hiredate)) AS months3
FROM
    emp;
    
    
-- 4) next_day(날짜, 요일) : 특정 날짜를 기준으로 돌아오는 요일의 날짜 출력
--    last_day(날짜) : 특정 날짜가 속한 달의 마지막 날짜를 출력
SELECT
    sysdate,
    next_day(sysdate, '금요일'),
    last_day(sysdate)
FROM
    dual; 
    
-- 날짜의 반올림, 버림 : ROUND, TRUNC
-- CC : 네 자리 연도의 끝 두자리를 기준으로 사용 
--      2023 년인 경우 2050 이하이므로 2001년으로 처리
SELECT
    sysdate,
    round(sysdate, 'CC')   AS format_cc,
    round(sysdate, 'YYYY') AS format_yyyy,
    round(sysdate, 'DDD')  AS format_ddd,
    round(sysdate, 'HH')   AS format_hh
FROM
    dual;
    
    



-- 형변환 함수 : 자료형을 형 변환
-- NUMBER, VARCHAR2, DATE

SELECT
    empno,
    ename,
    empno + '500'
FROM
    emp
WHERE
    ename = 'FORD';

SELECT
    empno,
    ename,
    'abcd' + empno
FROM
    emp
WHERE
    ename = 'FORD';
--ORA-01722: 수치가 부적합합니다
--01722. 00000 -  "invalid number"
--*Cause:    The specified number was invalid.
--*Action:   Specify a valid number.


-- TO_CHAR() : 숫자 또는 날짜 데이터를 문자 데이터로 변환
-- TO_NUMBER() : 문자데이터를 숫자데이터로 변환
-- TO_DATE() : 문자데이터를 날짜데이터로 변환

SELECT
    to_char(sysdate, 'YYYY/MM/DD HH24:MI:SS') AS 현재날짜시간
FROM
    dual;

-- MON, MONTH : 월이름 
-- DDD : 365일 중에서 며칠해당

SELECT
    sysdate,
    to_char(sysdate, 'yyyy/mm/dd')    AS 현재날짜,
    to_char(sysdate, 'yyyy')          AS 현재년도,
    to_char(sysdate, 'mm')            AS 현재월,
    to_char(sysdate, 'mon')           AS 현재월1,
    to_char(sysdate, 'dd')            AS 현재일자,
    to_char(sysdate, 'ddd')           AS 현재일자2,
    to_char(sysdate, 'HH12:MI:SS am') AS 현재날짜시간
FROM
    dual;

-- sal 필드에 , 나 $ 표시를 하고싶다면? 
-- L(Locale) 지역 화폐 단위 기호 붙여줌
SELECT
    sal,
    to_char(sal, '$999,999') AS sal_$,
    to_char(sal, 'L999,999') AS sal_l
FROM
    emp;


-- to_number(문자열데이터, 인식될 숫자형태

-- 자동형변환
SELECT
    1300 - '1500',
    '1300' + 1500
FROM
    dual;

-- 자동형변환 안되는 상황
SELECT
    TO_NUMBER('1,300', '999,999') - TO_NUMBER('1,500', '999,999')
FROM
    dual;
    
    
-- to_date(문자열데이터, '인식될 날짜 형태')
SELECT
    TO_DATE('2018-07-14', 'yyyy-mm-dd') AS todate1,
    TO_DATE('20230320', 'yyyy-mm-dd')   AS todate2
FROM
    dual;
    
    
-- 널처리 함수
-- NULL + 300 => NULL

-- NVL(데이터, NULL일 경우 반환할 데이터)
SELECT
    empno,
    ename,
    sal,
    comm,
    sal + comm,
    nvl(comm, 0),
    sal + nvl(comm, 0)
FROM
    emp;
    

-- NVL2(데이터, NULL이 아닐경우 반환할 데이터, NULL일경우 반환할 데이터)
SELECT
    empno,
    ename,
    comm,
    nvl2(comm, '0', 'x'),
    nvl2(comm, sal * 12 + comm, sal * 12) AS annsal
FROM
    emp;
    
    
-- DECODE함수 / CASE 문

-- DECODE(검사 대상이 될 데이터, 
--         조건1, 조건1이 일치할때 실행할 구문
--         조건2, 조건2이 일치할때 실행할 구문)


-- emp 테이블에 직책이 MANAGER인 사람은 급여의10% 인상, 
-- SALESMAN인 사람은 5%, ANALYST인 사람은 그대로, 나머지는 3%인상된 급여 출력
SELECT
    empno,
    ename,
    job,
    sal,
    decode(job, 'MANAGER', sal * 1.1, 'SALESMAN', sal * 1.05,
                'ANALYST', sal, sal * 1.03) as upsal
FROM
    emp;
    
    
SELECT
    empno,
    ename,
    job,
    sal,
    case job 
    when 'MANAGER' then sal * 1.1
    WHEN 'SALESMAN' THEN
        sal * 1.05
    WHEN 'ANALYST' THEN
        sal
    else sal * 1.03 
    end as upsal
FROM
emp;

SELECT
    empno,
    ename,
    job,
    sal,
    CASE
        WHEN comm IS NULL THEN
            '해당사항 없음'
        WHEN comm = 0 THEN
            '수당없음'
        WHEN comm > 0 THEN
            '수당 : ' || comm
    END AS comm_text
FROM
    emp;
    
    
    
    
    
    
    
-- EMP 테이블에서 사원들의 월 평균 근무일수는 21.5일이다.
-- 하루 근무 시간을 8시간으로 보았을 때 사원들의
-- 하루 급여(DAY_PAY)와 시급(TIME_PAY)를 계산하여
-- 결과를 출력한다. 단, 하루 급여는 소수점 셋째 자리에서
-- 버리고, 시급은 두 번째 소수점에서 반올림하시오
SELECT
    empno,
    ename,
    sal,
    trunc(sal / 21.5, 2)     AS day_pay,
    round(sal / 21.5 / 8, 1) AS time_pay
FROM
    emp;
    
    
-- EMP 테이블에서 사원들은 입사일(hiredate)을 기준으로
-- 3개월이 지난 후 첫 월요일에 정직원이 된다.
-- 사원들이 정직원이 되는 날짜(R_JOB)를 
-- yyyy-mm-dd 형식으로 출력하시오
-- 단, 추가수당(comm)이 없는 사원의 추가수당은 n/a로 출력
SELECT
    comm,
    nvl(to_char(comm),
        'N/A') --ORA-01722: 수치가 부적합합니다
FROM
    emp;

SELECT
    empno,
    ename,
    hiredate,
    next_day(add_months(hiredate, 3),
             '월요일') AS r_job,
    nvl(to_char(comm),
        'N/A')      AS comm
FROM
    emp;
    
    
    
-- EMP 테이블의 모든 사원을 대상으로 직속 상관의 사원 번호(MGR)를
-- 다음과 같은 조건을 기준으로 변환해서 CHG_MGR 열에 출력하시오

-- 직속상관의 사원번호가 존재하지 않을 경우 : 0000
-- 직속상관의 사원번호 앞 두자리가 75일 경우 : 5555
-- 직속상관의 사원번호 앞 두자리가 76일 경우 : 6666
-- 직속상관의 사원번호 앞 두자리가 77일 경우 : 7777
-- 직속상관의 사원번호 앞 두자리가 78일 경우 : 8888
-- 그 외 직속 상관 사원 번호의 경우 : 본래 직속 상관의 사원번호 그대로 출력 

SELECT
    empno,
    ename,
    mgr,
    decode(substr(to_char(mgr),1,2),
    null, '0000',
    '75', '5555',
    '76', '6666',
    '77', '7777',
    '78', '8888',
    substr(to_char(mgr),1)
    ) AS chg_mgr
FROM
emp;

SELECT
    empno,
    ename,
    mgr,
    CASE
        WHEN mgr IS NULL THEN
            '0000'
        WHEN substr(to_char(mgr), 1, 2) = '75' THEN
            '5555'
        WHEN substr(to_char(mgr), 1, 2) = '76' THEN
            '6666'
        WHEN substr(to_char(mgr), 1, 2) = '77' THEN
            '7777'
        WHEN substr(to_char(mgr), 1, 2) = '78' THEN
            '8888'
        ELSE
            to_char(mgr)
    END AS chg_mgr
FROM
    emp;
    
    
    
-- 다중행 (집계) 함수 : sum, count, max, min, avg
--ORA-00937: 단일 그룹의 그룹 함수가 아닙니다
SELECT
    SUM(sal)
FROM
    emp;

SELECT
    SUM(DISTINCT sal),
    SUM(ALL sal),
    SUM(sal)
FROM
    emp;
    
-- comm에 NULL    
select sum(comm) from emp;


select count(sal) from emp;

select count(*) from emp
where deptno = 30;

select max(sal) from emp;

-- 부서번호가 20인 사원의 입사일중 제일 최근 입사일
select max(hiredate) from emp where deptno=20;

-- 부서번호가 20인 사원의 입사일중 제일 오래된 입사일
select min(hiredate) from emp where deptno=20;


select avg(sal) from emp;

select avg(sal) from emp where deptno=30;



-- group by : 결과 값을 원하는 열로 묶어 출력

-- 부서별 sal 평균 구하기 
SELECT
    deptno,
    AVG(sal)
FROM
    emp
GROUP BY
    deptno;


-- 부서별 추가수당 평균 구하기
SELECT
    deptno,
    AVG(comm)
FROM
    emp
GROUP BY
    deptno;

---- GROUP BY 표현식이 아닙니다  ENAME은 없기때문에 쓰면안됨
--select deptno, ename, avg(comm) from emp group by deptno;


-- GROUP BY + HAVING : group by 절에 조건을 줄 때
-- HAVING : 그룹화된 대상을 출력 제한 걸때

-- 각 부서의 직책별 평균 급여 구하기(단, 평균 급여가 2000이상인 그룹만 출력)
-- deptno, job, 평균

-- 1) from 구문실행 2) where실행 3) group by 4) having 5) select 6) order by 
SELECT
    deptno,
    job,
    AVG(sal)
FROM
    emp
GROUP BY
    deptno,
    job
HAVING
    AVG(sal) >= 2000
ORDER BY
    deptno,
    job;
    
    
    
    
-- EMP 테이블을 이용하여 부서번호(deptno), 평균급여(avg_sal)
-- 최고급여(max_sal), 최저급여(min_sal), 사원수(cnt)를 출력
-- 단, 평균 급여를 출력할 때 소수점을 제외하고 각 부서번호별로 출력하는 sql문을 작성

SELECT
    deptno,
    AVG(sal) AS avg_sal,
    MAX(sal) AS max_sal,
    MIN(sal) AS min_sal,
    COUNT(*) AS cnt
FROM
    emp
GROUP BY
    deptno;
    
-- 같은 직책에 종사하는 사원이 3명 이상인 직책과 인원수를 출력

SELECT
    job,
    COUNT(*)
FROM
    emp
GROUP BY
    job
HAVING
    COUNT(job) >= 3;
    
    
-- 사원들의 입사연도(hire_year)를 기준으로 부서별로 몇 명이 입사했는지 출력
SELECT
    to_char(hiredate, 'yyyy') AS hire_year,
    deptno,
    COUNT(*)                  AS cnt
FROM
    emp
GROUP BY
    to_char(hiredate, 'yyyy'),
    deptno;
    
    
    
-- DML(Data Manipulation Language) : 데이터추가(INSERT), 수정(UPDATE), 삭제(DELETE)하는 데이터 조작어
-- COMMIT : DML 작업을 데이터베이스에 최종 반영
-- ROLLBACK : DML 작업을 취소
-- select + DML ==> 자주 사용하는 sql



-- 연습용 테이블 생성
CREATE TABLE dept_temp
    AS
        SELECT
            *
        FROM
            dept;

DROP TABLE dept_temp;


-- Insert into 테이블이름 (열이름1, 열이름2,....)
-- values (데이터1, 데이터2......);


-- dept_temp 새로운부서 추가
INSERT INTO dept_temp (
    deptno,
    dname,
    loc
) VALUES (
    50,
    'DATABASE',
    'SEOUL'
);

-- 열 이름 제거할때
INSERT INTO dept_temp (
    deptno,
    dname,
    loc
) VALUES (
    60,
    'NETWORK',
    'BUSAN'
);

-- insert 시 오류 

--이 열에 대해 지정된 전체 자릿수보다 큰 값이 허용됩니다.

--insert into dept_temp(deptno, dname, loc)
--values(600,'NETWORK','BUSAN');

--값의 수가 충분하지 않습니다
--insert into dept_temp(deptno, dname, loc)
--values(70,'NETWORK');

INSERT INTO dept_temp (
    deptno,
    dname,
    loc
) VALUES (
    80,
    'WEB',
    'NULL'
);

INSERT INTO dept_temp (
    deptno,
    dname,
    loc
) VALUES (
    90,
    'MOBILE',
    ' '
);

--NULL 삽입할 컬럼명 지정하지 않았음
INSERT INTO dept_temp (
    deptno,
    loc
) VALUES (
    91,
    'INCHEON'
);

SELECT
    *
FROM
    dept_temp;


-- emp_temp 생성(emp 테이블 복사 - 데이터는 복사를 하지 않을 때)
-- 구조만 복사
CREATE TABLE emp_temp
    AS
        SELECT
            *
        FROM
            emp
        WHERE
            1 <> 1;

INSERT INTO emp_temp (
    empno,
    ename,
    job,
    mgr,
    hiredate,
    sal,
    comm,
    deptno
) VALUES (
    9999,
    '홍길동',
    'PRESIDENT',
    NULL,
    '2001/01/01',
    5000,
    1000,
    10
);

INSERT INTO emp_temp (
    empno,
    ename,
    job,
    mgr,
    hiredate,
    sal,
    comm,
    deptno
) VALUES (
    1111,
    '성춘향',
    'MANAGER',
    9999,
    '2002-01-05',
    4000,
    NULL,
    20
);

-- 날짜 입력시 년/월/일 순서 => 일/월/년 삽입
--insert into emp_temp(empno,ename,job,mgr,hiredate,sal,comm,deptno)
--values(2222,'이순신','MANAGER',9999,'07/01/2001',4000,NULL,20);

INSERT INTO emp_temp (
    empno,
    ename,
    job,
    mgr,
    hiredate,
    sal,
    comm,
    deptno
) VALUES (
    2222,
    '이순신',
    'MANAGER',
    9999,
    TO_DATE('07/01/2001', 'dd/mm/yyyy'),
    4000,
    NULL,
    20
);

INSERT INTO emp_temp (
    empno,
    ename,
    job,
    mgr,
    hiredate,
    sal,
    comm,
    deptno
) VALUES (
    3333,
    '심봉사',
    'MANAGER',
    9999,
    sysdate,
    4000,
    NULL,
    30
);

-- 서브쿼리로 INSERT 구현
-- emp, salgrade 테이블을 조인 후 급여 등급이 1인 사원만 emp_temp에 추가

INSERT INTO emp_temp (
    empno,
    ename,
    job,
    mgr,
    hiredate,
    sal,
    comm,
    deptno
)
    SELECT
        e.empno,
        e.ename,
        e.job,
        e.mgr,
        e.hiredate,
        e.sal,
        e.comm,
        e.deptno
    FROM
        emp      e,
        salgrade s
    WHERE
        e.sal BETWEEN s.losal AND s.hisal
        AND s.grade = 1;

SELECT
    *
FROM
    emp_temp;

COMMIT;


-- UPDATE : 테이블에 있는 데이터 수정

--UPDATE 테이블명
--set 변경할열이름 = 데이터, 변경할열이름 = 데이터 ......
--where 변경을 위한 대상 행을 선별하기 위한 조건


-- dept_temp loc열의 모든 값을 seoul로 변경
UPDATE dept_temp
SET
    loc = 'SEOUL';

ROLLBACK;

-- 데이터 일부분 수정 : where 사용
--dept_temp 부서번호가 40번인 loc 열의 값을 seoul로 변경
UPDATE dept_temp
SET
    loc = 'SEOUL'
WHERE
    deptno = 40;

-- dept_temp 부서번호가 80번인 dname은 SALES, LOC는 CHICAGO
UPDATE dept_temp
SET
    dname = 'SALES',
    loc = 'CHICAGO'
WHERE
    deptno = 80;


-- emp_temp 사원들 중에서 급여가 2500이하인 사원만 추가수당을 50으로 설정
update emp_temp
set comm=50
where sal<=2500;

-- 서브쿼리를 사용하여 데이터 수정
-- dept 테이블의 40번 부서의 dname, loc를 dept_temp 40번 부서의 dname, loc로 업데이트
update dept_temp
set(dname, loc)=
(select dname, loc from dept where deptno=40)
where deptno=40;

commit;
SELECT
    *
FROM
    dept_temp;
    
    
    
-- delete : 테이블에 있는 데이터 삭제
--delete 테이블명
--from(선택)
--WHERE 삭제 데이터를 선별하기 위한 조건식


create table emp_temp2 as select * from emp;


-- job 이 MANAGER인 사원 삭제 

delete from emp_temp2 where job= 'MANAGER';

-- job이 SALESMAN인 사원 삭제
delete emp_temp2
where job='SALESMAN';

-- 전체 데이터 삭제
delete emp_temp2;
rollback;

--서브 쿼리를 사용하여 삭제
-- 급여등급이 3등급이고, 30번부서의 사원 삭제

delete from emp_temp2 
where empno in (select e.empno
                from emp_temp2 e, salgrade s
                where e.sal between s.losal and s.hisal and s.grade = 3 and e.deptno=30);

select * from emp_temp2;

commit;


-- emp 테이블의 내용을 이용하여 exam_emp생성
CREATE TABLE exam_emp
    AS
        SELECT
            *
        FROM
            emp
        WHERE
            1 <> 1;
            
-- dept 테이블의 내용을 이용하여 exam_dept생성
CREATE TABLE exam_dept
    AS
        SELECT
            *
        FROM
            dept
        WHERE
            1 <> 1;
            
-- salgrade 테이블의 내용을 이용하여 exam_salgrade생성
CREATE TABLE exam_salgrade
    AS
        SELECT
            *
        FROM
            salgrade
        WHERE
            1 <> 1;
            
-- 다음의 정보를 exam_emp테이블에 입력
INSERT INTO exam_emp (empno,ename,job,mgr,hiredate,sal,comm,deptno) 
VALUES (7201,'TEST_USER1','MANAGER',7788,'2016-01-02',4500,NULL,50);

INSERT INTO exam_emp (empno,ename,job,mgr,hiredate,sal,comm,deptno) 
VALUES (7202,'TEST_USER2','CLERK',7201,'2016-02-21',1800,NULL,50);

INSERT INTO exam_emp (empno,ename,job,mgr,hiredate,sal,comm,deptno) 
VALUES (7203,'TEST_USER3','ANALYST',7201,'2016-04-11',3400,NULL,60);

INSERT INTO exam_emp (empno,ename,job,mgr,hiredate,sal,comm,deptno) 
VALUES (7204,'TEST_USER4','SALESMAN',7201,'2016-05-31',2700,300,60);

INSERT INTO exam_emp (empno,ename,job,mgr,hiredate,sal,comm,deptno) 
VALUES (7205,'TEST_USER5','CLERK',7201,'2016-07-20',2600,NULL,70);

INSERT INTO exam_emp (empno,ename,job,mgr,hiredate,sal,comm,deptno) 
VALUES (7206,'TEST_USER6','CLERK',7201,'2016-09-08',2600,NULL,70);

INSERT INTO exam_emp (empno,ename,job,mgr,hiredate,sal,comm,deptno) 
VALUES (7207,'TEST_USER7','LECTURER',7201,'2016-10-28',2300,NULL,80);

INSERT INTO exam_emp (empno,ename,job,mgr,hiredate,sal,comm,deptno) 
VALUES (7208,'TEST_USER8','STUDENT',7201,'2018-03-09',1200,NULL,80);



--실습3] EXAM_EMP에 속한 사원 중 
--50번 부서에서 근무하는 사원들의 평균 급여보다 
--많은 급여를 받고 있는 사원들을 70번 부서로 옮기는 SQL 문 작성하기
update exam_emp set deptno=70
where sal>(select avg(sal) from exam_emp where deptno=50);



--[실습4] EXAM_EMP에 속한 사원 중 
--60번 부서의 사원 중에서 입사일이 가장 빠른 사원보다 
--늦게 입사한 사원의 급여를 10% 인상하고 80번 부서로 옮기는 SQL 문 작성하기
update exam_emp set sal=sal*1.1, deptno=80 where
hiredate > (select min(hiredate) from exam_emp where deptno=60);



--[실습5] EXAM_EMP에 속한 사원 중, 급여 등급이 5인 사원을 삭제하는 SQL문을 작성하기
delete from exam_emp where empno in
(select empno from exam_emp, salgrade where sal between losal and hisal and grade=5);



-- 트랜잭션(transaction) : 최소 수행 단위
-- 트랜잭션 제어하는 구문 TCL(Transaction Control Language) : commit, rollback

create table dept_tcl 
as select * from dept;

insert into dept_tcl values (50,'DATABASE','SEOUL');

update dept_tcl set loc='BUSAN' where deptno=40;

delete from dept_tcl where dname = 'RESEARCH';

select * from dept_tcl;


-- 트랜잭션 취소
rollback;

--트랜잭션 최종 반영
commit;


-- 세션 : 어떤 활동을 위한 시간이나 기간
-- 데이터베이스 세션 : 데이터베이스 접속을 시작으로 관련작업 수행한 후 접속종료
-- LOCK : 잠금(수정 중인 데이터 접근 막기)

delete from dept_tcl where deptno=50;

update dept_tcl set loc='SEOUL' where deptno=30;

select * from dept_temp;
commit;


-- DDL : 데이터 정의어(데이터 베이스 객체 생성, 수정, 삭제)
-- 1. 테이블 생성  :   CREATE
-- CREATE TABLE 테이블명(
--    열이름1 자료형,
--    열이름2 자료형,
--    열이름3 자료형,
--    열이름4 자료형
-- );

-- 테이블생성 / 열이름 지정 규칙
-- 1) 테이블 이름은 문자로 시작
-- 2) 테이블 이름은 30BYTE 이하(한글은 10글자)
-- 3) 같은 사용자 소유의 테이블 이름은 중복될 수 없다
-- 4) 테이블 명에 사용할 수 있는 특수문자는 $,#,_ 가능
-- 5) SQL 키워드(ex  SELECT, FROM , WHERE ...)는 테이블명에 사용할수없음

-- 자료형

-- 1. 문자 (보통 VARCHAR2를 많이 사용)
-- VARCHAR2(길이) : 가변 길이 문자열 데이터 저장(최대 4000BYTE)
-- CHAR(길이) : 고정 길이 문자열 데이터 저장
-- NVARCHAR2(길이) : 가변 길이(unicode) 데이터 저장
--  name varchar2(10) : 영어는 10자, 한글은 3자 까지 입력
--  name nvarchar2(10) : 영어 10자, 한글 10자 까지 입력
-- NCHAR(길이) : 고정 길이(unicode)  
--  name char(10) : 영어는 10자, 한글은 3자, + 메모리 10byte 고정
--  name nchar(10) : 영어는 10자, 한글은 10자, + 메모리 10byte 고정


-- 2. 숫자
-- NUMBER(전체자릿수, 소수점이하자릿수)

-- 3. 날짜
-- DATE : 날짜, 시간 저장
-- TIMESTAMP

-- 4. 기타
-- BLOB : 대용량 이진 데이터 저장
-- CLOB : 대용량 텍스트 데이터
-- JSON : JSON 데이터 저장

CREATE TABLE emp_ddl (
    empno number(4),    -- 사원번호를 총 4자리로 지정
    ename varchar2(10),  -- 사원명을 총 10BYTE로 지정
    job varchar2(9),      -- 직무를 총 9BYTE로 지정
    mgr number(4),       -- 매니저번호를 총 4자리로 지정
    hiredate date,         -- 날짜/ 시간을 저장
    sal number(7,2),      -- 급여를 전체자리수를7로 지정, 소수점2자리까지 허용
    comm number(7,2),   -- 추가수당을 전체자리수 7로 지정, 소수점2자리까지 허용
    deptno number(2)    -- 부서번호를 총 2자리로 지정
);
desc emp_ddl;



-- 2. 테이블 수정 : ALTER
-- 1) 열 추가 : ADD
ALTER TABLE emp_temp2 ADD hp VARCHAR2(20);

-- 2) 열 이름 변경 : RENAME
ALTER TABLE emp_temp2 RENAME COLUMN hp TO tel;

-- 3) 열 자료형 변경 : MODIFY
ALTER TABLE emp_temp2 MODIFY
    empno NUMBER(5);

-- 4) 특정 열을 삭제 : DROP
ALTER TABLE emp_temp2 DROP COLUMN tel;



-- 3. 테이블 삭제 : DROP
DROP TABLE emp_rename;

-- 테이블 명 변경
RENAME emp_temp2 TO emp_rename;

-- 테이블 데이터 전체 삭제
DELETE FROM emp_rename;

SELECT
    *
FROM
    emp_rename;

ROLLBACK;

-- ROLLBACK 안됨 : DDL 구문이기 때문
TRUNCATE TABLE emp_rename;






-- 실습1 MEMBER 테이블 작성

CREATE TABLE member (
    id     CHAR(8),
    name   VARCHAR2(10),
    addr   VARCHAR2(50),
    nation CHAR(4),
    email  VARCHAR2(50),
    age    NUMBER(7, 2)
);



-- 실습2 MEMBER 테이블 변경
-- 1. MEMBER테이블에 BIGO열추가하기 ( 가변형 문자열, 길이는 20)
ALTER TABLE member ADD bigo VARCHAR(20);

-- 2. MEMBER 테이블의 BIGO 열 크기를 30으로 변경
ALTER TABLE member MODIFY
    bigo VARCHAR(30);

-- 3. MEMBER 테이블의 BIGO 열 이름을 REMARK로 변경
ALTER TABLE member RENAME COLUMN bigo TO remark;

DROP TABLE member;

-- "SCOTT"."MEMBER"."NATION" 열에 대한 값이 너무 큼(실제: 12, 최대값: 4)
INSERT INTO member VALUES (
    'hong1234',
    '홍길동',
    '서울시 구로구 개봉동',
    '대한민국',
    'hong123@naver.com',
    25,
    NULL
);

CREATE TABLE member (
    id     CHAR(8),
    name   VARCHAR2(10),
    addr   VARCHAR2(50),
    nation NCHAR(4),
    email  VARCHAR2(50),
    age    NUMBER(7, 2)
);

ALTER TABLE member ADD remark VARCHAR(30);


-- 데이터 베이스 객체
-- 테이블, 인덱스, 뷰, 데이터 사전, 시퀀스, 시노님, 프로시저, 함수, 패키지, 트리거
-- 생성 : CREATE  // 수정 : ALTER  // 삭제 : DROP

-- 인덱스 : 더 빠른 검색을 도와줌
-- 인덱스 : 사용자가 직접 특정 테이블 열에 지정 가능
--        기본키(혹은 unique key)를 생성하면 인덱스로 지정 

-- CREATE INDEX 인덱스 이름 ON 테이블명(인덱스로 사용할 열이름)

-- EMP 테이블의 SAL 열을 인덱스로 지정
CREATE INDEX idx_emp_sal ON
    emp (
        sal
    );

-- SELECT : 검색방식
-- FULL SCAN
-- INDEX SCAN
SELECT
    *
FROM
    emp
WHERE
    empno = 7900;

--인덱스 삭제
DROP INDEX idx_emp_sal;


-- VIEW : 가상 테이블
-- 편리성 : SELECT 문의 복잡도를 완화하기 위해
-- 보안성 : 테이블의 특정 열을 노출하고 싶지 않을 때

-- CREATE[OR REPLACE] [FORCE | NOFORCE] VIEW 뷰이름(열이름1, 열이름2,...)
-- AS (저장할 SELECT 구문)
-- [WITH CHECK OPTION]
-- [WITH READ ONLY]

-- SELECT EMPNO, ENAME, JOB, DEPTNO FROM EMP WHERE DEPTNO=20
CREATE VIEW vm_emp20 AS
    (
        SELECT
            empno,
            ename,
            job,
            deptno
        FROM
            emp
        WHERE
            deptno = 20
    );



-- 서브쿼리를 사용
SELECT
    *
FROM
    (
        SELECT
            empno,
            ename,
            job,
            deptno
        FROM
            emp
        WHERE
            deptno = 20
    );


-- 뷰 사용
SELECT
    *
FROM
    vm_emp20;


-- 뷰 삭제
DROP VIEW vm_emp20;

CREATE VIEW vm_emp_read AS
    SELECT
        empno,
        ename,
        job
    FROM
        emp
WITH READ ONLY;


-- VIEW 에 INSERT 작업?
INSERT INTO vm_emp20 VALUES (
    8888,
    'KIM',
    'SALES',
    20
);
-- 원본 변경이 일어남
SELECT
    *
FROM
    emp;


-- 읽기 전용 뷰에서는 DML 작업을 수행할 수 없습니다.
INSERT INTO vm_emp_read VALUES (
    9999,
    'KIM',
    'SALES'
);

-- 인라인 뷰 : 일회성으로 만들어서 사용하는 뷰
-- rownum : 조회된 순서대로 일련번호 매김

SELECT
    ROWNUM,
    e.*
FROM
    emp e;

-- ORDER BY SAL DESC를 한 기준으로 ROWNUM이 생성
SELECT
    ROWNUM,
    e.*
FROM
    (
        SELECT
            *
        FROM
            emp e
        ORDER BY
            sal DESC
    ) e;

-- 급여 높은 상위 세 사람 조회
SELECT
    ROWNUM,
    e.*
FROM
    (
        SELECT
            *
        FROM
            emp e
        ORDER BY
            sal DESC
    ) e
WHERE
    ROWNUM <= 3;


-- 시퀀스 : 규칙에 따라 순번 생성
-- CREATE SEQUENCE 시퀀스이름;     (설정안하는 것등른 다 기본값으로 세팅)

--CREATE SEQUENCE 시퀀스명
--[INCREMENT BY 숫자]   기본값 1
--[START WITH 숫자]     기본값 1
--[MAXVALUE 숫자 | NOMAXVALUE]
--[MINVALUE 숫자 | NOMINVALUE]
--[CYCLE | NOCYCLE]    CYCLE 인 경우 MAXVALUE에 값이 다다르면 시작값부터 다시 시작
--[CACHE 숫자 | NOCACHE]  시퀀스가 생성할 번호를 미리 메모리에 할당해 놓음(기본 CACHE 20)

CREATE TABLE dept_sequence
    AS
        SELECT
            *
        FROM
            dept
        WHERE
            1 <> 1;

CREATE SEQUENCE seq_dept_sequence INCREMENT BY 10 START WITH 10 MAXVALUE 90 MINVALUE 0 NOCYCLE CACHE 2;


-- 시퀀스 사용 : 시퀀스이름.CURRVAL(마지막으로 생성된 시퀀스 조회), 시퀀스이름.NEXTVAL(시퀀스 생성)

-- 부서번호 입력시 시퀀스 사용
INSERT INTO dept_sequence (
    deptno,
    dname,
    loc
) VALUES (
    seq_dept_sequence.NEXTVAL,
    'DATABASE',
    'SEOUL'
);

SELECT
    *
FROM
    dept_sequence;

-- 최대값 90까지 가능
-- 시퀀스 SEQ_DEPT_SEQUENCE.NEXTVAL exceeds MAXVALUE : NOCYCLE 옵션으로 생성했기 때문에 번호 순환 X

-- 시퀀스 삭제
DROP SEQUENCE seq_dept_sequence;

CREATE SEQUENCE seq_dept_sequence INCREMENT BY 3 START WITH 10 MAXVALUE 99 MINVALUE 0 CYCLE CACHE 2;

SELECT
    seq_dept_sequence.CURRVAL
FROM
    dual;


-- SYNONYM(동의어) : 테이블, 뷰, 시퀀스 등 객체 이름 대신 사용할 수 있는 다른 이름을 부여하는 객체

-- EMP 테이블의 별칭을 E로 지정
CREATE SYNONYM e FOR emp;


-- PUBLIC 동의어를 데이터베이스 내 모든 사용자가 사용할 수 있도록 설정
-- CREATE [PUBLIC] SYNONYM E FOR EMP;

SELECT
    *
FROM
    emp;

SELECT
    *
FROM
    e;

DROP SYNONYM e;




-- 실습1 EMP테이블과 같은 구조의 데이터를 저장하는 EMPIDX테이블 생성
CREATE TABLE empidx
    AS
        SELECT
            *
        FROM
            emp;


-- 실습2 생성한 EMPIDX 테이블의 EMPNO 열에 IDX_EMPIDX_EMPNO인덱스 생성
CREATE INDEX idx_empidx_empno ON
    empidx (
        empno
    );

-- 데이터 사전 뷰를 통해 인덱스 확인
SELECT
    *
FROM
    user_indexes;


-- 실습1에서 생성한 EMPIDX테이블의 데이터중 급여가 1500 초과인 사원들만 출력하는 EMPIDX_OVER15K뷰생성
-- 사원번호, 사원이름, 직책, 부서번호, 급여, 추가수당열 가지고있음
CREATE VIEW empidx_over15k AS
    (
        SELECT
            empno,
            ename,
            job,
            deptno,
            sal,
            comm
        FROM
            empidx
        WHERE
            sal > 1500
    );
    
   
-- 실습3 DEPT 테이블과 같은 열과 행 구성을 가지는 DEPTSEQ 테이블 작성
CREATE TABLE deptseq
    AS
        SELECT
            *
        FROM
            dept;


-- 3-1 생성한 DEPTSEQ테이블의 DEPTNO열에 사용할 시퀀스를 아래에 제시된 특성에 맞춰 생성
-- 부서번호 시작값:1 // 부서번호증가:1 // 최댓값 : 99 // 최소값 : 1 최대값에서 생성중단 캐시없음
CREATE SEQUENCE seq_deptseq_deptno INCREMENT BY 1 START WITH 1 MAXVALUE 99 MINVALUE 1 NOCYCLE NOCACHE;
    
-- 데이터 사전 뷰를 통해 시퀀스 확인
SELECT
    *
FROM
    user_sequences;




-- 제약 조건  : 테이블의 특정 열에 지정
--            NULL 허용 / 불허용, 유일한 값, 조건식을 만족하는 데이터만 입력가능 ...
--            데이터 무결성 유지(데이터 정확성, 일관성 보장) 유지 ==> DML작업시 지켜야함
--            영역 무결성, 개체 무결성, 참조 무결성
--            테이블 생성시 제약조건 지정, OR 생성 후에 ALTER를 통해 추가, 변경 가능


-- 1) NOT NULL : 빈값 허용 불가
-- 사용자로부터 입력값이 필수로 입력되어야 할 때
CREATE TABLE table_notnull (
    login_id  VARCHAR(20) NOT NULL,
    login_pwd VARCHAR2(20) NOT NULL,
    tel       VARCHAR2(20)
);

INSERT INTO table_notnull (
    login_id,
    login_pwd,
    tel
) VALUES (
    'hong123',
    'hong123'
);

-- NULL을 ("SCOTT"."TABLE_NOTNULL"."LOGIN_PWD") 안에 삽입할 수 없습니다
INSERT INTO table_notnull (
    login_id,
    login_pwd,
    tel
) VALUES (
    'hong123',
    null,
    '010-1234-1234'
);

SELECT
    *
FROM
    table_notnull;
    
    
select * from user_constraints;


-- 제약조건 + 제약조건 명 지정
CREATE TABLE table_notnull2 (
    login_id  VARCHAR(20) CONSTRAINT TBLNN2_LOGIN_NN NOT NULL,
    login_pwd VARCHAR2(20) CONSTRAINT TBLNN2_LGPWD_NN NOT NULL,
    tel       VARCHAR2(20)
);


-- 생성한 테이블에 제약조건 추가
-- (SCOTT.) 사용으로 설정 불가 - 널 값이 발견되었습니다.
-- 이미 삽입된 데이터도 체크 대상이 됨
ALTER TABLE TABLE_NOTNULL MODIFY(TEL NOT NULL);
ALTER TABLE TABLE_NOTNULL2 MODIFY(TEL CONSTRAINT TBLNN2_TEL_NN NOT NULL);

UPDATE TABLE_NOTNULL
SET TEL = '010-1234-5678'
WHERE LOGIN_ID = 'hong123';


-- 제약조건 명 변경
ALTER TABLE TABLE_NOTNULL2 RENAME CONSTRAINT TBLNN2_TEL_NN TO TBLNN3_TEL_NN;

-- 제약조건 명 삭제
ALTER TABLE TABLE_NOTNULL2 DROP CONSTRAINT TBLNN3_TEL_NN;



-- 2) UNIQUE : 중복되지 않는 값  (NULL 삽입 가능)
--             아이디, 전화번호


CREATE TABLE table_UNIQUE (
    login_id  VARCHAR(20) UNIQUE,
    login_pwd VARCHAR2(20) NOT NULL,
    tel       VARCHAR2(20)
);

-- login_id가 중복된 상황일 때 : unique 위배
-- 무결성 제약 조건(SCOTT.SYS_C008362)에 위배됩니다
INSERT INTO table_UNIQUE (
    login_id,
    login_pwd,
    tel
) VALUES (
    'hong123',
    'hong123',
    '010-1234-1234'
);


INSERT INTO table_UNIQUE (
    login_id,
    login_pwd,
    tel
) VALUES (
    null,
    'hong123',
    '010-1234-1234'
);

select * from table_unique;


-- 테이블 생성 제약조건 지정, 변경, 삭제 not null 형태와 동일함



-- 3) PRIMARY KEY(PK) : UNIQUE + NOT NULL
CREATE TABLE table_PRIMARY (
    login_id  VARCHAR(20) PRIMARY KEY,
    login_pwd VARCHAR2(20) NOT NULL,
    tel       VARCHAR2(20)
);

-- PRIMARY KEY ==> INDEX 자동 생성 됨

INSERT INTO table_PRIMARY (
    login_id,
    login_pwd,
    tel
) VALUES (
    'hong123',
    'hong123',
    '010-1234-1234'
);


-- 4) 외래키 : FOREIGN KEY(FK) : 다른 테이블 간 관계를 정의하는데 사용
--           특정 테이블에서 PRIMARY KEY 제약조건을 지정한 열을 다른 테이블의 특정 열에서 참조

-- 사원 추가 시 부서 번호 입력을 해야 함 => DEPT 테이블의 DEPTNO만 삽입

-- 부모 테이블
CREATE TABLE DEPT_FK(
    DEPTNO NUMBER(2) CONSTRAINT DEPTFK_DEPTNO_PK PRIMARY KEY,
    DNAME VARCHAR2(14),
    LOC VARCHAR2(13)
);

-- 자식 테이블
-- REFERENCES 참조할테이블명(참조할 열) : 외래키 지정
CREATE TABLE EMP_FK(
    EMPNO NUMBER(4) CONSTRAINT EMPFK_EMPNO_PK PRIMARY KEY,
    ENAME VARCHAR2(10),
    JOB VARCHAR2(9),
    DEPTNO NUMBER(2) CONSTRAINT EMPFK_DEPTNO_FK REFERENCES DEPT_FK(DEPTNO));
    
-- 무결성 제약조건(SCOTT.EMPFK_DEPTNO_FK)이 위배되었습니다- 부모 키가 없습니다
INSERT INTO EMP_FK VALUES(1000,'TEST','SALES',10);

-- 외래키 제약 조건
-- 부모 테이블 데이터가 데이터 먼저 입력

INSERT INTO DEPT_FK VALUES(10,'DATABASE','SEOUL');

-- 삭제 시
-- 자식 테이블부터 삭제 후 부모 테이블 삭제

-- 무결성 제약조건(SCOTT.EMPFK_DEPTNO_FK)이 위배되었습니다- 자식 레코드가 발견되었습니다
-- DELETE FROM DEPT_FK WHERE DEPTNO=10;

-- 외래 키 제약조건 옵션
-- ON DELETE CASCADE : 부모가 삭제되면 부모를 참조하는 자식 레코드도 같이 삭제
-- ON DELETE SET NULL : 부모가 삭제되면 부모를 참조하는 자식 레코드 값을 NULL로 변경

CREATE TABLE DEPT_FK2(
    DEPTNO NUMBER(2) CONSTRAINT DEPTFK_DEPTNO_PK2 PRIMARY KEY,
    DNAME VARCHAR2(14),
    LOC VARCHAR2(13)
);

CREATE TABLE EMP_FK2(
    EMPNO NUMBER(4) CONSTRAINT EMPFK_EMPNO_PK2 PRIMARY KEY,
    ENAME VARCHAR2(10),
    JOB VARCHAR2(9),
    DEPTNO NUMBER(2) CONSTRAINT EMPFK_DEPTNO_FK2 REFERENCES DEPT_FK2(DEPTNO) ON DELETE CASCADE);
    
INSERT INTO DEPT_FK2 VALUES(10, 'DATABASE','SEOUL');
INSERT INTO EMP_FK2 VALUES(1000, 'TEST','SALES',10);

DELETE FROM DEPT_FK2 WHERE DEPTNO=10;


-- 5) CHECK : 열에 지정할 수 있는 값의 범위 또는 패턴 지정
-- 비밀번호는 3자리보다 커야한다

CREATE TABLE table_CHECK (
    login_id  VARCHAR(20) PRIMARY KEY,
    login_pwd VARCHAR2(20) CHECK (LENGTH(LOGIN_PWD)>3),
    tel       VARCHAR2(20)
);

-- 체크 제약조건(SCOTT.SYS_C008371)이 위배되었습니다
INSERT INTO TABLE_CHECK VALUES('TEST','123','010-1234-5678');

INSERT INTO TABLE_CHECK VALUES('TEST','1234','010-1234-5678');




-- 6) DEFAULT : 기본값 지정
CREATE TABLE table_DEFAULT (
    login_id  VARCHAR(20) PRIMARY KEY,
    login_pwd VARCHAR2(20) DEFAULT '1234',
    tel       VARCHAR2(20)
);

INSERT INTO TABLE_DEFAULT VALUES ('TEST',NULL,'010-1234-5678');
INSERT INTO TABLE_DEFAULT(LOGIN_ID, TEL) VALUES('TEST1','010-1234-5678');

SELECT * FROM TABLE_DEFAULT;