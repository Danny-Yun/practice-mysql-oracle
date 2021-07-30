/*여러줄 주석*/
-- 한 줄 주석
-- HR 계정으로 테스트하는 중. 
-- MySQL과는 달리 Oracle SQL에서는 계정이 데이터베이스 개념까지 겸할 수 있다. 
-- hr계정에는 인사팀 관련 데이터가 들어와 있다.

-- MySQL과 마찬가지로 Oracle에서도 거의 유사한 SELECT구문을 사용한다.
SELECT employee_id, first_name, last_name FROM employees;
SELECT * FROM employees;

-- 급여가 5000이상인 직원의 아이디, 성, 이름만 출력.
SELECT employee_id, first_name, last_name FROM employees WHERE salary >= 5000; 

-- Oracle에서도 ORDER BY로 정렬을 걸 수 있다. 위 구문에 직원 아이디를 내림차순으로 정렬.
SELECT employee_id, first_name, last_name FROM employees WHERE salary >= 5000 ORDER BY employee_id DESC; 

-- 조건을 다중으로 / 급여 5000이상 + job_id가 'IT_PROG'인 케이스만 조회.
SELECT employee_id, first_name, last_name FROM employees WHERE salary >= 5000 AND job_id = 'IT_PROG' ORDER BY employee_id DESC; 

-- Oracle은 문자열 자료형의 경우 대소문자를 구분한다. 
SELECT employee_id, first_name, last_name FROM employees WHERE salary >= 5000 AND job_id = 'it_frog' ORDER BY employee_id DESC; -- 조회 불가

-- 급여가 5000이상이거나 혹은 job_id가 'IT_PROG'직원들을 조회.
SELECT employee_id, first_name, last_name FROM employees WHERE salary >= 5000 OR job_id = 'IT_PROG' ORDER BY employee_id DESC;

-- 나오는 row개수만 알고싶은 경우
SELECT COUNT(*) FROM employees WHERE salary >= 5000 OR job_id = 'IT_PROG';

-- 컬럼명이 원래는 기존에 테이블을 만들 때 설정한 이름으로 조회되지만,
-- SELECT 결과문에서 바꿔서 조회하고 싶은 때는 AS구문을 사용한다.
-- SELECT 컬럼명1 AS 바꿀이름1, 컬럼명2 AS 바꿀이름2...
SELECT employee_id AS 직원아이디 FROM employees;
-- 키워드 AS는 생략할 수도 있다. 
SELECT employee_id 직원아이디 FROM employees;


-- INSERT INTO구문은 테이블에 ROW를 추가하는 구문이다. 
-- MYSQL과 거의 동일한 문법을 사용함. 
CREATE TABLE test01(
    col1 VARCHAR2 (10), -- 문자열
    col2 NUMBER, -- 정수
    col3 DATE -- 날짜, (상세시간 제외, 상세시간 입력시 TIMESTAMP)
);

-- 시간은 서버 시간으로 저장할 경우 SYSDATE를 입력
-- MySQL에서는 SYSDATE 대신 now()를 사용한다. 
INSERT INTO test01(col1, col2, col3) VALUES ('ABC', 10, SYSDATE);

-- INTO 절에서 컬럼 순서를 바꿔도 VALUES에서 바뀐 순서에 맞춰서 넣어주면 문제는 없음.
INSERT INTO test01(col1, col2, col3) VALUES (SYSDATE, 'DEF', 20);

-- 하지만 다음과 같이 데이터 타입을 맞추지 않으면 오류가 발생함.
INSERT INTO test01(col1, col2, col3) VALUES ('ABC', 10, 30);

-- 컬럼명은 전체컬럼에 집어넣는 경우 MYSQL과 마찬가지로 생략 가능함.
INSERT INTO test01 VALUES ('GHI', 10, SYSDATE);

-- 일부 생략시 역시 오류가 발생함
INSERT INTO test01 VALUES ('JKL', 30);

-- 컬럼 데이터 내용물 복사하기. INSERT ~ SELECT 문.
-- SubQUERY 형태로 INSERT INTO 구문의 VALUES가 들어갈 자리에 
-- 데이터 자료형이 일치하는 SELECT 구문을 작성하면
-- SELECT 문의 결과물이 그대로 전부 INSERT 된다. 
CREATE TABLE test02(
    emp_id NUMBER
);

-- 바로 아래의 SELECT 구문은 NUMBER 데이터만 결과로 나온다.
SELECT employee_id FROM employees;

-- 아래 구문은 test02 테이블 내부에, 92번 라인 결과로 나온 숫자 전체를 집어넣는다.
INSERT INTO test02 (SELECT employee_id FROM employees);

-- 실제로는 MYSQL의 아래쪽 구문처럼 처리됨.
-- INSERT INTO test02 VALUES (100), (101), (102)... (206);

SELECT * FROM test02;

-- INSERT ~ SELECT 구문을 이용해서 EMPLOYEE 테이블의 employee_id, first_name, last_name, job_id
-- 4개 컬럼을 전체 복사받는 test03 테이블을 생성한 후 복사를 진행
CREATE TABLE test03 (
    emp_id NUMBER(6) primary key,
    f_name varchar2(20),
    l_name varchar2(20),
    j_id varchar2(20)
);

INSERT INTO test03 (SELECT employee_id, first_name, last_name, job_id FROM employees);

SELECT * FROM test03;

-- UPDATE 문
-- UPDATE SET을 이용해서 처리하며 MySQL과 거의 유사한 문법을 사용한다.
-- UPDATE SET은 그냥 처리하면 컬럼 전체값이 바뀐다.
-- 따라서 WHERE와 함께 사용하는 것이 일반적이다. 
SELECT * FROM test01;

-- 테이블 col2의 값을 전부 50으로 바꿔줌.
UPDATE test01 SET col2 = 50;
SELECT * FROM test01;

-- col1의 값이 DEF인 경우만 col2를 500으로 
UPDATE test01 SET col2 = 500 WHERE col1 = 'DEF';
SELECT * FROM test01;

-- Oracle SQL의 MERGE구문은 MYSQL의ON DUPLICATE KEY와 같다.
-- 데이터가 있는 경우 UPDATE를, 없는 경우는 INSERT를 실행한다. 
-- MERGE INTO를 사용하고 오라클에서는 MySQL보다는 다소 복잡하지만,
-- 기능상으로는 큰 차이는 없기 때문에 문법적 차이점에 주목해야 함.
CREATE TABLE test04(
    employee_id NUMBER,
    bonus_amt NUMBER DEFAULT 0 -- 아무 값도 입력되지 않으면 0 입력
);
INSERT INTO test04(employee_id) SELECT e.employee_id from employees e WHERE e.employee_id < 106;
SELECT * FROM test04;

-- 존재하는 employee_id값으로 넣는 경우 => 갱신
-- 존재하지 않는 employee_id값으로 넣는 경우 => 추가
INSERT INTO test04(employee_id) VALUES (108);

-- MERGE INTO 구문을 이용해서 처리
-- 입력할 테이블 t1, 테이블 하나에 대해서만 작업시는 USING DUAL
MERGE INTO test04 t1 USING DUAL ON (t1.employee_id = 100)  -- 조건식(t1의 employee_id에 우측값이 있는가?)
WHEN MATCHED THEN UPDATE SET t1.bonus_amt = 100 WHERE t1.employee_id = 100  -- 매칭이 되는 경우(값이 존재)
WHEN NOT MATCHED THEN INSERT (t1.employee_id, t1.bonus_amt) VALUES (100, 100);  -- 매칭이 되지 않는 경우(값이 없음)

MERGE INTO test04 t1 USING DUAL ON (t1.employee_id = 105) 
WHEN MATCHED THEN UPDATE SET t1.bonus_amt = 2000 WHERE t1.employee_id = 105 
WHEN NOT MATCHED THEN INSERT (t1.employee_id, t1.bonus_amt) VALUES (105, 2000); 

SELECT * FROM test04;


-- DELETE 구문은 특정 로우를 삭제한다. 
-- WHERE 절이 들어가지 않는다면 전체 데이터가 삭제된다.
-- 이 점을 주의해서 UPDATE문과 마찬가지로 사실상 WHERE절과 세트로 생각해서 쓰자.
-- MySQL과 문법적으로 큰 차이 없음.

-- test04 테이블에서 bonus_amt가 700을 초과하는 데이터만 삭제
DELETE FROM test04 WHERE bonus_amt > 700;
SELECT * FROM test04;


-- Oracle SQL에서는 인덱스를 조회하기가 MySQL보다 쉽다.
-- 인덱스란 조회를 위해 ROW별로 매겨진 임의의 값이다. 
-- Oracle SQL에서는 SELECT문에 rounum을 적어서 로우 인덱스 번호를 
-- SELECT 문에 rowid를 적어 로우 인덱스 주소 값을 같이 조회할 수 있다.
-- MySQL에는 없는 기능이다. rownum, rowid처럼 사용자가 직접 입력하지 않고
-- 조회되는 컬럼을 가리켜서 의사컬럼이라고 부른다.
SELECT rownum, rowid, employee_id, first_name, last_name FROM employees;

-- GROUP BY 역시 MySQL과 비슷한 문법을 사용한다. 
-- SELECT 집계함수(컬럼명)... GROUP BY (기준컬럼) HAVING 조건절;
-- 조건절은 HAVING으로 처리한다.
SELECT * FROM employees;
-- employees에는 job_id(직무 구분), department_id(부서 구분_) 등 여러 집단을 대표하는 자료가 있다. 
-- GROUP BY를 통해 부서별, 직무별 데이터를 집계, 각 직무별 평균 연봉 구하기
SELECT job_id, avg(salary) FROM employees GROUP BY job_id;

-- 각 직무별 평균 연봉을 구하되, 10000이상을 구함
SELECT job_id, avg(salary) FROM employees GROUP BY job_id HAVING avg(salary) >= 1000;

-- 각 부서별 평균 연봉을 구하되, 6000이상 ~ 9000미만으로 
SELECT department_id, avg(salary) FROM employees GROUP BY department_id HAVING avg(salary) BETWEEN 6000 AND 9000;

-- JOIN은 두 개 이상의 테이블을 하나로 합쳐주는 것을 의미한다.
-- 기본적으로 JOIN시에는 특별한 경우를 제외하고는 합쳐주기 위한 기준컬럼이 필요합니다.
-- 그리고 일반적으로 FOREIGN KEY로 연결된 컬럼간에 JOIN을 수행한다.
-- 그러나 반드시 FOREIGN KEY 관계여야만 조인을 수행할 수 있는 것은 아님.
-- SELECT 테이블

-- 조인구문은 INNER, LEFT, RIGHT, FULL이 있다.
-- MySQL에서는 FULL조인이 FULL키워드로는 불가능함. Oracle에서는 FULL키워드를 허용함
CREATE TABLE join_A (
    emp_id NUMBER
);
CREATE TABLE join_B (
    emp_id NUMBER
);
INSERT INTO join_A VALUES(10);
INSERT INTO join_A VALUES(20);
INSERT INTO join_A VALUES(40);
INSERT INTO join_B VALUES(10);
INSERT INTO join_B VALUES(20);
INSERT INTO join_B VALUES(30);
SELECT * FROM join_A;
SELECT * FROM join_B;

-- INNER JOIN - 둘 다 가지고 있는 10, 20만 출력
SELECT a.emp_id, b.emp_id FROM join_A a INNER JOIN join_B b ON (a.emp_id = b.emp_id);

-- LEFT OUTER JOIN - 왼쪽 테이블 자료를 모두 살림 / 공통자료 10, 20 그리고 A만 가진 자료 40이 출력
SELECT a.emp_id, b.emp_id FROM join_A a RIGHT OUTER JOIN join_B b ON (a.emp_id = b.emp_id);

-- RIGHT OUTER JOIN - 오른쪽 테이블 자료를 모두 살림 / 공통자료 10, 20 그리고 B만 가진 자료 30이 출력
SELECT a.emp_id, b.emp_id FROM join_A a RIGHT OUTER JOIN join_B b ON (a.emp_id = b.emp_id);

-- FULL OUTER JOIN - 왼쪽, 오른쪽 테이블 자료를 모두 살림 / 공통자료 10, 20뿐만 아니라 왼쪽에 40, 오른쪽에 30이 모두 출력
SELECT a.emp_id, b.emp_id FROM join_A a FULL OUTER JOIN join_B b ON (a.emp_id = b.emp_id);
