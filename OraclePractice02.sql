-- Oracle SQL������ MySQLó�� ���α׷����� �� �� �ִ�.
-- ��, ���� �����̳� ȣ�� ���� ����, �׸��� �ܼ�â�� ����ϴ� ������ �Ȱ��� �ʱ� ������ Oracle���� ������ ���� ������ �Ѵ�.
-- Oracle���� �����Ѵ� ���α׷����� PL/SQL�̶�� �θ��⵵ �Ѵ�. 


-- PL/SQL ����
-- DECLARE 
--    ������ �ڷ���;
--    ......
-- BEGIN
--    ���๮
-- END;


-- �͸� ��� => DECLARE ~ END ������ ����̶�� �θ���.
-- �͸� ����� ��Ī�� ������ �ʰ� ����ϴ� PL/SQL ���α׷��� ������ �ǹ��Ѵ�. 


DECLARE
     vi_num NUMBER;
BEGIN
     vi_num := 100;
     DBMS_OUTPUT.PUT_LINE(vi_num);  --print ������ ������
END;     


-- sqlDeveloper���� �ܼ�â�� ���� ���
-- ��� �޴��� ���� -> DBMS ��� Ŭ��
-- DBMS ��� â���� �»�� ��� ���ڰ� Ŭ�� �� ���Ӱ��� ����


-- ���������� �Ϲ� ���α׷���ó�� �����ڸ� ����� �� �ִ�. 
DECLARE
    a INTEGER := (2**2) * (3**2);  
BEGIN
    DBMS_OUTPUT.PUT_LINE('a = ' || TO_CHAR(a));
END;


-- MySQL�� ���������� PL/SQL���� Ư�� ������ INTO ������ �̿��� SELECT �������� ������� ������ �� �ִ�. 
DECLARE
    vs_emp_name VARCHAR2(80);
BEGIN 
    SELECT first_name INTO vs_emp_name FROM employees WHERE employee_id = 100;
    dbms_output.put_line('�޾ƿ� ����� ' || vs_emp_name);
END;



-- ����ο��� ���� �ڷ����� ������ �� Ư�� ���̺��� Ư�� �÷����� �������� ����� �ϴ� ��찡 ����ϴ�.
-- �� ��, ����ڰ� ���������� �ڷ����� ������ Ȯ���ϼ� �����ϸ� �����ϴ� �ڵ����� �ش� �÷� �ڷ����� �޾ƿ����� ó���� ���� �ִ�. 
-- ������ ���̺��.�÷���%TYPE; �̶�� ��� ó��
-- ���÷� DEPARTMENTS���� DEPARTMENT_NAME�� LOCATION_ID�� �������ڴ�. 
DECLARE
    d_name DEPARTMENTS.DEPARTMENT_NAME%TYPE;
    l_id DEPARTMENTS.LOCATION_ID%TYPE;
BEGIN
    SELECT DEPARTMENT_NAME, LOCATION_ID INTO d_name, l_id FROM DEPARTMENTS WHERE DEPARTMENT_ID = 20; 
END;


-- PL/SQL�� ���ǹ�
-- IF ���ǽ� THEN�� ����ϸ�, ������ ������ END IF;�� �����ָ� �ȴ�.
-- �̿� ������ ���� MySQL�ʰ� �����ϳ� else if�� ELSIF�� ǥ��
DECLARE 
    vn_num1 NUMBER := 10;
    vn_num2 NUMBER := 20;
BEGIN
    IF vn_num1 > vn_num2 THEN DBMS_OUTPUT.put_line(vn_num1 || '������ num1�� Ů�ϴ�.');
    ELSIF vn_num1 < vn_num2 THEN DBMS_OUTPUT.put_line(vn_num2 || '������ num1�� Ů�ϴ�.');
    ELSE DBMS_OUTPUT.put_line('���� ���� ���Դϴ�.');
    END IF;
END;


-- ���ν��� ���� 
-- ���ν����� MYSQL�� ����ϰ� ����ϸ� ������ �ణ �޶� ������ �ʿ䰡 �ִ�.
-- CREATE OR REPLACE PROCEDURE ���ν�����(
--      �Ķ����1 ������Ÿ��,
--      ......
-- IS
--      �ʿ�� ���� �� ��� ����
-- BEGIN
--      ���౸��
-- END ���ν�����;
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


-- ���ν��� ȣ��ô� MySQL�� CALL ��� Oracle SQL������ EXEC ���ν�����, EXECUTE ���ν������� ����Ѵ�. 
EXEC my_new_job('INTERN', 'INTERN STAFF', 500, 1000);

