/* MySQL에서도 프로그래밍이 가능하고, 변수나 함수 등을 지정할 수 있다.
물론 Java, Python, Cpp 등의 프로그래밍과는 달리 제한되는 점이 많다. */


use employees;


-- <MySQL에서 변수 사용하기>
-- MySQL에서 변수를 지정할 때는 SET @변수명 = 값; 의 문법을 사용한다. 
SET @myVar1 = 5;
SET @myVar2 = 3;
SET @myVar3 = 4.25;
SET @myVar4 = '가수의 이름 =>';


-- 출력은 SELECT @변수명; 을 사용한다.
SELECT @myVar1;
-- 만약 계산식 등이 있다면 SELECT 구문 실행 이전에 계산을 모두 마치고 그 결과를 화면에 보여준다.
SELECT @myVar2 + @myVar3;


-- SELECT 구문이 그렇듯, 콤마(,)를 이용해서 출력데이토를 여러 개 나열할 수도 있다.
SELECT @myVar4, Name FROM usertbl;


-- 일반 구문에서 LIMIT에는 변수를 입력해서 쓸 수 없다.
SELECT * FROM usertbl limit 5; /*@myVar1;*/


-- PREPARE 구문
-- PREPARE 구문은 가변적으로 들어갈 문장요소 자리를 ?로 구멍을 뚫어놓고 그 자리를 채우는 방식으로 만든다.
-- 사용법 -> PREPARE 구문이름 FROM '실제 쿼리문'; 
-- 호출 -> EXECUTE 구문이름 USING 전달변수; 


SET @myVar5 = 3;
PREPARE myQuery FROM 'SELECT name, height FROM userTbl LIMIT ?';
EXECUTE myQuery USING @myVar5;



-- <MySQL의 데이터 형식과 형 변환>
-- 데이터 변환은 CAST(), CONVERT() 등의 함수를 이용해서 처리한다. 두 함수의 차이점은 거의 없음.
-- 문법 - CAST(실행문 as 바꿀자료형); / CONVERT(실행문, 바꿀자료형);
SELECT avg(amount) FROM buytbl;  -- 실수로 나오는 평균구매수
SELECT CAST(avg(amount) as SIGNED INTEGER) as '평균 구매' FROM buytbl;  
SELECT CONVERT(avg(amount), SIGNED INTEGER) as '평균 구매' FROM buytbl;  


-- CAST를 이용하면 날짜 양식을 통일시킬 수 있다. 
SELECT CAST('2021$07$20' as DATE);
SELECT CAST('2021/07/20' as DATE);
SELECT CAST('2021%07%20' as DATE);
SELECT CAST('2021@07@20' as DATE);


-- Oracle에서는 sysdate, MySQL에서는 now()를 이용해 현재 시각을 확인할 수 있다.
SELECT now();


-- <암시적 형 변환(자동 형 변환)>
SELECT '100' + 200;   -- 문자와 숫자 = 정수로 변환
SELECT '100' + '300';   -- 문자와 문자 = 정수로 변환


-- 만약 문자를 붙여서 출력하고 싶다면 concat()을 활용한다.
SELECT concat('100','200');  -- 100200을 붙여서 출력  
SELECT concat('100', 300);  -- 100300을 붙여서 출력  


-- 문자는 첫 머리에 숫자가 포함된 경우엔 첫 글자를 숫자로 변환한다.
-- 문자만 있는 경우엔 0으로 변환한다. 
-- 논리식의 경우 0은 false, 1은 true
SELECT 1 > '2mega';
SELECT 3 > '2mega';

SELECT 1 > 'AMEGA';



-- <MySQL 내장함수>
-- CONCAT, CAST, CONVERT 등과 같이 내부에 이미 선언되어 있어서 바로 호출해서 쓸 수 있는 함수들


-- IF(수식, 참일때 리턴, 거짓일때 리턴)
-- 삼항 연산자와 비슷하게 판단한다. 
SELECT IF(100 > 200, '참입니다', '거짓입니다');


-- IFNULL(수식1, 수식2)
-- 수식 1이 NULL이 아니면 수식 1이 반환, 수식1이 NULL이면 수식2로 반환함
SELECT IFNULL(NULL, '널입니다'), IFNULL(100, '널입니다');


-- NULLIF(수식1, 수식2)
-- 수식1과 수식2가 같으면 NULL을 반환하고 다르면 수식2를 반환
SELECT NULLIF(100, 100), NULLIF(200, 100);


-- CASE ~ WHEN ~ ELSE ~ END
-- SWITCH ~ CASE문과 비슷하게, 들어온 자료와 일치하는 구간이 있으면 출력 
-- 일치하는 것이 없을 때는 ELSE쪽 자료를 출력 
-- 단 SQL은 {}로 영역을 표시하지 않기 때문에 구문이 끝나는 지점에 END를 써줘야 한다. 
SELECT CASE 2 
		WHEN 1 THEN '일'
		WHEN 5 THEN '오'
		WHEN 10 THEN '십'
        ELSE '모름'
    END as '결과';
    
    
-- <문자열 함수>'
-- 문자열을 조작하는데 쓰고, 활용도가 높은 편임
-- ASCII(문자), CHAR(숫자)를 넣으면 문자는 숫자로, 숫자는 문자로 바뀐다.
SELECT ASCII('B'), CHAR(100);


-- 문자열의 길이를 그때그때 확인하기 위해서는 CHAR_LENGTH(문자열)을 사용한다. 
-- 이때 결과로 나오는 숫자는 문자열의 길이다.
SELECT CHAR_LENGTH("가나다라마바사");
SELECT CHAR_LENGTH("abcdefghi");


-- CONCAT(문자열1, 문자열2....);
SELECT CONCAT('가', '다', '마', '사');


-- CONCAT_WS(구분자, 문자열1, 문자열2...);
-- 문자열 사이를 구분자를 이용해 붙여줄 수 있음
SELECT CONCAT_WS('-', '1', '2', '3');


-- FORMAT(숫자, 소수점자리)
-- 소수점 아래 몇 자리까지 표현할지 정해준다.
SELECT FORMAT(1234.5678901234, 3);


-- BIN(숫자), HEX(숫자), OCT(숫자)
-- 2진수      16진수     8진수 
-- 정수로 10진수 숫자를 바꿔서 표현해준다.
SELECT BIN(31), HEX(31), OCT(31);


-- INSERT(기존문자열, 위치, 길이, 삽입할 문자열);
-- 기존 문자열의 위치 ~ 길이 사이를 지워주고, 그 사이에 삽입할 문자열을 새로 넣어줌.
SELECT INSERT('abcdefghi', 3, 4, '@@@@');


-- LEFT(문자열, 길이), RIGHT(문자열, 길이)
-- 해당 문자열의 왼쪽, 오른쪽에서 문자열 길이만큼만 남긴다.
SELECT LEFT('abcdefghi', 3), RIGHT('abcdefghi', 4);


-- UCASE(영문자열), LCASE(영문자열)
-- 소문자를 대문자로, 대문자를 소문자로 
SELECT UCASE('abcdEFGH'), LCASE('abcdEFGH');

-- UPPER(문자열), LOWER(문자열) 도 같은 역할을 한다. 
SELECT UPPER('abcdEFGH'), LOWER('abcdEFGH');


-- LPAD(문자열, 길이, 채울 문자열), RPAD(문자열, 길이, 채울 문자열)
-- 문자열을 길이만큼 늘려놓고, 빈 칸에 채울 문자열을 채운다.
SELECT LPAD('이것이', 5, '#-'), RPAD('저것이', 6, '#');



-- LTRIM(문자열), RTRIM(문자열) 
-- 문자열의 왼쪽/오른쪽 부분의 공배을 모두 없애준다. 
-- 단, 가운데 부분의 공백은 사라지지 않음.
SELECT LTRIM('     이것이'), RTRIM("저것이      ");
SELECT '          이것이', '저것이          ';


-- TRIM(문자열), TRIM(방향 '자를문자' FROM '대상문자')
-- TRIM은 기본적으로는 LTRIM + RTRIM 형식으로 양쪽의 모든 공백을 다 삭제해준다. 
-- 공백이 아닌 특정 문자를 삭제하도록 구문을 지정할 수도 있다. 
SELECT TRIM('    무야호         ');
-- 방향은 BOTH(양쪽), LEADING(왼쪽), TRALING(오른쪽) 중 하나를 고르면 된다.alter
SELECT TRIM(BOTH 'ㅋ' FROM 'ㅋㅋㅋㅋㅋㄹㅇㅋㅋㅋㅋㅋㅋ');


-- REPEAT(문자열, 횟수)
-- 문자열을 횟수만큼 반복한다.
SELECT REPEAT('ㅋ', 10);


-- REPLACE(문자열, 원래 문자열, 바꿀 문자열)
SELECT REPLACE( 'Java로 작성되었습니다. JAVA', 'Java', 'MySQL');


-- REVERSE(문자열)
-- 문자열을 인덱스 역순으로 재배치해준다. 
SELECT REVERSE('MySQL');


-- SPACE(길이)
-- 길이만큼의 공백을 사이에 넣어준다. 
SELECT CONCAT('이것이', SPACE(50), '저것이');


-- SUBSTRING(문자열, 시작위치, 길이)
-- SUBSTRING(문자열 FROM 시작위치 FOR 길이)
-- 시작위치붙터 길이만큼의 문자를 반환한다.
-- 길이를 생략하고 파라미터를 2개만 주면, 시작지점부터 끝까지 모든 문자를 반환한다. 
SELECT SUBSTRING('자바스프링마이에스큐엘', 6, 4);
SELECT SUBSTRING('자바스프링마이에스큐엘' FROM 6);



-- <SQL 프로그래밍>
-- SQL에서도 변수선언이 되는 것은 봤었지만, 심지어 프로그래밍을 진행할 수도 있다.
-- 문법) 
-- DELIMITER $$ -- 시작지점
-- CREATE PROCEDURE 선언할 프로시저이름()
-- BEGIN -- 본 실행코드는 BEGIN 아애에 작성한다. 
-- 		실행코드... 
-- END $$ 
-- DELIMITER;


-- 선언해둔 프로시저는 CALL 프로시저명(); 으로 호출이 가능하다. 

-- IF ~ ELSE 문을 프로시저로 작성 
DELIMITER $$ -- 여기서부터 프로시저 선언이 시작됨
CREATE PROCEDURE ifproc() -- ifproc() 프로시저 생성
BEGIN -- ifproc() 호출시 실행문의 시작지점
	DECLARE var1 INT; -- INT타입 var1 내부에서는 @ 안 붙임 
    SET var1 = 100; -- 프로시저 내부 SET은 값 대입용도 
    
	IF var1 = 100 THEN -- 만약 var1변수가 100이라면
		SELECT '100이 맞습니다.';
	ELSE
		SELECT '100이 아닙니다.';
	END IF; -- IF문의 종료지점은 END IF; 로 확인
END $$ -- BEGIN의 종료는 END $$ 로 확인 
DELIMITER ; -- 프로시저의 종료는 DELIMITER; 로 확인


CALL ifproc();


-- 테이블 호출 구문을 프로시저로 만들어보기
DELIMITER $$  -- 프로시저 관련 시작부분
CREATE PROCEDURE getEmp()  -- 프로시저명 선언
	BEGIN  -- 내부 실행문 시작 
		SELECT * FROM employees LIMIT 10;  -- 호출시 실행구문 
	END $$  -- 내부 실행문 끝 
DELIMITER ;  -- 프로시저 관련 종료부분

CALL getEmp();



use sqldb;
-- usertbl에서 name, addr, height을 조회하는 구문을 프로시저로 선언 후 호출
DELIMITER $ $ 
CREATE PROCEDURE getUser() # 이름은 getUser()
	BEGIN # 실행구문 시작
		SELECT name, addr, height FROM usertbl;
    END $$ # 실행구문 종료
DELIMITER ;

CALL getUser();



USE employees;
-- 프로시저를 활용해 employees 테이블의 10001번 직원의 입사일이 5년이 넘었는지 여부를 확인
-- hire_date 컬럼의 DATE 자료를 이용해 판단한다. 
DELIMITER $ $ 
CREATE PROCEDURE getFive() # 이름은 getUser()
	BEGIN # 실행구문 시작
		DECLARE hireDATE DATE;  # 입사 날짜를 받아옴 
        DECLARE todayDATE DATE;  # 오늘 날짜를 받아옴 
        DECLARE days INT;   # 오늘 날짜 - 입사 날짜 해서 경과일수
        
        SELECT hire_date INTO hireDATE FROM employees WHERE emp_no = 10001;
        # hire_date INTO hireDATE는 쿼리문의 결과로 나온 값을 hireDATE 변수에 대입함
        
        SET todayDATE = CURRENT_DATE();  # 오늘 날짜 함수
        SET days = DATEDIFF(todayDATE, hireDATE); # 경과일수 구하는 함수 
        
        IF (days/365) >= 5 THEN  # 입사한지 5년 여부 체크
			SELECT CONCAT('입사한지', days, '일이 경과했습니다.');
		ELSE 
			SELECT CONCAT('5년 미만이고', days, '일째 근무중');
		END IF;
    END $$ # 실행구문 종료
DELIMITER ;

CALL getFive();



-- IF THEN 구문 이후에 ELSE가 아닌 ELSEIF THEN을 붙이면
-- 두 번째, 세 번째 조건...을 줄줄이 붙일 수 있다. 
-- getScore 프로시저를 생성 / 변수로 point(int)는 점수를 입력받는데 77점을 줌 / 
-- 변수로 ranking(char)는 90점 이상이면 'A'를 저장 받고, 80점 이상이면 'B', 70점 이상이면 'C', 60점 이상이면 'D', 그 이하 점수는 'F'를 저장받는다.
-- IF문 종료 후 SELECT문과 CONCAT()을 활용해 
-- 취득 점수 : 77, 학점 : C 라는 구문이 콘솔에 띄워지도록 프로시저 생성 후 호출
DELIMITER $ $ 
CREATE PROCEDURE getScore()
	BEGIN 
		DECLARE point INT;
        DECLARE ranking CHAR(1);
        
        SET point = 77;
        
        IF point >= 90 THEN
			SET ranking = 'A';
        ELSE IF point >= 80 THEN
			SET ranking = 'B';
        ELSE IF point >= 70 THEN
			SET ranking = 'C';
        ELSE IF point >= 60 THEN
			SET ranking = 'D';
        ELSE 
			SET ranking = 'E';
        
        SELECT CONCAT('취득점수 : ', point, '학점 : ', ranking);
    END $$ 
DELIMITER ;

CALL getScore();


-- getScore2() 프로시저는 CASE문을 이용해 작성 / 기본적인 변수나 점수대는 모두 getScore() 프로시저에 요구한 사항 그대로 따라간다. 
-- CASE
-- 		WHEN 조건식 THEN
-- 			실행문;
-- 형태로 작성하면 범위조건이 적용된다. / 제일 마지막에 ELSE문을 사용 / END CASE;로 닫는다. 
DELIMITER $ $ 
CREATE PROCEDURE getScore2()
	BEGIN 
		DECLARE point INT;
        DECLARE ranking CHAR(1);
        
        SET point = 77;
        
        CASE 
			WHEN point >= 90 THEN
				SET ranking = 'A';
			WHEN point >= 80 THEN
				SET ranking = 'B';
			WHEN point >= 70 THEN
				SET ranking = 'C';
			WHEN point >= 60 THEN
				SET ranking = 'D';
			ELSE 
				SET ranking = 'E';
		END CASE;	
        SELECT CONCAT('취득점수 : ', point, '학점 : ', ranking);
    END $$ 
DELIMITER ;

CALL getScore2();



-- SQL에서도 WHILE 문을 작성해서 쓸 수 있다. 
-- WHILE (조건식) DO
-- 		실행문... 
-- END WHILE;
-- 형태로 작성하며, 자바에서 그랬듯, 조건식이 특정 조건을 만족시키지 못하면 탈출하도록 사용한다. 
DELIMITER $ $ 
CREATE PROCEDURE whileProc()
	BEGIN 
		DECLARE i INT;  # i변수 값으로 반복횟수 조절
        SET i = 1;
        
        WHILE (i <= 30) DO
			SET i = (i + 1);
		END WHILE;
        
        SELECT i;
	END $$ 
    DELIMITER ;

CALL whileProc();



-- 3 + 6 + 9 + 12 ...와 같은 방식으로 / 3부터 99까지 더했을 때 총합이 몇인지 SELECT문으로 화면에 띄어주는 프로시저 작성 및 호출
DELIMITER $ $ 
CREATE PROCEDURE whileProc2()
	BEGIN 
		DECLARE i INT;  # i변수 값으로 반복횟수 조절
        DECLARE total INT;
        SET i = 1;
        SET total = 0;
        
        WHILE (i <= 33) DO
			SET total = total + (i * 3);
            SET i = (i + 1);
		END WHILE;
        
        SELECT total;
	END $$ 
    DELIMITER ;

CALL whileProc2();



-- <테이블 심화> 
-- 테이블 생성 2가지 방법
-- 1. CREATE TABLE 구문을 이용해 생성
-- 2. DATABASE의 Tables 탭 우클릭 후 CREATE Table을 클릭해서 생성


-- 테이블을 수정할 때는 ALTER TABLE 구문을 이용한다. 
-- 컬럼 추가 
-- ALTER TABLE 테이블명 ADD 컬럼명 자료형(크기) DEFAULT 디폴트값;
-- 기존 테이블의 가장 마지막 컬럼 다음 위치에 생성된다.

-- job 컬럼을 wbtbl에 추가 / varchar(15) 자료를 저장받음 / 아무것도 입력받지 않았을 때, '0'을 입력받는다.(디폴트 값 설정)
ALTER TABLE sqldb.wbtbl ADD job varchar(15) DEFAULT '0';


-- 컬럼 삭제 
-- ALTER TABLE 테이블명 DROP COLUMN 컬럼명;
-- 테이블 생성시 컬럼을 삭제할 수 없는 제약 조건을 걸고 만드는 경우가 있는데, 이런 컬럼은 바로 삭제가 불가능하다. 

-- money 컬럼 삭제
ALTER TABLE sqldb.wbtbl DROP COLUMN money;


-- 컬럼 변경 
-- ALTER TABLE 테이블명 CHANGE COLUMN 컬럼명 바꿀이름 자료형(크기) 기타 조건들...;

-- job 컬럼의 이름을 ujob으로, 자료형을 varchar(20)으로, default 값을 '1'로 바꿈
ALTER TABLE sqldb.wbtbl CHANGE COLUMN job ujob varchar(20) default '1';


-- 제약조건 추가
-- NOT NULL, UNIQUE 등
-- ALTER TABLE 테이블명 MODIFY 컬럼명 데이터타입 제약조건;
ALTER TABLE sqldb.wbtbl MODIFY ujob varchar(20) not null;


-- 제약조건 삭제
-- 일부 제약조건은 구문이 조금 다르다. 
-- ALTER TABLE 테이블명 DROP 제약조건명;
ALTER TABLE sqldb.wbtbl DROP unique;


