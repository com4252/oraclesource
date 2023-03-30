-- JAVADB

-- USERTBL 테이블 생성
CREATE TABLE USERTBL(
NO NUMBER(4) CONSTRAINT PK_USERTBL PRIMARY KEY,
USERNAME NCHAR(4) NOT NULL,
BIRTHYEAR NUMBER(4) NOT NULL,
ADDR NVARCHAR2(30) NOT NULL,
MOBILE VARCHAR2(15)
);
-- NO(숫자 4), USERNAME(이름-한글4이상), BIRTHYEAR(년도-숫자4), ADDR(주소-한글,숫자넉넉하게), MOBILE(010-1234-1234)
-- NO PK 제약조건 지정(조건명 PK_USERTBL)
SELECT * FROM USER_CONSTRATINS;

DROP TABLE USERTBL;

-- 시퀀스 생성
-- user_seq 생성(기본)
CREATE SEQUENCE USER_SEQ;

SELECT * FROM USERTBL;


-- INSERT 
INSERT INTO USERTBL (NO,USERNAME,BIRTHYEAR, ADDR, MOBILE)
VALUES(USER_SEQ.NEXTVAL,'홍길동',1997,'대구광역시 북구 1234','010-1234-1234');

COMMIT;



-- paytype 테이블 : pay_no(숫자-1 pk), info(문자-card, cash)
-- paytype_seq 생성
create table paytype(
pay_no number(1) constraint pk_paytype primary key,
info char(4) not null);
create sequence paytype_seq;

insert into paytype values(paytype_seq.nextval,'card');
insert into paytype values(paytype_seq.nextval,'cash');

select * from paytype; -- 1 : card,   2 : cash

-- suser : user_id(숫자-4 pk), name(문자-한글), pay_no(숫자-1 : paytype테이블에 있는 pay_no참조 해서 사용)
create table suser(
user_id number(4) constraint pk_user_id primary key,
name nchar(4) not null,
pay_no number(1) constraint user_pay_no_fk references paytype(pay_no));


-- product
-- product_id(숫자-8자리-pk),pname(문자넉넉하게), price(숫자 가격), content(문자 정보 넉넉하게)
create table product(
product_id number(8) primary key,
pname varchar2(20) not null,
price number(10) not null,
content varchar2(50));

create sequence product_seq;

drop table product;

-- sorder
-- order_id(숫자-8 pk), user_id(suser 테이블의 user_id참조), product_id(product 테이블의 product_id 참조)
-- order_seq 생성
create table sorder(
order_id number(8) primary key,
user_id number(4) not null references suser(user_id),
product_id number(8) not null references product(product_id));

create sequence order_seq;

alter table sorder add order_date date; -- 구매날짜

commit;

insert into sorder values(order_seq.nextval, 물건을구매한id, 상품id, sysdate);


-- user_id,name,pay_no,info
-- suser와 paytype join 

select u.user_id, u.name, u.pay_no, p.info
from suser u, paytype p
where u.pay_no = p.pay_no and u.user_id=1000;

-- 주문정보 전체 조회
select * from sorder;

-- 주문목록 조회
-- user_id, name, card/cash, product_id, pname, price, content

-- 기준 : sorder
-- suser 테이블 : name     pay_no 위아래두개와 join
-- paytype 테이블 : cash/card      pay_no
-- product 테이블 : product_id, pname, price, content

-- 전체 주문목록 조회
select s.user_id, u.name, t.info, s.product_id, p.pname, p.price, p.content, s.order_date
from sorder s, suser u, paytype t, product p
where s.user_id = u.user_id and u.pay_no = t.pay_no and s.product_id = p.product_id;


-- 홍길동 주문목록 조회
select s.user_id, u.name, t.info, s.product_id, p.pname, p.price, p.content, s.order_date
from sorder s, suser u, paytype t, product p
where s.user_id = u.user_id and u.pay_no = t.pay_no and s.product_id = p.product_id and s.user_id=1000;