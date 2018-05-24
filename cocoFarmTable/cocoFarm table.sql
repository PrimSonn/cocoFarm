

------------------------코코팜 테이블-------------------------

/*
--DD 출력
select T.OWNER, T.TABLE_NAME, T.COLUMN_NAME, T.QUALIFIED_COL_NAME, C.COMMENTS, T.DATA_TYPE, T.DATA_LENGTH, T.DATA_PRECISION, T.NULLABLE, T.DATA_DEFAULT, T.CHARACTER_SET_NAME, T.CHAR_LENGTH
from all_tab_cols T inner join ALL_COL_COMMENTS C  on T.TABLE_NAME = C.TABLE_NAME and T.COLUMN_NAME=C.COLUMN_NAME where T.OWNER='COCOFARM' order by T.TABLE_NAME;

select TC.TABLE_NAME, TC.COMMENTS TABLE_COMMENTS, TB.COLUMN_NAME, TB.COMMENTS COLUMN_COMMENTS, TB.DATA_TYPE, TB.DATA_LENGTH, TB.DATA_PRECISION, TB.NULLABLE, TB.DATA_DEFAULT, TB.CHARACTER_SET_NAME, TB.CHAR_LENGTH from ALL_TAB_COMMENTS TC
full outer join
    (select T.OWNER, T.TABLE_NAME, T.COLUMN_NAME, T.QUALIFIED_COL_NAME, C.COMMENTS, T.DATA_TYPE, T.DATA_LENGTH, T.DATA_PRECISION, T.NULLABLE, T.DATA_DEFAULT, T.CHARACTER_SET_NAME, T.CHAR_LENGTH
    from all_tab_cols T 
    inner join ALL_COL_COMMENTS C  on T.TABLE_NAME = C.TABLE_NAME and T.COLUMN_NAME=C.COLUMN_NAME) TB
on TC.TABLE_NAME = TB.TABLE_NAME
where TC.TABLE_TYPE = 'TABLE' and TC.OWNER = 'COCOFARM' order by TABLE_NAME;

--USER_TABLES.TABLE_NAME
--USER_SEQUENCES.SEQUENCE_NAME
--USER_TRIGGERS.TRIGGER_NAME
--USER_INDEXES.INDEX_NAME
*/

-------------------------------------------------------------

drop trigger SITE_IMG_TRG;
drop sequence SITE_IMG_SEQ;
drop table SITE_IMG_SETTING cascade constraints;

drop table SITE_IMG_TYPE cascade constraints;

drop table SITE_MAIN_AUCTION cascade constraints;

drop trigger ANNOUNCEMENT_EDITED_TRG;
drop trigger ANNOUNCEMENT_TRG;
drop sequence ANNOUNCEMENT_SEQ;
drop table ANNOUNCEMENT cascade constraints;

drop trigger TODAYS_FARM_COMM_TRG;
drop sequence TODAYS_FARM_COMM_SEQ;
drop table TODAYS_FARMER_COMMENT cascade constraints;

drop table TODAYS_FARMER_PICK cascade constraints;

drop trigger TODAYS_FARMER_EDIT_TRG;
drop table TODAYS_FARMER cascade constraints;

drop trigger MESSAGE_TRG;
drop sequence MESSAGE_SEQ;
drop index MESSAGE_SENDER_ISDEL_INDEX;
drop table MESSAGE cascade constraints;

drop table MESSAGE_TYPE cascade constraints;

drop trigger BID_CONTRACT_TRG;
drop table BID_CONTRACT cascade constraints;

drop trigger BID_CONTRACT_RECPT_TRG;
drop sequence BID_CONTRACT_RECPT_SEQ;
drop index BID_CONTRCT_RECPT_INDX;
drop table BID_CONTRACT_RECEIPT cascade constraints;

drop trigger BID_CONTRACT_QUE_TRG;
drop table BID_CONTRACT_QUE cascade constraints;

drop trigger BID_INSERT_TRG;
--drop sequence BID_SEQ;
drop index BID_BIDDER_STATE_INDEX;
drop table BID cascade constraints;

drop table CONTRACT_TIME_WINDOW_TYPE cascade constraints;

drop table BID_STATE_TYPE cascade constraints;

drop sequence BID_DEPO_RECPT_SEQ;
drop trigger BID_DEPOSITE_RECPT_TRG;
drop index BID_DEPO_RECPT_INDEX;
drop table BID_DEPOSITE_RECEIPT cascade constraints;

drop trigger AUCTION_DUE_QUE_TRG;
drop index AUCTION_DUE_QUE_INDEX;
drop table AUCTION_DUE_QUE cascade constraints;

drop table AUCTION_CATEGORY_MAP cascade constraints;

drop trigger AUCTION_IDX_REGT_TRG;
drop sequence AUCTION_SEQ;
drop index AUCTION_ISDEL_ACC_IDX;
drop table AUCTION cascade constraints;

drop table AUCTION_STATE_TYPE cascade constraints;

drop table AUCTION_TIME_WINDOW_TYPE cascade constraints;

drop trigger SALE_EVAL_TRG;
drop index SALE_EVAL_INDEX;
drop table SALE_EVALUATION cascade constraints;

drop trigger SALE_OPT_RECPT_TRG;
drop sequence SALE_OPT_RECPT_SEQ;
drop index SALE_OPT_RECPT_INDEX;
drop table SALE_OPTION_RECEIPT cascade constraints;

drop trigger CART_TRG;
drop sequence CART_SEQ;
drop table CART cascade constraints;

drop trigger SALE_INQUIRE_ANSWER_TRG;
drop trigger SALE_INQUIRE_INSERT_TRG;
drop sequence SALE_INQUIRE_SEQ;
drop index SALE_INQUIRE_INDEX;
drop table SALE_INQUIRE cascade constraints;

drop trigger SALE_OPT_CAT_UPDATE_TRG;
drop trigger SALE_OPT_CAT_INSERT_TRG;
drop table SALE_OPT_CATEGORY cascade constraints;

drop trigger SALE_OPT_INSERT_TRG;
drop trigger SALE_OPT_SALE_EDIT_TRG;
drop trigger SALE_OPTION_WRITTENTIME_TRG;
drop trigger SALE_OPT_UPDATE_TRG;
drop sequence SALE_OPTION_SEQ;
drop index SALE_OPTION_INDEX;
drop table SALE_OPTION cascade constraints;

drop table SALE_HIT cascade constraints;

drop trigger SALE_LAST_EDITED_TRG;
drop trigger SALE_TRG;
drop sequence SALE_SEQ;
drop index SALE_ISDEL_ACC_IDX;
drop table SALE cascade constraints;

drop table CATEGORY_MAP cascade constraints;

drop trigger CATEGORY_TRG;
drop sequence CATEGORY_SEQ;
drop table CATEGORY cascade constraints;

drop table BID_DEPOSIT_TYPE cascade constraints;

drop trigger MAIN_RECEIPT_TRG;
drop sequence MAIN_RECEIPT_SEQ;
drop table MAIN_RECEIPT;

drop trigger DELIVERY_B_INSRT_TRG;
drop sequence DELIVERY_SEQ;
drop index DELIVERY_BUYER_INDEX;
drop index DELIVERY_SELLER_INDEX;
drop table DELIVERY cascade constraints;

drop table DELIV_RECV_T_WIN_TYPE cascade constraints;

drop table DELIVERY_TIME_WINDOW_TYPE cascade constraints;

drop table DELIVERY_STATE_TYPE cascade constraints;

drop table LIST_RECPT_STATE_TYPE;

drop table MAIN_RECEIPT_STATE_TYPE;

drop table PAYMENT_TYPE cascade constraints;

drop trigger BUSINESS_INFO_TRG;
drop sequence BUSINESS_INFO_SEQ;
drop table BUSINESS_INFO cascade constraints;

drop table BUSINESS_INFO_TYPE cascade constraints;

drop trigger ACCOUNT_TRG;
drop sequence ACCOUNT_SEQ;
drop table ACCOUNT cascade constraints;

drop table ACCOUNT_STATE_TYPE cascade constraints;

drop table ACCOUNT_TYPE cascade constraints;

drop table ISDEL_TYPE cascade constraints;


--purge recyclebin;


---------------------------- 뭔가 에러가 나면 아래 코드 실행해보기. 매번 할 필요는 없음 ------------------------------------
/*
ALTER SESSION SET PLSCOPE_SETTINGS = 'IDENTIFIERS:NONE';
*/

------------------------------- 설명 --------------------------------------------------

/*

비즈니스 코드, 서브타입 분류 코드 등은 테이블 내부에 "속성명_CODE" 속성으로 들어감.
비즈니스 코드, 서브타입 분류 정보 테이블은 '원형타입이름_TYPE' 으로 처리함.
코드 계통은 시퀀스 없음.

"IDX" 속성 -  인조식별자 사용 속성, 기본키 혹은 후보키(not null + unique). - rdbms 의 index가 아님.
인조식별자 : sequence.nextval 을 이용해서 정수로 처리. cash 는 기본값이 15이었던듯. 사이클이나 최대 크기를 따로 고려 안함.

트리거 있음: 주로 새 인스턴스(행) 입력시(insert) 자동으로 특정 속성 기입. 아닐때도 있으니 확인.

식별관계: 외래키가 not null 처리됨 - 참조대상의 존재에 의존적일 때.
외래키 속성 이름은 주로 '대상테이블_속성이름' 으로 하거나, 속성의 역할을 명시적으로 나타내도록 함.

확인용 플래그 이름은 'IS내용'.
확인용 플래그(indicator)는 number(1,0)에 check으로 1,0 만 허용. - 기본값(default) 확인하기!!
예시) ISDEL - 지워졌나? 0:false(안지워짐) 1:true(지워짐)

*/

------------------------------------------------  삭제상태 코드 ----------------------------------------------------
-- 삭제상태 코드 정리용.. 신경 안써도 됨. 뭔가 특별한 상태값을 더 추가하고 싶으면 이용하기
--예를들어 관리자의 블라인드 처리를 2번으로 둔다거나..

create table ISDEL_TYPE (

	CODE			number(1,0)
	,NAME			nvarchar2(15) not null
	,DESCRIPTION	nvarchar2(400)

	,constraint ISDEL_TYPE_PK primary key (CODE)
);

insert all
	into ISDEL_TYPE (CODE, NAME) values (0, '삭제안됨')
	into ISDEL_TYPE (CODE, NAME) values (1, '삭제됨')
select 1 from dual;

commit;


comment on table ISDEL_TYPE is '삭제상태 코드';

comment on column ISDEL_TYPE.CODE is '삭제상태 코드 - 기본키. 시퀀스 없음. 0: 삭제안됨, 1: 삭제됨';

comment on column ISDEL_TYPE.NAME is '상태 이름';

comment on column ISDEL_TYPE.DESCRIPTION is '상태 설명';


--drop table ISDEL_TYPE cascade constraints;


------------------------------------------------  계정 코드 ----------------------------------------------------
-- 이런 종류의 비즈니스 코드에 시퀀스 처리를 하는게 좀 이상해서 여기는 시퀀스를 안 넣어둠 (동적으로 타입을 정의하고 제어하는 구조가 아니니까..)
-- 0:시스템(메세지 처리용) 1:관리자계정 2:사업자계정 3:일반계정
-- 더미데이터에 관리자 계정 하나 이상 무조건 넣기.
-- 쪽지 처리 방식에 따라, 더미 데이터에 시스템계정 최소 1개 넣기.

create table ACCOUNT_TYPE (

	CODE			number(2,0)
	,NAME 			nvarchar2(15) not null
	,DESCRIPTION	nvarchar2(400)
	
	,constraint ACCOUNT_TYPE_PK primary key (CODE)
);

insert all
	into ACCOUNT_TYPE (CODE, NAME) values (0, '시스템')
	into ACCOUNT_TYPE (CODE, NAME) values (1, '관리자 계정')
	into ACCOUNT_TYPE (CODE, NAME) values (2, '사업자 계정')
	into ACCOUNT_TYPE (CODE, NAME) values (3, '일반 계정')
select 1 from dual;

commit;


comment on table ACCOUNT_TYPE is '계정코드 테이블';

comment on column ACCOUNT_TYPE.CODE is '계정코드 번호';

comment on column ACCOUNT_TYPE.NAME is '계정코드 이름';

comment on column ACCOUNT_TYPE.DESCRIPTION is '계정코드 설명';


--drop table ACCOUNT_TYPE cascade constraints;


------------------------------------------------  계정 상태 코드 추가  ----------------------------------------------------

create table ACCOUNT_STATE_TYPE (

	CODE			number(2,0)
	,NAME			nvarchar2(20)	not null
	,DESCRIPTION	nvarchar2(400)

	,constraint ACC_STATE_TYPE_PK primary key (CODE)
);

insert all
	into ACCOUNT_STATE_TYPE (CODE, NAME) values (0,'기본값')
	into ACCOUNT_STATE_TYPE (CODE, NAME) values (1,'삭제됨')
select 1 from DUAL;

commit;


comment on table ACCOUNT_STATE_TYPE is '';

comment on column ACCOUNT_STATE_TYPE.CODE is '';

comment on column ACCOUNT_STATE_TYPE.CODE is '';

comment on column ACCOUNT_STATE_TYPE.CODE is '';


--drop table ACCOUNT_STATE_TYPE cascade constraints;


------------------------------------------------  계정  ----------------------------------------------------
--세션 [ "idx" : IDX (INTEGER - int 아님, 널 확인 코드용), "type": TYPE (String), +옵션사항 "name" : NAME (String) ]

create table ACCOUNT (

	IDX					number(8,0)		unique
	,ID					nchar(15)		not null unique
	,PW					nchar(30)		not null
	,NAME				nvarchar2(20)	not null

	,EMAIL				nvarchar2(30)
	,PHONE				number(14,0)
	,PHONE2				number(14,0)

	,POSTNUM			number(8,0)
	,ADDR				nvarchar2(20)
	,DETAILED_ADDR		nvarchar2(50)

	,TYPE_CODE			number(2,0)		not null
	,ISDEL				number(1,0)

	,THUMB_IMG			varchar2(200 char)
	,REG_DATE			timestamp (0) with local time zone	not null

	,constraint ACCOUNT_PK primary key (ISDEL, IDX)
	,constraint FK_ACC_ISDEL_TYPE foreign key (ISDEL) references ACCOUNT_STATE_TYPE (CODE)
	,constraint FK_ACCOUNT_ACCTYPE foreign key (TYPE_CODE) references ACCOUNT_TYPE (CODE)
);

create sequence ACCOUNT_SEQ start with 1 increment by 1;

create trigger ACCOUNT_TRG
	before insert on ACCOUNT 
	for each row 
begin
	if (:NEW.IDX is null) then
		:NEW.IDX := ACCOUNT_SEQ.nextval;
	end if;
	if (:NEW.REG_DATE is null) then
		:NEW.REG_DATE := SYSTIMESTAMP;
	end if;
	if (:NEW.TYPE_CODE is null) then
		:NEW.TYPE_CODE := 3;
	end if;
	if (:NEW.ISDEL is null) then
		:NEW.ISDEL := 0;
	end if;
end;
/
--트리거 설명: 행 추가시 IDX가 없을 때 sequence.nextval 을 자동으로 넣음, REG_DATE 가 없을 때 시스템 시간을 넣음. 계정타입 없으면 3(일반계정). ISDEL 기본값 0


comment on table ACCOUNT is '계정 테이블';

comment on column ACCOUNT.IDX is '게정번호- 복합기본키. 유일성(unique). 인조식별자 - 트리거 있음';

comment on column ACCOUNT.ID is '계정 아이디 - null 안됨, unique';

comment on column ACCOUNT.PW is '계정 암호 null 안됨';

comment on column ACCOUNT.NAME is '사용자 이름 null 안됨';

comment on column ACCOUNT.EMAIL is '이메일';

comment on column ACCOUNT.PHONE is '전화번호';

comment on column ACCOUNT.PHONE2 is '전화번호2';

comment on column ACCOUNT.POSTNUM is '우편번호';

comment on column ACCOUNT.ADDR is '주소 - 도 시 구 동 까지만, api 따름';

comment on column ACCOUNT.DETAILED_ADDR is '세부주소';

comment on column ACCOUNT.TYPE_CODE is '계정타입 - 외래키, null 안됨(식별관계) 기본값 3(트리거, 일반계정)';

comment on column ACCOUNT.ISDEL is '상태 확인 코드 - 복합기본키+ 외래키 null 안됨 기본값:0(트리거)';

comment on column ACCOUNT.THUMB_IMG is '썸네일 위치 디렉토리+파일 이름';

comment on column ACCOUNT.REG_DATE is '계정 등록일 - null안됨, 트리거 있음';


--drop trigger ACCOUNT_TRG;
--drop sequence ACCOUNT_SEQ;
--drop table ACCOUNT cascade constraints;


------------------------------------------------  사업자 평점  ------------------------------------------------
-- 아래는 판매자 평점 조회를 쉽게 하려고 넣은 일종의 중복값 테이블. 트리거 처리 금지(원본 삭제시 문제가 됨), procedure을 이용해 처리할 것을 추천. (그냥 써도 어차피 아무도 모를거라 상관 없음)
-- 복잡하면 이 테이블을 안쓰고 그냥 매번 전체조회해도 됨 (그럴 경우 조회는 어려워지고 평점 등록/수정/삭제 가 쉬워짐)

-- !! 나중에 materialized view 로 바꿀것 같아서 일단 주석처리함. 쓰기전에 물어보기. !!

/*


create table ENTREPRENEUR_SCORE (

	ACC_IDX						number(8,0)		not null
	,ACC_TYPE					number(2,0)		not null

	,SCORE_TOTAL				number(12,0)	default 0 not null
	,SCORE_COUNT				number(10,0)	default 0 not null

	,constraint ENTREPRENEUR_SCORE_PK primary key (ACC_IDX)
	,constraint FK_ENTREPRE_SCORE_ACC foreign key (ACC_IDX, ACC_TYPE) references ACCOUNT (IDX, TYPE) on delete cascade on update cascade
	,constraint ENTREPRE_VALID_CHECK check (ACC_TYPE <=2)
	,constraint BUSINESS_SCORE_CHECK check (SCORE_TOTAL>=0 and SCORE_COUNT>=0)
);

comment on table ENTREPRENEUR_SCORE is '사업자 평점 테이블';

comment on column ENTREPRENEUR_SCORE.ACC_IDX is '';

comment on column ENTREPRENEUR_SCORE.ACC_TYPE is '';

comment on column ENTREPRENEUR_SCORE.SCORE_TOTAL is '';

comment on column ENTREPRENEUR_SCORE.SCORE_COUNT is '';


--drop table ENTREPRENEUR_SCORE cascade constraints;

*/
------------------------------------------------  사업자 등록증 타입  ----------------------------------------------------
-- 일단 기본값 코드 0: 일반 넣어둠

create table BUSINESS_INFO_TYPE (

	CODE			number(2,0)
	,NAME			nvarchar2(50) not null
	,DESCRIPTION	nvarchar2(400)

	,constraint	BUSINESS_INFO_TYPE_PK primary key (CODE) 
);

insert into BUSINESS_INFO_TYPE (CODE, NAME, DESCRIPTION) values ( 0, '일반', '기본값 설정. 혹시 기능을 안 쓰게 되었을 때 모듈에 이상이 없게 해둠');

commit;


comment on table BUSINESS_INFO_TYPE is '사업자 등록증 타입 코드 테이블';

comment on column BUSINESS_INFO_TYPE.CODE is '사업자 등록증 타입 비즈니스 코드';

comment on column BUSINESS_INFO_TYPE.NAME is '사업자 등록증 타입 이름';

comment on column BUSINESS_INFO_TYPE.DESCRIPTION is '사업자 등록증 타입 설명';


--drop table BUSINESS_INFO_TYPE cascade constraints;



------------------------------------------------  사업자 정보  ----------------------------------------------------
-- 사업자 등록증에 등록일자가 따로 있으면, 우리쪽에 정보를 입력한 시점을 기록하는 등록일자와 구분해서 하나 더 속성을 추가해야함.

create table BUSINESS_INFO (

	IDX								number(8,0)		not null unique
	,ACC_IDX						number(8,0)
	,BUSINESS_LICENSE_CODE			number(10,0)
	,CORPORATION_NAME				nvarchar2(20)	not null
	,REPRESENTATIVE					nvarchar2(20)	not null

	,TYPE_CODE						number(2,0)		not null

	,BUSINESS_ADDR					nvarchar2(20)	not null
	,BUSINESS_DETAILED_ADDR			nvarchar2(50)	not null

	,HEADHQUARTER_ADDR				nvarchar2(20)	not null
	,HEADHQUARTER_DETAILED_ADDR		nvarchar2(50)	not null

	,BUSINESS_CATEGORY				nvarchar2(25)	not null
	,BUSINESS_TYPE					nvarchar2(25)	not null

	,REG_DATE						nvarchar2(20)	not null

	,LICENSE_IMG					nvarchar2(200)	not null

	,INFO_REG_DATE					timestamp (0) with local time zone	not null

	,constraint BUSINESS_INFO_PK primary key (ACC_IDX, BUSINESS_LICENSE_CODE)
	,constraint FK_BUSINESS_INFO_TYPE foreign key (TYPE_CODE) references BUSINESS_INFO_TYPE (CODE)
	,constraint FK_BUSINESS_INFO_ACCOUNT_IDX foreign key (ACC_IDX) references ACCOUNT (IDX) on delete cascade
);

create sequence BUSINESS_INFO_SEQ start with 1 increment by 1;

create trigger BUSINESS_INFO_TRG
	before insert on BUSINESS_INFO 
	for each row
begin
	if(:NEW.IDX is null) then
		:NEW.IDX := BUSINESS_INFO_SEQ.nextval;
	end if;
	if(:NEW.TYPE_CODE is null) then
		:NEW.TYPE_CODE := 0;
	end if;
	if(:NEW.INFO_REG_DATE is null) then
		:NEW.INFO_REG_DATE := SYSTIMESTAMP;
	end if;
end;
/
--트리거 설명: INFO_REG_DATE 가 없을 때 시스템 시간을 넣음, IDX 넣어줌


comment on table BUSINESS_INFO is '사업자 등록 정보 - 전체가 null안됨 (사업자 등록증 등록일 제외)';

comment on column BUSINESS_INFO.IDX is '인덱스 - not null unique : 후보키 - 자동인덱스 생성';

comment on column BUSINESS_INFO.ACC_IDX is '계정번호 참조 외래키 + 복합 기본키 = 계정마다 서로 다른 여러 개의 사업자 정보를 등록 가능.';

comment on column BUSINESS_INFO.BUSINESS_LICENSE_CODE is '사업자 번호 - 복합 기본키';

comment on column BUSINESS_INFO.CORPORATION_NAME is '법인명/단체명';

comment on column BUSINESS_INFO.TYPE_CODE is '사업자 등록증 타입 - 기본값 처리해둠';

comment on column BUSINESS_INFO.REPRESENTATIVE is '대표자';

comment on column BUSINESS_INFO.BUSINESS_ADDR is '사업장 세부주소 앞 까지';

comment on column BUSINESS_INFO.BUSINESS_DETAILED_ADDR is '사업장 소재지 - 세부주소';

comment on column BUSINESS_INFO.HEADHQUARTER_ADDR is '본점주소 - 도 시 동 까지';

comment on column BUSINESS_INFO.HEADHQUARTER_DETAILED_ADDR is '본점주소 - 세부주소';

comment on column BUSINESS_INFO.BUSINESS_CATEGORY is '사업의 업태';

comment on column BUSINESS_INFO.BUSINESS_TYPE is '사업의 종류';

comment on column BUSINESS_INFO.REG_DATE is '사업자 등록증 등록일 - null 허용!';

comment on column BUSINESS_INFO.LICENSE_IMG is '사업자 등록증 이미지. 받은 이미지가 없을 때 기본값 이미지를 넣어두고 null처리를 해서 넣을수도 있음';

comment on column BUSINESS_INFO.INFO_REG_DATE is '등록일 - 트리거있음';


--drop trigger BUSINESS_INFO_TRG;
--drop sequence BUSINESS_INFO_SEQ;
--drop table BUSINESS_INFO cascade constraints;


---------------------------------------------- 결제 타입 -----------------------------------------------------
-- 결제형태가 여러개 나올 수 있다는 가정 하에 만듬. 안쓰일듯?

create table PAYMENT_TYPE (

	CODE			number(2,0)
	,NAME			nvarchar2(20) not null
	,DESCRIPTION	nvarchar2(200)

	,constraint PAYMENT_TYPE_PK primary key (CODE)
);

insert all
	into PAYMENT_TYPE (CODE, NAME, DESCRIPTION) values (0, '기본값 더미', '구현시 쓰지 않더라도 문제가 되지 않도록 넣어두는 기본값')
select 1 from DUAL;

commit;


comment on table PAYMENT_TYPE is '결제타입(코드) 테이블';

comment on column PAYMENT_TYPE.CODE is '결제타입 코드 -트리거나 시퀀스 없음';

comment on column PAYMENT_TYPE.NAME is '결제타입 코드 이름';

comment on column PAYMENT_TYPE.DESCRIPTION is '결제타입 코드 설명';


--drop table PAYMENT_TYPE cascade constraints;


---------------------------------------------- 주 영수증 상태 타입 -----------------------------------------------------
-- 구매취소, 에러 따위를 처리. 별 의미는 없을 듯. 실제 여기까지 구현하리라 생각하지는 않지만 모양상 넣음
-- 각종 비즈니스코드를 섞으면 절대! 안된다고 해서 그냥 이렇게 여러개로 막 뿌려둠.

create table MAIN_RECEIPT_STATE_TYPE (

	CODE				number(2,0)
	,NAME				nvarchar2(15)	not null
	,DESCRIPTION		nvarchar2(400)

	,constraint MAIN_RECEIPT_TYPE_PK primary key (CODE)
);

insert into MAIN_RECEIPT_STATE_TYPE (CODE, NAME, DESCRIPTION) values (0, '기본값', '일단 넣는 기본값');

commit;


comment on table MAIN_RECEIPT_STATE_TYPE is '주 영수증 상태 타입 코드 테이블';

comment on column MAIN_RECEIPT_STATE_TYPE.CODE is '주 영수증 상태 코드';

comment on column MAIN_RECEIPT_STATE_TYPE.NAME is '주 영수증 상태 코드 이름';

comment on column MAIN_RECEIPT_STATE_TYPE.DESCRIPTION is '주 영수증 상태 코드 설명';


--drop table MAIN_RECEIPT_STATE_TYPE;


---------------------------------------------- 주 영수증 -----------------------------------------------------
-- 한번의 결제에 한번 생성. 결제행위 자체를 나타냄. 개별 결제에 여러개의 판매옵션과 입찰, 낙찰 등이 묶일 수 있음
-- + 개별 영수증의 상태 코드??
/*
누가 : 산 계정
언제 : 시간저장
어디서:
무엇음:	입찰 구입(보증금)
		일반 판매 구입
		경매 물품 구입
			죄다 외부 테이블로 빼야할듯..
				일반구입: 일반구매 내역 테이블 만들기
				입찰 구입: 입찰 구입 테이블 따로 만들기.
				경매 물품 대금: 추가 외부 테이블
어떻게: 지불타입
왜:
영수증의 상태값 - 구매전 구매후 환불전 환불후
*/

create table MAIN_RECEIPT (

	IDX					number(13,0)	unique
	,BUYER_IDX			number(8,0)
	,PAYMENT_TYPE_CODE	number(2,0)		not null
	,MONEY_AMOUNT		number(13,0)	not null
	,PAID_NAME			nvarchar2(15)	not null
	,PAID_CODE			nvarchar2(20)

	,CONTRACT_TIME		timestamp(3) with local time zone not null

	,STATE_CODE			number(2,0)		not null

	,REFUND_TO			number(8,0)
	,REFUND_OF			number(13,0)

	,constraint MAIN_RECEIPT_PK primary key (BUYER_IDX, IDX)
	,constraint MAIN_RECEIPT_ACC_FK foreign key (BUYER_IDX) references ACCOUNT (IDX)
	,constraint M_RECEIPT_PAY_TYPE_FK foreign key (PAYMENT_TYPE_CODE) references PAYMENT_TYPE (CODE)
	,constraint M_RECEIPT_STATE_FK foreign key (STATE_CODE) references MAIN_RECEIPT_STATE_TYPE (CODE)
	,constraint M_RECEIPT_REFUND_FK foreign key (REFUND_TO, REFUND_OF) references MAIN_RECEIPT (BUYER_IDX, IDX)
);

create sequence MAIN_RECEIPT_SEQ start with 1 increment by 1;

create trigger MAIN_RECEIPT_TRG
	before insert on MAIN_RECEIPT
	for each row
begin
	if(:NEW.IDX is null) then
		:NEW.IDX := MAIN_RECEIPT_SEQ.nextval;
	end if;
	if(:NEW.PAYMENT_TYPE_CODE is null) then
		:NEW.PAYMENT_TYPE_CODE := 0;
	end if;
	if(:NEW.STATE_CODE is null) then
		:NEW.STATE_CODE := 0;
	end if;
	:NEW.CONTRACT_TIME := SYSTIMESTAMP;
end;
/
--트리거 설명: 인덱스, 결제타입, 상태코드 없으면 삽입. 결제시간 강제입력(덮어쓰기).


comment on table MAIN_RECEIPT is '주 영수증 (한 건의 결제에 해당)';

comment on column MAIN_RECEIPT.IDX is '주 영수증 번호 - 후보키. 복합기본키, 인조식별자, 트리거있음';

comment on column MAIN_RECEIPT.BUYER_IDX is '영수증 결제 계정 번호 - 복합기본키. 외래키. null불가 : 구매 영수증이 있는 계정은 정보 완전 삭제 불가';

comment on column MAIN_RECEIPT.PAYMENT_TYPE_CODE is '결제타입 - 외래키. null불가. 트리거있음 (기본값 : 0) 안 써도 문제없이 작동하게 해둠';

comment on column MAIN_RECEIPT.MONEY_AMOUNT is '돈돈돈 - null불가';

comment on column MAIN_RECEIPT.PAID_NAME is '결제자 이름 - null불가. 결제정보에서 가져올 수 있다면 가져오고 없으면 적당히 넣기';

comment on column MAIN_RECEIPT.PAID_CODE is '결제 코드 번호 - null 가능. 뭔가 결제정보에 추가적인 정보를 저장해야 한다면 여기에 넣기';

comment on column MAIN_RECEIPT.CONTRACT_TIME is '결제시간 - null불가. 트리거있음 (강제로 insert 당시 시스템 시간을 넣음) 입찰과 관련되서 밀리초 까지 넣음';

comment on column MAIN_RECEIPT.STATE_CODE is '주 영수증 상태 코드 - null불가. 트리거있음(기본값 0)';

comment on column MAIN_RECEIPT.REFUND_TO is '환불받을 대상 계정 번호 - 복합 외래키 null가능. 환불 영수증 통합용 속성';

comment on column MAIN_RECEIPT.REFUND_OF is '환불 대상 영수증 번호 - 복합 외래키 null가능. 환불 영수증 통합용 속성';


--drop trigger MAIN_RECEIPT_TRG;
--drop sequence MAIN_RECEIPT_SEQ;
--drop table MAIN_RECEIPT;


---------------------------------------------- 목록 영수증 상태 코드( 목록 영수증: 개별적인 세부 영수증 - 옵션목록, 입찰 보증금, 낙찰금)-----------------------------------------------------
-- 구조상 주 영수증 아래 상세 내역에 해당하는 개별 영수증이 따라붙기 때문에 생기는 코드.

create table LIST_RECPT_STATE_TYPE (

	CODE			number(2,0)
	,NAME			nvarchar2(20)
	,DESCRIPTION	nvarchar2(400)

	,constraint LIST_RECPT_STATE_PK primary key (CODE)
);

insert into LIST_RECPT_STATE_TYPE (CODE, NAME, DESCRIPTION) values (0, '기본값', '구현시 기능을 쓰지 않아도 작동하게 하기 위한 기본값');

commit;


comment on table LIST_RECPT_STATE_TYPE is '목록 영수증 에 대한 상태값';

comment on column LIST_RECPT_STATE_TYPE.CODE is '목록 영수증 상태 코드';

comment on column LIST_RECPT_STATE_TYPE.NAME is '목록 영수증 상태 코드 이름';

comment on column LIST_RECPT_STATE_TYPE.DESCRIPTION is '목록 영수증 상태 코드 설명';


--drop table LIST_RECPT_STATE_TYPE;

---------------------------------------------- 목록 영수증 타입-----------------------------------------------------
---------------------------------------------- 보류: 목록 영수증 -----------------------------------------------------
/*
create table LIST_RECEIPT (

	IDX						number(13,0)

	,MAIN_RECPT_BUYER		number(8,0)		not null
	,MAIN_RECPT_IDX			number(13,0)	not null

--	,LIST_TYPE
--	,SALE_OPTION_IDX		number(11,0)
--	,AUCTION_IDX

	,NAME					nvarchar2(25)	not null
	,PRICE					number(13,0)	not null

	,STATE_CODE				number(2,0)		not null

	,REFUND_TARGET_IDX		number(13,0)

	,constraint LIST_RECEIPTT_PK primary key (IDX)
	,constraint LIST_RECEIPT_M_RECPT_FK foreign key (MAIN_RECPT_BUYER, MAIN_RECPT_IDX) references MAIN_RECEIPT (BUYER_IDX, IDX)
	,constraint LIST_RECPT_STATE_CODE_FK foreign key (STATE_CODE) references LIST_RECPT_STATE_TYPE (CODE)
	,constraint LIST_RECPT_REFUND_FK foreign key (REFUND_TARGET_IDX) references LIST_RECEIPT (IDX)
	,constraint LIST_RECPT_CHECK check (AMOUNT >0 and PRICE >0)
);


*/

-----------------------------------------------  배송 상태 타입  -------------------------------------------------------

create table DELIVERY_STATE_TYPE (

	CODE			number(2,0)
	,NAME			nvarchar2(15)	not null
	,DESCRIPTION	nvarchar2(400)

	,constraint DELIVERY_STATE_PK primary key (CODE)
);

insert into DELIVERY_STATE_TYPE(CODE, NAME, DESCRIPTION) values (0, '기본값', '구현 방식 여부와 상관 없이 배송 테이블을 이용하기 위해 넣은 기본값');

commit;


comment on table DELIVERY_STATE_TYPE is '배송상태 타입 비즈니스 코드 테이블';

comment on column DELIVERY_STATE_TYPE.CODE is '배송상태 타입 코드';

comment on column DELIVERY_STATE_TYPE.NAME is '배송상태 이름';

comment on column DELIVERY_STATE_TYPE.DESCRIPTION is '배송상태 설명';


--drop table DELIVERY_STATE_TYPE cascade constraints;


-----------------------------------------------  배송 시작 만료기한  -------------------------------------------------------

create table DELIVERY_TIME_WINDOW_TYPE (

	CODE				number(2,0)
	,TIME_WINDOW		interval day (3) to second (3)	not null

	,NAME				nvarchar2(15)	not null
	,DESCRIPTION		nvarchar2(400)

	,constraint DELIVERY_T_W_TYPE_PK primary key (CODE)
);

insert all
	into DELIVERY_TIME_WINDOW_TYPE (CODE, TIME_WINDOW, NAME, DESCRIPTION) values (1, numtodsinterval( 05, 'DAY') ,'5일 내 배송 시작', '배송시작 요구를 한 뒤 5일 안에 배송이 시작되어야 함')
	into DELIVERY_TIME_WINDOW_TYPE (CODE, TIME_WINDOW, NAME, DESCRIPTION) values (2, numtodsinterval( 07, 'DAY') ,'7일 내 배송 시작', '배송시작 요구를 한 뒤 7일 안에 배송이 시작되어야 함')
select 1 from DUAL;

commit;


comment on table DELIVERY_TIME_WINDOW_TYPE is '배송 시작 만료시간 제어용 테이블(일종의 서브타입 묶음)';

comment on column DELIVERY_TIME_WINDOW_TYPE.CODE is '배송 시작 만료시간 비즈니스 코드 - 기본키';

comment on column DELIVERY_TIME_WINDOW_TYPE.TIME_WINDOW is '시간(길이) - null 안됨';

comment on column DELIVERY_TIME_WINDOW_TYPE.NAME is '코드 이름 - null 안됨';

comment on column DELIVERY_TIME_WINDOW_TYPE.DESCRIPTION is '코드 설명';


--drop table DELIVERY_TIME_WINDOW_TYPE cascade constraints;


-----------------------------------------------  수령 확인 만료기한  -------------------------------------------------------

create table DELIV_RECV_T_WIN_TYPE (

	CODE				number(2,0)
	,TIME_WINDOW		interval day (3) to second (3)	not null

	,NAME				nvarchar2(15)	not null
	,DESCRIPTION		nvarchar2(400)

	,constraint DELIV_R_T_W_TYPE_PK primary key (CODE)
);

insert all
	into DELIV_RECV_T_WIN_TYPE (CODE, TIME_WINDOW, NAME, DESCRIPTION) values (1, numtodsinterval( 07, 'DAY') ,'7일 내 수령 확인', '배송시작 확인 후 7일 안에 수령을 확인해야 함')
	into DELIV_RECV_T_WIN_TYPE (CODE, TIME_WINDOW, NAME, DESCRIPTION) values (2, numtodsinterval( 10, 'DAY') ,'10일 내 수령 확인', '배송시작 확인 후 10일 안에 수령을 확인해야 함')
select 1 from DUAL;

commit;


comment on table DELIVERY_TIME_WINDOW_TYPE is '수령 확인 만료시간 제어용 테이블(일종의 서브타입 묶음)';

comment on column DELIVERY_TIME_WINDOW_TYPE.CODE is '수령 확인 만료시간 비즈니스 코드 - 기본키';

comment on column DELIVERY_TIME_WINDOW_TYPE.TIME_WINDOW is '시간(길이) - null 안됨';

comment on column DELIVERY_TIME_WINDOW_TYPE.NAME is '코드 이름 - null 안됨';

comment on column DELIVERY_TIME_WINDOW_TYPE.DESCRIPTION is '코드 설명';


--drop table DELIV_RECV_T_WIN_TYPE cascade constraints;


-----------------------------------------------  배송  -------------------------------------------------------

/*
누가: 배송을 보낼 계정 + 받을계정
언제: 배송시작시간 + 만료시간(만료시간도 테이블)
어디서:
무엇을:	입반구입
		경매 물품 구입
어떻게: 배송타입 추가???
		배송지
왜:
*/

create table DELIVERY (

	IDX							number(13,0)
	,SELLER_IDX					number(8,0)		not null
	,BUYER_IDX					number(8,0)		not null
	,REG_TIME					timestamp(3) with local time zone	not null

	,RECEIVER_NAME				nvarchar2(20)	not null
	,RECEIVER_ADDR				nvarchar2(20)	not null
	,RECEIVER_DETAILED_ADDR		nvarchar2(50)	not null
	,RECEIVER_PHONE				number(14,0)	not null

	,STATE_CODE					number(2,0)		not null

	,START_TIME_WIN_CODE		number(2,0)		not null
	,RECEIVE_TIME_WIN_CODE		number(2,0)		not null

	,START_TIME					timestamp(3) with local time zone
	,RECEIVE_TIME				timestamp(3) with local time zone

	,constraint DELIVERY_PK primary key (IDX)
	,constraint DELIVERY_SELLER_IDX_FK foreign key (SELLER_IDX) references ACCOUNT (IDX)
	,constraint DELIVERY_BUYER_IDX_FK foreign key (BUYER_IDX) references ACCOUNT (IDX)
	,constraint DELIVERY_STATE_FK foreign key (STATE_CODE) references DELIVERY_STATE_TYPE (CODE)
	,constraint DELIVERY_START_T_W_FK foreign key (START_TIME_WIN_CODE) references DELIVERY_TIME_WINDOW_TYPE (CODE)
	,constraint DELIVERY_RECV_T_W_FK foreign key (RECEIVE_TIME_WIN_CODE) references DELIV_RECV_T_WIN_TYPE (CODE)
);

create index DELIVERY_SELLER_INDEX on DELIVERY (STATE_CODE, SELLER_IDX);

create index DELIVERY_BUYER_INDEX on DELIVERY (STATE_CODE, BUYER_IDX); 

create sequence DELIVERY_SEQ start with 1 increment by 1;

create trigger DELIVERY_B_INSRT_TRG
	before insert on DELIVERY
	for each row
begin
	if (:NEW.IDX is null) then
		:NEW.IDX := DELIVERY_SEQ.nextval;
	end if;
	if (:NEW.REG_TIME is null) then
		:NEW.REG_TIME := SYSTIMESTAMP;
	end if;
	if (:NEW.STATE_CODE is null) then
		:NEW.STATE_CODE := 0;
	end if;
	if (:NEW.START_TIME_WIN_CODE is null) then
		:NEW.START_TIME_WIN_CODE := 1;
	end if;
	if (:NEW.RECEIVE_TIME_WIN_CODE is null) then
		:NEW.RECEIVE_TIME_WIN_CODE := 1;
	end if;
end;
/


comment on table DELIVERY is '배송 테이블';

comment on column DELIVERY.IDX is '배송 번호 - 기본키, 인조식별자. 트리거 있음';

comment on column DELIVERY.SELLER_IDX is '판 계정 (물건을 보낼 계정) - 외래키 (계정번호) null불가';

comment on column DELIVERY.BUYER_IDX is '산사람 (물건을 받을 계정) - 외래키 (계정번호) null불가';

comment on column DELIVERY.REG_TIME is '등록시간 - null불가. 트리거 있음';

comment on column DELIVERY.RECEIVER_NAME is '받는사람 이름 - null불가';

comment on column DELIVERY.RECEIVER_ADDR is '받을 주소 - null불가';

comment on column DELIVERY.RECEIVER_DETAILED_ADDR is '받을 상세 주소 - null불가';

comment on column DELIVERY.RECEIVER_PHONE is '받을사람 연락처 - null불가';

comment on column DELIVERY.STATE_CODE is '배송 상태 코드 - null불가. 외래키, 트리거있음(기본값 0)';

comment on column DELIVERY.START_TIME_WIN_CODE is '배송 시작 제한 시간 타입 코드 - null불가. 외래키, 트리거있음(기본값 1)';

comment on column DELIVERY.RECEIVE_TIME_WIN_CODE is '수령 확인 제한 시각 타입 코드 - null불가. 외래키, 트리거있음(기본값 1)';

comment on column DELIVERY.START_TIME is '배송 시작 시간';

comment on column DELIVERY.RECEIVE_TIME is '수령 확인 시간';


--drop trigger DELIVERY_B_INSRT_TRG;
--drop sequence DELIVERY_SEQ;
--drop index DELIVERY_BUYER_INDEX;
--drop index DELIVERY_SELLER_INDEX;
--drop table DELIVERY cascade constraints;


-----------------------------------------------  (보류)배송 - 실제 배송 시작 대기열  -------------------------------------------------------
-----------------------------------------------  (보류)배송 - 수령 확인 대기열  -------------------------------------------------------

---------------------------------------------- 거래 중개 수수료 타입 ----------------------------------------------------
-----------------------------------------------  경매 수수료 타입  ------------------------------------------------------
--그냥 넣을까 말까.. 모든 업무 데이터를 표현한다는 관점에서는 넣는게 맞고, 구현할 때 이걸 신경 안써도 되긴 한데 일단 보류. 필요하면 말해주세요.-

-----------------------------------------------  입찰 보증금 타입 -------------------------------------------------------
-- 안쓰고 그냥 웹어플리케이션에서 정해진 상수값을 이용해도 됨.

create table BID_DEPOSIT_TYPE (

	CODE					number(2,0)
	,DEPOSIT_RATIO			number(4,4)		not null
	,STATIC_DEPOSIT_ADJ		number(11,0)	default 0 not null
	,NAME					nvarchar2(15)	not null
	,DESCRIPTION			nvarchar2(400)

	,constraint BID_DEPOSIT_TYPE_pk primary key (CODE)
);

insert all
	into BID_DEPOSIT_TYPE (CODE, DEPOSIT_RATIO, STATIC_DEPOSIT_ADJ, NAME, DESCRIPTION) values (0, 0, 1000, '보증금 1000원', '입찰시 보증금 최소값 처리용')
	into BID_DEPOSIT_TYPE (CODE, DEPOSIT_RATIO, STATIC_DEPOSIT_ADJ, NAME, DESCRIPTION) values (1, 0.1, 0, '10\% 보증금', '입찰시 제시해야 할 보증금 타입 1: 10%.')
select 1 from DUAL;

commit;


comment on table BID_DEPOSIT_TYPE is '입찰 보증금 타입 정보';

comment on column BID_DEPOSIT_TYPE.CODE is '입찰 보증금 타입 코드';

comment on column BID_DEPOSIT_TYPE.DEPOSIT_RATIO is '입찰 보증금 비율';

comment on column BID_DEPOSIT_TYPE.STATIC_DEPOSIT_ADJ is '보증금 계산시 상수값 속성 (최대 / 최소/ 일정비율 더하기 얼마 등..';

comment on column BID_DEPOSIT_TYPE.NAME is '보증금 타입 이름';

comment on column BID_DEPOSIT_TYPE.DESCRIPTION is '보증금 타입 설명';


--drop table BID_DEPOSIT_TYPE cascade constraints;


---------------------------------------------- 카테고리 노드 ----------------------------------------------------
-- 개별 카테고리 타입 개체. 예시: '사람' '당근' '채소' '과일'..
-- 1,2,3 번 카테고리 번호 기본값으로 넣어둠.

create table CATEGORY (

	IDX					number(3,0)
	,NAME				nvarchar2(15)		not null
	,DESCRIPTION		nvarchar2(1000)

	,constraint CATEGORY_PK primary key (IDX)
);

create sequence CATEGORY_SEQ start with 1 increment by 1;

create trigger CATEGORY_TRG
	before insert on CATEGORY 
	for each row
	when (NEW.IDX is null)
begin
	:NEW.IDX := CATEGORY_SEQ.nextval;
end;
/
--트리거 설명: 행 추가시 IDX가 없을 때 sequence.nextval 을 자동으로 넣음

insert all
	into CATEGORY (IDX, NAME, DESCRIPTION) values (-1, '기본값', '구현시 사용하지 않더라도 문제가 없도록 넣어두는 기본값.')
	into CATEGORY (IDX, NAME, DESCRIPTION) values (0, '기타/일반', '구현시 사용하지 않더라도 문제가 없도록 넣어두는 기본값.')
select 1 from DUAL;

insert all
	into CATEGORY (NAME) values ('과일/채소')
	into CATEGORY (NAME) values ('축산/수산')
	into CATEGORY (NAME) values ('가공식품')
select 1 from DUAL;

commit;


comment on table CATEGORY is '카테고리 노드';

comment on column CATEGORY.IDX is '카테고리 식별 번호 - 인조식별자 기본키. 트리거있음';

comment on column CATEGORY.NAME is '카테고리 노드 이름 - null 안됨';

comment on column CATEGORY.DESCRIPTION is '카테고리 노드 설명';


--drop trigger CATEGORY_TRG;
--drop sequence CATEGORY_SEQ;
--drop table CATEGORY cascade constraints;


---------------------------------------------- 카테고리 맵 ----------------------------------------------
-- 카테고리 타입 관 관계의 표현. 트리가 아니라 그래프 구조로 바꿈. 순환구조 허용됨.

create table CATEGORY_MAP (

	SUPER_CATEGORY		number(3,0)
	,SUB_CATEGORY		number(3,0)

	,DESCRIPTION		nvarchar2(300)

	,constraint CAT_MAP_PK primary key (SUPER_CATEGORY, SUB_CATEGORY)
	,constraint SUPERCAT_MAP_FK foreign key (SUPER_CATEGORY) references CATEGORY (IDX) on delete cascade
	,constraint SUBCAT_MAP_FK foreign key (SUB_CATEGORY) references CATEGORY (IDX) on delete cascade
	,constraint CAT_MAP_CHECKER check (SUPER_CATEGORY <> SUB_CATEGORY)
);

insert into CATEGORY_MAP (SUPER_CATEGORY, SUB_CATEGORY, DESCRIPTION) values (-1, 0, '혹시 카테고리 계층 구현중 문제가 없도록 넣어두는 기본값');

comment on table CATEGORY_MAP is '카테고리 맵 (카테고리간 관계 설정)';

comment on column CATEGORY_MAP.SUPER_CATEGORY is '상위 분류 - 기본키 + 외래키 (카테고리 IDX) 식별관계';

comment on column CATEGORY_MAP.SUB_CATEGORY is '하위 분류 - 기본키 + 외래키 (카테고리 IDX) 식별관계';

comment on column CATEGORY_MAP.DESCRIPTION is '관계 설명';


--drop table CATEGORY_MAP cascade constraints;


---------------------------------------------- 판매글 (거래 중개) ----------------------------------------------------

create table SALE(

	IDX				number(10,0)	unique
	,ACC_IDX		number(8,0)		not null
	,TITLE			nvarchar2(40)	not null
	,ORIGIN			nvarchar2(60)	not null

	,HIT			number(8,0)		not null
	,WRITTEN_TIME	date			not null
	,LAST_EDITED	date

	,CONTENT		nvarchar2(2000)

	,FACE_IMG		varchar2(200 char)
	,MAIN_IMG		varchar2(200 char)

-- 아래는 평균점수, 쿼리를 편하게 처리하기 위해 추가할 만한 중복 데이터. 쓰려면 주석해제하고 쓰기. 트리거 이용 금지(삭제시 문제유발). procedure을 이용하거나 application에서 무결성을 지키기 위한 로직 만들기.
--	,AVG_SCORE		number(3,2)

	,ISDEL			number(1,0)
--	,DEL_TIME		timestamp (0) with local time zone
-- 이렇게 삭제 처리시 옵션도 같이 삭제처리를 이렇게 하고 조회를 막아야함. (필요하면 VIEW를 만들어 사용)

	,constraint SALE_PK primary key (IDX, ISDEL)
	,constraint FK_SALE_ACC_IDX foreign key (ACC_IDX) references ACCOUNT (IDX) on delete cascade
	,constraint FK_SALE_ISDEL_TYPE foreign key (ISDEL) references ISDEL_TYPE (CODE)
	,constraint SALE_HIT_CHECKER check (HIT>=0)
);

create index SALE_ISDEL_ACC_IDX on SALE (ISDEL, ACC_IDX);

create sequence SALE_SEQ start with 1 increment by 1;

create trigger SALE_TRG
	before insert on SALE
	for each row
begin
	if (:NEW.IDX is null) then
		:NEW.IDX := SALE_SEQ.nextval;
	end if;
	if (:NEW.WRITTEN_TIME is null) then
		:NEW.WRITTEN_TIME := SYSDATE;
	end if;
	if (:NEW.LAST_EDITED is null) then
		:NEW.LAST_EDITED := SYSDATE;
	end if;
	if (:NEW.ISDEL is null) then
		:NEW.ISDEL := 0;
	end if;
	if (:NEW.HIT is null) then
		:NEW.HIT := 0;
	end if;
end;
/
--트리거 설명: 행 추가시 IDX가 없을 때 sequence.nextval 을 자동으로 넣음, WRITTEN_TIME 가 없을 때 시스템 시간을 넣음, HIT 0 기본값

create trigger SALE_LAST_EDITED_TRG
	before update of TITLE, ORIGIN, CONTENT, FACE_IMG, MAIN_IMG on SALE
	for each row
begin
	:NEW.LAST_EDITED := SYSTIMESTAMP;
end;
/
--트리거 설명: update 시 해당 행에 LAST_EDITED 값을 시스템 시간으로 처리.


comment on table SALE is '판매 목록';

comment on column SALE.IDX is '판매글 번호 - 복합기본키. 유일성. 인조식별자. 트리거 있음';

comment on column SALE.ACC_IDX is '판매글 올린이 idx - 외래키 null안됨 : 식별관계';

comment on column SALE.TITLE is '판매글제목 - null 안됨';

comment on column SALE.ORIGIN is '원산지. - null안됨';

comment on column SALE.HIT is '조회수 처리용, 기본값 0(트리거)';

comment on column SALE.WRITTEN_TIME is '글 쓴 시간 - 트리거 있음';

comment on column SALE.LAST_EDITED is '마지막 수정 시간 - 트리거 있음 (옵션의 변경에 대해서는 트리거가 안되어있음. 필요하면 만들 수 있을듯)';

comment on column SALE.CONTENT is '부가설명(글내용)';

comment on column SALE.FACE_IMG is '대표이지미 파일 위치 (디렉토리와 이름을 모두 포함해서 저장하기, 원래이름은 필요없음)';

comment on column SALE.MAIN_IMG is '본문이미지 파일 위치 (디렉토리와 이름을 모두 포함해서 저장하기, 원래이름은 필요없음)';

--comment on column SALE.AVG_SCORE is '평균점수 - 중복데이터, 무결성 주의';

comment on column SALE.ISDEL is '삭제 확인 코드 - 복합기본키. 외래키, 기본값:0, null안됨';

--comment on column SALE.DEL_TIME is '삭제시간 처리용 속성';


--drop trigger SALE_LAST_EDITED_TRG;
--drop trigger SALE_TRG;
--drop sequence SALE_SEQ;
--drop index SALE_ISDEL_ACC_IDX;
--drop table SALE cascade constraints;


---------------------------------------------- 판매글  조회수 중복 제거 처리용 테이블 ----------------------------------------------------
--안써도 전혀 문제 없음

create table SALE_HIT (

	SALE_IDX			number(10,0)
	,ACCOUNT_IDX		number(8,0)

	,constraint SALE_HIT_PK primary key (SALE_IDX, ACCOUNT_IDX)
	,constraint SALE_HIT_SALE_FK foreign key (SALE_IDX) references SALE (IDX) on delete cascade
	,constraint SALE_HIT_ACC_FK foreign key (ACCOUNT_IDX) references ACCOUNT (IDX) on delete cascade
);


comment on table SALE_HIT is '판매글 조회수 중복처리 테이블';

comment on column SALE_HIT.SALE_IDX is '판매글번호 - 복합기본키 + 외래키';

comment on column SALE_HIT.ACCOUNT_IDX is '계정번호 - 복합기본키 + 외래키';


--drop table SALE_HIT cascade constraints;


---------------------------------------------- 판매 옵션 ----------------------------------------------------
-- 구매 관련해서 나중에 조회를 편하게 하기 위해 기본키를 바꿈, 그리고 옵션 이름에 대한 unique 설정 해제. (이름 중복 가능)

create table SALE_OPTION (

	IDX				number(11,0)	unique
	,SALE_IDX		number(10,0)	not null
	,NAME			nvarchar2(25)	not null
	,DESCRIPTION	nvarchar2(200)

	,PRICE			number(7,0)		not null

	,UNIT			nvarchar2(20)	not null
	,START_AMOUNT	number(7,0)		not null
	,LEFT_AMOUNT	number(7,0)		not null
	
	,LASTSOLD_TIME	date

	,WRITTEN_TIME	date			not null
	,LAST_EDITED	date

	,ISDEL			number(1,0)		not null

	,constraint SALE_OPTION_PK primary key (SALE_IDX, IDX)
	,constraint FK_SALE_OPT_SALE foreign key (SALE_IDX) references SALE (IDX) on delete cascade
	,constraint FK_SALE_OPT_ISDEL foreign key (ISDEL) references ISDEL_TYPE (CODE)
	,constraint SALE_OPT_PRICE_CHECK check ( PRICE > 0 )
	,constraint SALE_OPT_AMOUNT_CHECK check ( START_AMOUNT > 0 and LEFT_AMOUNT >= 0 )
);

create index SALE_OPTION_INDEX on SALE_OPTION (ISDEL, SALE_IDX);

create sequence SALE_OPTION_SEQ start with 1 increment by 1;

create trigger SALE_OPTION_WRITTENTIME_TRG
	before insert on SALE_OPTION
	for each row
begin
	if (:NEW.IDX is null) then
		:NEW.IDX := SALE_OPTION_SEQ.nextval;
	end if;
	if (:NEW.WRITTEN_TIME is null) then
		:NEW.WRITTEN_TIME := SYSDATE;
	end if;
		if (:NEW.LAST_EDITED is null) then
		:NEW.LAST_EDITED := SYSDATE;
	end if;
	if (:NEW.UNIT is null) then
		:NEW.UNIT := '개';
	end if;
	if (:NEW.ISDEL is null) then
		:NEW.ISDEL := 0;
	end if;
end;
/
--트리거 설명: 판매옵션 번호 자동추가, 판매옵션 들어간 시간 저장. (혹시 나중에 판매글마다 별개로 추가 할 수 있으므로..) 판매단위 기본값 '개'. ISDEL 기본값 0

create trigger SALE_OPT_UPDATE_TRG
	before update of NAME, DESCRIPTION, PRICE, UNIT, ISDEL on SALE_OPTION
	for each row
	when (NEW.LAST_EDITED is null)
begin
	:NEW.LAST_EDITED := SYSDATE;
end;
/
--트리거 설명: 판매옵션 내용이 마지막으로 수정된 시각 저장.

create trigger SALE_OPT_SALE_EDIT_TRG
	after update of LAST_EDITED on SALE_OPTION
	for each row
begin
	update SALE set LAST_EDITED = SYSDATE where IDX = :NEW.SALE_IDX;
end;
/
--트리거 설명: 판매옵션 마지막 수정시각을 변경하거나 추가하면, 판매글의 마지막 수정시각도 변경.

create trigger SALE_OPT_INSERT_TRG
	before insert on SALE_OPTION
	for each row
declare
    COUNTER number;
begin
    select count(1) into COUNTER from SALE_OPTION where SALE_IDX = :NEW.SALE_IDX ;
	if (COUNTER > 0) then
		update SALE set LAST_EDITED = SYSDATE where IDX = :NEW.SALE_IDX;
	end if;
end;
/
--트리거 설명: 판매옵션 추가시 대상 판매글이 이미 존재했다면(원래 글이 있고 추가적인 옵션을 나중에 더하는 상황이라면), 대상 판매글의 마지막 수정시간 수정.


comment on table SALE_OPTION is '판매 옵션 목록 테이블';

comment on column SALE_OPTION.IDX is '옵션번호 - 후보키. 복합기본키, 인조식별자.';

comment on column SALE_OPTION.SALE_IDX is '판매글 번호 - 복합기본키, 외래키(판매글.글번호))';

comment on column SALE_OPTION.NAME is '판매 옵션 이름 - null불가';

comment on column SALE_OPTION.DESCRIPTION is '판매 옵션 설명';

comment on column SALE_OPTION.PRICE is '판매 옵션 가격 - null안됨 0초과.';

comment on column SALE_OPTION.UNIT is '판매 옵션 (개수당)단위 - null안됨. 트리거,기본값 :개 ';

comment on column SALE_OPTION.START_AMOUNT is '판매 옵션 시작 개수 - null안됨 0초과';

comment on column SALE_OPTION.LEFT_AMOUNT is '판매 옵션 남은 개수 - null안됨 0이상';

comment on column SALE_OPTION.LASTSOLD_TIME is '마지막으로 해당 옵션이 팔린 시각';

comment on column SALE_OPTION.WRITTEN_TIME is '해당 옵션을 등록한 시각 - 트리거 있음';

comment on column SALE_OPTION.LAST_EDITED is '해당 옵션 내용이 마지막으로 수정된 시각 - 트리거 있음';

comment on column SALE_OPTION.ISDEL is '삭제 확인 코드 - 외래키, 기본값:0(트리거), null안됨';


--drop trigger SALE_OPT_INSERT_TRG;
--drop trigger SALE_OPT_SALE_EDIT_TRG;
--drop trigger SALE_OPTION_WRITTENTIME_TRG;
--drop trigger SALE_OPT_UPDATE_TRG;
--drop sequence SALE_OPTION_SEQ;
--drop index SALE_OPTION_INDEX;
--drop table SALE_OPTION cascade constraints;


----------------------------------------------  옵션-카테고리 매핑  ----------------------------------------------
-- 개별 옵션이 속한 카테고리의 정보. 옵션에 복수 카테고리 허용(안써도 작동에 전혀 문제 없음)

create table SALE_OPT_CATEGORY (

	SALE_OPT_IDX		number(11,0)
	,CATEGORY_IDX		number(3,0) default 0

	,constraint SALE_OPT_CAT_PK primary key (SALE_OPT_IDX, CATEGORY_IDX)
	,constraint FK_OPT_CATMAP_SALEOPT foreign key (SALE_OPT_IDX) references SALE_OPTION (IDX) on delete cascade
	,constraint FK_OPT_CATMAP_CATNODE foreign key (CATEGORY_IDX) references CATEGORY (IDX)
);

create trigger SALE_OPT_CAT_UPDATE_TRG
	after update of CATEGORY_IDX on SALE_OPT_CATEGORY
	for each row
begin
	update SALE_OPTION set LAST_EDITED = SYSTIMESTAMP where IDX = :NEW.SALE_OPT_IDX;
end;
/
--트리거 설명: 카테고리 수정시 해당 옵션의 마지막 수정시각 수정.

create trigger SALE_OPT_CAT_INSERT_TRG
	before insert on SALE_OPT_CATEGORY
	for each row
begin
	merge into SALE_OPTION SO
	using (select SALE_OPT_IDX from SALE_OPT_CATEGORY where SALE_OPT_IDX= :NEW.SALE_OPT_IDX) C
	on (C.SALE_OPT_IDX = SO.IDX)
	when matched then update set SO.LAST_EDITED = SYSTIMESTAMP where SO.IDX = :NEW.SALE_OPT_IDX;
end;
/
--트리거 설명: 카테고리 추가시, 이전에 해당 옵션의 다른 카테고리가 등록되어 있었다면 해당 옵션의 마지막 수정시각 수정.


comment on table SALE_OPT_CATEGORY is '판매옵션 카테고리 매핑 - 복수 카테고리 허용';

comment on column SALE_OPT_CATEGORY.SALE_OPT_IDX is '대상 옵션 번호 - 복합 기본키 + 외래키';

comment on column SALE_OPT_CATEGORY.CATEGORY_IDX is '카테고리 노드 번호 - 복합 기본키 + 외래키. 기본값:0';


--drop trigger SALE_OPT_CAT_UPDATE_TRG;
--drop trigger SALE_OPT_CAT_INSERT_TRG;
--drop table SALE_OPT_CATEGORY cascade constraints;


---------------------------------------------- (판매 옵션)구매 목록(삭제중 - 배송처리를 분리하면서 바뀜) ----------------------------------------------------

/*
create table PURCHASE(

	IDX						number(12,0)
	,PURCHASED_ACC			number(8,0)		not null
	,SALE_IDX				number(9,0)

	,SOLD_ACC				number(8,0)
	,TITLE					nvarchar2(40)	not null
	,PRICE					number(7,0)		not null
	,AMOUNT					number(7,0)		not null
	,UNIT					nvarchar2(10)	not null


-- 구매한 이미지 처리용 예시 속성(거래 기록으로 남겨둘 부분). 일단 넣어두긴 하는데 이쪽 설계의 세부 사안을 만들어야 제대로 결정할 수 있는 부분 - 예를들어 판매글이 지워지고 이미지는 남는가, 변경되면? 이런거.
	,IMG					varchar2(100 char)

	,STATE					number(2,0)		not null

------------------------------------------------------------------
	,PAYMENT_TIME			timestamp (3) with local time zone	not null
	,PAYMENT_TYPE			number(2,0)		not null
	,PAYMENT_NAME			nvarchar2(20)	not null
	,PAYMENT_PHONE			number(14,0)

	,IS_Refunded			number(1,0)		default 0 not null
	,REFUNDED_TIME			timestamp (3) with local time zone
--------------------------------------------------------------------

	,DELIVERY_LOC			nvarchar2(50)	not null
	,RECEIVER_NAME			nvarchar2(20)	not null
	,RECEIVER_PHONE			number(14,0)



	,constraint PURCHASE_UNIQUE unique (IDX, PURCHASED_ACC, SALE_IDX)
-- 아래 평가 댓글 역정규화 외래키 용 unique.
);


*/

---------------------------------------------- 판매글에 대한 문의글 ----------------------------------------------------

create table SALE_INQUIRE(

	IDX				number(11,0)
	,SALE_IDX		number(10,0)	not null
	,WRITER_IDX		number(8,0)		not null

	,TITLE			nvarchar2(40)	not null
	,CONTENT		nvarchar2(2000)
	,WRITTEN_TIME	timestamp (0) with local time zone not null

	,ANSWER			nvarchar2(2000)
	,ANSWER_TIME	timestamp (0) with local time zone

	,ISDEL			number(1,0)		not null

	,constraint SALE_INQUIRE_PK primary key (IDX)
--	,constraint SALE_INQ_UNIQUE unique (IDX, SALE_IDX)
	,constraint FK_SALE_INQUIRE_SALE_IDX foreign key (SALE_IDX) references SALE (IDX) on delete cascade
	,constraint FK_SALE_INQUIRE_ACC_IDX foreign key (WRITER_IDX) references ACCOUNT (IDX) on delete cascade
	,constraint FK_SALE_INQUIRE_ISDEL foreign key (ISDEL) references ISDEL_TYPE (CODE)
);

create index SALE_INQUIRE_INDEX on SALE_INQUIRE (ISDEL, SALE_IDX);

create sequence SALE_INQUIRE_SEQ start with 1 increment by 1;

create trigger SALE_INQUIRE_INSERT_TRG
	before insert on SALE_INQUIRE
	for each row
begin
	if (:NEW.IDX is null) then
		:NEW.IDX := SALE_INQUIRE_SEQ.nextval;
	end if;
	if (:NEW.WRITTEN_TIME is null) then
		:NEW.WRITTEN_TIME := SYSTIMESTAMP;
	end if;
	if (:NEW.ISDEL is null) then
		:NEW.ISDEL := 0;
	end if;
end;
/
--트리거 설명: 판매 문의글 추가시 인덱스/작성시각 처리 트리거

create trigger SALE_INQUIRE_ANSWER_TRG
	before update of ANSWER on SALE_INQUIRE
	for each row
	when (NEW.ANSWER_TIME is null)
begin
	:NEW.ANSWER_TIME := SYSTIMESTAMP;
end;
/
--트리거 설명: 판매 문의글에 대해 응답이 있으면 자동으로 응답시각 처리.


comment on table SALE_INQUIRE is '판매글에 대한 문의글';

comment on column SALE_INQUIRE.IDX is '판매 문의 번호 - 기본키, 인조식별자';

comment on column SALE_INQUIRE.SALE_IDX is '대상 판매글 - 외래키 (판매글.IDX)';

comment on column SALE_INQUIRE.WRITER_IDX is '글쓴이 - 외래키 (계정.IDX). null 안됨';

comment on column SALE_INQUIRE.TITLE is '제목 - null 안됨';

comment on column SALE_INQUIRE.CONTENT is '내용';

comment on column SALE_INQUIRE.WRITTEN_TIME is '글 쓴 시각 - null 안됨. 트리거 있음';

comment on column SALE_INQUIRE.ANSWER is '응답 - 당연히 해당 글이 속한 판매글의 판매자 만이 응답 가능하게 해야 함.';

comment on column SALE_INQUIRE.ANSWER_TIME is '응답 시각 - 트리거 있음 null불가';

comment on column SALE_INQUIRE.ISDEL is '삭제 확인 코드 - 외래키, 기본값:0. null불가';


--drop trigger SALE_INQUIRE_ANSWER_TRG;
--drop trigger SALE_INQUIRE_INSERT_TRG;
--drop sequence SALE_INQUIRE_SEQ;
--drop index SALE_INQUIRE_INDEX;
--drop table SALE_INQUIRE cascade constraints;


------------------------------------------------  장바구니  ----------------------------------------------------
--ACC_IDX 와 SALE_IDX, SALE_OPT_NAME 을 묶어서 유일성 부여: 같은 장바구니에 같은 옵션이 중복해서 못들어감.
-- -> 장바구니에 이미 있는 목록에 또 추가버튼을 누르거나 하는 식의 작동방식은 일단 어플리케이션에서 잘 처리해야 함. (아니면 plsql을 활용할 수도 있고..)

create table CART (

	IDX				number(9,0) not null unique

	,ACC_IDX		number(8,0)
	,SALE_OPT_IDX	number(11,0)

	,COUNT			number(7,0)		not null

	,ADDED_TIME		timestamp(0) with local time zone

	,constraint CART_PK primary key (ACC_IDX, SALE_OPT_IDX)
	,constraint FK_CART_ACCOUNT foreign key (ACC_IDX) references ACCOUNT (IDX) on delete cascade
	,constraint FK_CART_SALE_OPT foreign key (SALE_OPT_IDX) references SALE_OPTION (IDX) on delete cascade
	,constraint CART_COUNT_CHECK check (COUNT >=0)
);

create sequence CART_SEQ start with 1 increment by 1;

create trigger CART_TRG
	before insert on CART
	for each row
begin
	if (:NEW.IDX is null) then
		:NEW.IDX := CART_SEQ.nextval;
	end if;
	if (:NEW.ADDED_TIME is null) then
		:NEW.ADDED_TIME := SYSTIMESTAMP;
	end if;
end;
/
--트리거 설명: 장바구니 인덱스/추가시간 처리 트리거


comment on table CART is '장바구니';

comment on column CART.IDX is '식별번호 - 후보키(null안됨+유일) 인조식별자. 순전히 쿼리를 쉽게 하기 위해 넣음.';

comment on column CART.ACC_IDX is '계정번호 - 복합기본키 + 외래키 (계정.계정번호)';

comment on column CART.SALE_OPT_IDX is '옵션번호 - 복합기본키 + 외래키 (판매옵션.번호)';

comment on column CART.COUNT is '갯수, 실제 남은 숫자는 비교를 안하니 조심!. - application에서 무결성을 확인 해야 하는 부분 (예외처리 사항)';

comment on column CART.ADDED_TIME is '등록시간 - 트리거 있음';


--drop trigger CART_TRG;
--drop sequence CART_SEQ;
--drop table CART cascade constraints;


-----------------------------------------------  일반 구매 영수증  -----------------------------------------------

create table SALE_OPTION_RECEIPT (

	IDX						number(13,0)

	,DELIVERY_IDX			number(13,0)

	,MAIN_RECPT_BUYER		number(8,0)		not null
	,MAIN_RECPT_IDX			number(13,0)	not null

	,SALE_OPTION_IDX		number(11,0)
	,NAME					nvarchar2(25)	not null
	,AMOUNT					number(7,0)		not null
	,UNIT					nvarchar2(20)	not null
	,PRICE					number(13,0)	not null

	,STATE_CODE				number(2,0)		not null

	,REFUND_TARGET_IDX		number(13,0)

	,constraint SALE_OPT_RECEIPT_PK primary key (IDX)
	,constraint SALE_OPT_RECPT_DLVRY_FK foreign key (DELIVERY_IDX) references DELIVERY (IDX)
	,constraint SALEOPTRECPT_MRECPT_FK foreign key (MAIN_RECPT_BUYER, MAIN_RECPT_IDX) references MAIN_RECEIPT (BUYER_IDX, IDX)
	,constraint SALE_OPT_RECPT_OPT_FK foreign key (SALE_OPTION_IDX) references SALE_OPTION (IDX) on delete set null
	,constraint SALE_OPT_STATE_CODE_FK foreign key (STATE_CODE) references LIST_RECPT_STATE_TYPE (CODE)
	,constraint SALE_OPT_REFUND_FK foreign key (REFUND_TARGET_IDX) references SALE_OPTION_RECEIPT (IDX)
	,constraint SALE_OPT_RECPT_UNQ unique (IDX, MAIN_RECPT_BUYER, MAIN_RECPT_IDX)
	,constraint SALE_OPT_RECPT_CHECK check (AMOUNT >0 and PRICE >0)
);

create index SALE_OPT_RECPT_INDEX on SALE_OPTION_RECEIPT (MAIN_RECPT_BUYER);

create sequence SALE_OPT_RECPT_SEQ start with 1 increment by 1;

create trigger SALE_OPT_RECPT_TRG
	before insert on SALE_OPTION_RECEIPT
	for each row
begin
	if (:NEW.IDX is null) then
		:NEW.IDX := SALE_OPT_RECPT_SEQ.nextval;
	end if;
	if (:NEW.STATE_CODE is null) then
		:NEW.STATE_CODE := 0;
	end if;
end;
/


comment on table SALE_OPTION_RECEIPT is '판매 옵션 목록 영수증';

comment on column SALE_OPTION_RECEIPT.IDX is '판매 옵션 목록 영수증 번호 - 기본키, 인조식별자.';

comment on column SALE_OPTION_RECEIPT.DELIVERY_IDX is '배송 번호 - 외래키, null가능';

comment on column SALE_OPTION_RECEIPT.MAIN_RECPT_BUYER is '주 영수증 구매자 번호 - 복합외래키 (주 영수증 기본키)';

comment on column SALE_OPTION_RECEIPT.MAIN_RECPT_IDX is '주 영수증 번호 - 복합외래키 (주 영수증 기본키)';

comment on column SALE_OPTION_RECEIPT.SALE_OPTION_IDX is '판매 옵션 번호 - 외래키';

comment on column SALE_OPTION_RECEIPT.NAME is '판매 옵션 이름 - null불가. 복제값 저장용.';

comment on column SALE_OPTION_RECEIPT.AMOUNT is '판매 옵션 구매 수 - null불가';

comment on column SALE_OPTION_RECEIPT.UNIT is '판매 옵션 단위 - null불가. 복제값 저장용.';

comment on column SALE_OPTION_RECEIPT.PRICE is '옵션 개별 가격 - null불가. 복제값 저장용';

comment on column SALE_OPTION_RECEIPT.STATE_CODE is '목록 영수증 상태 코드 - 외래키 (트리거 기본값 있음)';

comment on column SALE_OPTION_RECEIPT.REFUND_TARGET_IDX is '목록 영수증 환불 대상 - null 가능';


--drop trigger SALE_OPT_RECPT_TRG;
--drop sequence SALE_OPT_RECPT_SEQ;
--drop index SALE_OPT_RECPT_INDEX;
--drop table SALE_OPTION_RECEIPT cascade constraints;


-----------------------------------------------  일반 구매: 배송대상  -----------------------------------------------
-- 영수증과 통합.

-----------------------------------------------  일반 구매: 판매 평가  -----------------------------------------------

create table SALE_EVALUATION (

	SALE_OPT_RECPT_IDX		number(13,0)	not null
	,MAIN_RECPT_BUYER		number(8,0)
	,MAIN_RECPT_IDX			number(13,0)

	,SALE_IDX				number(10,0)	not null
	,SCORE					number(3,0)		not null
	,TITLE					nvarchar2(40)	not null
	,CONTENT				nvarchar2(400)
	,REG_TIME				date			not null
	
	,constraint SALE_EVAL_PK primary key (SALE_OPT_RECPT_IDX, MAIN_RECPT_BUYER, MAIN_RECPT_IDX)
	,constraint SALE_EVAL_OPT_RCPT_FK foreign key (SALE_OPT_RECPT_IDX, MAIN_RECPT_BUYER, MAIN_RECPT_IDX) references SALE_OPTION_RECEIPT (IDX, MAIN_RECPT_BUYER, MAIN_RECPT_IDX) on delete cascade
	,constraint SALE_EVAL_SALE_FK foreign key (SALE_IDX) references SALE (IDX) on delete cascade
	,constraint SALE_EVAL_ACC_IDX foreign key (MAIN_RECPT_BUYER) references ACCOUNT (IDX) on delete cascade
	,constraint SALE_EVAL_CHECK check (SCORE <=100 and SCORE >= 0)
);

create index SALE_EVAL_INDEX on SALE_EVALUATION (SALE_IDX);

create trigger SALE_EVAL_TRG
	before insert on SALE_EVALUATION
	for each row 
	when (NEW.REG_TIME is null)
begin
	:NEW.REG_TIME := SYSDATE;
end;
/


comment on table SALE_EVALUATION is '판매글 평가';

comment on column SALE_EVALUATION.MAIN_RECPT_BUYER is '주 영수증 구매계정..이자 글 쓴 계정 번호 - 복합기본키 + 복합외래키 (일반 구매 영수증 기본키)';

comment on column SALE_EVALUATION.MAIN_RECPT_IDX is '주 영수증 번호 - 복합기본키 + 복합외래키';

comment on column SALE_EVALUATION.SALE_OPT_RECPT_IDX is '일반 구매 영수증 번호 - 복합기본키 + 복합외래키 (일반 구매 영수증 기본키)';

comment on column SALE_EVALUATION.SALE_IDX is '판매글 번호 - 외래키. null불가. 일종의 중복 데이터 이지만 처리의 용이성을 위해 추가.';

comment on column SALE_EVALUATION.SCORE is '점수 - 0이상 100이하 정수. null불가';

comment on column SALE_EVALUATION.TITLE is '제목 - null불가';

comment on column SALE_EVALUATION.CONTENT is '내용 - null가능';

comment on column SALE_EVALUATION.REG_TIME is '등록시간 - 트리거있음(시스템시간) null불가';

--이미지도 추가할 거면 속성 추가하기..

--drop trigger SALE_EVAL_TRG;
--drop index SALE_EVAL_INDEX;
--drop table SALE_EVALUATION cascade constraints;


-----------------------------------------------  경매 만료시간 타입  -------------------------------------------------------
-- 각종 만료시간 처리를 하나로 합쳤다가, 절대 해서는 안되는 금기사항이라고 해서 다시 분리함..

create table AUCTION_TIME_WINDOW_TYPE (

	CODE				number(2,0)
	,TIME_WINDOW		interval day (3) to second (3)	not null

	,NAME				nvarchar2(15)	not null
	,DESCRIPTION		nvarchar2(400)

	,constraint AUCTION_T_W_TYPE_PK primary key (CODE)
);

insert all
	into AUCTION_TIME_WINDOW_TYPE (CODE, TIME_WINDOW, NAME, DESCRIPTION) values (1, numtodsinterval( 03, 'DAY') ,'3일 경매', '3일짜리 경매 기한')
	into AUCTION_TIME_WINDOW_TYPE (CODE, TIME_WINDOW, NAME, DESCRIPTION) values (2, numtodsinterval( 07, 'DAY') ,'7일 경매', '7일짜리 경매 기한')
	into AUCTION_TIME_WINDOW_TYPE (CODE, TIME_WINDOW, NAME, DESCRIPTION) values (3, numtodsinterval( 28, 'DAY') ,'28일 경매', '28일짜리 경매 기한')
select 1 from DUAL;

commit;


comment on table AUCTION_TIME_WINDOW_TYPE is '경매 만료시간 제어용 테이블(일종의 서브타입 묶음)';

comment on column AUCTION_TIME_WINDOW_TYPE.CODE is '경매 만료시간 비즈니스 코드 - 기본키';

comment on column AUCTION_TIME_WINDOW_TYPE.TIME_WINDOW is '시간(길이) - null 안됨';

comment on column AUCTION_TIME_WINDOW_TYPE.NAME is '코드 이름 - null 안됨';

comment on column AUCTION_TIME_WINDOW_TYPE.DESCRIPTION is '코드 설명';


--drop table AUCTION_TIME_WINDOW_TYPE cascade constraints;


-----------------------------------------------  경매 입찰 최소 단위 타입  -------------------------------------------------------


-----------------------------------------------  경매 상태 타입  -------------------------------------------------------

create table AUCTION_STATE_TYPE (

	CODE			number(2,0)
	,NAME			nvarchar2(30)	not null
	,DESCRIPTION	nvarchar2(400)
	
	,constraint AUCTION_STATE_TYPE_PK primary key (CODE)
);

insert all
	into AUCTION_STATE_TYPE (CODE, NAME, DESCRIPTION) values (1,'진행중','')
	into AUCTION_STATE_TYPE (CODE, NAME, DESCRIPTION) values (2,'진행중 취소 시작','')
	into AUCTION_STATE_TYPE (CODE, NAME, DESCRIPTION) values (3,'진행중 취소됨','')
	into AUCTION_STATE_TYPE (CODE, NAME, DESCRIPTION) values (4,'낙찰 시작','')
	into AUCTION_STATE_TYPE (CODE, NAME, DESCRIPTION) values (5,'만료: 유효입찰 없음','')
	into AUCTION_STATE_TYPE (CODE, NAME, DESCRIPTION) values (6,'낙찰 완료 대기중','')
	into AUCTION_STATE_TYPE (CODE, NAME, DESCRIPTION) values (7,'만료: 입찰자의 거래 거부','')
	into AUCTION_STATE_TYPE (CODE, NAME, DESCRIPTION) values (8,'낙찰 완료','')
select 1 from dual;

commit;


comment on table AUCTION_STATE_TYPE is '경매 상태 제어용 코드 테이블';

comment on column AUCTION_STATE_TYPE.CODE is '코드 - 기본키';

comment on column AUCTION_STATE_TYPE.NAME is '상태 이름 - null 불가';

comment on column AUCTION_STATE_TYPE.DESCRIPTION is '설명';


--drop table AUCTION_STATE_TYPE cascade constraints;


-----------------------------------------------  경매  -------------------------------------------------------


create table AUCTION (

	IDX						number(10,0)
	,WRITTER_IDX			number(8,0)			not null

	,REG_TIME				timestamp(3) with local time zone	not null
	,TIME_WINDOW_CODE		number(2,0)			not null
	,START_PRICE			number(9,0)			not null

	,TITLE					nvarchar2(40)		not null
	,CONTENT				nvarchar2(2000)		not null
	,ITEM_IMG				varchar2(200 char)	not null

	,STATE_CODE				number(2,0)

	,HIGHEST_BID			number(11,0)

	,constraint AUCTION_PK primary key (IDX)
	,constraint AUCTION_WRITTER_FK foreign key (WRITTER_IDX) references ACCOUNT (IDX) on delete cascade
	,constraint AUCTION_T_W_TYPE_FK	foreign key (TIME_WINDOW_CODE) references AUCTION_TIME_WINDOW_TYPE (CODE)
	,constraint AUCTION_STATE_FK foreign key (STATE_CODE) references AUCTION_STATE_TYPE (CODE)
	,constraint AUCTION_PRICE_CHECK check (START_PRICE >0)
);

create index AUCTION_ISDEL_ACC_IDX on AUCTION (STATE_CODE, WRITTER_IDX);

create sequence AUCTION_SEQ start with 1 increment by 1;

create trigger AUCTION_IDX_REGT_TRG
	before insert on AUCTION
	for each row
begin
	if (:NEW.IDX is null) then
		:NEW.IDX := AUCTION_SEQ.nextval;
	end if;
	if (:NEW.TIME_WINDOW_CODE is null) then
		:NEW.TIME_WINDOW_CODE := 1;
	end if;
	if (:NEW.STATE_CODE is null) then
		:NEW.STATE_CODE := 1;
	end if;
	:NEW.REG_TIME := SYSTIMESTAMP;
end;
/
--트리거 설명: IDX 삽입, 상태코드 삽입, REG_TIME 무조건 시스템시간으로 삽입 (입력값 덮어쓰기)


comment on table AUCTION is '경매';

comment on column AUCTION.IDX is '경매번호 - 유일성. 복합기본키, 인조식별자. 트리거 있음';

comment on column AUCTION.WRITTER_IDX is '작성자 인덱스 - 외래키. null 불가';

comment on column AUCTION.REG_TIME is '작성시간 - null 불가. 트리거 있음';

comment on column AUCTION.TIME_WINDOW_CODE is '경매 기간 타입 - 외래키. null불가 트리거 있음(기본값:1 - 3일)';

comment on column AUCTION.START_PRICE is '시작가격 - null 불가. 0이상';

comment on column AUCTION.TITLE is '글제목 - null 불가';

comment on column AUCTION.CONTENT is '글내용 - null 불가';

comment on column AUCTION.ITEM_IMG is '경매물품 사진 - null 불가';

comment on column AUCTION.STATE_CODE is '경매 상태 비즈니스 코드 - 외래키. 트리거 있음';

comment on column AUCTION.HIGHEST_BID is '최고 입찰액 - 일종의 중복값, 병행 처리를 쉽게 하기 위해 넣은 속성: 경매 행을 lock 한 상태에서 입찰이 이루어짐';


--drop trigger AUCTION_IDX_REGT_TRG;
--drop sequence AUCTION_SEQ;
--drop index AUCTION_ISDEL_ACC_IDX;
--drop table AUCTION cascade constraints;


-----------------------------------------------  경매 카테고리 매핑 -------------------------------------------------------

create table AUCTION_CATEGORY_MAP (

	AUCTION_IDX			number(10,0)
	,CATEGORY_IDX		number(3,0)

	,constraint AUCTION_CATEGORY_MAP_PK primary key (AUCTION_IDX, CATEGORY_IDX)
	,constraint AUCTION_CAT_MAP_AUCT_FK foreign key (AUCTION_IDX) references AUCTION (IDX) on delete cascade
	,constraint AUCTION_CAT_MAP_CAT_FK foreign key (CATEGORY_IDX) references CATEGORY (IDX)
);


comment on table AUCTION_CATEGORY_MAP is '경매 카테고리 맵';

comment on column AUCTION_CATEGORY_MAP.AUCTION_IDX is '경매글 번호 - 복합기본키 + 외래키 (경매.경매글 번호)';

comment on column AUCTION_CATEGORY_MAP.CATEGORY_IDX is '카테고리 노드 번호 - 복합기본키 + 외래키';


--drop table AUCTION_CATEGORY_MAP cascade constraints;


-----------------------------------------------  경매 물품 이미지 -------------------------------------------------------

-----------------------------------------------  경매 만료 대기열  -------------------------------------------------------
-- 일종의 중복 데이터, 만료 처리를 용이하게 하기 위한 부분.
-- 처리방식에 따라 이런 테이블을 쓰지 않을 수도 있음.

create table AUCTION_DUE_QUE (

	AUCTION_IDX				number(10,0)
	,TIME_WINDOW			timestamp(3) with local time zone

	,constraint AUCTION_DUE_QUE_PK primary key (AUCTION_IDX)
	,constraint AUCTION_DUE_QUE_FK foreign key (AUCTION_IDX) references AUCTION (IDX) on delete cascade
);

create index AUCTION_DUE_QUE_INDEX on AUCTION_DUE_QUE (TIME_WINDOW desc);

create trigger AUCTION_DUE_QUE_TRG
	after insert on AUCTION
	for each row
begin
	insert into AUCTION_DUE_QUE (AUCTION_IDX, TIME_WINDOW) values ( :NEW.IDX, :NEW.REG_TIME + (select TIME_WINDOW from AUCTION_TIME_WINDOW_TYPE where CODE = :NEW.TIME_WINDOW_CODE) );
end;
/
--트리거 설명: 경매 등록시 만료 대기열에 자동으로 만료시간을 계산하여 등록.


comment on table AUCTION_DUE_QUE is '만료 처리를 위해 만료되지 않은 경매들을 모아둔 테이블. 스케쥴러든 타이머든 써서 이 대기열을 처리.';

comment on column AUCTION_DUE_QUE.AUCTION_IDX is '대상 경매 인덱스. 기본키';

comment on column AUCTION_DUE_QUE.TIME_WINDOW is '예정 만료시각 - 트리거 있음';


--drop trigger AUCTION_DUE_QUE_TRG;
--drop index AUCTION_DUE_QUE_INDEX;
--drop table AUCTION_DUE_QUE cascade constraints;


----------------------------------------------- 입찰 보증금 영수증 --------------------------------------------------------
-- 입찰 정보의 변화나 처리에 무관하게 존재해야 하기 때문에 영수증을 입찰에서 분리. 입찰 보증금 영수증 -> 입찰 발생
-- 목록 영수증들을 통합하려다 어차피 복잡하기는 매한가지라 그냥 나뉜채로 둠.

create table BID_DEPOSITE_RECEIPT (

	IDX						number(13,0)
	,AUCTION_IDX			number(11,0)
	,MAIN_RECPT_BUYER		number(8,0)			not null
	,MAIN_RECPT_IDX			number(13,0)		not null
	,DEPOSIT_AMOUNT			number(10,0)		not null

	,TITLE					nvarchar2(40)		not null
	
	,STATE_CODE				number(2,0)			not null

	,REFUND_TARGET_IDX		number(13,0)

	,constraint BID_DEPOST_RECPT_PK primary key (IDX) 
	,constraint BID_DEPOST_M_RECPT_FK foreign key (MAIN_RECPT_BUYER, MAIN_RECPT_IDX) references MAIN_RECEIPT (BUYER_IDX, IDX)
	,constraint BID_DEPO_RECPT_AUCT_FK foreign key (AUCTION_IDX) references AUCTION (IDX) on delete set null
	,constraint BID_DEPO_RECPT_STATE_FK foreign key (STATE_CODE) references LIST_RECPT_STATE_TYPE (CODE)
	,constraint BID_REFUND_FK foreign key (REFUND_TARGET_IDX) references BID_DEPOSITE_RECEIPT (IDX)
	,constraint BID_DEPOSITE_CHECK check (DEPOSIT_AMOUNT >0)
);

create index BID_DEPO_RECPT_INDEX on BID_DEPOSITE_RECEIPT (MAIN_RECPT_BUYER, MAIN_RECPT_IDX);

create sequence BID_DEPO_RECPT_SEQ start with 1 increment by 1;

create trigger BID_DEPOSITE_RECPT_TRG
	before insert on BID_DEPOSITE_RECEIPT
	for each row
begin
	if(:NEW.IDX is null) then
		:NEW.IDX := BID_DEPO_RECPT_SEQ.nextval;
	end if;
	if (:NEW.STATE_CODE is null) then
		:NEW.STATE_CODE := 0;
	end if;
end;
/
-- 트리거 : 입찰번호 기본값, 상태코드 기본값(0).

comment on table BID_DEPOSITE_RECEIPT is '입찰 보증금 영수증';

comment on column BID_DEPOSITE_RECEIPT.IDX is '입찰 보증금 영수증 번호 - 기본키, 인조식별자';

comment on column BID_DEPOSITE_RECEIPT.AUCTION_IDX is '입찰 대상 경매 번호 - null 가능. 외래키';

comment on column BID_DEPOSITE_RECEIPT.MAIN_RECPT_BUYER is '주 영수증 구매자 - 복합외래키. null불가';

comment on column BID_DEPOSITE_RECEIPT.MAIN_RECPT_IDX is '주 영수증 번호 -  복합외래키. null불가';

comment on column BID_DEPOSITE_RECEIPT.DEPOSIT_AMOUNT is '보증금 액수 - null불가. 0이상';

comment on column BID_DEPOSITE_RECEIPT.TITLE is '입찰 대상 경매 제목: 복제값 저장용. null불가';

comment on column BID_DEPOSITE_RECEIPT.STATE_CODE is '목록 영수증 상태 코드 -  외래키. null불가';

comment on column BID_DEPOSITE_RECEIPT.REFUND_TARGET_IDX is '목록 영수증 환불 대상 IDX null가능';


--drop sequence BID_DEPO_RECPT_SEQ;
--drop trigger BID_DEPOSITE_RECPT_TRG;
--drop index BID_DEPO_RECPT_INDEX;
--drop table BID_DEPOSITE_RECEIPT cascade constraints;


-----------------------------------------------  입찰 상태 타입 -------------------------------------------------------
-- 0. 입찰중.
-- 1. 입찰 성공. 경매 진행중
-- 2. 낙찰 대기중 (최고입찰이 아님)
-- 3. 낙찰금 지불 대기중 (최고입찰임, 금액 지불 대기중)
-- 4. 완료
-- 11. 자기 상위입찰 됨. - 보증금 환불 전
-- 12. 자기 상위입찰 됨. - 보증금 환불 후
-- 13. 경매가 취소됨 - 환불 전.
-- 14. 경매가 취소됨 - 환불 후.
-- 15. 진행중 입찰 취소 - 보증금 환불 전
-- 16. 진행중 입찰 취소 - 보증금 환불 후
-- 21. 경매 완료됨 - 최고입찰이 아님 - 보증금 환불 전
-- 22. 경매 완료됨 - 최고입찰이 아님 - 보증금 환불 후
-- 23. 경매 완료 후 취소 - 보증금 환불 없음
-- 23. 낙찰금 지불 거부
/*
입찰 등록:
	금액 지불(지불 요청 전 입찰액 확인(낙찰금 + 최소입찰 단위 보다 큰가, 경매가 만료되었는가)
	1. 경매 만료 시한 확인
	1.1 예외시 환불
	2. 최고입찰액 + 최소입찰 단위와 입찰액 비교
	2.1 예외시 환불
	3. 경매의 최고 입찰액 갱신
	3.1 예외시 환불
	4. 입찰 목록에 등록 (최고입찰 목록을 따로 가지고 있다면 여기서 함께 처리)
	4.1 예외시 환불 + 경매의 최고 입찰액을 돌려놓아야 함
	5. 자기 상위입찰 여부 확인
	5.1 자기 상위입찰 이라면 이전의 입찰에 대한 처리 (위의 11.12)
*/

create table BID_STATE_TYPE (

	CODE				number(2,0)
	,NAME				nvarchar2(30)	not null
	,DESCRIPTION		nvarchar2(400)

	,constraint BID_STATE_TYPE_PK primary key (CODE)
);

insert all
	into BID_STATE_TYPE (CODE, NAME, DESCRIPTION) values (1,'경매진행중: 최고입찰','입찰 후 경매 만료 대기중, 최고입찰.처음 들어오는 입찰은 무조건 최고입찰이어야 함.')
select 1 from DUAL;

commit;


comment on table BID_STATE_TYPE is '경매 상태 타입 코드 테이블';

comment on column BID_STATE_TYPE.CODE is '경매 상태 코드 - 기본키';

comment on column BID_STATE_TYPE.NAME is '경매 상태 이름 - null 불가';

comment on column BID_STATE_TYPE.DESCRIPTION is '경매 상태 설명';


--drop table BID_STATE_TYPE cascade constraints;


-----------------------------------------------  낙찰 지불 기한 타입 - 경매 만료 후, 최고입찰의 대금의 지불 기한 타입 -------------------------------------------------------
-- 각종 만료 기한 테이블 통합 -> 취소. 절대 해서는 안되는 짓이라고 해서 돌려놓음.

create table CONTRACT_TIME_WINDOW_TYPE (

	CODE				number(2,0)
	,TIME_WINDOW		interval day (3) to second (3)	not null

	,NAME				nvarchar2(15)	not null
	,DESCRIPTION		nvarchar2(400)

	,constraint CONTRACT_T_W_TYPE_PK primary key (CODE)
);

insert all
	into CONTRACT_TIME_WINDOW_TYPE (CODE, TIME_WINDOW, NAME, DESCRIPTION) values (1, numtodsinterval( 03, 'DAY') ,'3일 낙찰금 지불기한', '3일짜리 낙찰금 지불기한')
	into CONTRACT_TIME_WINDOW_TYPE (CODE, TIME_WINDOW, NAME, DESCRIPTION) values (2, numtodsinterval( 04, 'DAY') ,'4일 낙찰금 지불기한', '4일짜리 낙찰금 지불기한')
	into CONTRACT_TIME_WINDOW_TYPE (CODE, TIME_WINDOW, NAME, DESCRIPTION) values (3, numtodsinterval( 05, 'DAY') ,'5일 낙찰금 지불기한', '5일짜리 낙찰금 지불기한')
select 1 from DUAL;

commit;


comment on table CONTRACT_TIME_WINDOW_TYPE is '낙찰 만료시간 제어용 테이블(일종의 서브타입 묶음)';

comment on column CONTRACT_TIME_WINDOW_TYPE.CODE is '낙찰 만료시간 비즈니스 코드 - 기본키';

comment on column CONTRACT_TIME_WINDOW_TYPE.TIME_WINDOW is '시간(길이) - null 안됨';

comment on column CONTRACT_TIME_WINDOW_TYPE.NAME is '코드 이름 - null 안됨';

comment on column CONTRACT_TIME_WINDOW_TYPE.DESCRIPTION is '코드 설명';


--drop table CONTRACT_TIME_WINDOW_TYPE cascade constraints;


-----------------------------------------------  입찰  -------------------------------------------------------
--계정 삭제 과정 처리 조심. (예외사항이라 일단은 무시함)
--낙찰 대기열이 보류중이라 낙찰 시간을 저장하는 속성을 따로 추가해야 할 수도 있음.

create table BID (

--	IDX						number(12,0)	not null unique ,
	AUCTION_IDX				number(10,0)
	,AMOUNT					number(11,0)

	,DEPOSITE_RECPT_IDX		number(13,0)	not null
	,BID_TIME				timestamp(3) with local time zone not null

	,BIDDER_IDX				number(8,0)		not null
	,DEPOSIT_RATIO_CODE		number(2,0)		not null

	,STATE_CODE				number(2,0)		not null

	,constraint BID_PK primary key (AUCTION_IDX, AMOUNT)
	,constraint BID_RECPT_FK foreign key (DEPOSITE_RECPT_IDX) references BID_DEPOSITE_RECEIPT (IDX) on delete cascade
	,constraint BID_AUCTION_FK foreign key (AUCTION_IDX) references AUCTION (IDX) on delete cascade
	,constraint BID_ACC_IDX_FK foreign key (BIDDER_IDX) references ACCOUNT (IDX) on delete cascade
	,constraint BID_DEPO_RETIO_FK foreign key (DEPOSIT_RATIO_CODE) references BID_DEPOSIT_TYPE (CODE)
	,constraint BID_STATE_TYPE_FK foreign key (STATE_CODE) references BID_STATE_TYPE (CODE)
	,constraint BID_AMOUNT_CHECK check (AMOUNT >0)
);

create index BID_BIDDER_STATE_INDEX on BID (STATE_CODE, BIDDER_IDX, AUCTION_IDX);

--create sequence BID_SEQ start with 1 increment by 1;

create trigger BID_INSERT_TRG
	before insert on BID
	for each row
begin
--	if(:NEW.IDX is null) then
--		:NEW.IDX := BID_SEQ.nextval;
--	end if;
	if(:NEW.DEPOSIT_RATIO_CODE is null) then
		:NEW.DEPOSIT_RATIO_CODE :=1;
	end if;
	if(:NEW.STATE_CODE is null) then
		:NEW.STATE_CODE := 1;
	end if;
	:NEW.BID_TIME := SYSTIMESTAMP;
end;
/
-- 트리거 설명: 인덱스 삽입, 상태코드 삽입, 보증금비율 코드 삽입, 결제타입 기본값 삽입, 지불기한 코드 삽입, 입찰시각 시스템 시각으로 덮어쓰기


comment on table BID is '입찰 테이블 - 전체 속성 null 불가';

--comment on column BID.IDX is '입찰번호 - 후보키. 인조식별자. 트리거 있음. 각종 처리를 쉽게 하귀 위한 속성';

comment on column BID.AUCTION_IDX is '대상 경매 번호 - 복합기본키. 외래키 (경매)';

comment on column BID.AMOUNT is '입찰액 - 복합 기본키, 0이상';

comment on column BID.DEPOSITE_RECPT_IDX is '주 영수증 번호 - 외래키(보증금 영수증) null불가';

comment on column BID.BID_TIME is '입찰 시각 - null불가. 트리거 있음: 새 입찰 등록시, 시스템 시각 지정';

comment on column BID.BIDDER_IDX is '입찰자 계정번호 - 외래키 (계정) null불가';

comment on column BID.DEPOSIT_RATIO_CODE is '보증금 비율 코드 - 외래키, 트리거 있음(기본값 1)';

comment on column BID.STATE_CODE is '입찰 상태 코드 - 외래키. 트리거 있음 (기본값 1)';


--drop trigger BID_INSERT_TRG;
--drop sequence BID_SEQ;
--drop index BID_BIDDER_STATE_INDEX;
--drop table BID cascade constraints;


-----------------------------------------------  (보류)입찰 환불 영수증  -----------------------------------------------

-----------------------------------------------  경매 낙찰 대기열  -------------------------------------------------------
-- 처리의 용이성을 위한 중복 테이블. (낙찰금 지불 만료 기한 처리)
-- 낙찰 처리를 하기 위해 낙찰 대기중인 경매(최고입찰)만 모아둔 테이블. (낙찰을 대기중인 경매와 대상 입찰 정보 + 만료시간)
-- 어느 경매가 낙찰 대기중이며, 대기중인 대상 입찰(최고입찰) 은 ### 이다. 대기 만료시간은 ### 이다.
-- 1.목록 확인 2.지불기한이 만료된 입찰 확인 3.대상이 실제 대기중인 상태였는지 한번 더 확인(예외처리 사항) 4.지불 대기중인 입찰을 만료시키고 다음 유효 입찰(취소가 안된)을 찾기. - 입찰이 취소되면 여기 있는 해당 입찰이 삭제되어야 함!
-- 경매 후보키: AUCTION_IDX
-- 입찰 후보키: AUCTION_IDX, AMOUNT.
-- insert 동작: 낙찰을 시작하거나, 다음 최고입찰을 찾은 경매의 최고입찰을 찾아서  해당 입찰을 그냥 insert 하면 트리거로 처리하는게 편할 듯.
-- 이후 목록의 시간들을 확인하고 처리.


create table BID_CONTRACT_QUE (

	AUCTION_IDX					number(10,0)
	,BID_AMOUNT					number(11,0)	not null
	,CONTRACT_T_WIN_CODE		number(2,0)		not null
	
	,PAYMENT_DUE				timestamp(3) with local time zone	not null

	,constraint BID_CONTRACT_QUE_PK primary key (AUCTION_IDX)
	,constraint BID_CONTRACT_AUCT_FK foreign key (AUCTION_IDX) references AUCTION (IDX) on delete cascade
	,constraint BID_CONTRACT_Q_BID_FK foreign key (AUCTION_IDX, BID_AMOUNT) references BID (AUCTION_IDX, AMOUNT) on delete cascade
	,constraint BID_CONTRACT_T_WIN foreign key (CONTRACT_T_WIN_CODE) references CONTRACT_TIME_WINDOW_TYPE (CODE)
);

create trigger BID_CONTRACT_QUE_TRG
	before insert on BID_CONTRACT_QUE
	for each row
begin
	if (:NEW.CONTRACT_T_WIN_CODE is null) then
		:NEW.CONTRACT_T_WIN_CODE := 1;
	end if;
	select (TIME_WINDOW +SYSTIMESTAMP) into :NEW.PAYMENT_DUE from CONTRACT_TIME_WINDOW_TYPE
		where CODE = :NEW.CONTRACT_T_WIN_CODE;
end;
/


comment on table BID_CONTRACT_QUE is '경매 낙찰 대기열. 모든 속성이 null 불가';

comment on column BID_CONTRACT_QUE.AUCTION_IDX is '경매 번호. 기본키 + 경매 외래키 + 입찰 외래키. null불가';

comment on column BID_CONTRACT_QUE.BID_AMOUNT is '입찰액. 입찰 외래키 + null불가';

comment on column BID_CONTRACT_QUE.CONTRACT_T_WIN_CODE is '낙찰금 지불 기한 타입 코드 - 외래키. null불가 트리거 있음(기본값:1, 3일짜리)';

comment on column BID_CONTRACT_QUE.PAYMENT_DUE is '낙찰금 지불 만료 기한 - 트리거 있음. null불가';


--drop trigger BID_CONTRACT_QUE_TRG;
--drop table BID_CONTRACT_QUE cascade constraints;


-----------------------------------------------  낙찰금 영수증  -----------------------------------------------

create table BID_CONTRACT_RECEIPT (

	IDX						number(13,0)

	,AUCTION_IDX			number(11,0)
	,BID_AMOUNT				number(11,0)

	,MAIN_RECPT_BUYER		number(8,0)			not null
	,MAIN_RECPT_IDX			number(13,0)		not null
	,CONTRACT_AMOUNT		number(10,0)		not null
	
	,TITLE					nvarchar2(40)		not null

	,STATE_CODE				number(2,0)			not null

	,REFUND_TARGET_IDX		number(13,0)

	,constraint BID_CONTRCT_RECPT_PK primary key (IDX) 
	,constraint BID_CONTRCT_M_RECPT_FK foreign key (MAIN_RECPT_BUYER, MAIN_RECPT_IDX) references MAIN_RECEIPT (BUYER_IDX, IDX)
	,constraint BID_CONT_RECPT_BID_FK foreign key (AUCTION_IDX, BID_AMOUNT) references BID (AUCTION_IDX, AMOUNT) on delete set null
	,constraint BID_CONT_RECPT_STATE_FK foreign key (STATE_CODE) references LIST_RECPT_STATE_TYPE (CODE)
	,constraint CONT_REFUND_FK foreign key (REFUND_TARGET_IDX) references BID_CONTRACT_RECEIPT (IDX)
	,constraint CONTRACT_UNIQUE unique (AUCTION_IDX, BID_AMOUNT)
	,constraint BID_CONTRACT_CHECK check (CONTRACT_AMOUNT >0)
);

create index BID_CONTRCT_RECPT_INDX on BID_CONTRACT_RECEIPT (MAIN_RECPT_BUYER, MAIN_RECPT_IDX);

create sequence BID_CONTRACT_RECPT_SEQ start with 1 increment by 1;

create trigger BID_CONTRACT_RECPT_TRG
	before insert on BID_CONTRACT_RECEIPT
	for each row
begin
	if (:NEW.IDX is null) then
		:NEW.IDX := BID_CONTRACT_RECPT_SEQ.nextval;
	end if;
		if (:NEW.STATE_CODE is null) then
		:NEW.STATE_CODE := 0;
	end if;
end;
/


comment on table BID_CONTRACT_RECEIPT is '낙찰금 영수증';

comment on column BID_CONTRACT_RECEIPT.IDX is '낙찰금 영수증 번호 - 기본키, 인조식별자';

comment on column BID_CONTRACT_RECEIPT.AUCTION_IDX is '경매번호 - 복합외래키 (입찰 기본키). 복합 유일 (입찰 기본키와 일치시킴)';

comment on column BID_CONTRACT_RECEIPT.BID_AMOUNT is '입찰액 - 복합외래키 (입찰 기본키). 복합 유일 (입찰 기본키와 일치시킴)';

comment on column BID_CONTRACT_RECEIPT.MAIN_RECPT_BUYER is '주 영수증 구매자 - 복합외래키. null불가';

comment on column BID_CONTRACT_RECEIPT.MAIN_RECPT_IDX is '주 영수증 번호 -  복합외래키. null불가';

comment on column BID_CONTRACT_RECEIPT.CONTRACT_AMOUNT is '낙찰금 지불액(보증금 제외), null불가. 0이상';

comment on column BID_CONTRACT_RECEIPT.TITLE is '낙찰 대상 경매 제목 - 복제값 저장용 null불가';

comment on column BID_CONTRACT_RECEIPT.STATE_CODE is '목록 영수증 상태 코드 -  외래키. null불가';

comment on column BID_CONTRACT_RECEIPT.REFUND_TARGET_IDX is '목록 영수증 환불 대상 IDX null가능';


--drop trigger BID_CONTRACT_RECPT_TRG;
--drop sequence BID_CONTRACT_RECPT_SEQ;
--drop index BID_CONTRCT_RECPT_INDX;
--drop table BID_CONTRACT_RECEIPT cascade constraints;

-----------------------------------------------  낙찰 완료 입찰 정보 -----------------------------------------------
-- 낙찰된 입찰 목록 (입찰의 서브타입 형태)
-- 트리거로 정보 관리중: 낙찰금 영수증 발생시 자동으로 입력

create table BID_CONTRACT (

	AUCTION_IDX			number(10,0)
	,BID_AMOUNT			number(11,0)

	,RECPT_IDX			number(13,0)	not null

	,CONTRACT_TIME		timestamp(3)	not null

	,constraint BID_CONTRACT_PK primary key (AUCTION_IDX, BID_AMOUNT)
	,constraint BID_CONTRACT_BID_FK foreign key (AUCTION_IDX, BID_AMOUNT) references BID (AUCTION_IDX, AMOUNT) on delete cascade
	,constraint BID_CONTRACT_RECPT_FK foreign key (RECPT_IDX) references BID_CONTRACT_RECEIPT (IDX) on delete cascade
);

create trigger BID_CONTRACT_TRG
	after insert on BID_CONTRACT_RECEIPT
	for each row
begin
	insert into BID_CONTRACT (AUCTION_IDX, BID_AMOUNT, RECPT_IDX, CONTRACT_TIME) values (:NEW.AUCTION_IDX, :NEW.BID_AMOUNT, :NEW.IDX, SYSTIMESTAMP);
end;
/


comment on table BID_CONTRACT is '낙찰 완료 입찰 목록';

comment on column BID_CONTRACT.AUCTION_IDX is '대상 경매 번호 - 복합기본키 + 복합 외래키 (입찰 기본키)';

comment on column BID_CONTRACT.BID_AMOUNT is '입찰액 - 복합기본키 + 복합 외래키 (입찰 기본키)';

comment on column BID_CONTRACT.RECPT_IDX is '낙찰금 지불 영수증 번호 - 외래키. null불가';

comment on column BID_CONTRACT.CONTRACT_TIME is '낙찰 완료 목록에 등록된 시간 - null불가';


--drop trigger BID_CONTRACT_TRG;
--drop table BID_CONTRACT cascade constraints;


-----------------------------------------------  경매: 배송대상  -----------------------------------------------
-----------------------------------------------  (보류)배송 묶음 -------------------------------------------------------
--배송 대상들과 배송 간 연결

------------------------------------------------  쪽지 타입 -------------------------------------------------
-- 일단 쪽지 조회를 쉽게 처리하기 위해 넣은 테이블. 추가적인 타입을 지정하면서 여러 용도로 사용 가능

create table MESSAGE_TYPE (

	CODE				number(2,0)
	,NAME				nvarchar2(50) not null
	,DESCRIPTION		nvarchar2(2000)

	,constraint PK_MESSAGE_TYPE primary key (CODE)
);

insert into MESSAGE_TYPE (CODE, NAME, DESCRIPTION) values (0, '일반', 'default 값 처리용 일반 타입(더미, 그냥 써도 됨)');

commit;


comment on table MESSAGE_TYPE is '쪽지 타입 비즈니스 코드 테이블';

comment on column MESSAGE_TYPE.CODE is '쪽지 타입 코드 - 기본키 시퀀스없음';

comment on column MESSAGE_TYPE.NAME is '쪽지 타입 이름 - null 안됨';

comment on column MESSAGE_TYPE.DESCRIPTION is '쪽지 타입 설명';


--drop table MESSAGE_TYPE cascade constraints;


------------------------------------------------  쪽지  ----------------------------------------------------

create table MESSAGE (

	IDX					number(12,0)		unique
	,SENDER_IDX			number(8,0)			not null
	,RECEIVER_IDX		number(8,0)

	,TITLE				nvarchar2(200)		not null
	,CONTENT			nvarchar2(1000)
	,WRITTEN_TIME		timestamp(0) with local time zone not null

	,IS_READ			number(1,0)			default 0 not null
	,READ_TIME			timestamp(0) with local time zone

	,TYPE_CODE			number(2,0)			default 0 not null

	,ISDEL				number(1,0)			default 0

	,constraint MESSAGE_PK primary key (ISDEL, RECEIVER_IDX, IDX)
	,constraint FK_MESSAGE_SENDER_ACCIDX foreign key (SENDER_IDX) references ACCOUNT (IDX) on delete cascade
	,constraint FK_MESSAGE_RECEIVER_ACCIDX foreign key (RECEIVER_IDX) references ACCOUNT (IDX) on delete cascade
	,constraint FK_MESSAGE_MSGTYPE foreign key (TYPE_CODE) references MESSAGE_TYPE (CODE)
	,constraint FK_MESSAGE_ISDEL foreign key (ISDEL) references ISDEL_TYPE (CODE)
);

create index MESSAGE_SENDER_ISDEL_INDEX on MESSAGE (ISDEL, SENDER_IDX);

create sequence MESSAGE_SEQ start with 1 increment by 1;

create trigger MESSAGE_TRG
	before insert on MESSAGE
	for each row
begin
	if (:NEW.IDX is null) then
		:NEW.IDX := MESSAGE_SEQ.nextval;
	end if;
	if (:NEW.WRITTEN_TIME is null) then
		:NEW.WRITTEN_TIME := SYSTIMESTAMP;
	end if;
end;
/
--트리거 설명: 인덱스 없으면 시퀀스 넣어줌, 작성시각 없으면 시스템 시각 넣어줌


comment on table MESSAGE is '쪽지';

comment on column MESSAGE.IDX is '쪽지번호 - 유일성. 복합기본키, 인조식별자';

comment on column MESSAGE.SENDER_IDX is '보낸사람 - 외래키 (계정.계정번호) null안됨';

comment on column MESSAGE.RECEIVER_IDX is '받는사람 - 복합기본키. 외래키 (계정.계정번호)';

comment on column MESSAGE.TITLE is '제목 - null 안됨';

comment on column MESSAGE.CONTENT is '내용';

comment on column MESSAGE.WRITTEN_TIME is '작성시각 - null안됨 트리거 있음';

comment on column MESSAGE.IS_READ is '조회 여부 표시. 1:읽음, 0:안읽음, 기본값:0';

comment on column MESSAGE.READ_TIME is '읽은 시각 기록 - 조회여부 확인용.';

comment on column MESSAGE.TYPE_CODE is '메세지 타입 - 일단은 시스템 알림이나 관리자 문의사항 조회를 쉽게 하기 위한 부분인데, 더 세분화 해서 기능을 확장할 수 있는 부분(추가 테이블이 필요할 수도 있음). 예시) 중요 메세지 표시';

comment on column MESSAGE.ISDEL is '삭제 확인 코드 - 복합기본키. 외래키, 기본값:0';


--drop trigger MESSAGE_TRG;
--drop sequence MESSAGE_SEQ;
--drop index MESSAGE_SENDER_ISDEL_INDEX;
--drop table MESSAGE cascade constraints;


------------------------------------------------  1:1 문의(취소됨 - 쪽지의 일부로 통합)  ----------------------------------------------------

/*
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
*/

------------------------------------------------  오늘의 농부  ----------------------------------------------------


create table TODAYS_FARMER (

	ACC_IDX			number(8,0)

	,TITLE			nvarchar2(40)	not null
	,CONTENT		nvarchar2(2000)
-- 2000자로 부족하면 clob로 변경하기 (단, clob는 update 트리거 적용 불가)
	,WRITTEN_TIME	timestamp (0) with local time zone default SYSTIMESTAMP not null
	
	,VIEW_COUNT		number(9,0) default 0
	,LAST_EDITED	timestamp (0) with local time zone

--	,RECOMMEND		number(8,0)	(매번 전체조회를 피하기 위해 넣을 수 있는 속성, 무결성 관리를 하려면 별도의 뷰를 생성하고 트리거를 쓰는 짓을 해야 되서 일단 보류)

	,THUMB_IMG		varchar2(200 char)
	,MAIN_IMG		varchar2(200 char)	
--이미지를 제대로 여럿 넣으려면 별도의 테이블 쓰기

	,ISDEL			number(1,0) default 0 not null

	,constraint TODAYS_FARMER_PK primary key (ACC_IDX)
	,constraint FK_TODAYS_FARMER_ACC foreign key (ACC_IDX) references ACCOUNT (IDX) on delete cascade
	,constraint TODAYS_FARM_VCOUNT_CHECK check (VIEW_COUNT >=0)
	,constraint FK_TODAYS_FARMER_ISDEL foreign key (ISDEL) references ISDEL_TYPE (CODE)
);

create trigger TODAYS_FARMER_EDIT_TRG
	before update of TITLE, CONTENT, THUMB_IMG, MAIN_IMG  on TODAYS_FARMER
	for each row
	when (NEW.LAST_EDITED is null)
begin
	:NEW.LAST_EDITED := SYSTIMESTAMP;
end;
/
--트리거 설명: 오늘의 농부 마지막 수정시각 처리


comment on table TODAYS_FARMER is '오늘의 농부';

comment on column TODAYS_FARMER.ACC_IDX is '계정 번호- 기본키 + 외래키 (계정.계정번호) = 1:1. 계정타입에 대한 규칙은 application에서 관리하기';

comment on column TODAYS_FARMER.TITLE is '제목 - null 안됨';

comment on column TODAYS_FARMER.CONTENT is '내용 - 각종html 을 넣다보면 매우 길어질 거라 생각해서 nclob. 대신 문자열로 바꾸기 위해서 to_nclob 함수 이용. 불편하고 쓸데없다 싶으면 nvarchar2 로 변경';

comment on column TODAYS_FARMER.WRITTEN_TIME is '작성 시각 - null 안됨, 기본값: 시스템 시각';

comment on column TODAYS_FARMER.VIEW_COUNT is '조회수';

comment on column TODAYS_FARMER.LAST_EDITED is '마지막 수정시각 - 트리거 없음. 글내용의 data type 이 clob 라서 update 관련 트리거가 안됨';

--comment on column TODAYS_FARMER.RECOMMEND is '추천? 점수? 보류중';

comment on column TODAYS_FARMER.THUMB_IMG is '썸네일 이미지 위치(경로+파일이름 전부) 저장. 원래이름은 필요 없음, 아마도.';

comment on column TODAYS_FARMER.MAIN_IMG is '주 이미지 위치(경로+파일이름 전부) 저장. 원래이름은 필요 없음, 아마도.';

comment on column TODAYS_FARMER.ISDEL is '삭제 확인 코드(블라인드) - 외래키, 기본값:0, null안됨. 삭제요청시 삭제코드만 바꾸면 나중에 다시 글을 쓸 수 없음!!(기본키 유일) 관리자가 블라인드 처리 하는 용으로만 사용!';


--drop trigger TODAYS_FARMER_EDIT_TRG;
--drop table TODAYS_FARMER cascade constraints;


------------------------------------------------  오늘의 농부 추천(보류: 일단 추천식으로 가정)  ----------------------------------------------------
/*
create table TODAYS_FARMER_RECOMMEND (

	RECOMMEND_ACC			number(8,0)
	,TODAYS_FARMER_IDX		number(8,0)
	
	,constraint TODAYS_FARM_RECOMM_PK primary key (RECOMMEND_ACC, TODAYS_FARMER_IDX)
	,constraint FK_TODAYS_FARM_REC_ACC foreign key (RECOMMEND_ACC) references ACCOUNT (IDX) on delete cascade
	,constraint FK_TODAYS_FARM_RECOMM foreign key (TODAYS_FARMER_IDX) references TODAYS_FARMER (ACC_IDX) on delete cascade
);

--drop table TODAYS_FARMER_RECOMMEND cascade constraints;
*/

------------------------------------------------  오늘의 농부 픽(관리자의 메인 노출 설정)  ----------------------------------------------------
--갯수 조절 안됨, 예외처리 사항이라 일단은 그냥 둠.

create table TODAYS_FARMER_PICK (
	
	FARM_ACC_IDX	number(8,0)
	
	,constraint PK_TODAY_FARM_PICK primary key (FARM_ACC_IDX)
	,constraint FK_TODAY_FARM_FK foreign key (FARM_ACC_IDX) references TODAYS_FARMER (ACC_IDX) on delete cascade
);


comment on table TODAYS_FARMER_PICK is '오늘의 농부 선택';

comment on column TODAYS_FARMER_PICK.FARM_ACC_IDX is '선택된 오늘의 농부 - 기본키 + 외래키 (오늘의 농부 기본키)';


--drop table TODAYS_FARMER_PICK cascade constraint;;


------------------------------------------------  오늘의 농부 댓글 ----------------------------------------------------

create table TODAYS_FARMER_COMMENT (

	IDX						number(10,0)	unique
	,TODAYS_FARMER_IDX		number(8,0)
	,WRITER_IDX				number(8,0)		not null
	,CONTENT				nvarchar2(400)	not null

	,WRITTEN_TIME			timestamp (0) with local time zone not null
	,LAST_EDITED			timestamp (0) with local time zone

	,SUPER_COMMENT			number(10,0)

	,ISDEL					number(1,0) default 0 not null

	,constraint TODAYS_FARM_COMM_PK primary key (TODAYS_FARMER_IDX, IDX)
	,constraint FK_TODAYS_FARM_COMM foreign key (TODAYS_FARMER_IDX) references TODAYS_FARMER (ACC_IDX) on delete cascade
	,constraint FK_FARM_COMM_WRITER foreign key (WRITER_IDX) references ACCOUNT (IDX) on delete cascade
	,constraint FK_TODAYS_FARM_ISDEL foreign key (ISDEL) references ISDEL_TYPE (CODE)
	,constraint FK_FARM_IDX_IDX foreign key (SUPER_COMMENT) references TODAYS_FARMER_COMMENT (IDX)
);

create sequence TODAYS_FARM_COMM_SEQ start with 1 increment by 1;

create trigger TODAYS_FARM_COMM_TRG
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
--트리거 설명: 인덱스/작성시각 처리 트리거

create trigger TODAYS_FARM_COMM_EDIT_TRG
	before update of CONTENT on TODAYS_FARMER_COMMENT
	for each row
	when (NEW.LAST_EDITED is null)
begin
	:NEW.LAST_EDITED := SYSTIMESTAMP;
end;
/
--트리거 설명: 마지막 수정시각 처리 트리거


comment on table TODAYS_FARMER_COMMENT is '오늘의 농부 댓글';

comment on column TODAYS_FARMER_COMMENT.IDX is '오늘의 농부 댓글번호 - 유일성. 후보키. 복합기본키, 인조식별자';

comment on column TODAYS_FARMER_COMMENT.TODAYS_FARMER_IDX is '오늘의 농부 글번호 - 복합기본키. 외래키.';

comment on column TODAYS_FARMER_COMMENT.WRITER_IDX is '글쓴이 - 외래키 null안됨';

comment on column TODAYS_FARMER_COMMENT.CONTENT is '글내용';

comment on column TODAYS_FARMER_COMMENT.WRITTEN_TIME is '작성시각 - null안됨, 트리거있음';

comment on column TODAYS_FARMER_COMMENT.LAST_EDITED is '마지막 수정 시각 - 트리거 있음';

comment on column TODAYS_FARMER_COMMENT.SUPER_COMMENT is '상위 댓글 - 대댓글용, 안써도 작동에 문제 없음';

comment on column TODAYS_FARMER_COMMENT.ISDEL is '삭제 확인 코드 - 외래키, 기본값:0, null안됨';


--drop trigger TODAYS_FARM_COMM_TRG;
--drop sequence TODAYS_FARM_COMM_SEQ;
--drop table TODAYS_FARMER_COMMENT cascade constraints;


------------------------------------------------  공지사항 ----------------------------------------------------

create table ANNOUNCEMENT (

	IDX					number(4,0)
	,WRITER_IDX			number(8,0) not null
	,TITLE				nvarchar2(50) not null
	,CONTENT			nvarchar2(2000)
	,WRITTEN_TIME		timestamp(0) with local time zone not null
	,LAST_EDITED		timestamp(0) with local time zone

	,constraint ANNOUNCEMENT_PK primary key (IDX)
	,constraint FK_WRITER_IDX_ACC foreign key (WRITER_IDX) references ACCOUNT (IDX)
);

create sequence ANNOUNCEMENT_SEQ start with 1 increment by 1;

create trigger ANNOUNCEMENT_TRG
	before insert on ANNOUNCEMENT
	for each row
begin
	if (:NEW.IDX is null) then
		:NEW.IDX := ANNOUNCEMENT_SEQ.nextval;
	end if;
	if  (:NEW.WRITTEN_TIME is null) then
		:NEW.WRITTEN_TIME := SYSTIMESTAMP;
	end if;
end;
/
--트리거 설명: 공지사항 인덱스/작성시각 처리 트리거

create trigger ANNOUNCEMENT_EDITED_TRG
	before update of TITLE, CONTENT on ANNOUNCEMENT
	for each row
begin
	if(:NEW.LAST_EDITED is null) then
		:NEW.LAST_EDITED := SYSTIMESTAMP;
	end if;
end;
/
--트리거 설명: 최종 작성시각 처리용 (만약 내용이 길이가 부족해서 nclob로 데이터 타입을 바꾸면 트리거 처리 불가능


comment on table ANNOUNCEMENT is '공지사항';

comment on column ANNOUNCEMENT.IDX is '공지사항번호 - 기본키, 인조식별자';

comment on column ANNOUNCEMENT.WRITER_IDX is '작성자 번호 - 외래키 null안됨. 작성자 타입에 따른 규칙은 어플리케이션에서 구현';

comment on column ANNOUNCEMENT.TITLE is '제목 - null 안됨';

comment on column ANNOUNCEMENT.CONTENT is '내용';

comment on column ANNOUNCEMENT.WRITTEN_TIME is '작성시각 - null안됨 트리거있음';

comment on column ANNOUNCEMENT.LAST_EDITED is '';


--drop trigger ANNOUNCEMENT_EDITED_TRG;
--drop trigger ANNOUNCEMENT_TRG;
--drop sequence ANNOUNCEMENT_SEQ;
--drop table ANNOUNCEMENT cascade constraints;


---------------------------------------------- 메인 노출 경매 설정 ----------------------------------------------------
--몇개까지 노출할 것인지를 DB 수준에서 관리하지 않는 구조. 5개로 그냥 고정해버린다면 아예 속성 5개 짜리 1개 행 테이블로 만들어 버릴 수도 있음.

create table SITE_MAIN_AUCTION (

	AUCTION_IDX		number(10,0)
	,REG_TIME		timestamp(0) with local time zone default SYSTIMESTAMP
	
	,constraint SITE_MAIN_AUCT_PK primary key (AUCTION_IDX)
	,constraint FK_SITE_MAIN_AUCTION foreign key (AUCTION_IDX) references AUCTION (IDX)
);


comment on table SITE_MAIN_AUCTION is '메인 노출 경매 설정';

comment on column SITE_MAIN_AUCTION.AUCTION_IDX is '경매번호. 기본키 + 외래키';

comment on column SITE_MAIN_AUCTION.REG_TIME is '등록시간. 기본값 시스템시간';


--drop table SITE_MAIN_AUCTION cascade constraints;


----------------------------------------------  사이트 형상(일단 이미지만) 타입  ----------------------------------------------
-- 사이트 이미지 관리 테이블 서브타입 비즈니스 코드.
-- 일단 1번:배너 넣어둠

create table SITE_IMG_TYPE (

	CODE				number(2,0)
	,NAME				nvarchar2(50) not null
	,DESCRIPTION		nvarchar2(400)
	
	,constraint SITE_IMG_TYPE_PK primary key (CODE)
);

insert into SITE_IMG_TYPE (CODE, NAME, DESCRIPTION) values (1, '배너', '동적으로 배너 설정, 1, 배너 이미지 받기. 2, 컨텍스트 저장값 수정. 3,이 값 수정');

commit;


comment on table SITE_IMG_TYPE is '사이트 형상(이미지) 타입';

comment on column SITE_IMG_TYPE.CODE is '사이트 이미지 타입 코드. 예) 1:배너';

comment on column SITE_IMG_TYPE.NAME is '사이트 이미지 타입 이름';

comment on column SITE_IMG_TYPE.DESCRIPTION is '사이트 이미지 타입 설명';


--drop table SITE_IMG_TYPE cascade constraints;


---------------------------------------------- 사이트 형상(이미지만) 관리 ----------------------------------------------------

create table SITE_IMG_SETTING (

	IDX					number(4,0)			unique
	,TYPE_CODE			number(2,0)			not null
	,IMG_LOCATION		varchar2(200 char)	not null
	
	,constraint SITE_IMG_SET_PK primary key (TYPE_CODE, IDX)
	,constraint SITE_IMGSET_TYPE_FK foreign key (TYPE_CODE) references SITE_IMG_TYPE (CODE)
);

create sequence SITE_IMG_SEQ start with 1 increment by 1;

create trigger SITE_IMG_TRG
	before insert on SITE_IMG_SETTING
	for each row
	when (NEW.IDX is null)
begin
	:NEW.IDX := SITE_IMG_SEQ.nextval;
end;
/
--트리거 설명: 인덱스 설정 트리거


comment on table SITE_IMG_SETTING is '사이트 형상(이미지) 관리';

comment on column SITE_IMG_SETTING.IDX is '이미지 번호 - 복합기본키. 유일성.';

comment on column SITE_IMG_SETTING.TYPE_CODE is '이미지 타입 - 복합기본키. 외래키(이미지타입.코드)';

comment on column SITE_IMG_SETTING.IMG_LOCATION is '이미지 위치(경로 + 파일이름) 원래 이름은 쓸데 없을듯, UUID 사용하기';


--drop trigger SITE_IMG_TRG;
--drop sequence SITE_IMG_SEQ;
--drop table SITE_IMG_SETTING cascade constraints;

