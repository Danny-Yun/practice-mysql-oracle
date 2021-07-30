/* SELECT 구문은 DB 내부의 자료를 조회하는 구문이다.
SELECT 컬럼명1, 컬럼명2.... FROM 테이블이름 WHRER 조건;
형식을 주로 사용한다. */


/* SELECT 구문을 활용하기에 앞서서 사용할 데이터베이스(스키마)를 지정해야 한다.
이를 위해 USE 구문을 사용함. 아래 구문은 좌측 SCHEMAS에서 employees를 우클릭 한 후 
set as default schema를 클릭하는 것과 같은 효과를 낸다. */


-- 한 줄 주석은 "-- 주석내용"으로 작성한다.
-- employees 데이터베이스가 지금부터 모든 명령을 받습니다.
use employees;


-- ict03 데이터베이스가 지금부터 모든 명령을 받습니다.
use ict03;


-- employees 데이터베이스 내부의 employees table 조회
-- SQL구문의 명령구문은 무조건 대문자, 테이블명이나 호칭 등은 소문자로 작성하는 것이 관례이다.
-- 무조건 지키지 않아도 되는 제약조건이지만, 가독성을 위해 되도록 지키자.
SELECT * FROM employees;


-- 원래 테이블 조회시는 데이터베이스명.테이블명 으로 모두 표기해야 한다.
SELECT * FROM employees.employees;


-- 칼럼을 전체가 아닌 임의로 가져올 때는 컬럼명을 ,로 구분한다.
-- 이 경우 모든 컬럼이 아닌 일부 컬럼만 조회할 수도 있으며
-- 심지어 한 개의 컬럼만 조회하는 등 개수조절도 가능하다.
SELECT first_name, last_name, gender FROM employees;


-- CMD환경에서는 좌측 스키마처럼 DB목록을 보여주는 창이 없으므로 아래 명령어를 이용해 DB목록을 확인할 수 있다.
SHOW databases;


-- 현재 DB정보 조회시
SHOW TABLE STATUS;


-- 특정 테이블의 컬럼 정보를 조회하고 싶다면 아래 명령어를 쓴다.
-- DESCRIBE 테이블명; 혹은 DESC 테이블명;
DESCRIBE employees;
DESC employees;


-- 보통 DB는 그냥 생성하지만, 간혹 DB가 있는데 초기화하기위해서 
-- 만약 기존에 같은 이름을 가진 DB가 존재한다면 삭제하고 다시 만들라는 명령을 내리기도 한다.
-- 아래처럼 조건문을 이용해서 처리.
DROP DATABASE IF EXISTS sqlDB;  -- sqlDB가 존재시 삭제
CREATE DATABASE sqlDB DEFAULT CHARACTER SET utf8;


-- primary key(주요 키)
-- 각 테이블을 대표할 수 있는 대표데이터를 저장하는 컬럼에 붙인다.
-- 모든 테이블은 무조건 하나의 Primary key를 갖는다. 
-- primary key는 자동으로 중복을 방지하고, null도 받을 수 없다.


-- 테이블을 생성합니다. 테이블 생성시 적힌 제약조건과 컬럼명을 활용해 만들어주세요.
CREATE TABLE userTbl(
	userID CHAR(8) PRIMARY KEY NOT NULL,
    name VARCHAR(10) NOT NULL,
    birthYear INT NOT NULL,
    addr CHAR(2) NOT NULL,
    pNum CHAR(11),
    height INT,
    mDate DATE
    );
    
    
-- foreign key(외래 키)
-- 쇼핑몰의 구매자는 반드시 회원이어야 하듯 특정 테이블의 값만 해당 칼럼에 들어올 수 있도록
-- 거는 제약조건 foreign key를 거는 칼럼의 자료형과 크기는 양쪽 모두에서 같아야한다.
-- 참조컬럼에 있는 자료만 타겟칼럼으로 돌아올 수 있다.
-- 지금같은경우 buyTbl의 userID에는 userTbl의 userID에 존재하는 데이터만 저장할 수 있다.
CREATE TABLE buyTbl(
	num INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    userID CHAR(8) NOT NULL,
    prodName CHAR(6) NOT NULL,
    groupName CHAR(4),
    price INT NOT NULL,
    amount INT NOT NULL,
    FOREIGN KEY (userID) REFERENCES userTbl(userID)
    );
    
    
-- 테이블 삭제는 DROP TABLE 테이블명; 으로 합니다.
-- DB처럼 삭제시 IF EXISTS를 쓸 수 있다.
use employees;
DROP TABLE userTbl;
DROP TABLE buytbl;


INSERT INTO userTbl VALUES('LSG', '이승기', 1987, '서울', '01111111111', 182, '2008-8-8');
INSERT INTO userTbl VALUES('KBS', '김범수', 1979, '경남', '01122222222', 173, '2012-4-4');
INSERT INTO userTbl VALUES('KKH', '김경호', 1971, '전남', '01133333333', 177, '2007-7-7');
INSERT INTO userTbl VALUES('JYP', '조용필', 1950, '경기', '01144444444', 166, '2009-4-4');
INSERT INTO userTbl VALUES('SSK', '성시경', 1979, '서울', null, 186, '2013-12-12');
INSERT INTO userTbl VALUES('LJB', '임재범', 1963, '서울', '01166666666', 182, '2009-9-9');
INSERT INTO userTbl VALUES('YJS', '윤종신', 1969, '경남', null, 170, '2005-5-5');
INSERT INTO userTbl VALUES('EJW', '은지원', 1972, '경북', '01188888888', 174, '2014-3-3');
INSERT INTO userTbl VALUES('JKW', '조관우', 1965, '경기', '01199999999', 172, '2010-10-10');
INSERT INTO userTbl VALUES('BBK', '바비킴', 1973, '서울', '01100000000', 176, '2013-5-5');


INSERT INTO buyTbl VALUES(null, 'KBS', '운동화', null, 30, 2);
INSERT INTO buyTbl VALUES(null, 'KBS', '노트북', '전자', 1000, 1);
INSERT INTO buyTbl VALUES(null, 'JYP', '모니터', '전자', 200, 1);
INSERT INTO buyTbl VALUES(null, 'BBK', '모니터', '전자', 200, 5);
INSERT INTO buyTbl VALUES(null, 'KBS', '청바지', '의류', 50, 3);
INSERT INTO buyTbl VALUES(null, 'BBK', '메모리', '전자', 80, 10);
INSERT INTO buyTbl VALUES(null, 'SSK', '책', '서적', 15, 5);
INSERT INTO buyTbl VALUES(null, 'EJW', '책', '서적', 15, 2);
INSERT INTO buyTbl VALUES(null, 'EJW', '청바지', '의류', 50, 1);
INSERT INTO buyTbl VALUES(null, 'BBK', '운동화', NULL, 30, 2);
INSERT INTO buyTbl VALUES(null, 'EJW', '책', '서적', 15, 1);
INSERT INTO buyTbl VALUES(null, 'BBK', '운동화', NULL, 30, 2);


select * from userTbl;
select * from buyTbl;    


-- buyTbl에 임의로 INSERT 구문을 이용해서
-- 없는 userID를 정해 데이터 입력을 시도해보세요.
INSERT INTO buyTbl VALUES(null, 'AAA', '운동화', NULL, 30, 2);


-- 여태까지의 SELECT구문은 조건 없이 모든 데이터를 조회했다.
-- 극단적인 경우 employees 테이블의 수십만 row를 다 조회하다보니, 조회시간만 오래 걸리는 경우가 발생했다.
-- 따라서 조건에 맞도록 필터링을 할 수 있고, 이를 위해 사용하는 구문은 WHERE구문이다.
-- SELECT 컬럼명1, 컬럼명2... FROM 테이블명 WHERE 컬럼명 + 조건식;


-- 아래는 이름이 김경호인 사람만 조회하는 구문임.
SELECT * FROM userTbl WHERE name = '김경호';


-- 관계연산자를 활용해서 대소비교를 하거나
-- and, or를 이용해 조건 여러 개를 연결할 수 있다.
-- 1970년 이후 출생했으며, 키가 182이상인 사람의 아이디와 이름을 조회하는 구문을 아래에 작성해보세요.(workbench, 커맨드라인 둘 다)
SELECT userID, name FROM userTbl WHERE (birthYear > 1970) AND (height > 181); 


-- 키가 180이상, 183이하인 사람만 필터링alter
SELECT * FROM userTbl WHERE (height >= 180) AND (height <= 183);


-- 위와 같이 범위를 정하는 구문은 BETWEEN ~ AND로 간단하게 구현할 수 있다.
SELECT * FROM userTbl WHERE height BETWEEN 180 AND 183;


-- 위와 같이 숫자는 연속된 범위를 갖기 때문에 범위연산자로 처리가 가능하나,
-- addr 같은 자료는 서울이 크다던가 경남이 작다던가 하는 연산적 처리가 불가능하다.
-- 먼저 지역이 경남, 전남, 경북 인 사람의 정보를 WHERE로 조회해보자.
SELECT * FROM userTbl WHERE (addr='경남') or (addr='전남') or (addr='경북');


-- in키워드를 사용, 컬럼명 in (데이터1, 2, 3...);
-- 특정컬럼에 괄호에 담긴 데이터가 포함되는 경우를 전부 출력하게 된다.
SELECT * FROM userTbl WHERE addr IN ('경남', '전남', '경북');


-- like 연산자는 일종의 표현 양식을 만들어준다.
-- like 연산자를 이용하면, %라고 불리는 와일드 카드나 혹은 _라고 불리는 와일드 카드 구문을 사용해
-- 매치되는 문자, 문자열을 찾는다.


-- 김씨를 찾는 경우(%는 뒤에 몇 글자가 오던 상관없음)
SELECT * FROM userTbl WHERE name like '김%';


-- 김씨는 찾는 경우(_는 하나에 한 글자임)
SELECT * FROM userTbl WHERE name like '김__';



-- 서브쿼리(하위쿼리)란 1차적 결과를 얻어놓고, 거기서 다시 조회구문을 중첩해서 날리는 것을 의미한다.
-- 김경호보다 키가 큰 사람을 조회하는 예시
-- 원시적 방법
-- 1. 김경호의 키를 WHERE절을 이용해 확인한다.
SELECT height FROM userTbl WHERE name = '김경호';
-- 2. 확인한 김경호의 키를 쿼리문에 넣는다.
SELECT Name, height from userTbl WHERE height > 177;



-- 서브쿼리 활용 방법
-- 서브쿼리는 FROM 절 다음에 ()를 이용해서 
-- SELECT 구문을 한 번 더 활용한다.
SELECT name, height from userTbl WHERE height > (SELECT height FROM userTbl WHERE name='김경호');



-- 지역이 경남인 사람들 중 키가 제일 큰 사람보다 키가 더 큰 타 지역 사람을 구해보세요.(max를 활용하세요)
SELECT name, height, addr FROM userTbl WHERE height > (SELECT max(height) FROM userTbl Where addr='경남');



-- ANY, ALL, SOME구문은 서브쿼리와 조합해서 사용한다.
-- 지역이 경남인 사람보다 키가 큰 사람을 찾는 쿼리문
-- 아래 구문은 170, 173을 동시에 반환해서 에러가 발생함
SELECT * FROM userTbl WHERE height >= (SELECT height FROM userTbl WHERE addr='경남');


-- ANY 구문을 사용하면 (170보다 크거나 같은) OR (173보다 크거나 같은) 조건으로 들어간다.
-- (개별 값 하나하나에 대해 OR이 걸림) 즉, 170보다 크거나 같다로 결론이 나오게 된다.
SELECT * FROM userTbl WHERE height >= ANY (SELECT height FROM userTbl WHERE addr='경남');


-- ALL 구문을 사용하면 (170보다 크거나 같은) AND (173보다 크거나 같은) 조건으로 들어간다.
-- (개별 조건 하나하나에 대해 AND가 걸림) 즉, 173보다 크거나 같다로 결론이 나오게 된다.
SELECT * FROM userTbl WHERE height >= ALL (SELECT height FROM userTbl WHERE addr='경남');


-- ANY를 사용함에 있어서 = 로 조건비교를 하는 경우
-- 사실상 in 키워드와 같은 효과를 낸다.
SELECT * FROM userTbl WHERE height = ANY (SELECT height FROM userTbl WHERE addr='경남');



-- ORDER BY는 결과물의 개수나 종류에는 영향을 미치지 않지만, 결과물을 순서대로(오름차순, 내림차순) 정렬하는 기능을 가진다.
-- SELECT 컬럼명 FROM 테이블명 ORDER BY 기준컬럼 정렬기준;
-- 정렬기준은 ASC(오름차순), DESC(내림차순)이 있으며, 입력이 없을 경우 기본은 ASC이다.
-- 가입한 순서(mDate순으로 오름차순 조회를 해주세요)
SELECT * FROM userTbl ORDER BY mDate ASC;
SELECT * FROM userTbl ORDER BY mDate DESC;


-- 정렬시 동점인 부분을 처리하기 위해 order by절을 두 개 이상 동시에 나열할 수도 있다.
-- 아래 코드는 키로 내림차순을 하되, 동점이면 가나다라순으로 나열한다.
SELECT * FROM userTbl ORDER BY height DESC, birthYear ASC;



-- DISTINCT는 결과물로 나온 컬럼의 중복값을 다 제거하고, 고유 값을 하나씩만 남긴다.


-- 아래 코드는 지역 종류 5개(데이터 개수는 10개)를 파악하기 어렵다.
SELECT addr FROM userTbl;


-- 중복값을 하나로 출력하기 위해 출력컬럼 앞에 distinct를 붙인다.
SELECT DISTINCT addr FROM userTbl;



-- 출력 요소의 개수를 제한할 때는 limit 구문을 사용한다.
use employees;


-- 데이터가 30만개에 가깝다보니 모든 데이터를 보여주지 않고, 1000개만 보여주도록 설정되어 있음.
SELECT * FROM employees;


-- 테이블명 뒤에 limit 숫자; 가 오는 경우는 적은 숫자 개수만큼만 결과창에 보여준다. 
-- 하나만 적으면 자동으로 0번부터 n개를 보여준다. 
SELECT * FROM employees limit 10;


-- 만약 limit 숫자1, 숫자2; 와 같이 숫자 2개를 넣는 경우, 숫자1번부터 숫자 2개를 보여준다.
SELECT * FROM employees limit 5, 10;



-- GROUP BY는 같은 데이터를 하나의 그룹으로 묶어준다.
-- 조건절은 WHERE가 아닌 HAVING절로 처리하게 된다.
use employees;
SELECT userID, amount FROM buyTbl ORDER BY userID;


-- SELECT 컬럼명, 집계함수(컬럼명2)...FROM 테이블명 GROUP BY 묶을 컬럼명;
SELECT userID, sum(amount) FROM buyTbl GROUP BY userID;


-- 각 유저별 구매물품의 평균가를 구해보세요(총액이 아님)(평균은 avg);
SELECT userID, avg(price) FROM buyTbl GROUP BY userID;


-- 각 유저별 총 구매액을 구해주세요. 총 구매액 = 가격 * 개수의 결과를 다 더한 것 
SELECT userID, sum(price * amount) FROM buyTbl GROUP by userID;


-- 각 물품그룹별 총 판매금액을 집계해주세요.
-- 컬럼명은 as '변경명칭'으로 변경할 수 있다.
SELECT groupName, sum(price * amount) as '총매출' FROM buyTbl group by groupName;


-- 자주쓰는 집계함수 정리
-- AVG() 평균
-- MIN 최솟값 
-- MAX 최댓값 
-- COUNT 로우 개수
-- COUNT(DISTINCT) 종류 개수
-- STDEV() 표준편차
-- VAR_SAMP() 분산 


-- userTbl에서 키가 가장 큰 회원을 찾아주세요.
SELECT name, height FROM userTbl WHERE height = (SELECT max(height) FROM userTbl);


-- userTbl에서 키가 가장 작은 회원을 찾아주세요.
SELECT name, height FROM userTbl WHERE height = (SELECT min(height) FROM userTbl);


-- userTbl의 가수 전체 키 평균을 구해주세요 
SELECT AVG(height) FROM userTbl;



-- GROUP BY절에서는 조건절로 WHERE를 쓰지 않는다.
-- 대신에 HAVING절을 사용한다. 사용법은 완전히 WHERE과 동일.
-- 우선 사용자별 총 구매액을 다시 구해보겠다.
SELECT userID, sum(price * amount) as '총 구매액' FROM buyTbl GROUP BY userID;


-- 여기서 구매액이 1000을 넘기는 사람들만 남겨보겠다
SELECT userID, sum(price * amount) as '총 구매액' FROM buyTbl GROUP BY userID HAVING sum(price * amount) > 1000;
 
 