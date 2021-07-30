-- Oracle SQL에서도 MySQL처럼 프로그래밍을 할 수 있다.
-- 단, 변수 선언이나 호출 등의 문법, 그리고 콘솔창에 출력하는 문법이 똑같지 않기 때문에 Oracle쪽의 문법을 따로 익혀야 한다.
-- Oracle에서 진행한는 프로그래밍은 PL/SQL이라고 부르기도 한다. 


-- PL/SQL 문법
-- DECLARE 
--    변수명 자료형;
--    ......
-- BEGIN
--    실행문
-- END;


-- 익명 블록 => DECLARE ~ END 구간을 블록이라고 부른다.
-- 익명 블록은 명칭을 붙이지 않고 사용하는 PL/SQL 프로그래밍 구간을 의미한다. 


DECLARE
     vi_num NUMBER;
BEGIN
     vi_num := 100;
     DBMS_OUTPUT.PUT_LINE(vi_num);  --print 구문은 좌측에
END;     


-- sqlDeveloper에서 콘솔창을 여는 방법
-- 상단 메뉴의 보기 -> DBMS 출력 클릭
-- DBMS 출력 창에서 좌상단 녹색 십자가 클릭 후 접속계정 연결


-- 내부적으로 일반 프로그래밍처럼 연산자를 사용할 수 있다. 
DECLARE
    a INTEGER := (2**2) * (3**2);  
BEGIN
    DBMS_OUTPUT.PUT_LINE('a = ' || TO_CHAR(a));
END;


-- MySQL과 마찬가지로 PL/SQL에서 특정 변수에 INTO 구문을 이용해 SELECT 쿼리문의 결과값을 저장할 수 있다. 
DECLARE
    vs_emp_name VARCHAR2(80);
BEGIN 
    SELECT first_name INTO vs_emp_name FROM employees WHERE employee_id = 100;
    dbms_output.put_line('받아온 사원명 ' || vs_emp_name);
END;



-- 선언부에서 변수 자료형을 설정할 때 특정 테이블의 특정 컬럼값을 기준으로 맞춰야 하는 경우가 빈번하다.
-- 이 때, 사용자가 직접적으로 자료형을 일일히 확인하소 기입하면 불편하니 자동으로 해당 컬럼 자료형을 받아오도록 처리할 수도 있다. 
-- 변수명 테이블명.컬럼명%TYPE; 이라고 적어서 처리
-- 예시로 DEPARTMENTS에서 DEPARTMENT_NAME과 LOCATION_ID를 가져오겠다. 
DECLARE
    d_name DEPARTMENTS.DEPARTMENT_NAME%TYPE;
    l_id DEPARTMENTS.LOCATION_ID%TYPE;
BEGIN
    SELECT DEPARTMENT_NAME, LOCATION_ID INTO d_name, l_id FROM DEPARTMENTS WHERE DEPARTMENT_ID = 20; 
END;


-- PL/SQL의 조건문
-- IF 조건식 THEN을 사용하며, 끝나는 지점에 END IF;를 적어주면 된다.
-- 이외 문법은 전부 MySQL쪽과 동일하나 else if는 ELSIF로 표기
DECLARE 
    vn_num1 NUMBER := 10;
    vn_num2 NUMBER := 20;
BEGIN
    IF vn_num1 > vn_num2 THEN DBMS_OUTPUT.put_line(vn_num1 || '값으로 num1이 큽니다.');
    ELSIF vn_num1 < vn_num2 THEN DBMS_OUTPUT.put_line(vn_num2 || '값으로 num1이 큽니다.');
    ELSE DBMS_OUTPUT.put_line('서로 같은 값입니다.');
    END IF;
END;


-- 프로시저 생성 
-- 프로시저는 MYSQL과 비슷하게 사용하며 문법은 약간 달라서 주의할 필요가 있다.
-- CREATE OR REPLACE PROCEDURE 프로시저명(
--      파라미터1 데이터타입,
--      ......
-- IS
--      필요시 변수 및 상수 선언
-- BEGIN
--      실행구문
-- END 프로시저명;
CREATE OR REPLACE PROCEDURE my_new_job(
    n_job_id IN JOBS.JOB_ID%TYPE,
    n_job_title IN JOBS.JOB_TITLE%TYPE,
    n_min_salary IN JOBS.MIN_SALARY%TYPE,
    n_max_salary IN JOBS.MAX_SALARY%TYPE
)
IS
BEGIN
    INSERT INTO JOBS(JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY)
        VALUES(n_job_id, n_job_title, n_min_salary, n_max_salary ); 
    COMMIT;
END my_new_job;    


-- 프로시저 호출시는 MySQL의 CALL 대신 Oracle SQL에서는 EXEC 프로시저명, EXECUTE 프로시저명을 사용한다. 
EXEC my_new_job('INTERN', 'INTERN STAFF', 500, 1000);

