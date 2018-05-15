

------------------------코코팜 테이블-------------------------

--코멘트는 일단 귀찮아서 생략 (나중에 제대로 정리한 버전의 물리모델에는 하나하나 코멘트 할 예정..)


/*
--DD
select T.OWNER, T.TABLE_NAME, T.COLUMN_NAME, T.QUALIFIED_COL_NAME, C.COMMENTS, T.DATA_TYPE, T.DATA_LENGTH, T.DATA_PRECISION, T.NULLABLE, T.DATA_DEFAULT, T.CHARACTER_SET_NAME, T.CHAR_LENGTH
from all_tab_cols T inner join ALL_COL_COMMENTS C  on T.TABLE_NAME = C.TABLE_NAME and T.COLUMN_NAME=C.COLUMN_NAME where T.OWNER='COCOFARM' order by T.TABLE_NAME;



--drop table SITE_IMG_SETTING cascade constraints
drop trigger TODAYS_FARM_COMM_TRG;
drop sequence TODAYS_FARM_COMM_SEQ;
drop table TODAYS_FARMER_COMMENT cascade constraints;
drop table TODAYS_FARMER_RECOMMEND cascade constraints;
drop table TODAYS_FARMER cascade constraints;
drop trigger ACC_SUPPORT_ANS_TRG;
drop trigger ACC_SUPPORT_INSERT_TRG;
drop sequence ACC_SUPPORT_SEQ;
drop table ACCOUNT_SUPPORT cascade constraints;
drop trigger MESSAGE_IDX_TRG;
drop sequence MESSAGE_SEQ;
drop table MESSAGE cascade constraints;
drop table CART cascade constraints;
drop trigger SALE_INQUIRE_ANSWER_TRG;
drop trigger SALE_INQUIRE_INSERT_TRG;
drop sequence SALE_INQUIRE_SEQ;
drop table SALE_INQUIRE cascade constraints;
drop trigger SALE_RECOMMEND_TRG;
drop table SALE_RECOMMEND cascade constraints;
drop trigger PURCHASE_TRG;
drop sequence PURCHASE_SEQ;
drop table PURCHASE cascade constraints;
drop trigger SALE_TRG;
drop sequence SALE_SEQ;
drop table SALE cascade constraints;
drop trigger PRODUCT_CATEGORY_TRG;
drop sequence PRODUCT_CATEGORY_SEQ;
drop table PRODUCT_CATEGORY cascade constraints;
drop trigger BUSINESS_INFO_TRG;
drop table BUSINESS_INFO cascade constraints;
drop trigger ACCOUNT_TRG;
drop sequence ACCOUNT_SEQ;
drop table ACCOUNT cascade constraints;
drop table ACCOUNT_TYPE cascade constraints;

*/

---------------------------- 뭔가 에러가 나면 아래 코드 실행해보기. 매번 할 필요는 없음 ------------------------------------
/*
ALTER SESSION SET PLSCOPE_SETTINGS = 'IDENTIFIERS:NONE';
*/
------------------------------------------------------------------------------------------------------------------
쪽지
idx pk
주는사람 foreign key references ACCOUNT.IDX
받는사람 foreign key references ACCOUNT.IDX

제목
내용
시간
읽음?
타입?

------------------------------------------------  계정 코드 ----------------------------------------------------
-- 이런 종류의 비즈니스 코드에 시퀀스 처리를 하는게 좀 이상해서 여기는 시퀀스를 안 넣어둠 (동적으로 타입을 정의하고 제어하는 구조가 아니니까..)
-- 0:시스템(메세지 처리용) 1:관리자계정 2:사업자계정 3:일반계정  으로 일단 생각중.

create table ACCOUNT_TYPE (

	CODE			number(2,0)
	,TYPE_NAME 		nvarchar2(15)
	
	,constraint ACCOUNT_TYPE_PK primary key (CODE)
	,constraint ACCTYPE_CODE_CHECK check (CODE >0)
);


comment on table ACCOUNT_TYPE is '계정코드 테이블';

comment on column ACCOUNT_TYPE.CODE is '계정코드 번호';

comment on column ACCOUNT_TYPE.TYPE_NAME is '계정코드 이름(설명)';


--drop table ACCOUNT_TYPE cascade constraints;

------------------------------------------------  계정  ----------------------------------------------------
--세션 idx, name, type
create table ACCOUNT (

	IDX					number(8,0)
	,ID					nchar(15)		not null unique
	,PW					nchar(30)		not null
	,NAME				nvarchar2(20)	not null

	,EMAIL				nvarchar2(30)
	,PHONE				number(14,0)
--	,PHONE2				number(14,0)
--	전화번호 두 개 받으려면 윗줄 주석해제

	,POSTNUM			number(8,0)
	,ADDR				nvarchar2(20)
	,DETAILED_ADDR		nvarchar2(50)

	,TYPE				number(2,0)		not null
	,ISDEL				number(1,0)		default 0 not null

	,THUMB_LOC			varchar2(100 char)
	,REG_DATE			timestamp (0) with local time zone	not null

	,constraint ACCOUNT_PK primary key (IDX)
	,constraint ACCOUNT_DELCHECK check (ISDEL in (1,0))
	,constraint FK_ACCOUNT_ACCTYPE foreign key (TYPE) references ACCOUNT_TYPE (CODE)
);

create sequence ACCOUNT_SEQ start with 1 increment by 1;

create or replace trigger ACCOUNT_TRG
	before insert on ACCOUNT 
	for each row 
begin
	if :NEW.IDX is null
		then select ACCOUNT_SEQ.nextval into :NEW.IDX from DUAL;
	end if;
	if :NEW.REG_DATE is null
		then :NEW.REG_DATE := SYSTIMESTAMP;
	end if;
end;
/


comment on table ACCOUNT is '계정 테이블';

comment on column ACCOUNT.IDX is '게정번호- 기본키, 인조식별자 - 트리거 있음';

comment on column ACCOUNT.ID is '계정 아이디 - null 안됨, unique';

comment on column ACCOUNT.PW is '계정 암호 null 안됨';

comment on column ACCOUNT.NAME is '사용자 이름 null 안됨';

comment on column ACCOUNT.EMAIL is '이메일';

comment on column ACCOUNT.PHONE is '전화번호';

--comment on column ACCOUNT.PHONE2 is '전화번호 2';

comment on column ACCOUNT.POSTNUM is '우편번호';

comment on column ACCOUNT.ADDR is '주소 - 도 시 구 동 까지만, api 따름';

comment on column ACCOUNT.DETAILED_ADDR is '세부주소';

comment on column ACCOUNT.TYPE is '계정타입 - 외래키, null 안됨(종속)';

comment on column ACCOUNT.ISDEL is '삭제 확인 코드 - 0 또는 1 null 안됨, 기본값 0. 1이 삭제됨 표시';

comment on column ACCOUNT.THUMB_LOC is '썸네일 위치 디렉토리 이름';

comment on column ACCOUNT.REG_DATE is '계정 등록일 - null안됨, 트리거 있음';


--drop trigger ACCOUNT_TRG;
--drop sequence ACCOUNT_SEQ;
--drop table ACCOUNT cascade constraints;

------------------------------------------------  사업자 정보  ----------------------------------------------------
-- 사업자 등록증에 등록일자가 따로 있으면, 우리쪽에 정보를 입력한 시점을 기록하는 등록일자와 구분해서 하나 더 속성을 추가해야함.

create table BUSINESS_INFO (

	ACC_IDX							number(8,0)		not null
	,BUSINESS_LICENSE_CODE			number(10,0)	not null
	,CORPORATION_NAME				nvarchar2(20)	not null
	,REPRESENTATIVE					nvarchar2(20)	not null

	,BUSINESS_PROVINCE				nvarchar2(4)	not null
	,BUSINESS_CITY					nvarchar2(7)	not null
	,BUSINESS_DONG					nvarchar2(7)	not null
	,BUSINESS_DETAILED_ADDR			nvarchar2(50)	not null

	,HEADHQUARTER_ADDR				nvarchar2(20)	not null
	,HEADHQUARTER_DETAILED_ADDR		nvarchar2(50)	not null

	,BUSINESS_CATEGORY				nvarchar2(25)	not null
	,BUSINESS_TYPE					nvarchar2(25)	not null

	,REG_DATE						timestamp (0) with local time zone	not null

	,constraint BUSINESS_INFO_PK primary key (ACC_IDX)
	,constraint FK_BUSINESS_INFO_ACCOUNT_IDX foreign key (ACC_IDX) references ACCOUNT (IDX) on delete cascade
);

create or replace trigger BUSINESS_INFO_TRG
	before insert on BUSINESS_INFO 
	for each row
	when (NEW.REG_DATE is null)
begin
	:NEW.REG_DATE := SYSTIMESTAMP;
end;
/


comment on table BUSINESS_INFO is '사업자 등록 정보 - 전체가 null안됨';

comment on column BUSINESS_INFO.ADD_IDX is '계정번호 참조 외래키 + 기본키 = 1:1관계';

comment on column BUSINESS_INFO.BUSINESS_LICENSE_CODE is '사업자 번호';

comment on column BUSINESS_INFO.CORPORATION_NAME is '법인명/단체명';

comment on column BUSINESS_INFO.REPRESENTATIVE is '대표자';

comment on column BUSINESS_INFO.BUSINESS_PROVINCE is '사업장 소재지- 도';

comment on column BUSINESS_INFO.BUSINESS_CITY is '사업장 소재지 - 시';

comment on column BUSINESS_INFO.BUSINESS_DONG is '사업장 소재지 - 동';

comment on column BUSINESS_INFO.BUSINESS_DETAILED_ADDR is '사업장 소재지 - 세부주소';

comment on column BUSINESS_INFO.HEADHQUARTER_ADDR is '본점주소 - 도 시 동 까지';

comment on column BUSINESS_INFO.HEADHQUARTER_DETAILED_ADDR is '본점주소 - 세부주소';

comment on column BUSINESS_INFO.BUSINESS_CATEGORY is '사업의 업태';

comment on column BUSINESS_INFO.BUSINESS_TYPE is '사업의 종류';

comment on column BUSINESS_INFO.REG_DATE is '등록일 - 트리거있음';	

--drop trigger BUSINESS_INFO_TRG;
--drop table BUSINESS_INFO cascade constraints;


---------------------------------------------- 상품 카테고리 관리 ----------------------------------------------------

create table PRODUCT_CATEGORY (

	IDX					number(3,0)
	,SUPER_CATEGORY		number(3,0)
	,NAME				nvarchar2(15) not null
	
	,constraint PRODUCT_CATEGORY_PK primary key (IDX)
	,constraint PRODUCT_CAT_CAT_FK foreign key (SUPER_CATEGORY) references PRODUCT_CATEGORY (IDX)
);

create sequence PRODUCT_CATEGORY_SEQ start with 1 increment by 1;

create or replace trigger PRODUCT_CATEGORY_TRG
	before insert on PRODUCT_CATEGORY 
	for each row
	when (NEW.IDX is null)
begin
	:NEW.IDX := PRODUCT_CATEGORY_SEQ.nextval;
end;
/


comment on table PRODUCT_CATEGORY is '상품 카테고리';

comment on column PRODUCT_CATEGORY.IDX is '카테고리 식별 번호 - 인조식별자 기본키';

comment on column PRODUCT_CATEGORY.SUPER_CATEGORY is '외래키 - 자기 식별번호 참조, 트리구조';

comment on column PRODUCT_CATEGORY.NAME is '카테고리 이름 - null 안됨';


--drop trigger PRODUCT_CATEGORY_TRG;
--drop sequence PRODUCT_CATEGORY_SEQ;
--drop table PRODUCT_CATEGORY cascade constraints;

---------------------------------------------- 판매 (거래 중개. 이하 '판매') 목록 ----------------------------------------------------

create table SALE(

	IDX				number(9,0)
	,ACC_IDX		number(8,0)		not null
	,TITLE			nvarchar2(40)	not null

	,WRITTEN_TIME	timestamp (0) with local time zone	not null
--	,LAST_EDITED	timestamp (0) with local time zone (일단 안넣음. 마지막 수정 시간 기록하려면 넣기. 이것도 '초' 까지 넣는걸로 정함. 소수점이 필요하면 괄호 안의 숫자 변경. '일'까지만 필요하면 date로 바꾸기)

	,CONTENT1		nvarchar2(1000)
	,CONTENT2		nvarchar2(1000)
	,CONTENT3		nvarchar2(1000)

	,IMG			varchar2(100 char)
	,IMG2			varchar2(100 char)
	,IMG3			varchar2(100 char)

	,constraint SALE_PK primary key (IDX)
	,constraint FK_SALE_ACC_IDX foreign key (ACC_IDX) references ACCOUNT (IDX) on delete cascade
	,constraint FK_SALE_CATEGORY foreign key (CATEGORY) references PRODUCT_CATEGORY (IDX) on delete set null
);

create sequence SALE_SEQ start with 1 increment by 1;

create or replace trigger SALE_TRG
	before insert on SALE
	for each row
begin
	if :NEW.IDX is null
		then :NEW.IDX := SALE_SEQ.nextval;
	end if;
	if :NEW.WRITTEN_TIME is null
		then :NEW.WRITTEN_TIME := SYSTIMESTAMP;
	end if;
end;
/

제목
부가설명
점수
대표이미지
원산지
	도
	시
	동
	상세
본문이미지


comment on table SALE is '판매 목록';

comment on column SALE.IDX is '';

comment on column SALE.ACC_IDX is '';

comment on column SALE.TITLE is '';

comment on column SALE.WRITTEN_TIME is '';

comment on column SALE.IDX is '';

comment on column SALE.IDX is '';

comment on column SALE.IDX is '';

comment on column SALE.IDX is '';








--drop trigger SALE_TRG;
--drop sequence SALE_SEQ;
--drop table SALE cascade constraints;

---------------------------------------------- 옵션 목록 ----------------------------------------------------







---------------------------------------------- 구매 목록 ----------------------------------------------------
-- 상태 처리용 테이블(상태코드. STATE) 은 일단 안만들어둠. 설명도 필요하고 어떻게 할지 논의가 좀 필요한 부분. 그냥 어플리케이션 로직으로 둘 수도 있으니 당장은 작업 가능하리라 생각함.
-- 결제 타입도 코드로 처리할 모양으로 속성만 넣어두고 실제 테이블은 안 만들어둠.
-- 환불도 따로 테이블을 두지 않는 구조로 일단 만들어둠.

create table PURCHASE(

	IDX						number(12,0)
	,PURCHASED_ACC			number(8,0)		not null
	,SALE_IDX				number(9,0)

	,SOLD_ACC				number(8,0)
	,TITLE					nvarchar2(40)	not null
	,PRICE					number(7,0)		not null
	,AMOUNT					number(7,0)		not null
	,UNIT					nvarchar2(10)	not null
	,PRODUCER				nvarchar2(20)	not null
	,ORIGIN					nvarchar2(40)	not null

-- 내용 추가용 예시 속성.. 지우고 적당히 추가해서 쓰거나 아니면 일단 연습용으로 그냥 쓰거나..
	,CONTENT1				nvarchar2(1000)
	,CONTENT2				nvarchar2(1000)
	,CONTENT3				nvarchar2(1000)

-- 구매한 이미지 처리용 예시 속성(거래 기록으로 남겨둘 부분). 일단 넣어두긴 하는데 이쪽 설계의 세부 사안을 만들어야 제대로 결정할 수 있는 부분 - 예를들어 판매글이 지워지고 이미지는 남는가, 변경되면? 이런거.
	,IMG					varchar2(100 char)
	,IMG2					varchar2(100 char)
	,IMG3					varchar2(100 char)

	,STATE					number(2,0)		not null

	,PAYMENT_TIME			timestamp (3) with local time zone	not null
	,PAYMENT_TYPE			number(2,0)		not null
	,PAYMENT_NAME			nvarchar2(20)	not null
	,PAYMENT_PHONE			number(14,0)

	,IS_Refunded			number(1,0)		default 0 not null
	,REFUNDED_TIME			timestamp (3) with local time zone

	,DELIVERY_LOC			nvarchar2(50)	not null
	,RECEIVER_NAME			nvarchar2(20)	not null
	,RECEIVER_PHONE			number(14,0)

	,constraint PURCHASE_PK primary key (IDX)
	,constraint FK_PURCHASE_ACCOUNT foreign key (PURCHASED_ACC) references ACCOUNT (IDX) on delete cascade
-- 영수증 처리를 해야 하는데 cascade 하는게 맞는지 잘 모르겠음. 애초에 계정 삭제 상황에 대한 부분이 제대로 설계가 안되어 있음.

	,constraint FK_PURCHASE_SALE foreign key (SALE_IDX) references SALE (IDX) on delete set null
-- 판매글 지우고 나서 null 로 일단 두는데 어플리케이션에서 null 처리는 알아서...

	,constraint FK_PURCHASE_SOLDACC foreign key (SOLD_ACC) references ACCOUNT (IDX) on delete set null
-- 판 계정이 삭제되면 null 로 세팅하긴 하는데 계정 삭제에 대해서 좀 설계를 해야 함. (사실 그냥 모른척 해도 되고)

	,constraint PURCHASE_UNIQUE unique (IDX, PURCHASED_ACC, SALE_IDX)
-- 아래 평가 댓글 역정규화 외래키 용 unique.
);

create sequence PURCHASE_SEQ start with 1 increment by 1;

create or replace trigger PURCHASE_TRG
	before insert on PURCHASE
	for each row
begin
	if :NEW.IDX is null
		then :NEW.IDX := PURCHASE_SEQ.nextval;
	end if;
	if :NEW.PAYMENT_TIME is null
		then :NEW.PAYMENT_TIME := SYSTIMESTAMP;
	end if;
end;
/


--drop trigger PURCHASE_TRG;
--drop sequence PURCHASE_SEQ;
--drop table PURCHASE cascade constraints;

---------------------------------------------- 판매 평가 댓글 ----------------------------------------------------
-- 성능..및 쿼리문의 작성을 용이하게 하기 위해 역정규화를 해둠. (SALE_IDX,PURCHASED_ACC)

create table SALE_RECOMMEND (

	PURCHASE_IDX		number(12,0)
	,PURCHASED_ACC		number(8,0)		not null
	,SALE_IDX			number(9,0)
	,SCORE				number(3,0)		not null

	,WRITTEN_TIME		timestamp (0) with local time zone	not null
--	,LAST_EDITED		timestamp (0) with local time zone (보류: 마지막 수정 시간 기록하려면 넣기. 이것도 '초' 까지 넣는걸로 정함. 소수점이 필요하면 괄호 안의 숫자 변경. '일'까지만 필요하면 date로 바꾸기)

	,CONTENT			nvarchar2(2000)

	,constraint SALE_RECOMMEND_PK primary key (PURCHASE_IDX)
	,constraint FK_SALE_RECOMMEND_PURCHASE foreign key (PURCHASE_IDX, PURCHASED_ACC, SALE_IDX) references PURCHASE ( IDX, PURCHASED_ACC, SALE_IDX) on delete cascade
	,constraint SALE_RECOMMEND_SCORE_CHECK check (SCORE between 1 and 100)
);

create or replace trigger SALE_RECOMMEND_TRG
	before insert on SALE_RECOMMEND
	for each row
	when (NEW.WRITTEN_TIME is null)
begin
	:NEW.WRITTEN_TIME := SYSTIMESTAMP;
end;
/


--drop trigger SALE_RECOMMEND_TRG;
--drop table SALE_RECOMMEND cascade constraints;

---------------------------------------------- 판매글에 대한 문의글 ----------------------------------------------------

create table SALE_INQUIRE(
	IDX				number(11,0)
	,SALE_IDX		number(9,0)		not null
	,WRITER			number(8,0)		not null

	,TITLE			nvarchar2(40)	not null
	,CONTENT		nvarchar2(2000)
	,WRITTEN_TIME	timestamp (0) with local time zone

	,ANSWER			nvarchar2(2000)
	,ANSWER_TIME	timestamp (0) with local time zone

	,constraint SALE_INQUIRE_PK primary key (IDX)
	,constraint FK_SALE_INQUIRE_SALE_IDX foreign key (SALE_IDX) references SALE (IDX) on delete cascade
	,constraint SALE_INQUIRE_ACC_IDX foreign key (WRITER) references ACCOUNT (IDX) on delete cascade
);

create sequence SALE_INQUIRE_SEQ start with 1 increment by 1;

create or replace trigger SALE_INQUIRE_INSERT_TRG
	before insert on SALE_INQUIRE
	for each row
begin
	if :NEW.IDX is null
		then :NEW.IDX := SALE_INQUIRE_SEQ.nextval;
	end if;
	if :NEW.WRITTEN_TIME is null
		then :NEW.WRITTEN_TIME := SYSTIMESTAMP;
	end if;
end;
/

create or replace trigger SALE_INQUIRE_ANSWER_TRG
	before update of ANSWER on SALE_INQUIRE
	for each row
	when (NEW.ANSWER_TIME is null)
begin
	:NEW.ANSWER_TIME := SYSTIMESTAMP;
end;
/


--drop trigger SALE_INQUIRE_ANSWER_TRG;
--drop trigger SALE_INQUIRE_INSERT_TRG;
--drop sequence SALE_INQUIRE_SEQ;
--drop table SALE_INQUIRE cascade constraints;

------------------------------------------------  장바구니  ----------------------------------------------------
--ACC_IDX 와 SALE_IDX 을 묶어서 기본키 처리. -> 장바구니에 이미 있는 목록에 또 추가버튼을 누르거나 하는 식의 작동방식은 일단 어플리케이션에서 잘 처리해야 함. (아니면 트리거를 쓸 수도 있고.)

create table CART (

	ACC_IDX			number(8,0)
	,SALE_IDX		number(11,0)
	,COUNT			number(3,0)
	
	,constraint CART_PK primary key (ACC_IDX, SALE_IDX)
	,constraint FK_CART_ACCOUNT foreign key (ACC_IDX) references ACCOUNT (IDX) on delete cascade
	,constraint FK_CART_SALE foreign key (SALE_IDX) references SALE(IDX) on delete cascade
	,constraint CART_COUNT_CHECK check (COUNT >0)
);


--drop table CART cascade constraints;

------------------------------------------------  쪽지  ----------------------------------------------------

create table MESSAGE (

	IDX			number(11,0)
	,ACC_IDX	number(8,0)			not null
	,CONTENT	nvarchar2(1000)
	,IS_READ	number(1,0)			default 0 not null

	,constraint MESSAGE_PK primary key (IDX)
	,constraint FK_MESSAGE_ACCOUNT_IDX foreign key (ACC_IDX) references ACCOUNT (IDX)
);

create sequence MESSAGE_SEQ start with 1 increment by 1;

create or replace trigger MESSAGE_IDX_TRG
	before insert on MESSAGE
	for each row
	when (NEW.IDX is null)
begin
	:NEW.IDX := MESSAGE_SEQ.nextval;
end;
/


--drop trigger MESSAGE_IDX_TRG;
--drop sequence MESSAGE_SEQ;
--drop table MESSAGE cascade constraints;

------------------------------------------------  1:1 문의  ----------------------------------------------------

create table ACCOUNT_SUPPORT (
	IDX				number(10,0)
	,ACC_IDX		number(8,0)			not null
	,CONTENT		nvarchar2(2000)
	
	,WRITTEN_TIME	timestamp (0) with local time zone
	
	,ANS_ACC		number(8,0)
	,ANSWER			nvarchar2(2000)
	,ANSWER_TIME	timestamp (0) with local time zone

	,constraint ACC_SUPPORT_PK primary key (IDX)
	,constraint FK_ACC_SUPPORT_ACC foreign key (ACC_IDX) references ACCOUNT (IDX) on delete cascade
	,constraint FK_ACC_SUPPORT_ANS_ACC foreign key (ANS_ACC) references ACCOUNT (IDX) on delete set null
);

create sequence ACC_SUPPORT_SEQ start with 1 increment by 1;

create or replace trigger ACC_SUPPORT_INSERT_TRG
	before insert on ACCOUNT_SUPPORT
	for each row
begin
	if :NEW.IDX is null
		then :NEW.IDX := ACC_SUPPORT_SEQ.nextval;
	end if;
	if :NEW.WRITTEN_TIME is null
		then :NEW.WRITTEN_TIME := SYSTIMESTAMP;
	end if;
end;
/

create or replace trigger ACC_SUPPORT_ANS_TRG
	before update of ANSWER on ACCOUNT_SUPPORT
	for each row
	when (NEW.ANSWER_TIME is null)
begin
	:NEW.ANSWER_TIME := SYSTIMESTAMP;
end;
/

--drop trigger ACC_SUPPORT_ANS_TRG;
--drop trigger ACC_SUPPORT_INSERT_TRG;
--drop sequence ACC_SUPPORT_SEQ;
--drop table ACCOUNT_SUPPORT cascade constraints;

------------------------------------------------  오늘의 농부  ----------------------------------------------------


create table TODAYS_FARMER (

	ACC_IDX			number(8,0)

	,TITLE			nvarchar2(30)	not null
	,CONTENT		nclob
--(내용 nclob. 각종html 을 넣다보면 매우 길어질 거라 생각해서 nclob. 대신 문자열로 바꾸기 위해서 to_nclob 함수 이용. 불편하고 쓸데없다 싶으면 nvarchar2 로 변경-최대 2000자)
	,WRITTEN_TIME	timestamp (0) with local time zone default SYSTIMESTAMP
	
--	,VIEW_COUNT		number(9,0)	(보류: 조회수 필요하면 넣기, 아이디당 조회수를 1개로 제한하려면 별도의 테이블 작성 필요.)
--	,LAST_EDITED	timestamp (0) with local time zone (보류: 마지막 수정 시간 기록하려면 넣기.)

--	,RECOMMEND		number(8,0)	(매번 전체조회를 피하기 위해 넣을 수 있는 속성, 무결성 관리를 하려면 별도의 뷰를 생성하고 트리거를 쓰는 짓을 해야 되서 일단 보류)

	,IMG			varchar2(100 char)
--이미지를 제대로 여럿 넣으려면 별도의 테이블 쓰기

	,constraint TODAYS_FARMER_PK primary key (ACC_IDX)
	,constraint FK_TODAYS_FARMER_ACC foreign key (ACC_IDX) references ACCOUNT (IDX) on delete cascade
);


--drop table TODAYS_FARMER cascade constraints;

------------------------------------------------  오늘의 농부 추천(일단 추천식으로 가정)  ----------------------------------------------------

create table TODAYS_FARMER_RECOMMEND (

	RECOMMEND_ACC			number(8,0)
	,TODAYS_FARMER_IDX		number(8,0)
	
	,constraint TODAYS_FARM_RECOMM_PK primary key (RECOMMEND_ACC, TODAYS_FARMER_IDX)
	,constraint FK_TODAYS_FARM_REC_ACC foreign key (RECOMMEND_ACC) references ACCOUNT (IDX) on delete cascade
	,constraint FK_TODAYS_FARM_RECOMM foreign key (TODAYS_FARMER_IDX) references TODAYS_FARMER (ACC_IDX) on delete cascade
);

--drop table TODAYS_FARMER_RECOMMEND cascade constraints;

------------------------------------------------  오늘의 농부 댓글 ----------------------------------------------------

create table TODAYS_FARMER_COMMENT (

	IDX						number(10,0)
	,TODAYS_FARMER_IDX		number(8,0)		not null
	,WRITER					number(8,0)		not null
	,CONTENT				nvarchar2(200)	not null

	,WRITTEN_TIME			timestamp (0) with local time zone
--	,LAST_EDITED			timestamp (0) with local time zone (보류:마지막 수정 시간 기록하려면 넣기.)

--	,SUPER_COMMENT			number(11,0)	(대댓글 만들고 싶으면 넣기, 자기 기본키 참조 외래키. scott예제의 직속 상사 코드 같은 형태)

	,constraint TODAYS_FARM_COMM_PK primary key (IDX)
	,constraint FK_TODAYS_FARM_COMM foreign key (TODAYS_FARMER_IDX) references TODAYS_FARMER (ACC_IDX) on delete cascade
	,constraint FK_FARM_COMM_WRITER foreign key (WRITER) references ACCOUNT (IDX) on delete cascade
--혹시 대댓글 만드려면 cascade 설정을 null 로 바꿔야 함
);

create sequence TODAYS_FARM_COMM_SEQ start with 1 increment by 1;

create or replace trigger TODAYS_FARM_COMM_TRG
	before insert on TODAYS_FARMER_COMMENT
	for each row
begin
	if :NEW.IDX is null
		then :NEW.IDX := TODAYS_FARM_COMM_SEQ.nextval;
	end if;
	if :NEW.WRITTEN_TIME is null
		then :NEW.WRITTEN_TIME := SYSTIMESTAMP;
	end if;
end;
/


--drop trigger TODAYS_FARM_COMM_TRG;
--drop sequence TODAYS_FARM_COMM_SEQ;
--drop table TODAYS_FARMER_COMMENT cascade constraints;

---------------------------------------------- 여타 게시판 추가 예정(게시판은 다 비슷비슷하게 나올 듯?) ----------------------------------------------------


---------------------------------------------- 사이트 배너 관리 ----------------------------------------------------

/*
당장은 이런 테이블의 필요성이 전혀 느껴지지 않아서 일단 코멘트 처리해둠.
만약 사이트의 여러 이미지를 등록해두고, 저장된 위치를 DB에서 불러오는 리스너를 이용한다던가 하는 걸 만든다면,
게다가 관리자 쪽에서 여러 개를 추가하면 다시 jsp에서 참조하는 parameter 를 바꿔주는 장치를 만든다면 쓸 만한 테이블.
아니면 프로토타입에 굳이 넣을 필요가 없음(나중에도).

create table SITE_IMG_SETTING (

	BANNER_LOC		varchar2(100 char)
	,constraint SITE_IMG_SET_PK primary key (BANNER_LOC)
);
*/


--drop table SITE_IMG_SETTING cascade constraints

---------------------------------------------- 메인 노출 경매 설정 ----------------------------------------------------

/*


SITE_MAIN_AUCTION
	#AUCT_IDX		number(8,0)

몇개까지 노출할 것인지를 DB 수준에서 관리하지 않는 구조. 5개로 그냥 고정해버린다면 아예 속성 5개 짜리 1개 행 테이블로 만들어 버릴 수도 있음.
*/
