/*������ �ּ�*/
-- �� �� �ּ�
-- HR �������� �׽�Ʈ�ϴ� ��. 
-- MySQL���� �޸� Oracle SQL������ ������ �����ͺ��̽� ������� ���� �� �ִ�. 
-- hr�������� �λ��� ���� �����Ͱ� ���� �ִ�.

-- MySQL�� ���������� Oracle������ ���� ������ SELECT������ ����Ѵ�.
SELECT employee_id, first_name, last_name FROM employees;
SELECT * FROM employees;

-- �޿��� 5000�̻��� ������ ���̵�, ��, �̸��� ���.
SELECT employee_id, first_name, last_name FROM employees WHERE salary >= 5000; 

-- Oracle������ ORDER BY�� ������ �� �� �ִ�. �� ������ ���� ���̵� ������������ ����.
SELECT employee_id, first_name, last_name FROM employees WHERE salary >= 5000 ORDER BY employee_id DESC; 

-- ������ �������� / �޿� 5000�̻� + job_id�� 'IT_PROG'�� ���̽��� ��ȸ.
SELECT employee_id, first_name, last_name FROM employees WHERE salary >= 5000 AND job_id = 'IT_PROG' ORDER BY employee_id DESC; 

-- Oracle�� ���ڿ� �ڷ����� ��� ��ҹ��ڸ� �����Ѵ�. 
SELECT employee_id, first_name, last_name FROM employees WHERE salary >= 5000 AND job_id = 'it_frog' ORDER BY employee_id DESC; -- ��ȸ �Ұ�

-- �޿��� 5000�̻��̰ų� Ȥ�� job_id�� 'IT_PROG'�������� ��ȸ.
SELECT employee_id, first_name, last_name FROM employees WHERE salary >= 5000 OR job_id = 'IT_PROG' ORDER BY employee_id DESC;

-- ������ row������ �˰���� ���
SELECT COUNT(*) FROM employees WHERE salary >= 5000 OR job_id = 'IT_PROG';

-- �÷����� ������ ������ ���̺��� ���� �� ������ �̸����� ��ȸ������,
-- SELECT ��������� �ٲ㼭 ��ȸ�ϰ� ���� ���� AS������ ����Ѵ�.
-- SELECT �÷���1 AS �ٲ��̸�1, �÷���2 AS �ٲ��̸�2...
SELECT employee_id AS �������̵� FROM employees;
-- Ű���� AS�� ������ ���� �ִ�. 
SELECT employee_id �������̵� FROM employees;


-- INSERT INTO������ ���̺� ROW�� �߰��ϴ� �����̴�. 
-- MYSQL�� ���� ������ ������ �����. 
CREATE TABLE test01(
    col1 VARCHAR2 (10), -- ���ڿ�
    col2 NUMBER, -- ����
    col3 DATE -- ��¥, (�󼼽ð� ����, �󼼽ð� �Է½� TIMESTAMP)
);

-- �ð��� ���� �ð����� ������ ��� SYSDATE�� �Է�
-- MySQL������ SYSDATE ��� now()�� ����Ѵ�. 
INSERT INTO test01(col1, col2, col3) VALUES ('ABC', 10, SYSDATE);

-- INTO ������ �÷� ������ �ٲ㵵 VALUES���� �ٲ� ������ ���缭 �־��ָ� ������ ����.
INSERT INTO test01(col1, col2, col3) VALUES (SYSDATE, 'DEF', 20);

-- ������ ������ ���� ������ Ÿ���� ������ ������ ������ �߻���.
INSERT INTO test01(col1, col2, col3) VALUES ('ABC', 10, 30);

-- �÷����� ��ü�÷��� ����ִ� ��� MYSQL�� ���������� ���� ������.
INSERT INTO test01 VALUES ('GHI', 10, SYSDATE);

-- �Ϻ� ������ ���� ������ �߻���
INSERT INTO test01 VALUES ('JKL', 30);

-- �÷� ������ ���빰 �����ϱ�. INSERT ~ SELECT ��.
-- SubQUERY ���·� INSERT INTO ������ VALUES�� �� �ڸ��� 
-- ������ �ڷ����� ��ġ�ϴ� SELECT ������ �ۼ��ϸ�
-- SELECT ���� ������� �״�� ���� INSERT �ȴ�. 
CREATE TABLE test02(
    emp_id NUMBER
);

-- �ٷ� �Ʒ��� SELECT ������ NUMBER �����͸� ����� ���´�.
SELECT employee_id FROM employees;

-- �Ʒ� ������ test02 ���̺� ���ο�, 92�� ���� ����� ���� ���� ��ü�� ����ִ´�.
INSERT INTO test02 (SELECT employee_id FROM employees);

-- �����δ� MYSQL�� �Ʒ��� ����ó�� ó����.
-- INSERT INTO test02 VALUES (100), (101), (102)... (206);

SELECT * FROM test02;

-- INSERT ~ SELECT ������ �̿��ؼ� EMPLOYEE ���̺��� employee_id, first_name, last_name, job_id
-- 4�� �÷��� ��ü ����޴� test03 ���̺��� ������ �� ���縦 ����
CREATE TABLE test03 (
    emp_id NUMBER(6) primary key,
    f_name varchar2(20),
    l_name varchar2(20),
    j_id varchar2(20)
);

INSERT INTO test03 (SELECT employee_id, first_name, last_name, job_id FROM employees);

SELECT * FROM test03;

-- UPDATE ��
-- UPDATE SET�� �̿��ؼ� ó���ϸ� MySQL�� ���� ������ ������ ����Ѵ�.
-- UPDATE SET�� �׳� ó���ϸ� �÷� ��ü���� �ٲ��.
-- ���� WHERE�� �Բ� ����ϴ� ���� �Ϲ����̴�. 
SELECT * FROM test01;

-- ���̺� col2�� ���� ���� 50���� �ٲ���.
UPDATE test01 SET col2 = 50;
SELECT * FROM test01;

-- col1�� ���� DEF�� ��츸 col2�� 500���� 
UPDATE test01 SET col2 = 500 WHERE col1 = 'DEF';
SELECT * FROM test01;

-- Oracle SQL�� MERGE������ MYSQL��ON DUPLICATE KEY�� ����.
-- �����Ͱ� �ִ� ��� UPDATE��, ���� ���� INSERT�� �����Ѵ�. 
-- MERGE INTO�� ����ϰ� ����Ŭ������ MySQL���ٴ� �ټ� ����������,
-- ��ɻ����δ� ū ���̴� ���� ������ ������ �������� �ָ��ؾ� ��.
CREATE TABLE test04(
    employee_id NUMBER,
    bonus_amt NUMBER DEFAULT 0 -- �ƹ� ���� �Էµ��� ������ 0 �Է�
);
INSERT INTO test04(employee_id) SELECT e.employee_id from employees e WHERE e.employee_id < 106;
SELECT * FROM test04;

-- �����ϴ� employee_id������ �ִ� ��� => ����
-- �������� �ʴ� employee_id������ �ִ� ��� => �߰�
INSERT INTO test04(employee_id) VALUES (108);

-- MERGE INTO ������ �̿��ؼ� ó��
-- �Է��� ���̺� t1, ���̺� �ϳ��� ���ؼ��� �۾��ô� USING DUAL
MERGE INTO test04 t1 USING DUAL ON (t1.employee_id = 100)  -- ���ǽ�(t1�� employee_id�� �������� �ִ°�?)
WHEN MATCHED THEN UPDATE SET t1.bonus_amt = 100 WHERE t1.employee_id = 100  -- ��Ī�� �Ǵ� ���(���� ����)
WHEN NOT MATCHED THEN INSERT (t1.employee_id, t1.bonus_amt) VALUES (100, 100);  -- ��Ī�� ���� �ʴ� ���(���� ����)

MERGE INTO test04 t1 USING DUAL ON (t1.employee_id = 105) 
WHEN MATCHED THEN UPDATE SET t1.bonus_amt = 2000 WHERE t1.employee_id = 105 
WHEN NOT MATCHED THEN INSERT (t1.employee_id, t1.bonus_amt) VALUES (105, 2000); 

SELECT * FROM test04;


-- DELETE ������ Ư�� �ο츦 �����Ѵ�. 
-- WHERE ���� ���� �ʴ´ٸ� ��ü �����Ͱ� �����ȴ�.
-- �� ���� �����ؼ� UPDATE���� ���������� ��ǻ� WHERE���� ��Ʈ�� �����ؼ� ����.
-- MySQL�� ���������� ū ���� ����.

-- test04 ���̺��� bonus_amt�� 700�� �ʰ��ϴ� �����͸� ����
DELETE FROM test04 WHERE bonus_amt > 700;
SELECT * FROM test04;


-- Oracle SQL������ �ε����� ��ȸ�ϱⰡ MySQL���� ����.
-- �ε����� ��ȸ�� ���� ROW���� �Ű��� ������ ���̴�. 
-- Oracle SQL������ SELECT���� rounum�� ��� �ο� �ε��� ��ȣ�� 
-- SELECT ���� rowid�� ���� �ο� �ε��� �ּ� ���� ���� ��ȸ�� �� �ִ�.
-- MySQL���� ���� ����̴�. rownum, rowidó�� ����ڰ� ���� �Է����� �ʰ�
-- ��ȸ�Ǵ� �÷��� �����Ѽ� �ǻ��÷��̶�� �θ���.
SELECT rownum, rowid, employee_id, first_name, last_name FROM employees;

-- GROUP BY ���� MySQL�� ����� ������ ����Ѵ�. 
-- SELECT �����Լ�(�÷���)... GROUP BY (�����÷�) HAVING ������;
-- �������� HAVING���� ó���Ѵ�.
SELECT * FROM employees;
-- employees���� job_id(���� ����), department_id(�μ� ����_) �� ���� ������ ��ǥ�ϴ� �ڷᰡ �ִ�. 
-- GROUP BY�� ���� �μ���, ������ �����͸� ����, �� ������ ��� ���� ���ϱ�
SELECT job_id, avg(salary) FROM employees GROUP BY job_id;

-- �� ������ ��� ������ ���ϵ�, 10000�̻��� ����
SELECT job_id, avg(salary) FROM employees GROUP BY job_id HAVING avg(salary) >= 1000;

-- �� �μ��� ��� ������ ���ϵ�, 6000�̻� ~ 9000�̸����� 
SELECT department_id, avg(salary) FROM employees GROUP BY department_id HAVING avg(salary) BETWEEN 6000 AND 9000;

-- JOIN�� �� �� �̻��� ���̺��� �ϳ��� �����ִ� ���� �ǹ��Ѵ�.
-- �⺻������ JOIN�ÿ��� Ư���� ��츦 �����ϰ�� �����ֱ� ���� �����÷��� �ʿ��մϴ�.
-- �׸��� �Ϲ������� FOREIGN KEY�� ����� �÷����� JOIN�� �����Ѵ�.
-- �׷��� �ݵ�� FOREIGN KEY ���迩�߸� ������ ������ �� �ִ� ���� �ƴ�.
-- SELECT ���̺�

-- ���α����� INNER, LEFT, RIGHT, FULL�� �ִ�.
-- MySQL������ FULL������ FULLŰ����δ� �Ұ�����. Oracle������ FULLŰ���带 �����
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

-- INNER JOIN - �� �� ������ �ִ� 10, 20�� ���
SELECT a.emp_id, b.emp_id FROM join_A a INNER JOIN join_B b ON (a.emp_id = b.emp_id);

-- LEFT OUTER JOIN - ���� ���̺� �ڷḦ ��� �츲 / �����ڷ� 10, 20 �׸��� A�� ���� �ڷ� 40�� ���
SELECT a.emp_id, b.emp_id FROM join_A a RIGHT OUTER JOIN join_B b ON (a.emp_id = b.emp_id);

-- RIGHT OUTER JOIN - ������ ���̺� �ڷḦ ��� �츲 / �����ڷ� 10, 20 �׸��� B�� ���� �ڷ� 30�� ���
SELECT a.emp_id, b.emp_id FROM join_A a RIGHT OUTER JOIN join_B b ON (a.emp_id = b.emp_id);

-- FULL OUTER JOIN - ����, ������ ���̺� �ڷḦ ��� �츲 / �����ڷ� 10, 20�Ӹ� �ƴ϶� ���ʿ� 40, �����ʿ� 30�� ��� ���
SELECT a.emp_id, b.emp_id FROM join_A a FULL OUTER JOIN join_B b ON (a.emp_id = b.emp_id);
