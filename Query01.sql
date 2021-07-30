/* 1. 데이터베이스 생성 명령
DB 생성시 한글을 쓸 수 있도록 - default character set utf8; */
create database ict03 default character set utf8;


/* 좌하단 Schemas 클릭 후, 새로고침 한 다음 ict03 우클릭alter
-> set as default schema를 클릭함. 이러면 현재 명령을 받을 DB로 지정됨 */


/* DB 사용자 계정 생성하기 */
/* user -> ID, identified by -> Password */
create user 'ict' identified by 'ict';


/* 사용자에게 권한 부여
grant 주고싶은기능1, 주고싶은기능2 ... 
만약 모든 권한을 넘길 때는 all privileges(관리자의 모든 권한)
to 뒤쪽에는 어떤 계정에게 권한을 넘길지 */
grant all privileges on ict03.* to 'ict';


/* 테이블 생성 명령
primary key - 컬럼의 주요 키를 뜻하며, 중복데이터를 방지한다.
하나의 컬럼은 반드시 primary key 속성을 가져야 함.
not null -> 데이터에 null 값이 들어오는 것을 방지.
UNIQUE -> 중복 데이터가 들어오는 것을 막는다. */
CREATE TABLE USERS(
    uid varchar(20) primary key,
    upw varchar(20) not null,
    uname varchar(30) not null,
	email varchar(80) 
    );
    
    
/* 데이터 조회하기 
* -> 전체 적용  */
SELECT uid, email FROM users;
SELECT * FROM users;


/* 데이터 적재하기
INSERT INTO 테이블명 (컬럼1, 컬럼2 ...) VALUES (컬럼1값, 컬럼2값 ...)
만약 모든 컬럼이 전부 입력대상인 경우 테이블명과 VALUE사이는 생략가능
INSERT INTO 테이블명 VALUES (컬럼1값, 컬럼2값 ...) */
INSERT INTO users VALUES("DannyYun", "yjw3570", "윤지우", null);


SELECT * FROM users;
/* WORKBENCH상에서 데이터를 입력했을 때는 마지막에 반드시 commit; 이라고 한번 더 확인 작업을 해줘야 데이터가 최종적으로 저장된다. */
commit;
