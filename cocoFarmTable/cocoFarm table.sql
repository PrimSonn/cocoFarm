

------- ************* 코코팜 테이블 ************* -------





/*-------------------------------------------------------------

--DD 출력
select T.OWNER, T.TABLE_NAME, T.COLUMN_NAME, T.QUALIFIED_COL_NAME, C.COMMENTS, T.DATA_TYPE, T.DATA_LENGTH, T.DATA_PRECISION, T.NULLABLE, T.DATA_DEFAULT, T.CHARACTER_SET_NAME, T.CHAR_LENGTH
from all_tab_cols T inner join ALL_COL_COMMENTS C  on T.TABLE_NAME = C.TABLE_NAME and T.COLUMN_NAME=C.COLUMN_NAME where T.OWNER='COCOFARM' order by T.TABLE_NAME;


--아래 쿼리를 실행하면 코코팜 관련 테이블 정보를 모두 띄워 줍니다.
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

-------------------------------------------------------------*/



/*-------------------------------------------------------------

테이블 리스트

	PLOGGER: 경매(혹은 그 외) 프로시져 로그

	ISDEL_TYPE: 삭제상태 코드

	ISDEL_TYPE: 계정 타입 코드

	ACCOUNT_TYPEL 계정 타입 코드

	ACCOUNT_STATE_TYPE: 계정 전용 상태 코드 (삭제 등..)

	ACCOUNT: 계정

	BUSINESS_INFO_TYPE: 사업자 등록증 타입 코드

	BUSINESS_INFO: 사업자 정보

	PAYMENT_TYPE: 결제 타입

	MAIN_RECEIPT_STATE_TYPE: 주 영수증 상태 코드

	MAIN_RECEIPT: 주 영수증

	LIST_RECPT_STATE_TYPE: 목록 영수증 상태 코드

	DELIVERY_STATE_TYPE: 배송 상태 코드

	DELIVERY_TIME_WINDOW_TYPE: 배송 시작 만료 기한 타입 코드

	DELIV_RECV_T_WIN_TYPE: 수령 확인 만료 기한 타입 코드

	DELIVERY: 배송

	--BID_DEPOSIT_TYPE: 입찰 보증금 타입 코드 **취소됨**

	CATEGORY: 카테고리 (노드)

	CATEGORY_MAP: 카테고리 맵

	SALE: 판매글

	SALE_HIT: 판매글 조회수 중복 처리용 테이블

	SALE_OPTION: 판매 옵션

	SALE_OPT_CATEGORY: 옵션 - 카테고리 맵

	SALE_INQUIRE: 판매글에 대한 문의글

	CART: 장바구니

	SALE_RECEIPT: 일반 구매 묶음 영수증 (서브타입)

	SALE_OPTION_RECEIPT: 일반 구매 목록 영수증

	SALE_EVALUATION: 판매글 평가

	AUCTION_TIME_WINDOW_TYPE: 경매 만료시간 타입 코드

	AUCTION_STATE_TYPE: 경매 상태 코드

	AUCTION: 경매

	AUCTION_CATEGORY_MAP: 경매 - 카테고리 맵

	AUCTION_INQUIRE: 경매글 문의사항 덧글

	AUCTION_DUE_QUE: 경매 만료 대기열

	--BID_DEPOSITE_RECEIPT: 입찰 보증금 영수증 **취소됨**

	BID_STATE_TYPE: 입찰 상태 코드

	CONTRACT_TIME_WINDOW_TYPE: 낙찰 지불 기한 타입 코드

	BID: 입찰

	BID_ALIVE_QUE: 유효 입찰 목록

	BID_CONTRACT_QUE: 경매 낙찰 대기열

	BID_CONTRACT_RECEIPT: 낙찰금 영수증

	BID_CONTRACT: 낙찰 완료 입찰 정보

	MESSAGE_TYPE: 쪽지 타입 코드
	
	MESSAGE_STATE_TYPE: 쪽지 상태 코드

	MESSAGE: 쪽지

	TODAYS_FARMER: 오늘의 농부

	TODAYS_FARMER_PICK: 오늘의 농부 픽(관리자 선택)

	TODAYS_FARMER_COMMENT: 오늘의 농부 댓글

	NOTICE: 공지사항

	SITE_MAIN_AUCTION: 메인 노출 경매 설정

	SITE_IMG_TYPE: 사이트 이미지 타입 코드

	SITE_IMG_SETTING: 사이트 이미지
	
	DEED_RECORD_STATE_TYPE: 나쁜짓 기록의 상태 코드

	BAD_DEED_TYPE: 나쁜짓 목록 코드
	
	BAD_DEED_RECORD: 나쁜짓 기록
	
	PENALTY_TYPE: 벌 목록 코드
	
	PENALTY_RECORD: 벌 준 기록
	
-------------------------------------------------------------*/

drop procedure CHECK_TEMP_RECPT;

drop procedure CANCEL_AUCTION;

drop procedure CANCEL_BID;

drop procedure BID_DUE_CHECK;

drop procedure AUCTION_DUE_CHECK;

drop procedure BIDDER;

drop trigger PENALTY_RECORD_TRG;
drop sequence PENALTY_RECORD_SEQ;
drop table PENALTY_RECORD cascade constraints;

drop table PENALTY_TYPE cascade constraints;

drop trigger BAD_DEED_RECORD_TRG;
drop sequence BAD_DEED_RECORD_SEQ;
drop table BAD_DEED_RECORD cascade constraints;

drop table BAD_DEED_TYPE cascade constraints;

drop table DEED_RECORD_STATE_TYPE cascade constraints;

drop trigger SITE_IMG_TRG;
drop sequence SITE_IMG_SEQ;
drop table SITE_IMG_SETTING cascade constraints;

drop table SITE_IMG_TYPE cascade constraints;

drop table SITE_MAIN_AUCTION cascade constraints;

drop trigger NOTICE_EDITED_TRG;
drop trigger NOTICE_TRG;
drop sequence NOTICE_SEQ;
drop table NOTICE cascade constraints;

drop trigger TODAYS_FARM_COMM_TRG;
drop sequence TODAYS_FARM_COMM_SEQ;
drop table TODAYS_FARMER_COMMENT cascade constraints;

drop table TODAYS_FARMER_PICK cascade constraints;

drop table TODAYS_FARMER_RECOMMEND cascade constraints;

drop trigger TODAYS_FARMER_EDIT_TRG;
drop index TODAYS_FARMER_IDX;
drop table TODAYS_FARMER cascade constraints;

drop trigger MESSAGE_TRG;
drop sequence MESSAGE_SEQ;
drop index MESSAGE_SENDER_ISDEL_INDEX;
drop table MESSAGE cascade constraints;

drop table MESSAGE_STATE_TYPE cascade constraints;

drop table MESSAGE_TYPE cascade constraints;

drop trigger BID_CONTRACT_TRG;
drop table BID_CONTRACT cascade constraints;

drop trigger BID_CONTRACT_RECPT_TRG;
drop sequence BID_CONTRACT_RECPT_SEQ;
drop index BID_CONTRCT_RECPT_INDX;
drop table BID_CONTRACT_RECEIPT cascade constraints;

drop trigger BID_CONTRACT_QUE_TRG;
drop table BID_CONTRACT_QUE cascade constraints;

drop table BID_ALIVE_QUE cascade constraints;

drop trigger BID_INSERT_TRG;
drop index BID_BIDDER_STATE_INDEX;
drop table BID cascade constraints;

drop table CONTRACT_TIME_WINDOW_TYPE cascade constraints;

drop table BID_STATE_TYPE cascade constraints;

drop trigger AUCTION_DUE_QUE_TRG;
drop index AUCTION_DUE_QUE_INDEX;
drop table AUCTION_DUE_QUE cascade constraints;

drop trigger AUCT_INQ_ANS_TRG;
drop trigger AUCT_INQUIRE_TRG;
drop sequence AUCT_INQUIRE_SEQ;
drop table AUCTION_INQUIRE cascade constraints;

drop table AUCTION_CATEGORY_MAP cascade constraints;

drop trigger AUCTION_IDX_REGT_TRG;
drop sequence AUCTION_SEQ;
drop index AUCTION_STATE_ACC_IDX;
drop table AUCTION cascade constraints;

drop table AUCTION_STATE_TYPE cascade constraints;

drop table AUCTION_TIME_WINDOW_TYPE cascade constraints;

drop trigger SALE_EVAL_TRG;
drop table SALE_EVALUATION cascade constraints;

drop trigger SALE_OPT_RECPT_TRG;
drop index SALE_OPT_RECPT_INDEX;
drop table SALE_OPTION_RECEIPT cascade constraints;

drop table SALE_RECEIPT cascade constraints;

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

drop trigger MAIN_RECEIPT_TRG;
drop function MAIN_RECPT_IDX_FUNC;
drop sequence MAIN_RECEIPT_SEQ;
drop table MAIN_RECEIPT cascade constraints;

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

drop trigger BUSINESS_ACCOUNT_TRG;--deprecated
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

drop index PLOGGER_T_IDX;
drop index PLOGGER_IDX;
drop table PLOGGER;


-- 위 삭제 코드를 실행한 후, 코코팜 계정에 남아있는 테이블, 트리거, 시퀀스, 인덱스, 프로시저 등이 하나도 없어야 합니다. (이름 중복 방지)
-- 혹시 중간에 없애기로 한 테이블이 남아있는지 확인해 주세요.

--purge recyclebin;


/*=========== 뭔가 에러가 나면 아래 코드 실행해보기. 매번 할 필요는 없음 ================

ALTER SESSION SET PLSCOPE_SETTINGS = 'IDENTIFIERS:NONE';

=======================================================================================*/


/*==================================== 설명 =============================================

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

========================================================================================*/


----------- 프로시저 아웃풋 ------------

set serveroutput on;

----------------------------------------



----------------------------------------------- 프로시저 로그 -----------------------------------------------

create table PLOGGER (

	NAME			nvarchar2(400)
	,TIME			timestamp(3) default SYSTIMESTAMP
	,RESULTCODE		number(10,0)
	,CONTENT		nvarchar2(2000)
	,ERR_CODE		number
	,ERR_MESSAGE	nvarchar2(255)
	,OTHER_INFO		nvarchar2(2000)
);

create index PLOGGER_IDX on PLOGGER (NAME, RESULTCODE);
create index PLOGGER_T_IDX on PLOGGER (TIME);

comment on table PLOGGER is '프로시저 실행 로그';

comment on column PLOGGER.NAME is '실행 프로시저 이름 기록';

comment on column PLOGGER.TIME is '실행시간 기록';

comment on column PLOGGER.RESULTCODE is '실행결과 코드 (각 프로시저 설정에 따름)';

comment on column PLOGGER.CONTENT is '프로시저 실행 결과 세부 내용 저장';

comment on column PLOGGER.OTHER_INFO is '내용과 별도로 저장해야할 속성이 있을 때 사용';


--drop index PLOGGER_T_IDX;
--drop index PLOGGER_IDX;
--drop table PLOGGER;


------------------------------------------------  삭제상태 코드 ----------------------------------------------------
-- 계정 전용 삭제상태 처리 테이블. (계시판의 삭제 처리와 분리)

create table ISDEL_TYPE (

	CODE			number(1,0)
	,NAME			nvarchar2(15) not null
	,DESCRIPTION	nvarchar2(400)

	,constraint ISDEL_TYPE_PK primary key (CODE)
);

insert all
	into ISDEL_TYPE (CODE, NAME) values (0, '삭제안됨')
	into ISDEL_TYPE (CODE, NAME) values (1, '삭제됨')
select 1 from DUAL;

commit;


comment on table ISDEL_TYPE is '삭제상태 코드';

comment on column ISDEL_TYPE.CODE is '삭제상태 코드 - 기본키. 시퀀스 없음. 0: 삭제안됨, 1: 삭제됨';

comment on column ISDEL_TYPE.NAME is '상태 이름';

comment on column ISDEL_TYPE.DESCRIPTION is '상태 설명';


--drop table ISDEL_TYPE cascade constraints;


------------------------------------------------  계정 타입 코드 ----------------------------------------------------
-- 0:시스템(메세지 처리용) 1:관리자계정 2:사업자계정 3:일반계정
-- 더미데이터에 관리자 계정 하나 이상, 시스템계정 최소 1개 넣기. 무조건 넣기.

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
--계정 상태값 -1에 시스템/관리자 상태를 두었습니다.

create table ACCOUNT_STATE_TYPE (

	CODE			number(2,0)
	,THRESHOLD		number(15,0)
	,NAME			nvarchar2(20)	not null
	,DESCRIPTION	nvarchar2(400)

	,constraint ACC_STATE_TYPE_PK primary key (CODE)
);

insert all
	into ACCOUNT_STATE_TYPE (CODE, NAME, DESCRIPTION) values (-1,'시스템 전용 상태값', '시스템 전용 상태값. 로그인 불가, 선택 불가, 메세지 받는대상 불가 등등의 처리를 하기 위한 상태값')
	into ACCOUNT_STATE_TYPE (CODE, NAME, DESCRIPTION) values (0,'기본값', '살아있음')
	into ACCOUNT_STATE_TYPE (CODE, NAME, DESCRIPTION) values (1,'삭제됨', '죽었음')
select 1 from DUAL;

commit;


comment on table ACCOUNT_STATE_TYPE is '별도의 계정 상태 (페널티 등) 처리용 테이블';

comment on column ACCOUNT_STATE_TYPE.THRESHOLD is '상태 처리시 상수 처리용 속성';

comment on column ACCOUNT_STATE_TYPE.CODE is '계정 상태 타입 코드';

comment on column ACCOUNT_STATE_TYPE.NAME is '계정 상태 타입 이름';

comment on column ACCOUNT_STATE_TYPE.DESCRIPTION is '계정 상태 타입 설명';


--drop table ACCOUNT_STATE_TYPE cascade constraints;


------------------------------------------------  계정  ----------------------------------------------------
--세션 [ "idx" : IDX (INTEGER - int 아님, 널 확인 코드용), "type": TYPE (Integer), +옵션사항 "name" : NAME (String) ]

create table ACCOUNT (

	IDX					number(8,0)		unique
	,ID					nvarchar2(15)	not null unique
	,PW					nvarchar2(30)	not null
	,NAME				nvarchar2(20)	not null

	,EMAIL				nvarchar2(30)
	,PHONE				number(14,0)
	,PHONE2				number(14,0)

	,POSTNUM			nvarchar2(8)
	,ADDR				nvarchar2(50)
	,DETAILED_ADDR		nvarchar2(50)

	,ACCOUNT_TYPE		number(2,0)		not null
	,ISDEL				number(1,0)

	,THUMB_LOC			varchar2(200 char)
	,REG_DATE			timestamp (0) with local time zone	not null

	,constraint ACCOUNT_PK primary key (ISDEL, IDX)
	,constraint FK_ACC_ISDEL_TYPE foreign key (ISDEL) references ACCOUNT_STATE_TYPE (CODE)
	,constraint FK_ACCOUNT_ACCTYPE foreign key (ACCOUNT_TYPE) references ACCOUNT_TYPE (CODE)
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
	if (:NEW.ACCOUNT_TYPE is null) then
		:NEW.ACCOUNT_TYPE := 3;
	end if;
	if (:NEW.ISDEL is null) then
		:NEW.ISDEL := 0;
	end if;
end;
/
--트리거 설명: 행 추가시 IDX가 없을 때 sequence.nextval 을 자동으로 넣음, REG_DATE 가 없을 때 시스템 시간을 넣음. 계정타입 없으면 3(일반계정). ISDEL 기본값 0

insert into ACCOUNT (IDX, ID, PW, NAME, ACCOUNT_TYPE, ISDEL) values (0, 'cocoSystem', 'cocoSystem#1234', '시스템', 0, -1);
insert into ACCOUNT (ID, PW, NAME, ACCOUNT_TYPE, ISDEL) values ('cocoAdmin', 'cocoAdmin#1234', '관리자', 1, -1);
commit;
--시스템 계정 기본값 생성하는 코드입니다.. (메세지용)


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

comment on column ACCOUNT.ACCOUNT_TYPE is '계정타입 - 외래키, null 안됨(식별관계) 기본값 3(트리거, 일반계정)';

comment on column ACCOUNT.ISDEL is '상태 확인 코드 - 복합기본키+ 외래키 null 안됨 기본값:0(트리거)';

comment on column ACCOUNT.THUMB_LOC is '썸네일 위치 디렉토리+파일 이름';

comment on column ACCOUNT.REG_DATE is '계정 등록일 - null안됨, 트리거 있음';


--drop trigger ACCOUNT_TRG;
--drop sequence ACCOUNT_SEQ;
--drop table ACCOUNT cascade constraints;


------------------------------------------------  (보류: 결제 이후 처리)사업자 평점  ------------------------------------------------
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

	,REG_DATE						nvarchar2(20)

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

--create trigger BUSINESS_ACCOUNT_TRG
--	after insert on BUSINESS_INFO
--	for each row
--begin
--	update ACCOUNT set ACCOUNT_TYPE = 2 where IDX = :NEW.ACC_IDX;
--end;
--/
--트리거 설명: 사업자 등록증을 등록하면 계정타입번호 자동 전환.


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

comment on column BUSINESS_INFO.INFO_REG_DATE is '(사이트 내) 등록일 - 트리거있음';


--drop trigger BUSINESS_ACCOUNT_TRG;
--drop trigger BUSINESS_INFO_TRG;
--drop sequence BUSINESS_INFO_SEQ;
--drop table BUSINESS_INFO cascade constraints;


---------------------------------------------- 결제 타입 -----------------------------------------------------
-- 결제형태가 여러개 나올 수 있다는 가정 하에 만듬. 안쓰일듯? - 아임포트에서 여러 가지 결제를 이용하려면 유료..

create table PAYMENT_TYPE (

	CODE			number(2,0)
	,NAME			nvarchar2(20) not null
	,DESCRIPTION	nvarchar2(200)

	,constraint PAYMENT_TYPE_PK primary key (CODE)
);

insert all
	into PAYMENT_TYPE (CODE, NAME, DESCRIPTION) values (0, '모바일 결제', '구현시 쓰지 않더라도 문제가 되지 않도록 넣어두는 기본값')
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

insert into MAIN_RECEIPT_STATE_TYPE (CODE, NAME, DESCRIPTION) values (0, '지불 전', '임시 저장용 영수증');
insert into MAIN_RECEIPT_STATE_TYPE (CODE, NAME, DESCRIPTION) values (1, '지불 완료', '활성화된 영수증');
insert into MAIN_RECEIPT_STATE_TYPE (CODE, NAME, DESCRIPTION) values (2, '임시 대기중 - 취소', '임시영수증 상태에서 취소됨');

commit;


comment on table MAIN_RECEIPT_STATE_TYPE is '주 영수증 상태 타입 코드 테이블';

comment on column MAIN_RECEIPT_STATE_TYPE.CODE is '주 영수증 상태 코드';

comment on column MAIN_RECEIPT_STATE_TYPE.NAME is '주 영수증 상태 코드 이름';

comment on column MAIN_RECEIPT_STATE_TYPE.DESCRIPTION is '주 영수증 상태 코드 설명';


--drop table MAIN_RECEIPT_STATE_TYPE;


---------------------------------------------- 주 영수증 -----------------------------------------------------
-- 한번의 결제에 한번 생성. 결제행위 자체를 나타냄. 개별 결제에 여러개의 판매옵션과 입찰, 낙찰 등이 묶일 수 있음

create table MAIN_RECEIPT (

	IDX					number(30,0)	unique
	,PAYMENT_CODE		nvarchar2(45)
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

create function MAIN_RECPT_IDX_FUNC return number
is
begin
	return to_number(to_char(SYSTIMESTAMP,'YYYYMMDDHH24MISSSS')) *100000000000000 + MAIN_RECEIPT_SEQ.nextval;
end;
/

create trigger MAIN_RECEIPT_TRG
	before insert on MAIN_RECEIPT
	for each row
declare
	accName ACCOUNT.NAME%type;
begin
	if(:NEW.IDX is null) then
		:NEW.IDX := MAIN_RECPT_IDX_FUNC;
	end if;
	if(:NEW.PAYMENT_TYPE_CODE is null) then
		:NEW.PAYMENT_TYPE_CODE := 0;
	end if;
	if(:NEW.PAID_NAME is null) then
		select NAME into accName from ACCOUNT where IDX = :NEW.BUYER_IDX;
		:NEW.PAID_NAME := accName;
	end if;
	if(:NEW.STATE_CODE is null) then
		:NEW.STATE_CODE := 0;
	end if;
	:NEW.CONTRACT_TIME := SYSTIMESTAMP;
end;
/
--트리거 설명: 인덱스, 결제타입, 결제자 이름, 상태코드 없으면 삽입. 결제시간 강제입력(덮어쓰기).


comment on table MAIN_RECEIPT is '주 영수증 (한 건의 결제에 해당)';

comment on column MAIN_RECEIPT.IDX is '주 영수증 번호 - 후보키. 복합기본키, 인조식별자, 트리거있음';

comment on column MAIN_RECEIPT.PAYMENT_CODE is '결제번호 - 환불 결정 요인';

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
--drop function MAIN_RECPT_IDX_FUNC;
--drop sequence MAIN_RECEIPT_SEQ;
--drop table MAIN_RECEIPT cascade constraints;


---------------------------------------------- 목록 영수증 상태 코드 (목록 영수증: 개별적인 세부 영수증 - 옵션목록, 입찰 보증금, 낙찰금) -----------------------------------------------------
-- 구조상 주 영수증 아래 상세 내역에 해당하는 개별 영수증이 따라붙기 때문에 생기는 코드.

create table LIST_RECPT_STATE_TYPE (

	CODE			number(2,0)
	,NAME			nvarchar2(20)
	,DESCRIPTION	nvarchar2(400)

	,constraint LIST_RECPT_STATE_PK primary key (CODE)
);

insert into LIST_RECPT_STATE_TYPE (CODE, NAME, DESCRIPTION) values (0, '임시 영수증', '결제 전 임시 영수증');
insert into LIST_RECPT_STATE_TYPE (CODE, NAME, DESCRIPTION) values (1, '결제 완료', '이상 없이 결제가 완료된 영수증');
insert into LIST_RECPT_STATE_TYPE (CODE, NAME, DESCRIPTION) values (2, '임시 영수증 - 취소', '임시 영수증 상태에서 대기 하다 취소됨.');

commit;


comment on table LIST_RECPT_STATE_TYPE is '목록 영수증 에 대한 상태값';

comment on column LIST_RECPT_STATE_TYPE.CODE is '목록 영수증 상태 코드';

comment on column LIST_RECPT_STATE_TYPE.NAME is '목록 영수증 상태 코드 이름';

comment on column LIST_RECPT_STATE_TYPE.DESCRIPTION is '목록 영수증 상태 코드 설명';


--drop table LIST_RECPT_STATE_TYPE;


---------------------------------------------- (취소)목록 영수증 타입-----------------------------------------------------
---------------------------------------------- (취소) 목록 영수증 -----------------------------------------------------
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
-----------------------------------------------  배송비 타입  -------------------------------------------------------
-----------------------------------------------  배송비 영수증  -------------------------------------------------------
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


comment on table DELIV_RECV_T_WIN_TYPE is '수령 확인 만료시간 제어용 테이블(일종의 서브타입 묶음)';

comment on column DELIV_RECV_T_WIN_TYPE.CODE is '수령 확인 만료시간 비즈니스 코드 - 기본키';

comment on column DELIV_RECV_T_WIN_TYPE.TIME_WINDOW is '시간(길이) - null 안됨';

comment on column DELIV_RECV_T_WIN_TYPE.NAME is '코드 이름 - null 안됨';

comment on column DELIV_RECV_T_WIN_TYPE.DESCRIPTION is '코드 설명';


--drop table DELIV_RECV_T_WIN_TYPE cascade constraints;


-----------------------------------------------  배송  -------------------------------------------------------

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

-----------------------------------------------  거래 대금 전달 영수증  ------------------------------------------------------
-----------------------------------------------  경매 대금 전달 영수증  ------------------------------------------------------

-----------------------------------------------  (취소)입찰 보증금 타입 -------------------------------------------------------
-- 안쓰고 그냥 웹어플리케이션에서 정해진 상수값을 이용해도 됨.

/*
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
*/

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
--	,DEL_TIME		date
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
	,SALE_IDX		number(10,0)
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
	if (:NEW.LEFT_AMOUNT is null) then
		:NEW.LEFT_AMOUNT := :NEW.START_AMOUNT;
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


-----------------------------------------------  일반 구매 묶음 영수증 (서브타입)  -----------------------------------------------

create table SALE_RECEIPT (

	SALE_IDX			number(10,0)
	,MAIN_RECPT_IDX		number(30,0)

	,constraint SALE_RECPT_PK primary key (SALE_IDX, MAIN_RECPT_IDX)
	,constraint SALE_RECPT_SALE_FK foreign key (SALE_IDX) references SALE (IDX)
	,constraint SALE_RECPT_M_FK foreign key (MAIN_RECPT_IDX) references MAIN_RECEIPT (IDX)
);

comment on table SALE_RECEIPT is '일반 구매 묶음 영수증 (주 영수증 서브타입 형태)';

comment on column SALE_RECEIPT.SALE_IDX is '판매글 번호 - 복합기본키. 외래키';

comment on column SALE_RECEIPT.MAIN_RECPT_IDX is '주 영수증 번호 -  복합기본키. 외래키';


--drop table SALE_RECEIPT cascade constraints;


-----------------------------------------------  일반 구매 목록 영수증  -----------------------------------------------

create table SALE_OPTION_RECEIPT (

	MAIN_RECPT_IDX			number(30,0)
	,SALE_IDX				number(10,0)
	,SALE_OPTION_IDX		number(11,0)

	,DELIVERY_IDX			number(13,0)

	,NAME					nvarchar2(25)	not null
	,AMOUNT					number(7,0)		not null
	,UNIT					nvarchar2(20)	not null
	,PRICE					number(13,0)	not null

	,STATE_CODE				number(2,0)		not null

	,constraint SALE_OPT_RECEIPT_PK primary key (MAIN_RECPT_IDX, SALE_IDX, SALE_OPTION_IDX)
	,constraint SALE_OPT_RECPT_DLVRY_FK foreign key (DELIVERY_IDX) references DELIVERY (IDX) on delete set null
	,constraint SALEOPTRECPT_S_RECPT_FK foreign key (SALE_IDX, MAIN_RECPT_IDX) references SALE_RECEIPT (SALE_IDX, MAIN_RECPT_IDX)
	,constraint SALE_OPT_RECPT_OPT_FK foreign key (SALE_IDX, SALE_OPTION_IDX) references SALE_OPTION (SALE_IDX, IDX)
	,constraint SALE_OPT_STATE_CODE_FK foreign key (STATE_CODE) references LIST_RECPT_STATE_TYPE (CODE)
	,constraint SALE_OPT_RECPT_CHECK check (AMOUNT >0 and PRICE >0)
);

create index SALE_OPT_RECPT_INDEX on SALE_OPTION_RECEIPT (DELIVERY_IDX);

create trigger SALE_OPT_RECPT_TRG
	before insert on SALE_OPTION_RECEIPT
	for each row
declare
	saleIdx SALE.IDX%type;
begin
	if (:NEW.SALE_IDX is null) then
		select SALE_IDX into saleIdx from SALE_OPTION where IDX = :NEW.SALE_OPTION_IDX;
		:NEW.SALE_IDX := saleIdx;
	end if;
	if (:NEW.STATE_CODE is null) then
		:NEW.STATE_CODE := 0;
	end if;
end;
/


comment on table SALE_OPTION_RECEIPT is '판매 옵션 목록 영수증';

comment on column SALE_OPTION_RECEIPT.MAIN_RECPT_IDX is '주 영수증 번호 - 복합기본키. 옵션 묶음 영수증 외래키';

comment on column SALE_OPTION_RECEIPT.SALE_IDX is '판매글 번호 - 복합기본키. 옵션 묶음 영수증 외래키';

comment on column SALE_OPTION_RECEIPT.SALE_OPTION_IDX is '판매 옵션 번호 - 복합기본키. 외래키, 트리거 있음';

comment on column SALE_OPTION_RECEIPT.DELIVERY_IDX is '배송 번호 - 외래키, null가능';

comment on column SALE_OPTION_RECEIPT.NAME is '판매 옵션 이름 - null불가. 복제값 저장용.';

comment on column SALE_OPTION_RECEIPT.AMOUNT is '판매 옵션 구매 수 - null불가';

comment on column SALE_OPTION_RECEIPT.UNIT is '판매 옵션 단위 - null불가. 복제값 저장용.';

comment on column SALE_OPTION_RECEIPT.PRICE is '옵션 개별 가격 - null불가. 복제값 저장용';

comment on column SALE_OPTION_RECEIPT.STATE_CODE is '목록 영수증 상태 코드 - 외래키 (트리거 기본값 있음)';


--drop trigger SALE_OPT_RECPT_TRG;
--drop index SALE_OPT_RECPT_INDEX;
--drop table SALE_OPTION_RECEIPT cascade constraints;


-----------------------------------------------  일반 구매: 배송대상  -----------------------------------------------
-- 영수증과 통합.

-----------------------------------------------  일반 구매: 판매 평가  -----------------------------------------------

create table SALE_EVALUATION (

	SALE_IDX				number(10,0)
	,MAIN_RECPT_IDX			number(30,0)

	,SCORE					number(3,0)		not null
	,TITLE					nvarchar2(40)	not null
	,CONTENT				nvarchar2(400)
	,REG_TIME				date			not null
	,LAST_EDITED			date
	,ISDEL					number(1,0)		not null

	,constraint SALE_EVAL_PK primary key (SALE_IDX, MAIN_RECPT_IDX)
	,constraint SALE_EVAL_RECPT_IDX foreign key (SALE_IDX, MAIN_RECPT_IDX) references SALE_RECEIPT (SALE_IDX, MAIN_RECPT_IDX) on delete cascade
	,constraint SALE_EVAL_CHECK check (SCORE <=100 and SCORE >= 0)
);

create trigger SALE_EVAL_TRG
	before insert or update of SCORE, TITLE, CONTENT on SALE_EVALUATION
	for each row 
	when (NEW.REG_TIME is null)
begin
	if inserting then
		:NEW.REG_TIME := SYSDATE;
		if (:NEW.ISDEL is null) then
			:NEW.ISDEL := 0;
		end if;
	end if;
	if updating then
		:NEW.LAST_EDITED := SYSDATE;
	end if;
end;
/
--트리거 설명: 처음 등록시 등록시각 자동 등록, 삭제상태 코드 자동기입 , 이후 수정시 수정시각 자동 등록


comment on table SALE_EVALUATION is '판매글 평가';

comment on column SALE_EVALUATION.SALE_IDX is '판매글 번호 - 복합 외래키(판매 영수증)';

comment on column SALE_EVALUATION.MAIN_RECPT_IDX is '주 영수증 번호 - 복합 외래키(판매 영수증)';

comment on column SALE_EVALUATION.SCORE is '점수 - 0이상 100이하 정수. null불가';

comment on column SALE_EVALUATION.TITLE is '제목 - null불가';

comment on column SALE_EVALUATION.CONTENT is '내용 - null가능';

comment on column SALE_EVALUATION.REG_TIME is '등록시각 - 트리거있음(시스템시간) null불가';

comment on column SALE_EVALUATION.LAST_EDITED is '최종 수정 시각 - 트리거있음(시스템시간) null가능';

comment on column SALE_EVALUATION.ISDEL is '삭제상태 코드 - 외래키. null불가. 트리거있음 (기본값0)';

--이미지도 추가할 거면 속성/테이블 추가하기..


--drop trigger SALE_EVAL_DEL_TRG;
--drop trigger SALE_EVAL_TRG;
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
	into AUCTION_TIME_WINDOW_TYPE (CODE, TIME_WINDOW, NAME, DESCRIPTION) values (4, numtodsinterval( 2,'MINUTE'), '2분 경매','테스트용 2분 경매')
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

/*

 상태값:
		1. 진행중
		2. 진행중 취소됨 (끝)
		3. 낙찰 시작  --안씀
		4. 만료: 유효입찰 없음 (끝)
		5. 낙찰 완료 대기중 (입찰금 지불 대기중)
		6. 만료 후 최고입찰이 취소/만료됨
		7. 만료: 모든 입찰자의 거래 거부
		8. 낙찰 중 경매인의 경매 취소
		9. 낙찰 완료

*/



create table AUCTION_STATE_TYPE (

	CODE			number(2,0)
	,NAME			nvarchar2(30)	not null
	,DESCRIPTION	nvarchar2(400)
	
	,constraint AUCTION_STATE_TYPE_PK primary key (CODE)
);

insert all
	into AUCTION_STATE_TYPE (CODE, NAME, DESCRIPTION) values (1,'진행중','')
	into AUCTION_STATE_TYPE (CODE, NAME, DESCRIPTION) values (2,'진행중 취소됨','')
--	into AUCTION_STATE_TYPE (CODE, NAME, DESCRIPTION) values (3,'낙찰 시작','낙찰 절차 프로시저 중간 단계 처리용')
	into AUCTION_STATE_TYPE (CODE, NAME, DESCRIPTION) values (4,'만료: 유효입찰 없음','')
	into AUCTION_STATE_TYPE (CODE, NAME, DESCRIPTION) values (5,'낙찰 완료 대기중','')
	into AUCTION_STATE_TYPE (CODE, NAME, DESCRIPTION) values (6,'만료 후 최고입찰이 취소/만료됨','')
	into AUCTION_STATE_TYPE (CODE, NAME, DESCRIPTION) values (7,'만료: 모든 입찰자의 거래 거부','')
	into AUCTION_STATE_TYPE (CODE, NAME, DESCRIPTION) values (8,'낙찰 중 경매인의 경매 취소','')
	into AUCTION_STATE_TYPE (CODE, NAME, DESCRIPTION) values (9,'낙찰 완료','')
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
	
	,CLOSED_WHEN			timestamp(3) with local time zone
	,FINISHED_WHEN			timestamp(3) with local time zone

	,HIGHEST_BID			number(11,0)		not null

	,constraint AUCTION_PK primary key (IDX)
	,constraint AUCTION_WRITTER_FK foreign key (WRITTER_IDX) references ACCOUNT (IDX) on delete cascade
	,constraint AUCTION_T_W_TYPE_FK	foreign key (TIME_WINDOW_CODE) references AUCTION_TIME_WINDOW_TYPE (CODE)
	,constraint AUCTION_STATE_FK foreign key (STATE_CODE) references AUCTION_STATE_TYPE (CODE)
	,constraint AUCTION_PRICE_CHECK check (START_PRICE >0)
);

create index AUCTION_STATE_ACC_IDX on AUCTION (STATE_CODE, WRITTER_IDX);

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
	if (:NEW.HIGHEST_BID is null) then
		:NEW.HIGHEST_BID := :NEW.START_PRICE;
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

comment on column AUCTION.CLOSED_WHEN is '경매 입찰 진행이 종료된 시각';

comment on column AUCTION.FINISHED_WHEN is '경매의 생명주기가 끝난 시각 (취소/대금지불/입찰거부 등)';

comment on column AUCTION.HIGHEST_BID is '현재 최고 입찰액 - null불가 기본값(시작가) 트리거. 일종의 중복값, 병행 처리를 쉽게 하기 위해 넣은 속성: 경매 행을 lock 한 상태에서 입찰이 이루어짐';


--drop trigger AUCTION_IDX_REGT_TRG;
--drop sequence AUCTION_SEQ;
--drop index AUCTION_STATE_ACC_IDX;
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

-----------------------------------------------  경매 문의사항 -------------------------------------------------------

create table AUCTION_INQUIRE(

	IDX				number(11,0)
	,AUCTION_IDX	number(10,0)	not null
	,WRITER_IDX		number(8,0)		not null

	,CONTENT		nvarchar2(2000) not null
	,WRITTEN_TIME	timestamp (0) with local time zone not null

	,ANSWER			nvarchar2(2000)
	,ANSWER_TIME	timestamp (0) with local time zone

	,ISDEL			number(1,0)		not null
	
	,constraint AUCTION_INQUIRE_PK primary key (IDX)
	,constraint FK_AUCT_INQUIRE_AUCT_IDX foreign key (AUCTION_IDX) references AUCTION (IDX) on delete cascade
	,constraint FK_AUCT_INQUIRE_ACC_IDX foreign key (WRITER_IDX) references ACCOUNT (IDX) on delete cascade
	,constraint FK_AUCT_INQUIRE_ISDEL foreign key (ISDEL) references ISDEL_TYPE (CODE)
);

create sequence AUCT_INQUIRE_SEQ start with 1 increment by 1;

create trigger AUCT_INQUIRE_TRG
	before insert on AUCTION_INQUIRE
	for each row
begin
	if (:NEW.IDX is null) then
		:NEW.IDX := AUCT_INQUIRE_SEQ.nextval;
	end if;
	if (:NEW.WRITTEN_TIME is null) then
		:NEW.WRITTEN_TIME := SYSTIMESTAMP;
	end if;
	if (:NEW.ISDEL is null) then
		:NEW.ISDEL := 0;
	end if;
end;
/

create trigger AUCT_INQ_ANS_TRG
	before update of ANSWER on AUCTION_INQUIRE
	for each row
begin
	if (:NEW.ANSWER_TIME is null) then
		:NEW.ANSWER_TIME := SYSTIMESTAMP;
	end if;
end;
/	


comment on table AUCTION_INQUIRE is '경매 문의사항';

comment on column AUCTION_INQUIRE.IDX is '경매 문의글 번호 - 기본키, 인조식별자 트리거있음';

comment on column AUCTION_INQUIRE.AUCTION_IDX is '경매글 번호 - null불가. 외래키';

comment on column AUCTION_INQUIRE.WRITER_IDX is '문의 계정 번호 - null불가. 외래키';

comment on column AUCTION_INQUIRE.CONTENT is '문의내용 - null불가';

comment on column AUCTION_INQUIRE.WRITTEN_TIME is '문의글 작성시각 - null불가, 트리거있음(기본값 시스템시간처리)';

comment on column AUCTION_INQUIRE.ANSWER is '문의글에 대한 답변 - null가능.';

comment on column AUCTION_INQUIRE.ANSWER_TIME is '문의글 답변 시각 - null가능, 트리거있음 (답변 작성시 자동으로 시간 기입)';

comment on column AUCTION_INQUIRE.ISDEL is '삭제 혹은 이외의(블라인드 따위) 글 상태 - 외래키 null불가 트리거있음 (기본값 0)';


--drop trigger AUCT_INQ_ANS_TRG;
--drop trigger AUCT_INQUIRE_TRG;
--drop sequence AUCT_INQUIRE_SEQ;
--drop table AUCTION_INQUIRE cascade constraints;


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


----------------------------------------------- (취소)입찰 보증금 영수증 --------------------------------------------------------
-- 입찰 정보의 변화나 처리에 무관하게 존재해야 하기 때문에 영수증을 입찰에서 분리. 입찰 보증금 영수증 -> 입찰 발생
-- 목록 영수증들을 통합하려다 어차피 복잡하기는 매한가지라 그냥 나뉜채로 둠.
/*
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
*/

-----------------------------------------------  입찰 상태 타입 -------------------------------------------------------

/*

 상태값:
		1. 경매진행중: 최고입찰
		2. 경매진행중: 차등위 입찰
		10. 경매 진행중 입찰 취소: 최고 입찰
		11. 경매 진행중 입찰 취소: 차등위 입찰
		12. 자기 상위입찰 됨. - 취소
		13. 낙찰금 지불기한 만료. - 취소
		14. 경매 만료 이후 입찰 취소: 최고입찰
		15. 경매 만료 이후 입찰 취소: 차등위 입찰
		20. 경매가 취소됨: 진행 중
		21. 경매가 취소됨: 만료 후
		30. 낙찰됨
		31. 낙찰 실패

*/

create table BID_STATE_TYPE (

	CODE				number(2,0)
	,NAME				nvarchar2(30)	not null
	,DESCRIPTION		nvarchar2(400)

	,constraint BID_STATE_TYPE_PK primary key (CODE)
);

insert all
	into BID_STATE_TYPE (CODE, NAME, DESCRIPTION) values (1,'경매진행중: 최고입찰','입찰중. 최고입찰.처음 들어오는 입찰은 무조건 최고입찰이어야 함.')
	into BID_STATE_TYPE (CODE, NAME, DESCRIPTION) values (2,'경매진행중: 차등위 입찰','입찰중. 최고입찰이 아님.')
	into BID_STATE_TYPE (CODE, NAME, DESCRIPTION) values (10,'경매 진행중 입찰 취소: 최고 입찰', '경매 진행시간이 만료되기 전 취소를 신청하여 입찰이 취소됨')
	into BID_STATE_TYPE (CODE, NAME, DESCRIPTION) values (11,'경매 진행중 입찰 취소: 차등위 입찰', '경매 진행시간이 만료되기 전 취소를 신청하여 입찰이 취소됨')
	into BID_STATE_TYPE (CODE, NAME, DESCRIPTION) values (12,'자기 상위입찰 됨. - 취소', '자기 입찰에 상위입찰을 하여 이전 입찰이 취소됨')
	into BID_STATE_TYPE (CODE, NAME, DESCRIPTION) values (13,'낙찰금 지불기한 만료. - 취소', '최고입찰로서 낙찰이 되었으나, 대금 지불 기한 안에 낙찰금을 지불하지 않음')
	into BID_STATE_TYPE (CODE, NAME, DESCRIPTION) values (14,'경매 만료 이후 입찰 취소: 최고입찰', '최고입찰로서 낙찰이 되었으나, 대금 지불 기한 안에 취소함')
	into BID_STATE_TYPE (CODE, NAME, DESCRIPTION) values (15,'경매 만료 이후 입찰 취소: 차등위 입찰', '경매 만료 후 차등위 입찰 상태에서 입찰을 취소함.')
	into BID_STATE_TYPE (CODE, NAME, DESCRIPTION) values (20,'경매가 취소됨: 진행 중', '대상 경매가 만료되기 전에 일방적으로 취소됨')
	into BID_STATE_TYPE (CODE, NAME, DESCRIPTION) values (21,'경매가 취소됨: 만료 후', '대상 경매가 만료된 후에 일방적으로 취소됨')
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
--	,THRESHOLD			number(13,0)

	,NAME				nvarchar2(15)	not null
	,DESCRIPTION		nvarchar2(400)

	,constraint CONTRACT_T_W_TYPE_PK primary key (CODE)
);

insert all
	into CONTRACT_TIME_WINDOW_TYPE (CODE, TIME_WINDOW, NAME, DESCRIPTION) values (1, numtodsinterval( 03, 'DAY') ,'3일 낙찰금 지불기한', '3일짜리 낙찰금 지불기한')
	into CONTRACT_TIME_WINDOW_TYPE (CODE, TIME_WINDOW, NAME, DESCRIPTION) values (2, numtodsinterval( 04, 'DAY') ,'4일 낙찰금 지불기한', '4일짜리 낙찰금 지불기한')
	into CONTRACT_TIME_WINDOW_TYPE (CODE, TIME_WINDOW, NAME, DESCRIPTION) values (3, numtodsinterval( 05, 'DAY') ,'5일 낙찰금 지불기한', '5일짜리 낙찰금 지불기한')
	into CONTRACT_TIME_WINDOW_TYPE (CODE, TIME_WINDOW, NAME, DESCRIPTION) values (4, numtodsinterval( 02, 'MINUTE') ,'1분 낙찰금 지불기한', '2분짜리 낙찰금 지불기한')
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

--	,DEPOSITE_RECPT_IDX		number(13,0)	not null
	,BID_TIME				timestamp(3) with local time zone not null

	,BIDDER_IDX				number(8,0)		not null
--	,DEPOSIT_RATIO_CODE		number(2,0)		not null

	,STATE_CODE				number(2,0)		not null
	,FINISHED_WHEN			timestamp(3) with local time zone

	,constraint BID_PK primary key (AUCTION_IDX, AMOUNT)
--	,constraint BID_RECPT_FK foreign key (DEPOSITE_RECPT_IDX) references BID_DEPOSITE_RECEIPT (IDX) on delete cascade
	,constraint BID_AUCTION_FK foreign key (AUCTION_IDX) references AUCTION (IDX) on delete cascade
	,constraint BID_ACC_IDX_FK foreign key (BIDDER_IDX) references ACCOUNT (IDX) on delete cascade
--	,constraint BID_DEPO_RETIO_FK foreign key (DEPOSIT_RATIO_CODE) references BID_DEPOSIT_TYPE (CODE)
	,constraint BID_STATE_TYPE_FK foreign key (STATE_CODE) references BID_STATE_TYPE (CODE)
	,constraint BID_AMOUNT_CHECK check (AMOUNT >0)
);

create index BID_BIDDER_STATE_INDEX on BID (STATE_CODE, BIDDER_IDX);

--create sequence BID_SEQ start with 1 increment by 1;

create trigger BID_INSERT_TRG
	before insert on BID
	for each row
begin
--	if(:NEW.IDX is null) then
--		:NEW.IDX := BID_SEQ.nextval;
--	end if;
--	if(:NEW.DEPOSIT_RATIO_CODE is null) then
--		:NEW.DEPOSIT_RATIO_CODE :=1;
--	end if;
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

--comment on column BID.DEPOSITE_RECPT_IDX is '주 영수증 번호 - 외래키(보증금 영수증) null불가';

comment on column BID.BID_TIME is '입찰 시각 - null불가. 트리거 있음: 새 입찰 등록시, 시스템 시각 지정';

comment on column BID.BIDDER_IDX is '입찰자 계정번호 - 외래키 (계정) null불가';

--comment on column BID.DEPOSIT_RATIO_CODE is '보증금 비율 코드 - 외래키, 트리거 있음(기본값 1)';

comment on column BID.STATE_CODE is '입찰 상태 코드 - 외래키. 트리거 있음 (기본값 1) null불가';

comment on column BID.FINISHED_WHEN is '입찰 종료 시각 (지불기간 만료/취소/대금지불 등)';


--drop trigger BID_INSERT_TRG;
--drop sequence BID_SEQ;
--drop index BID_BIDDER_STATE_INDEX;
--drop table BID cascade constraints;


-----------------------------------------------  경매 입찰 대기열  -------------------------------------------------------

create table BID_ALIVE_QUE (

	AUCTION_IDX				number(10,0)
	,BID_AMOUNT				number(11,0)
	,BIDDER_IDX				number(8,0)		not null

	,constraint BID_ALIVE_Q_PK primary key (AUCTION_IDX, BID_AMOUNT)
	,constraint BID_ALIVE_BID_FK foreign key (AUCTION_IDX, BID_AMOUNT) references BID (AUCTION_IDX, AMOUNT) on delete cascade
	,constraint BID_ALIVE_Q_ACC_FK foreign key (BIDDER_IDX) references ACCOUNT (IDX) on delete cascade
);


comment on table BID_ALIVE_QUE is '경매 낙찰 대기열 (유효입찰 나열)';

comment on column BID_ALIVE_QUE.AUCTION_IDX is '경매번호 - 복합기본키 + 복합외래키';

comment on column BID_ALIVE_QUE.BID_AMOUNT is '입찰액 - 복합기본키 + 복합외래키';

comment on column BID_ALIVE_QUE.BIDDER_IDX is '입찰인 - 외래키 not null';


--drop table BID_ALIVE_QUE cascade constraints;


-----------------------------------------------  경매 낙찰 대기열  -------------------------------------------------------
-- 처리의 용이성을 위한 중복 테이블. (낙찰금 지불 만료 기한 처리)
-- 낙찰 처리를 하기 위해 낙찰 대기중인 경매(최고입찰)만 모아둔 테이블. (낙찰을 대기중인 경매와 대상 입찰 정보 + 만료시간)
-- 경매 후보키: AUCTION_IDX
-- 입찰 후보키: AUCTION_IDX, BID_AMOUNT.

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
--트리거 설명: 만료기한 타입이 없으면 기본값 1, 만료기한을 계산해서 넣음.


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

	,DELIVERY_IDX			number(13,0)

	,AUCTION_IDX			number(11,0)
	,BID_AMOUNT				number(11,0)

	,MAIN_RECPT_BUYER		number(8,0)			not null
	,MAIN_RECPT_IDX			number(30,0)		not null
	,CONTRACT_AMOUNT		number(10,0)		not null
	
	,TITLE					nvarchar2(40)		not null

	,STATE_CODE				number(2,0)			not null

	,REFUND_TARGET_IDX		number(13,0)

	,constraint BID_CONTRCT_RECPT_PK primary key (IDX) 
	,constraint BID_CONT_RECPT_DELVRY foreign key (DELIVERY_IDX) references DELIVERY (IDX) on delete set null
	,constraint BID_CONTRCT_M_RECPT_FK foreign key (MAIN_RECPT_BUYER, MAIN_RECPT_IDX) references MAIN_RECEIPT (BUYER_IDX, IDX)
	,constraint BID_CONT_RECPT_BID_FK foreign key (AUCTION_IDX, BID_AMOUNT) references BID (AUCTION_IDX, AMOUNT) on delete set null
	,constraint BID_CONT_RECPT_STATE_FK foreign key (STATE_CODE) references LIST_RECPT_STATE_TYPE (CODE)
	,constraint CONT_REFUND_FK foreign key (REFUND_TARGET_IDX) references BID_CONTRACT_RECEIPT (IDX)
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

comment on column BID_CONTRACT_RECEIPT.DELIVERY_IDX is '배송 번호 - 외래키 , null가능';

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
insert into MESSAGE_TYPE (CODE, NAME, DESCRIPTION) values (1, '경매 시스템 메세지', '경매 시스템 메세지 타입');
insert into MESSAGE_TYPE (CODE, NAME, DESCRIPTION) values (2, '판매 시스템 메세지', '판매 시스템 메세지 타입');

commit;


comment on table MESSAGE_TYPE is '쪽지 타입 비즈니스 코드 테이블';

comment on column MESSAGE_TYPE.CODE is '쪽지 타입 코드 - 기본키 시퀀스없음';

comment on column MESSAGE_TYPE.NAME is '쪽지 타입 이름 - null 안됨';

comment on column MESSAGE_TYPE.DESCRIPTION is '쪽지 타입 설명';


--drop table MESSAGE_TYPE cascade constraints;


------------------------------------------------  쪽지 상태 타입 -------------------------------------------------

create table MESSAGE_STATE_TYPE (

	CODE			number(2,0)
	,NAME			nvarchar2(30)	not null
	,DESCRIPTION	nvarchar2(400)

	,constraint MESSAGE_STATE_TYPE_PK primary key (CODE)
);

insert all
	into MESSAGE_STATE_TYPE (CODE, NAME, DESCRIPTION) values (0,'삭제안됨','아주 삭제가 안된 상태')
	into MESSAGE_STATE_TYPE (CODE, NAME, DESCRIPTION) values (1,'완전삭제','양 쪽에서 모두 삭제한 상태')
	into MESSAGE_STATE_TYPE (CODE, NAME, DESCRIPTION) values (2,'보낸쪽지 삭제','보낸 계정이 삭제한 상태')
	into MESSAGE_STATE_TYPE (CODE, NAME, DESCRIPTION) values (3,'받은쪽지 삭제','받은 계정이 삭제한 상태')
select 1 from DUAL;

commit;

comment on table MESSAGE_STATE_TYPE is '쪽지 상태 타입';

comment on column MESSAGE_STATE_TYPE.CODE is '쪽지 상태 번호 - 기본키';

comment on column MESSAGE_STATE_TYPE.NAME is '쪽지 상태 이름 - null불가';

comment on column MESSAGE_STATE_TYPE.DESCRIPTION is '쪽지 상태 설명';


--drop table MESSAGE_STATE_TYPE cascade constraints;


------------------------------------------------  쪽지  ----------------------------------------------------

create table MESSAGE (

	IDX					number(12,0)		unique
	,SENDER_IDX			number(8,0)			not null
	,RECEIVER_IDX		number(8,0)			not null

	,TITLE				nvarchar2(200)		not null
	,CONTENT			nvarchar2(1000)
	,WRITTEN_TIME		timestamp(0) with local time zone not null

	,IS_READ			number(1,0)			not null
	,READ_TIME			timestamp(0) with local time zone

	,TYPE_CODE			number(2,0)			not null

	,ISDEL				number(1,0)

	,constraint MESSAGE_PK primary key (ISDEL, IDX)
	,constraint FK_MESSAGE_SENDER_ACCIDX foreign key (SENDER_IDX) references ACCOUNT (IDX) on delete cascade
	,constraint FK_MESSAGE_RECEIVER_ACCIDX foreign key (RECEIVER_IDX) references ACCOUNT (IDX) on delete cascade
	,constraint FK_MESSAGE_MSGTYPE foreign key (TYPE_CODE) references MESSAGE_TYPE (CODE)
	,constraint FK_MESSAGE_STATE foreign key (ISDEL) references MESSAGE_STATE_TYPE (CODE)
);

create index MESSAGE_SENDER_ISDEL_INDEX on MESSAGE (RECEIVER_IDX, SENDER_IDX);

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
	if (:NEW.IS_READ is null) then
		:NEW.IS_READ := 0;
	end if;
	if (:NEW.TYPE_CODE is null) then
		:NEW.TYPE_CODE := 0;
	end if;
	if (:NEW.ISDEL is null) then
		:NEW.ISDEL := 0;
	end if;
end;
/
--트리거 설명: 인덱스 없으면 시퀀스 넣어줌, 작성시각 없으면 시스템 시각 넣어줌, 상태값을 읽지않음 상태로 넣어줌, 쪽지타입 기본값 0 넣어줌


comment on table MESSAGE is '쪽지';

comment on column MESSAGE.IDX is '쪽지번호 - 후보키. 복합기본키, 인조식별자';

comment on column MESSAGE.SENDER_IDX is '보낸사람 - 외래키 (계정.계정번호) null안됨';

comment on column MESSAGE.RECEIVER_IDX is '받는사람 - 외래키 (계정.계정번호) null안됨';

comment on column MESSAGE.TITLE is '제목 - null 안됨';

comment on column MESSAGE.CONTENT is '내용';

comment on column MESSAGE.WRITTEN_TIME is '작성시각 - null안됨 트리거 있음';

comment on column MESSAGE.IS_READ is '조회 여부 표시. 1:읽음, 0:안읽음, (트리거)기본값:0';

comment on column MESSAGE.READ_TIME is '읽은 시각 기록 - 조회여부 확인용.';

comment on column MESSAGE.TYPE_CODE is '메세지 타입 - (트리거)기본값 0. null불가. 일단은 시스템 알림이나 관리자 문의사항 조회를 쉽게 하기 위한 부분인데, 더 세분화 해서 기능을 확장할 수 있는 부분(추가 테이블이 필요할 수도 있음). 예시) 중요 메세지 표시';

comment on column MESSAGE.ISDEL is '삭제 확인 코드 - 복합기본키. 외래키, (트리거)기본값:0';


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

	,WRITTEN_DATE	date default SYSDATE not null
	
	,HIT			number(9,0) default 0
	,LAST_EDITED	timestamp (0) with local time zone

	,MAIN_IMG		varchar2(200 char)
	
	,ISDEL			number(1,0) default 0 not null

	,constraint TODAYS_FARMER_PK primary key (ACC_IDX)
	,constraint FK_TODAYS_FARMER_ACC foreign key (ACC_IDX) references ACCOUNT (IDX) on delete cascade
	,constraint TODAYS_FARM_VCOUNT_CHECK check (HIT >=0)
	,constraint FK_TODAYS_FARMER_ISDEL foreign key (ISDEL) references ISDEL_TYPE (CODE)
);

create index TODAYS_FARMER_IDX on TODAYS_FARMER (WRITTEN_DATE desc);

create trigger TODAYS_FARMER_EDIT_TRG
	before update of TITLE, CONTENT, MAIN_IMG  on TODAYS_FARMER
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

comment on column TODAYS_FARMER.WRITTEN_DATE is '작성 시각 - null 안됨, 기본값: 시스템 시각';

comment on column TODAYS_FARMER.HIT is '조회수';

comment on column TODAYS_FARMER.LAST_EDITED is '마지막 수정시각 - 트리거 없음. 글내용의 data type 이 clob 라서 update 관련 트리거가 안됨';

--comment on column TODAYS_FARMER.RECOMMEND is '추천? 점수? 보류중';

comment on column TODAYS_FARMER.MAIN_IMG is '주 이미지 위치(경로+파일이름 전부) 저장. 원래이름은 필요 없음, 아마도.';

comment on column TODAYS_FARMER.ISDEL is '삭제 확인 코드(블라인드) - 외래키, 기본값:0, null안됨. 삭제요청시 삭제코드만 바꾸면 나중에 다시 글을 쓸 수 없음!!(기본키 유일) 관리자가 블라인드 처리 하는 용으로만 사용!';


--drop trigger TODAYS_FARMER_EDIT_TRG;
--drop index TODAYS_FARMER_IDX;
--drop table TODAYS_FARMER cascade constraints;


------------------------------------------------  오늘의 농부 추천  ----------------------------------------------------

create table TODAYS_FARMER_RECOMMEND (

	RECOMMEND_ACC			number(8,0)
	,TODAYS_FARMER_IDX		number(8,0)
	
	,constraint TODAYS_FARM_RECOMM_PK primary key (RECOMMEND_ACC, TODAYS_FARMER_IDX)
	,constraint FK_TODAYS_FARM_REC_ACC foreign key (RECOMMEND_ACC) references ACCOUNT (IDX) on delete cascade
	,constraint FK_TODAYS_FARM_RECOMM foreign key (TODAYS_FARMER_IDX) references TODAYS_FARMER (ACC_IDX) on delete cascade
);


comment on table TODAYS_FARMER_RECOMMEND is '오늘의 농부 추천';

comment on column TODAYS_FARMER_RECOMMEND.RECOMMEND_ACC is '추천인 계정번호 - 외래키, 복합기본키';

comment on column TODAYS_FARMER_RECOMMEND.TODAYS_FARMER_IDX is '오늘의 농부 글번호 - 외래키, 복합기본키';


--drop table TODAYS_FARMER_RECOMMEND cascade constraints;


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

	,WRITTEN_TIME			date not null
	,LAST_EDITED			date

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
		then :NEW.WRITTEN_TIME := SYSDATE;
	end if;
end;
/
--트리거 설명: 인덱스/작성시각 처리 트리거

create trigger TODAYS_FARM_COMM_EDIT_TRG
	before update of CONTENT on TODAYS_FARMER_COMMENT
	for each row
	when (NEW.LAST_EDITED is null)
begin
	:NEW.LAST_EDITED := SYSDATE;
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

create table NOTICE (

	IDX					number(4,0)
	,WRITER_IDX			number(8,0) not null
	,TITLE				nvarchar2(50) not null
	,CONTENT			nvarchar2(2000)
	,WRITTEN_DATE		date not null
	,LAST_EDITED		date

	,constraint NOTICE_PK primary key (IDX)
	,constraint FK_WRITER_IDX_ACC foreign key (WRITER_IDX) references ACCOUNT (IDX)
);

create sequence NOTICE_SEQ start with 1 increment by 1;

create trigger NOTICE_TRG
	before insert on NOTICE
	for each row
begin
	if (:NEW.IDX is null) then
		:NEW.IDX := NOTICE_SEQ.nextval;
	end if;
	if  (:NEW.WRITTEN_DATE is null) then
		:NEW.WRITTEN_DATE := SYSDATE;
	end if;
end;
/
--트리거 설명: 공지사항 인덱스/작성시각 처리 트리거

create trigger NOTICE_EDITED_TRG
	before update of TITLE, CONTENT on NOTICE
	for each row
begin
	if(:NEW.LAST_EDITED is null) then
		:NEW.LAST_EDITED := SYSDATE;
	end if;
end;
/
--트리거 설명: 최종 작성시각 처리용 (만약 내용이 길이가 부족해서 nclob로 데이터 타입을 바꾸면 트리거 처리 불가능


comment on table NOTICE is '공지사항';

comment on column NOTICE.IDX is '공지사항번호 - 기본키, 인조식별자';

comment on column NOTICE.WRITER_IDX is '작성자 번호 - 외래키 null안됨. 작성자 타입에 따른 규칙은 어플리케이션에서 구현';

comment on column NOTICE.TITLE is '제목 - null 안됨';

comment on column NOTICE.CONTENT is '내용';

comment on column NOTICE.WRITTEN_DATE is '작성시각 - null안됨 트리거있음';

comment on column NOTICE.LAST_EDITED is '';


--drop trigger NOTICE_EDITED_TRG;
--drop trigger NOTICE_TRG;
--drop sequence NOTICE_SEQ;
--drop table NOTICE cascade constraints;


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


----------------------------------------------- 나쁜짓 기록 상태 -----------------------------------------------

create table DEED_RECORD_STATE_TYPE (

	CODE			number(1,0)
	,THRESHOLD		number(15,0)
	,NAME			nvarchar2(15) not null
	,DESCRIPTION	nvarchar2(400)
	,ADJUSTMENT		number(15,0)
	
	,constraint PK_DEED_RECORD_S_CD primary key (CODE)
);

insert all
	into DEED_RECORD_STATE_TYPE (CODE, NAME, DESCRIPTION) values (0, '활성', '기본값, 유효함')
	into DEED_RECORD_STATE_TYPE (CODE, NAME, DESCRIPTION) values (1, '비활성', '무효가 됨')
select 1 from DUAL;

commit;


comment on table DEED_RECORD_STATE_TYPE is '나쁜짓 기록 상태';

comment on column DEED_RECORD_STATE_TYPE.CODE is '나쁜짓 기록 상태 코드 - 기본키';

comment on column DEED_RECORD_STATE_TYPE.THRESHOLD is '나쁜짓 기록 상태 기준치';

comment on column DEED_RECORD_STATE_TYPE.NAME is '나쁜짓 기록 상태 코드 이름 - null 불가';

comment on column DEED_RECORD_STATE_TYPE.DESCRIPTION is '나쁜짓 기록 상태 코드 설명';

comment on column DEED_RECORD_STATE_TYPE.ADJUSTMENT is '나쁜짓 기록 상태 조정치';


--drop table DEED_RECORD_STATE_TYPE cascade constraints;


----------------------------------------------- 나쁜짓 목록 -----------------------------------------------

/*

	코드:
		0. 기본값
		1. 낙찰금 지불 기한 만료
		2. 경매 진행중 입찰 취소: 최고입찰
		3. 경매 진행중 입찰 취소: 차등 입찰
		4. 경매 만료 이후 입찰 취소: 최고입찰
		5. 경매 만료 이후 입찰 취소: 차등 입찰
		6. 경매 진행 중 경매 취소
		7. 경매 만료 후 경매 취소

*/

create table BAD_DEED_TYPE (

	CODE			number(2,0)
	,THRESHOLD		number(15,0)
	,KARMA			number(3,0)		not null
	,NAME			nvarchar2(25)	not null
	,DESCRIPTION	nvarchar2(400)

	,constraint PK_BAD_DEED_CD primary key (CODE)
);

insert all 
	into BAD_DEED_TYPE (CODE, KARMA, NAME, DESCRIPTION) values (0, 100, '나쁜짓 기본값', '혹시 구현중 문제가 생기지 않도록 넣어둔 기본값')
	into BAD_DEED_TYPE (CODE, KARMA, NAME, DESCRIPTION) values (1, 100, '낙찰금 지불 기한 만료', '최고입찰로 지정된 후 낙찰금을 지불하지 않는 나쁜 짓.')
	into BAD_DEED_TYPE (CODE, KARMA, NAME, DESCRIPTION) values (2, 10, '경매 진행중 입찰 취소: 최고입찰', '최고입찰 상태일 때, 진행중인 경매에서 입찰을 취소하는 나쁜 짓.')
	into BAD_DEED_TYPE (CODE, KARMA, NAME, DESCRIPTION) values (3, 5, '경매 진행중 입찰 취소: 차등 입찰', '최고입찰 상태가 아닐 때, 진행중인 경매에서 입찰을 취소하는 나쁜 짓.')
	into BAD_DEED_TYPE (CODE, KARMA, NAME, DESCRIPTION) values (4, 50, '경매 만료 이후 입찰 취소: 최고입찰', '최고입찰 상태일 때, 낙찰 대기중인 경매에서 입찰을 취소하는 나쁜 짓.')
	into BAD_DEED_TYPE (CODE, KARMA, NAME, DESCRIPTION) values (5, 15, '경매 만료 이후 입찰 취소: 차등 입찰', '최고입찰 상태가 아닐 때, 낙찰 대기중인 경매에서 입찰을 취소하는 나쁜 짓.')
	into BAD_DEED_TYPE (CODE, KARMA, NAME, DESCRIPTION) values (6, 10, '경매 진행 중 경매 취소', '경매를 입찰이 진행중에 취소하는 나쁜 짓.')
	into BAD_DEED_TYPE (CODE, KARMA, NAME, DESCRIPTION) values (7, 50, '경매 만료 후 경매 취소', '경매를 낙찰이 진행중에 취소하는 나쁜 짓.')
select 1 from DUAL;
commit;


comment on table BAD_DEED_TYPE is '나쁜짓 목록 테이블';

comment on column BAD_DEED_TYPE.CODE is '나쁜짓 번호 - 기본키';

comment on column BAD_DEED_TYPE.THRESHOLD is '나쁜짓 기준치';

comment on column BAD_DEED_TYPE.KARMA is '나쁜짓 점수 - null불가';

comment on column BAD_DEED_TYPE.NAME is '나쁜짓 이름 - null불가';

comment on column BAD_DEED_TYPE.DESCRIPTION is '나쁜짓 내용';


--drop table BAD_DEED_TYPE cascade constraints;


----------------------------------------------- 나쁜짓 기록 -----------------------------------------------

create table BAD_DEED_RECORD (

	IDX				number(13,0)
	,CULPRIT_IDX	number(8,0)		not null
	,RECORDED_WHEN	date			not null
	,DEED_CODE		number(2,0)		not null
	,STATE_CODE		number(2,0)		not null
	
	,constraint PK_BAD_RECORD primary key (IDX)
	,constraint BAD_RECORD_ACC_FK foreign key (CULPRIT_IDX) references ACCOUNT (IDX)
	,constraint BAD_RECORD_CODE_FK foreign key (DEED_CODE) references BAD_DEED_TYPE (CODE)
	,constraint BAD_RECORD_STATE_FK foreign key (STATE_CODE) references DEED_RECORD_STATE_TYPE (CODE)
);

create sequence BAD_DEED_RECORD_SEQ start with 1 increment by 1;

create trigger BAD_DEED_RECORD_TRG
	before insert on BAD_DEED_RECORD
	for each row
begin
	if (:NEW.IDX is null) then
		:NEW.IDX := BAD_DEED_RECORD_SEQ.nextval;
	end if;
	if (:NEW.DEED_CODE is null) then
		:NEW.DEED_CODE := 0;
	end if;
	if (:NEW.STATE_CODE is null) then
		:NEW.STATE_CODE := 0;
	end if;
	:NEW.RECORDED_WHEN := SYSDATE;
end;
/
--트리거 설명: 인덱스 번호에 시퀀스 넣어줌, 나쁜짓 번호 기본값 0 넣어줌, 기록시각 강제입력(시스템시각)


comment on table BAD_DEED_RECORD is '나쁜짓 기록';

comment on column BAD_DEED_RECORD.IDX is '나쁜짓 기록 번호 - 기본키, 인조식별자, 트리거 있음';

comment on column BAD_DEED_RECORD.CULPRIT_IDX is '나쁜짓을 한 계정 번호- 외래키 null불가';

comment on column BAD_DEED_RECORD.RECORDED_WHEN is '나쁜짓을 한 시각 - null불가, 트리거있음(강제로 시스템시간 입력)';

comment on column BAD_DEED_RECORD.DEED_CODE is '나쁜짓 번호 - 외래키 null불가, 트리거있음 (기본값0)';

comment on column BAD_DEED_RECORD.STATE_CODE is '나쁜짓 기록 상태 코드 - 외래키 null불가, 트리거있음 (기본값0)';


--drop trigger BAD_DEED_RECORD_TRG;
--drop sequence BAD_DEED_RECORD_SEQ;
--drop table BAD_DEED_RECORD cascade constraints;


----------------------------------------------- 벌 목록 -----------------------------------------------

create table PENALTY_TYPE (

	CODE			number(2,0)
	,NAME			nvarchar2(20)	not null
	,DESCRIPTION	nvarchar2(400)	
	,THRESHOLD		number(15,0)
	,LENGTH			interval day (3) to second (0)	not null

	,constraint PK_PENALTY_TYPE primary key (CODE)
);

insert into PENALTY_TYPE (CODE, NAME, DESCRIPTION, LENGTH)
	values (0, '벌 기본값', '혹시 구현중 문제가 생기지 않도록 넣어둔 기본값', numtodsinterval( 03, 'DAY'));
commit;


--drop table PENALTY_TYPE cascade constraints;


----------------------------------------------- 벌 준 기록 -----------------------------------------------

create table PENALTY_RECORD (

	IDX					number(13,0)
	,CONVICT_IDX		number(8,0)		not null
	,RECORDED_WHEN		date			not null
	,PENALTY_CODE		number(2,0)		not null

	,constraint PK_PENALTY_RECORD primary key (IDX)
	,constraint PENALTY_RECORD_ACC_FK foreign key (CONVICT_IDX) references ACCOUNT (IDX)
	,constraint PENALTY_RECORD_CODE_FK foreign key (PENALTY_CODE) references PENALTY_TYPE(CODE)
);

create sequence PENALTY_RECORD_SEQ start with 1 increment by 1;

create trigger PENALTY_RECORD_TRG
	before insert on PENALTY_RECORD
	for each row
begin
	if (:NEW.IDX is null) then
		:NEW.IDX := PENALTY_RECORD_SEQ.nextval;
	end if;
	if (:NEW.PENALTY_CODE is null) then
		:NEW.PENALTY_CODE := 0;
	end if;
	:NEW.RECORDED_WHEN := SYSDATE;
end;
/
--트리거 설명: 인덱스 넣어줌, 페널티번호 0번 기본값, 시각 강제로 시스템시각으로 넣음


comment on table PENALTY_RECORD is '''벌'' 의 기록';

comment on column PENALTY_RECORD.IDX is '벌 기록 번호 - 기본키, 인조식별자, 트리거있음';

comment on column PENALTY_RECORD.CONVICT_IDX is '벒을 준 계정 번호 - 외래키, null불가';

comment on column PENALTY_RECORD.RECORDED_WHEN is '벌을 준 시각 - null불가, 트리거있음 (강제로 시각 주입)';

comment on column PENALTY_RECORD.PENALTY_CODE is '''벌'' 번호 - 외래키, null불가, 트리거있음 (기본값 0)';


--drop trigger PENALTY_RECORD_TRG;
--drop sequence PENALTY_RECORD_SEQ;
--drop table PENALTY_RECORD cascade constraints;


----------------------------------------------- 경매/입찰 진행용 프로시저 -----------------------------------------------


/*======================================= 1. 입찰 프로시저 =========================================

	결과 코드 - isDone
		0: 에러(주로 경매 번호나 계정 이상)
		1: 성공
		-1: 금액 부족
		-2: 경매 기간 만료
		-3: 경매인이 입찰시

===================================================================================================*/

create procedure BIDDER (in_auction_idx AUCTION.IDX%type, in_amount AUCTION.HIGHEST_BID%type, in_bidder_idx BID.BIDDER_IDX%type, isDone out number)
is
	a_amount		AUCTION.HIGHEST_BID%type;
	a_timeWindow	AUCTION.REG_TIME%type;
	a_writter		AUCTION.WRITTER_IDX%type;
	
	err_code		number;
	err_message		varchar2(255);
	
begin

	savepoint START_TRANSACTION;

	select A.HIGHEST_BID , A.REG_TIME+(select TIME_WINDOW from AUCTION_TIME_WINDOW_TYPE where CODE = A.TIME_WINDOW_CODE) ,WRITTER_IDX
		into a_amount, a_timeWindow, a_writter  from AUCTION A where IDX = in_auction_idx;
	
	if (in_bidder_idx = a_writter) then
		insert into PLOGGER (NAME, RESULTCODE, CONTENT) values ('BIDDER',-3,'Self Bidding (auctionIdx: '||in_auction_idx||',amount:  '||in_amount||',bidderIdx: '||in_bidder_idx||')');
		select -3 into isDone from DUAL;
	elsif ( SYSTIMESTAMP > a_timeWindow) then
		insert into PLOGGER (NAME, RESULTCODE, CONTENT) values ('BIDDER',-2,'Bid after Timeout (auctionIdx: '||in_auction_idx||',amount: '||in_amount||',bidderIdx: '||in_bidder_idx||')');
		select -2 into isDone from DUAL;
	elsif (in_amount < a_amount*1.1) then
		insert into PLOGGER (NAME, RESULTCODE, CONTENT) values ('BIDDER',-1,'usder Bid (auctionIdx: '||in_auction_idx||',amount: '||in_amount||',bidderIdx: '||in_bidder_idx||')');
		select -1 into isDone from DUAL;
	else
		update AUCTION set HIGHEST_BID = in_amount where IDX = in_auction_idx;
		insert into BID (AUCTION_IDX, AMOUNT, BIDDER_IDX) values (in_auction_idx, in_amount, in_bidder_idx);
		insert into BID_ALIVE_QUE (AUCTION_IDX, BID_AMOUNT, BIDDER_IDX) values (in_auction_idx, in_amount, in_bidder_idx);
		update BID set STATE_CODE = 12, FINISHED_WHEN = SYSTIMESTAMP where AUCTION_IDX = in_auction_idx and AMOUNT != in_amount and BIDDER_IDX = in_bidder_idx;
		update BID set STATE_CODE = 2 where AUCTION_IDX = in_auction_idx and AMOUNT != in_amount and STATE_CODE =1;
		delete BID_ALIVE_QUE where AUCTION_IDX = in_auction_idx and BID_AMOUNT != in_amount and BIDDER_IDX =  in_bidder_idx;
		insert into PLOGGER (NAME, RESULTCODE, CONTENT) values ('BIDDER',1,'BID done (auctionIdx: '||in_auction_idx||',amount: '||in_amount||',bidderIdx: '||in_bidder_idx||')');
		select 1 into isDone from DUAL;
	end if;
	
	commit;
	
exception when OTHERS then
	rollback to START_TRANSACTION;
	
	err_code := sqlcode;
	err_message := substr(sqlerrm, 1, 255);
	
	insert into PLOGGER (NAME, RESULTCODE, CONTENT, err_code, err_message) values ('BIDDER',0,'ERROR! (auctionIdx: '||in_auction_idx||',amount: '||in_amount||',bidderIdx: '||in_bidder_idx||')', err_code, err_message );
	commit;
	
	select 0 into isDone from DUAL;
end;
/

--drop procedure BIDDER;


/*============================= 2. 경매 만료 목록 확인 + 진행시키기 ================================

	경매 진행기간이 지난 경매를 확인하여 낙찰/만료 절차 진행 (타이머)

===================================================================================================*/

create procedure AUCTION_DUE_CHECK (DBTIME out timestamp, NEXTCHECK out timestamp)
is
	bid_alive_cnt	number;
	no_bid_cnt		number;
	has_bid_cnt		number;
	bidder			number;
	timewindow		timestamp;
	has_next_time	number;
	
	err_code		number;
	err_message		varchar2(255);

	cursor AUCT_CUR is
		select IDX, WRITTER_IDX, TITLE, HIGHEST_BID from AUCTION A where IDX in(select AUCTION_IDX from AUCTION_DUE_QUE where TIME_WINDOW < SYSTIMESTAMP) for update;
begin
	no_bid_cnt := 0;
	has_bid_cnt := 0;
	
	savepoint START_TRANSACTION;
	
	for AUCTION_ROW in AUCT_CUR loop
		
		select count(1) into bid_alive_cnt from BID_ALIVE_QUE where AUCTION_IDX = AUCTION_ROW.IDX;
		
		if( bid_alive_cnt = 0 ) then
			update AUCTION set STATE_CODE = 4, CLOSED_WHEN = SYSTIMESTAMP, FINISHED_WHEN = SYSTIMESTAMP where current of AUCT_CUR;
			insert into MESSAGE (SENDER_IDX, RECEIVER_IDX, TITLE, CONTENT, TYPE_CODE)
				values (0, AUCTION_ROW.WRITTER_IDX, '신청하신 경매 '||AUCTION_ROW.TITLE||' 가 입찰이 없이 만료되었습니다.', '경매기간 만료: 유효입찰 없음',1);
			delete AUCTION_DUE_QUE where AUCTION_IDX = AUCTION_ROW.IDX;
			no_bid_cnt := no_bid_cnt+1;

			insert into PLOGGER (NAME, RESULTCODE, CONTENT) values ('AUCTION_DUE_CHECK',1,'successful. no ALIVE_BID found on AUCTION.IDX: '||AUCTION_ROW.IDX);

		else
------------------- 입찰금 지불 기간에 대한 기준 필요. 현재 테스트용 4번 코드 지정중.
			insert into BID_CONTRACT_QUE (AUCTION_IDX, BID_AMOUNT, CONTRACT_T_WIN_CODE) values (AUCTION_ROW.IDX, AUCTION_ROW.HIGHEST_BID, 4);
			select BIDDER_IDX into bidder from BID_ALIVE_QUE where AUCTION_IDX = AUCTION_ROW.IDX and BID_AMOUNT = AUCTION_ROW.HIGHEST_BID;
			select PAYMENT_DUE into timewindow from BID_CONTRACT_QUE where AUCTION_IDX = AUCTION_ROW.IDX;
			insert into MESSAGE (SENDER_IDX, RECEIVER_IDX, TITLE, CONTENT, TYPE_CODE)
					values (0, bidder, '입찰하신 경매 '||AUCTION_ROW.TITLE||' 에 낙찰되셨습니다', to_char(timewindow, 'YYYY-MM-DD HH24:MI:SS') ||' 까지 '||AUCTION_ROW.HIGHEST_BID||'원 을 지불하셔야 낙찰이 완료됩니다. 그렇지 않을 시, 낙찰 권한이 차등위 입찰로 넘어가고 계약 위반에 대해 제재를 받을 수 있음을 알려드립니다.', 1);
			insert into MESSAGE (SENDER_IDX, RECEIVER_IDX, TITLE, CONTENT, TYPE_CODE)
					values (0, AUCTION_ROW.WRITTER_IDX, '신청하신 경매 '||AUCTION_ROW.TITLE||' 의 낙찰이 시작되었습니다.','낙찰가 : '||AUCTION_ROW.HIGHEST_BID||' 최고액 입찰자가 입찰액을 지불하면 낙찰 절차가 완료됩니다.', 1);
			update AUCTION set STATE_CODE = 5, CLOSED_WHEN = SYSTIMESTAMP where current of AUCT_CUR;
			delete AUCTION_DUE_QUE where AUCTION_IDX = AUCTION_ROW.IDX;
			
			insert into PLOGGER (NAME, RESULTCODE, CONTENT) values ('AUCTION_DUE_CHECK',1,'successful. found ALIVE_BID on AUCTION.IDX: '||AUCTION_ROW.IDX||' is bidder: '||bidder||', AMOUNT: '||AUCTION_ROW.HIGHEST_BID);

		end if;

	end loop;
	
	insert into PLOGGER (NAME, RESULTCODE, CONTENT) values ('AUCTION_DUE_CHECK',1,'AUCTION_DUE_CHECK done. (no_bid_cnt: '||no_bid_cnt||', has_bid_cnt: '||has_bid_cnt||')');
	
	commit;
	
	select count(1) into has_next_time from AUCTION_DUE_QUE;
	if (has_next_time >0) then
		select SYSTIMESTAMP , min(TIME_WINDOW) into DBTIME, NEXTCHECK from AUCTION_DUE_QUE;
	else
		select SYSTIMESTAMP, SYSTIMESTAMP into DBTIME, NEXTCHECK from DUAL;
	end if;
	
	
exception when OTHERS then

	rollback to START_TRANSACTION;
	
	err_code := sqlcode;
	err_message := substr(sqlerrm, 1, 255);

	insert into PLOGGER (NAME, RESULTCODE, CONTENT, err_code, err_message)
		values ('AUCTION_DUE_CHECK',0,'ERROR!!!. (no_bid_cnt: '||no_bid_cnt||', has_bid_cnt: '||has_bid_cnt||')', err_code, err_message );

	commit;
	
	select count(1) into has_next_time from AUCTION_DUE_QUE;
	if (has_next_time >0) then
		select SYSTIMESTAMP , min(TIME_WINDOW) into DBTIME, NEXTCHECK from AUCTION_DUE_QUE;
	else
		select count(1) into has_next_time from AUCTION_TIME_WINDOW_TYPE;
		if (has_next_time >0) then
			select SYSTIMESTAMP, SYSTIMESTAMP + min(TIME_WINDOW) into DBTIME, NEXTCHECK from AUCTION_TIME_WINDOW_TYPE;
		else
			select SYSTIMESTAMP, SYSTIMESTAMP into DBTIME, NEXTCHECK from DUAL;
		end if;
	end if;
	
end;
/

--drop procedure AUCTION_DUE_CHECK;


/*=============================== 3. 낙찰금 지불 거부 (만료 타이머) ==================================

설명:
	반환할 값을 0 으로 초기화.
	만료된 경매들을 하나씩 확인함
		만약 해당 경매에 유효입찰이 있으면
			해당 경매의 상태코드를 5 로 변경 (경매만료: 유효입찰 없음)
			경매 신청 계정 에게 메세지를 보냄
			경매 만료 대기열에서 해당 경매를 삭제
		만약 유효 입찰이 있으면
			해당 경매의 유효입찰을 낙찰금 지불 대기열에 입력
			경매 신청 계정 /최고입찰의 신청 계정 에게 메세지를 보냄
			해당 경매의 상태 코드를 6 으로 변경 (경매 만료: 낙찰금 지불 대기중)
			경매 만료 대기열에서 해당 경매를 삭제
	commit;

	다음 경매 만료 시간을 확인
		있으면 DB시간, 다음경매 시간을 내보냄
		없으면 DB시간, DB시간을 내보냄

	-중간에 이상이 있었다면
		rollback;
		있으면 DB시간, 다음경매 시간을 내보냄
		없으면 DB시간, DB시간을 내보냄
	종료

===================================================================================================*/

create procedure BID_DUE_CHECK (DBTIME out timestamp, NEXTCHECK out timestamp)
is
	next_bid_check		number;
	was_lesser_bid		number;
	no_lesser_bid		number;
	next_bid_amount		number;
	next_bid_bidder		number;
	auct_writter		number;
	timewindow			timestamp;
	auct_title			AUCTION.TITLE%type;
	karma_point			number;

	err_code			number;
	err_message			varchar2(255);

	cursor BID_CUR is
		select AUCTION_IDX, AMOUNT, BIDDER_IDX from BID where (AUCTION_IDX, AMOUNT) in (select AUCTION_IDX, BID_AMOUNT from BID_CONTRACT_QUE where PAYMENT_DUE < SYSTIMESTAMP) for update;
begin
	was_lesser_bid := 0;
	no_lesser_bid := 0;

	savepoint START_TRANSACTION;

	select KARMA into karma_point from BAD_DEED_TYPE where CODE = 1;

	for BID_ROW in BID_CUR loop
	
		delete BID_CONTRACT_QUE where AUCTION_IDX = BID_ROW.AUCTION_IDX and BID_AMOUNT = BID_ROW.AMOUNT;
		delete BID_ALIVE_QUE where AUCTION_IDX = BID_ROW.AUCTION_IDX and BID_AMOUNT = BID_ROW.AMOUNT;
		
		select count(1) into next_bid_check from BID_ALIVE_QUE where AUCTION_IDX = BID_ROW.AUCTION_IDX;
		select TITLE, WRITTER_IDX into auct_title, auct_writter from AUCTION where IDX = BID_ROW.AUCTION_IDX;

		if (next_bid_check >0) then
			select B.BIGGEST_BID, Q.BIDDER_IDX into next_bid_amount, next_bid_bidder from BID_ALIVE_QUE Q
				inner join (select max(BID_AMOUNT) BIGGEST_BID from BID_ALIVE_QUE where AUCTION_IDX = BID_ROW.AUCTION_IDX) B
					on B.BIGGEST_BID = Q.BID_AMOUNT
				where AUCTION_IDX = BID_ROW.AUCTION_IDX;
			update BID set STATE_CODE = 1 where AUCTION_IDX = BID_ROW.AUCTION_IDX and AMOUNT = next_bid_amount;
			update AUCTION set HIGHEST_BID = next_bid_amount, STATE_CODE = 6 where IDX = BID_ROW.AUCTION_IDX;
			insert into BID_CONTRACT_QUE (AUCTION_IDX, BID_AMOUNT, CONTRACT_T_WIN_CODE) values (BID_ROW.AUCTION_IDX, next_bid_amount, 4);
			select PAYMENT_DUE into timewindow from BID_CONTRACT_QUE where AUCTION_IDX = BID_ROW.AUCTION_IDX;
			insert into MESSAGE (SENDER_IDX, RECEIVER_IDX, TITLE, CONTENT, TYPE_CODE) values (0, next_bid_bidder, '입찰하신 경매 '''||auct_title||''' 에 낙찰되셨습니다.','상위 입찰이 만료되어 해당 경매 '''||auct_title||''' 에 낙찰되셨습니다. '||timewindow||' 까지 '||next_bid_amount||'원 을 지불하셔야 낙찰이 완료됩니다. 그렇지 않을 시, 낙찰 권한이 차등위 입찰로 넘어가고 계약 위반에 대해 제재를 받을 수 있음을 알려드립니다.',1);
			insert into MESSAGE (SENDER_IDX, RECEIVER_IDX, TITLE, CONTENT, TYPE_CODE) values (0, auct_writter, '신청하신 경매 '''||auct_title||''' 의 대금 납부를 입찰인이 거부하였습니다.','해당 경매의 최고 입찰자가 낙찰 대금을 지불기한 내 지불을 하지 않아, 차등위 입찰로 낙찰 권한이 이양되었습니다. 차등위 입찰의 입찰금: '||next_bid_amount||'월', 1);
			was_lesser_bid := was_lesser_bid +1;

			insert into PLOGGER (NAME, RESULTCODE, CONTENT) values ('BID_DUE_CHECK',1, 'successful. found NEXT_BID on AUCTION.IDX: '||BID_ROW.AUCTION_IDX||', next_bid_amount: '||next_bid_amount||', next_bid_bidder: '||next_bid_bidder);

		else
			update AUCTION set STATE_CODE = 7, FINISHED_WHEN = SYSTIMESTAMP where IDX = BID_ROW.AUCTION_IDX;
			insert into MESSAGE (SENDER_IDX, RECEIVER_IDX, TITLE, CONTENT, TYPE_CODE) values (0, auct_writter, '신청하신 경매 '''||auct_title||''' 의 대금 납부를 모든 입찰인이 거부하였습니다.','해당 경매에 참여한 모든 유효 입찰의 입찰자 들이 낙찰 대금을 지불기한 내 지불을 하지 않아, 해당 경매가 거래 없이 완료되었습니다.', 1);
			no_lesser_bid := no_lesser_bid +1;

			insert into PLOGGER (NAME, RESULTCODE, CONTENT) values ('BID_DUE_CHECK',1, 'successful. found no NEXT_BID on AUCTION.'||BID_ROW.AUCTION_IDX);

		end if;

		insert into BAD_DEED_RECORD (CULPRIT_IDX, DEED_CODE) values ( BID_ROW.BIDDER_IDX, 1);
		insert into MESSAGE (SENDER_IDX, RECEIVER_IDX, TITLE, CONTENT, TYPE_CODE)  values(0, BID_ROW.BIDDER_IDX, '경매 '''||auct_title||''' 의 낙찰금 지불 기한이 만료되었습니다.','대상 경매에 대한 낙찰 권한을 상실하셨으며, 벌점 '||karma_point|| '점을 받으셨습니다.', 1);
		update BID set STATE_CODE = 13, FINISHED_WHEN = SYSTIMESTAMP where current of BID_CUR;

	end loop;
	
	insert into PLOGGER (NAME, RESULTCODE, CONTENT) values ('BID_DUE_CHECK', 1, 'BID_DUE_CHECK done. (no_lesser_bid: '||no_lesser_bid||', was_lesser_bid: '||was_lesser_bid||')');
	
	commit;

	select count(1) into next_bid_check from BID_CONTRACT_QUE;--시간
	if (next_bid_check >0 ) then
		select SYSTIMESTAMP, PAYMENT_DUE into DBTIME, NEXTCHECK from BID_CONTRACT_QUE;
	else
		select SYSTIMESTAMP, SYSTIMESTAMP into DBTIME, NEXTCHECK from DUAL;
	end if;
	
exception when others then

	rollback to START_TRANSACTION;
	
	err_code := sqlcode;
	err_message := substr(sqlerrm, 1, 255);
	
	insert into PLOGGER (NAME, RESULTCODE, CONTENT, err_code, err_message)
		values ('BID_DUE_CHECK',0,'ERROR!!!. (no_lesser_bid: '||no_lesser_bid||', was_lesser_bid: '||was_lesser_bid||')',err_code, err_message);
	
	commit;
	
	select count(1) into next_bid_check from BID_CONTRACT_QUE;
	if (next_bid_check >0 ) then
		select SYSTIMESTAMP, PAYMENT_DUE into DBTIME, NEXTCHECK from BID_CONTRACT_QUE;
	else
		select count(1) into next_bid_check from CONTRACT_TIME_WINDOW_TYPE;
		if (next_bid_check >0) then 
			select SYSTIMESTAMP, SYSTIMESTAMP + min(TIME_WINDOW) into DBTIME, NEXTCHECK from CONTRACT_TIME_WINDOW_TYPE;
		else
			select SYSTIMESTAMP, SYSTIMESTAMP into DBTIME, NEXTCHECK from DUAL;
		end if;
		
	end if;
	
end;
/

--drop procedure BID_DUE_CHECK;


/*==================================== 4.입찰 취소용 프로시저 ======================================

결과 코드 - isDone
	0: 에러 (오라클 에러)
	1:성공
	-1: 그런 입찰 없음
	-2: 요청자가 입찰자가 아님
	-3: 입찰이 유효입찰이 아닌 상태 (취소가 불가능한 상태의입찰)
	-4: 대상 경매가 취소할 수 있는 상태가 아님 (진행중이거나 낙찰 대기중이 아님)
	-5: 뭔가 잘못됨
	-6: 뭔가 잘못됨#2
	-7: 뭔가 잘못됨#3

===================================================================================================*/

create procedure CANCEL_BID (in_auction_idx AUCTION.IDX%type, in_amount AUCTION.HIGHEST_BID%type, in_bidder_idx BID.BIDDER_IDX%type, isDone out number)
is
	null_checker		number;
	auction_state		AUCTION.STATE_CODE%type;
	bid_state			BID.STATE_CODE%type;
	auction_title		AUCTION.TITLE%type;
	auction_writter		AUCTION.WRITTER_IDX%type;
	karma_point			BAD_DEED_TYPE.KARMA%type;
	next_amount			BID_ALIVE_QUE.BID_AMOUNT%type;
	next_bidder			BID_ALIVE_QUE.BIDDER_IDX%type;
	timewindow			timestamp;
	
	err_code			number;
	err_message			varchar2(255);

begin
	savepoint START_TRANSACTION;
	
	select count(1) into null_checker from BID where AUCTION_IDX = in_auction_idx and AMOUNT = in_amount;
	
	if(null_checker =0) then
		insert into PLOGGER (NAME, RESULTCODE, CONTENT) values ('CANCEL_BID', -1, 'No such Bid exists. [in_auction_idx: '||in_auction_idx||', in_amount: '||in_amount||', in_bidder_idx: '||in_bidder_idx||']');
		select -1 into isDone from DUAL;
		
	else
		select count(1) into null_checker from BID where AUCTION_IDX = in_auction_idx and AMOUNT = in_amount and BIDDER_IDX = in_bidder_idx;
	
		if (null_checker =0) then
			insert into PLOGGER (NAME, RESULTCODE, CONTENT) values ('CANCEL_BID', -2, 'Calcel request is not from a bidder. [in_auction_idx: '||in_auction_idx||', in_amount: '||in_amount||', in_bidder_idx: '||in_bidder_idx||']');
			select -2 into isDone from DUAL;
		else
			select A.WRITTER_IDX, A.TITLE, A.STATE_CODE, B.STATE_CODE into auction_writter, auction_title, auction_state, bid_state from AUCTION A inner join BID B on B.AUCTION_IDX = A.IDX where A.IDX = in_auction_idx and B.AUCTION_IDX = in_auction_idx and B.AMOUNT = in_amount;
			
			if (auction_writter is null or auction_title is null or bid_state is null) then
				insert into PLOGGER (NAME, RESULTCODE, CONTENT, ERR_CODE) values ('CANCEL_BID', -7, 'Something''s wrong! This shouldn''t be here. Check ''CANCEL_BID'' procedure code. [in_auction_idx: '||in_auction_idx||', in_amount: '||in_amount||', in_bidder_idx: '||in_bidder_idx||']', -1);
				select -7 into isDone from DUAL;
			else
				if (bid_state <>1 and bid_state<>2) then
					insert into PLOGGER (NAME, RESULTCODE, CONTENT) values ('CANCEL_BID', -3, 'Bid is not alive. [in_auction_idx: '||in_auction_idx||', in_amount: '||in_amount||', in_bidder_idx: '||in_bidder_idx||']');
					select -3 into isDone from DUAL;
					
				elsif (auction_state <>1 and auction_state <>5) then
					insert into PLOGGER (NAME, RESULTCODE, CONTENT) values ('CANCEL_BID', -4, 'Cannot cancel bid on current state of target auction. [in_auction_idx: '||in_auction_idx||', in_amount: '||in_amount||', in_bidder_idx: '||in_bidder_idx||']');
					select -4 into isDone from DUAL;
					
				elsif (auction_state =1) then
					delete BID_ALIVE_QUE where AUCTION_IDX = in_auction_idx and BID_AMOUNT = in_amount and BIDDER_IDX = in_bidder_idx;
					
					if (bid_state =1) then
						select count(1) into null_checker from BID_ALIVE_QUE where AUCTION_IDX = in_auction_idx;
						
						if (null_checker =0) then
							update AUCTION set HIGHEST_BID = START_PRICE where IDX = in_auction_idx;
						else
							select max(BID_AMOUNT) into next_amount from BID_ALIVE_QUE where AUCTION_IDX = in_auction_idx;
							update AUCTION set HIGHEST_BID = next_amount where IDX = in_auction_idx;
							update BID set STATE_CODE = 1 where AUCTION_IDX = in_auction_idx and AMOUNT = next_amount;
						end if;

						update BID set STATE_CODE = 10, FINISHED_WHEN = SYSTIMESTAMP where AUCTION_IDX = in_auction_idx and AMOUNT = in_amount;
						insert into BAD_DEED_RECORD (CULPRIT_IDX, DEED_CODE) values (in_bidder_idx, 2);
						select KARMA into karma_point from BAD_DEED_TYPE where CODE = 2;
						insert into MESSAGE (SENDER_IDX, RECEIVER_IDX, TITLE, CONTENT, TYPE_CODE) values (0, in_bidder_idx, ''''||auction_title||''' 의 입찰을 취소하셨습니다.','진행중 인 경매에 대해 최고 입찰 상태에서 취소하셨기 때문에 벌점 '||karma_point||'점을 받으셨습니다.',1);
						insert into PLOGGER (NAME, RESULTCODE, CONTENT) values ('CANCEL_BID',1,'Successfully canceled a bid. It was the Highest Bid. [in_auction_idx: '||in_auction_idx||', in_amount: '||in_amount||', in_bidder_idx: '||in_bidder_idx||']');
						select 1 into isDone from DUAL;
						
					elsif ( bid_state =2) then
						update BID set STATE_CODE = 11, FINISHED_WHEN = SYSTIMESTAMP where AUCTION_IDX = in_auction_idx and AMOUNT = in_amount;
						insert into BAD_DEED_RECORD (CULPRIT_IDX, DEED_CODE) values (in_bidder_idx, 3);
						select KARMA into karma_point from BAD_DEED_TYPE where CODE = 3;
						insert into MESSAGE (SENDER_IDX, RECEIVER_IDX, TITLE, CONTENT, TYPE_CODE) values (0, in_bidder_idx, ''''||auction_title||''' 의 입찰을 취소하셨습니다.','진행중 인 경매에 대해 최고 입찰이 아닌 상태에서 취소하셨기 때문에 벌점 '||karma_point||'점을 받으셨습니다.',1);
						insert into PLOGGER (NAME, RESULTCODE, CONTENT) values ('CANCEL_BID',1,'Successfully canceled a bid. It was not the Highest Bid. [in_auction_idx: '||in_auction_idx||', in_amount: '||in_amount||', in_bidder_idx: '||in_bidder_idx||']');
						select 1 into isDone from DUAL;
						
					else
						insert into PLOGGER (NAME, RESULTCODE, CONTENT, ERR_CODE) values ('CANCEL_BID', -5, 'Something''s wrong! This shouldn''t be here. Check ''CANCEL_BID'' procedure code. [in_auction_idx: '||in_auction_idx||', in_amount: '||in_amount||', in_bidder_idx: '||in_bidder_idx||']', -1);
						select -5 into isDone from DUAL;
					end if;
					
				elsif (auction_state =5) then
					delete BID_ALIVE_QUE where AUCTION_IDX = in_auction_idx and BID_AMOUNT = in_amount and BIDDER_IDX = in_bidder_idx;
					delete BID_CONTRACT_QUE where AUCTION_IDX = in_auction_idx and BID_AMOUNT = in_amount;
					
					if (bid_state =1) then
						select count(1) into null_checker from BID_ALIVE_QUE where AUCTION_IDX = in_auction_idx;
						
						if (null_checker =0) then
							update AUCTION set STATE_CODE = 7 , FINISHED_WHEN = SYSTIMESTAMP where IDX = in_auction_idx;
							insert into MESSAGE (SENDER_IDX, RECEIVER_IDX, TITLE, CONTENT, TYPE_CODE) values (0, auction_writter, '신청하신 경매 '''||auction_title||''' 의 대금 납부를 모든 입찰인이 거부하였습니다.','해당 경매에 참여한 마지막 유효 입찰의 입찰자 가 낙찰 대금의 지불을 거부하여, 해당 경매가 거래 없이 완료되었습니다.',1);
							insert into PLOGGER (NAME, RESULTCODE, CONTENT) values ('CANCEL_BID',1,'Successfully canceled a bid. It was the Highest Bid. No lesser Alive_Bid found. [in_auction_idx: '||in_auction_idx||', in_amount: '||in_amount||', in_bidder_idx: '||in_bidder_idx||']');
						else
							select B.BIGGEST_BID, Q.BIDDER_IDX into next_amount, next_bidder from BID_ALIVE_QUE Q
								inner join (select max(BID_AMOUNT) BIGGEST_BID from BID_ALIVE_QUE where AUCTION_IDX = in_auction_idx) B
								on B.BIGGEST_BID = Q.BID_AMOUNT
								where AUCTION_IDX = in_auction_idx;
							update BID set STATE_CODE = 1 where AUCTION_IDX = in_auction_idx and AMOUNT = next_amount;
							update AUCTION set HIGHEST_BID = next_amount, STATE_CODE = 6 where IDX = in_auction_idx;
							insert into BID_CONTRACT_QUE (AUCTION_IDX, BID_AMOUNT, CONTRACT_T_WIN_CODE) values (in_auction_idx, next_amount, 4);
							select PAYMENT_DUE into timewindow from BID_CONTRACT_QUE where AUCTION_IDX = in_auction_idx;
							insert into MESSAGE (SENDER_IDX, RECEIVER_IDX, TITLE, CONTENT, TYPE_CODE) values (0, next_bidder, '입찰하신 경매 '''||auction_title||''' 에 낙찰되셨습니다.', '상위 입찰이 취소되어 해당 경매 '''||auction_title||''' 에 낙찰되셨습니다. '||timewindow||' 까지 '||next_amount||'원 을 지불하셔야 낙찰이 완료됩니다. 그렇지 않을 시, 낙찰 권한이 차등위 입찰로 넘어가고 계약 위반에 대해 제재를 받을 수 있음을 알려드립니다.', 1);
							insert into PLOGGER (NAME, RESULTCODE, CONTENT) values ('CANCEL_BID',1,'Successfully canceled a bid. It was the Highest Bid. lesser Alive_Bid found. [in_auction_idx: '||in_auction_idx||', in_amount: '||in_amount||', in_bidder_idx: '||in_bidder_idx||']');
						end if;
						
						update BID set STATE_CODE = 14, FINISHED_WHEN = SYSTIMESTAMP where AUCTION_IDX = in_auction_idx and AMOUNT = in_amount;
						insert into BAD_DEED_RECORD (CULPRIT_IDX, DEED_CODE) values (in_bidder_idx, 4);
						select KARMA into karma_point from BAD_DEED_TYPE where CODE = 4;
						insert into MESSAGE (SENDER_IDX, RECEIVER_IDX, TITLE, CONTENT, TYPE_CODE) values (0, in_bidder_idx, ''''||auction_title||''' 의 입찰을 취소하셨습니다.','만료된 경매에 대해 최고 입찰인 상태에서 취소하셨기 때문에 벌점 '||karma_point||'점을 받으셨습니다.',1);
						select 1 into isDone from DUAL;
						
					elsif (bid_state =2) then
						update BID set STATE_CODE = 15, FINISHED_WHEN = SYSTIMESTAMP where AUCTION_IDX = in_auction_idx and AMOUNT = in_amount;
						insert into BAD_DEED_RECORD (CULPRIT_IDX, DEED_CODE) values (in_bidder_idx, 5);
						select KARMA into karma_point from BAD_DEED_TYPE where CODE = 5;
						insert into MESSAGE (SENDER_IDX, RECEIVER_IDX, TITLE, CONTENT, TYPE_CODE) values (0, in_bidder_idx, ''''||auction_title||''' 의 입찰을 취소하셨습니다.','만료된 경매에 대해 최고 입찰이 아닌 상태에서 취소하셨기 때문에 벌점 '||karma_point||'점을 받으셨습니다.',1);
						insert into PLOGGER (NAME, RESULTCODE, CONTENT) values ('CANCEL_BID',1,'Successfully canceled a bid. It was not Highest Bid. [in_auction_idx: '||in_auction_idx||', in_amount: '||in_amount||', in_bidder_idx: '||in_bidder_idx||']');
						select 1 into isDone from DUAL;
					else
						insert into PLOGGER (NAME, RESULTCODE, CONTENT, ERR_CODE) values ('CANCEL_BID', -5, 'Something''s wrong! This shouldn''t be here. Check ''CANCEL_BID'' procedure code. [in_auction_idx: '||in_auction_idx||', in_amount: '||in_amount||', in_bidder_idx: '||in_bidder_idx||']', -1);
						select -5 into isDone from DUAL;
					end if;
				else
					insert into PLOGGER (NAME, RESULTCODE, CONTENT, ERR_CODE) values ('CANCEL_BID', -6, 'Something''s wrong! This shouldn''t be here. Check ''CANCEL_BID'' procedure code. [in_auction_idx: '||in_auction_idx||', in_amount: '||in_amount||', in_bidder_idx: '||in_bidder_idx||']', -1);
					select -6 into isDone from DUAL;
				end if;
				
			end if;
			
		end if;
		
	end if;

	commit;
	
exception when OTHERS then
	rollback to START_TRANSACTION;
	
	err_code := sqlcode;
	err_message := substr(sqlerrm, 1, 255);
	
	insert into PLOGGER (NAME, RESULTCODE, CONTENT, err_code, err_message)
		values ('CANCEL_BID', 0, 'ERROR!!! ........)', err_code, err_message );
	commit;
	
	select 0 into isDone from DUAL;
end;
/

--drop procedure CANCEL_BID;


/*===================================  5. 경매 취소 프로시저  ======================================

완료 코드
	1: 성공
	0: 오라클 에러
	-1: 그런 번호의 경매가 존재하지 않음
	-2: 대상 경매를 올린 계정과 취소를 신청한 계정이 다름
	-3: 경매가 취소할 수 있는 상태가 아님

===================================================================================================*/
	
create procedure CANCEL_AUCTION (in_auction_idx AUCTION.IDX%type, in_writter_idx AUCTION.WRITTER_IDX%type, isDone out number)
is
	null_checker		number;
	auction_state		AUCTION.STATE_CODE%type;
	auction_title		AUCTION.TITLE%type;
	karma_point			BAD_DEED_TYPE.KARMA%type;
	
	err_code			number;
	err_message			varchar2(255);

	cursor BID_CUR is
		select AUCTION_IDX, AMOUNT, BIDDER_IDX from BID where (AUCTION_IDX, AMOUNT) in (select AUCTION_IDX, BID_AMOUNT from BID_ALIVE_QUE where AUCTION_IDX = in_auction_idx) for update;
begin

	savepoint START_TRANSACTION;
	
	select count(1) into null_checker from AUCTION where IDX = in_auction_idx;
	
	if (null_checker =0) then
		insert into PLOGGER (NAME, RESULTCODE, CONTENT) values ('CANCEL_AUCTION', -1, 'No such AUCTION exists. [in_auction_idx: '||in_auction_idx||', in_writter_idx: '||in_writter_idx||']');
		select -1 into isDone from DUAL;
	else
		select count(1) into null_checker from AUCTION where IDX = in_auction_idx and WRITTER_IDX = in_writter_idx;
		
		if (null_checker =0) then
			insert into PLOGGER (NAME, RESULTCODE, CONTENT) values ('CANCEL_AUCTION', -2, 'cancel request is not from a writter. [in_auction_idx: '||in_auction_idx||', in_amount: '||in_writter_idx||']');
			select -2 into isDone from DUAL;
		else
		
			select TITLE, STATE_CODE into auction_title, auction_state from AUCTION where IDX = in_auction_idx;
			
			if(auction_state =1) then
				delete AUCTION_DUE_QUE where AUCTION_IDX = in_auction_idx;
				update AUCTION set STATE_CODE = 2, FINISHED_WHEN = SYSTIMESTAMP where IDX = in_auction_idx;
				insert into BAD_DEED_RECORD (CULPRIT_IDX, DEED_CODE) values (in_writter_idx, 6);
				select KARMA into karma_point from BAD_DEED_TYPE where CODE = 6;
				insert into MESSAGE (SENDER_IDX, RECEIVER_IDX, TITLE, CONTENT, TYPE_CODE) values (0, in_auction_idx, ''''||auction_title||''' 경매를 취소하셨습니다.','진행중 인 경매를 취소하셨기 때문에 벌점 '||karma_point||'점을 받으셨습니다.',1);
				
				for BID_ROW in BID_CUR loop
					update BID set STATE_CODE = 20, FINISHED_WHEN = SYSTIMESTAMP where current of BID_CUR;
					insert into MESSAGE (SENDER_IDX, RECEIVER_IDX, TITLE, CONTENT, TYPE_CODE) values (0, BID_ROW.BIDDER_IDX, ''''||auction_title||''' 경매가 취소되었습니다.', '진행중 이던 경매가 취소되어 해당 경매에 신청한 입찰이 취소되었습니다.', 1);
				end loop;
				
				delete BID_ALIVE_QUE where AUCTION_IDX = in_auction_idx;
				
				insert into PLOGGER (NAME, RESULTCODE, CONTENT) values ('CANCEL_AUCTION', 1, 'Success. Auction canceled while running. [in_auction_idx: '||in_auction_idx||', in_amount: '||in_writter_idx||']');
				select 1 into isDone from DUAL;
				
			elsif(auction_state =6) then
				delete BID_CONTRACT_QUE where AUCTION_IDX = in_auction_idx;
				
				for BID_ROW in BID_CUR loop
					update BID set STATE_CODE = 21,FINISHED_WHEN = SYSTIMESTAMP where current of BID_CUR;
					insert into MESSAGE (SENDER_IDX, RECEIVER_IDX, TITLE, CONTENT, TYPE_CODE) values (0, BID_ROW.BIDDER_IDX, ''''||auction_title||''' 경매가 취소되었습니다.', '낙찰을 대기중이던 경매가 취소되어 해당 경매에 신청한 입찰이 취소되었습니다.', 1);
				end loop;
				
				delete BID_ALIVE_QUE where AUCTION_IDX = in_auction_idx;
				
				update AUCTION set STATE_CODE = 8, FINISHED_WHEN = SYSTIMESTAMP where IDX = in_auction_idx;
				insert into BAD_DEED_RECORD (CULPRIT_IDX, DEED_CODE) values (in_writter_idx, 7);
				select KARMA into karma_point from BAD_DEED_TYPE where CODE = 7;
				insert into MESSAGE (SENDER_IDX, RECEIVER_IDX, TITLE, CONTENT, TYPE_CODE) values (0, in_auction_idx, ''''||auction_title||''' 경매를 취소하셨습니다.','낙찰중 인 경매를 취소하셨기 때문에 벌점 '||karma_point||'점을 받으셨습니다.',1);
				
				insert into PLOGGER (NAME, RESULTCODE, CONTENT) values ('CANCEL_AUCTION', 1, 'Success. Auction canceled after due. [in_auction_idx: '||in_auction_idx||', in_amount: '||in_writter_idx||']');
				select 1 into isDone from DUAL;
				
			else
				insert into PLOGGER (NAME, RESULTCODE, CONTENT) values ('CANCEL_AUCTION', -3, 'Cannot cancel auction with this stats. [in_auction_idx: '||in_auction_idx||', in_amount: '||in_writter_idx||', auction_state: '||auction_state||']');
				select -3 into isDone from DUAL;
			end if;
		
		end if;
	
	end if;
	
	commit;
	
exception when others then
	rollback to START_TRANSACTION;
	
	err_code := sqlcode;
	err_message := substr(sqlerrm, 1, 255);

	insert into PLOGGER (NAME, RESULTCODE, CONTENT, err_code, err_message)
		values ('CANCEL_AUCTION', 0, 'ERROR!!! ........)', err_code, err_message );
	commit;
	
	select 0 into isDone from DUAL;
end;
/


--drop procedure CANCEL_AUCTION;


----------------------------------------------- 영수증 처리용 프로시저 -----------------------------------------------


/*===============================  1. 임시 영수증 확인 프로시저 ====================================

	결과
		2: 해당 영수증이 임시 대기 상태가 아니며 같은 결제번호로 요청이 들어옴 (누군가 의도적으로 중복값을 보냄. 환불 대상이 아님)
		1: 성공
		0: 에러
		-1: 해당 번호의 임시 영수증이 없음.
		-2: 해당 영수증이 처리 불가능한 상태, 다른 결제번호 ('임시 대기' 상태가 아님.)
		-3: 해당 번호의 영수증이 있고, 임시 영수증인데 요청 계정이 다름
		-4: 임시 처리한 영수증의 금액과 결제 정보의 금액이 다름.
		-5: 임시 영수증에 저장된 옵션이 활성화 상태가 아님
		-6: 구매한 옵션 중 최소 하나의 옵션이 남은 재고가 부족함
		-7: 뭔가 매우 잘못됨

===================================================================================================*/

create procedure CHECK_TEMP_RECPT (in_pay_code MAIN_RECEIPT.PAYMENT_CODE%type, in_acc_idx ACCOUNT.IDX%type, merchant_uid MAIN_RECEIPT.IDX%type, in_price MAIN_RECEIPT.MONEY_AMOUNT%type, isDone out number)
is
	null_checker		number;
	main_rcpt_idx		MAIN_RECEIPT.IDX%type;
	money_amount		MAIN_RECEIPT.MONEY_AMOUNT%type;
	recpt_amount		SALE_OPTION_RECEIPT.AMOUNT%type;
	acc_idx				ACCOUNT.IDX%type;
	sale_title			SALE.TITLE%type;
	pay_code			MAIN_RECEIPT.PAYMENT_CODE%type;

	err_code			number;
	err_message			varchar2(255);
	
	cursor SALE_OPTION_CUR is
		select * from SALE_OPTION where IDX in (select SALE_OPTION_IDX from SALE_OPTION_RECEIPT where MAIN_RECPT_IDX = merchant_uid)for update;
begin
	savepoint START_TRANSACTION;

	select 0 into isDone from DUAL;
	select count(1) into null_checker from MAIN_RECEIPT where IDX = merchant_uid;
	
	if (null_checker =0) then
		select -1 into isDone from DUAL;
	else
		select BUYER_IDX, STATE_CODE, MONEY_AMOUNT, PAYMENT_CODE into acc_idx, null_checker, money_amount, pay_code from MAIN_RECEIPT where IDX = merchant_uid;
		
		if (null_checker <>0) then
			if (pay_code = in_pay_code) then
				select 2 into isDone from DUAL;
			else
				select -2 into isDone from DUAL;
			end if;
			
		elsif(acc_idx <> in_acc_idx) then
			select -3 into isDone from DUAL;
		elsif (money_amount <> in_price) then
			delete MAIN_RECEIPT where IDX = merchant_uid and BUYER_IDX = in_acc_idx;
			select -4 into isDone from DUAL;
		else
			select count(1) into null_checker from SALE_OPTION O inner join SALE_OPTION_RECEIPT R on O.IDX = R.SALE_OPTION_IDX where O.ISDEL <>0;
			
			if (null_checker <>0) then 
				select -5 into isDone from DUAL;
			else
				savepoint OPT_UPDATE;
				
				for SALE_OPTION_ROW in SALE_OPTION_CUR loop
					select AMOUNT into recpt_amount from SALE_OPTION_RECEIPT where MAIN_RECPT_IDX = merchant_uid and SALE_IDX = SALE_OPTION_ROW.SALE_IDX and SALE_OPTION_IDX = SALE_OPTION_ROW.IDX;
					
					if (recpt_amount > SALE_OPTION_ROW.LEFT_AMOUNT ) then
						rollback to OPT_UPDATE;
						select -6 into isDone from DUAL;
						exit;
					end if;
					
					update SALE_OPTION set LEFT_AMOUNT = LEFT_AMOUNT - recpt_amount where current of SALE_OPTION_CUR;
					if (SALE_OPTION_ROW.LEFT_AMOUNT =0) then
						select ACC_IDX, TITLE into acc_idx, sale_title from SALE where IDX = SALE_OPTION_ROW.SALE_IDX;
						insert into MESSAGE (SENDER_IDX, RECEIVER_IDX, TITLE, CONTENT, TYPE_CODE) values (0,acc_idx,'판매글 '''||sale_title||''' 의 옵션 '''||SALE_OPTION_ROW.NAME||''' 이 모두 소진되었습니다.','해당 옵션의 재고가 모두 소진되었음을 알려드립니다.',2);
					end if;
					
				end loop;
				
				if (isDone = 0) then
					update SALE_OPTION_RECEIPT set STATE_CODE = 1 where MAIN_RECPT_IDX = merchant_uid;
					update MAIN_RECEIPT set STATE_CODE = 1, PAYMENT_CODE = in_pay_code where IDX = merchant_uid;
					select 1 into isDone from DUAL;
				else
					select -7 into isDone from DUAL;
				end if;
			end if;
			
			---경매 부분 추가 가능 부분.
		end if;
	end if;
	
	insert into PLOGGER (NAME, RESULTCODE, CONTENT) values ('CHECK_TEMP_RECPT',isDone,'merchant_uid: '||merchant_uid||', in_price: '||in_price||', in_acc_idx: '||in_acc_idx);
	
	commit;
	
exception when OTHERS then
	rollback to START_TRANSACTION;
	
	err_code := sqlcode;
	err_message := substr(sqlerrm, 1, 255);	
		insert into PLOGGER (NAME, RESULTCODE, CONTENT, err_code, err_message)
		values ('CHECK_TEMP_RECPT', 0, 'ERROR!  merchant_uid: '||merchant_uid||', in_price: '||in_price||', in_acc_idx: '||in_acc_idx, err_code, err_message );
	commit;
	
	select 0 into isDone from DUAL;
end;
/

--drop procedure CHECK_TEMP_RECPT;



-------------------------------------------------- 더미 예시 (시퀀스 주의)  ---------------------------------------------------
/*
--계정 썸네일 없는 계정 2개

insert into ACCOUNT (ID, PW, NAME) values ('계정1', 'test', '계정1이름');
insert into ACCOUNT (ID, PW, NAME) values ('계정2', 'test', '계정2이름');

--계정 썸네일 있는 계정 2개
insert into ACCOUNT (ID, PW, NAME, THUMB_LOC) values ('계정3', 'test', '계정3이름', '/img/thumb3.jpg');
insert into ACCOUNT (ID, PW, NAME, THUMB_LOC) values ('계정4', 'test', '계정4이름', '/img/thumb4.jpg');

--사업자 등록증 정보 (계정 4번, 5번)
insert into BUSINESS_INFO (ACC_IDX, BUSINESS_LICENSE_CODE, CORPORATION_NAME, REPRESENTATIVE
, BUSINESS_ADDR, BUSINESS_DETAILED_ADDR, HEADHQUARTER_ADDR, HEADHQUARTER_DETAILED_ADDR, BUSINESS_CATEGORY, BUSINESS_TYPE, REG_DATE, LICENSE_IMG)
	values( 4, 123123, '법인명1', '대표자명1', '사업장 주소1', '사업장 세부주소1', '본점주소1', '본점 세부주소1', '업태1', '업종1', '2017년 1월1일', '/img/license1.jpg');
insert into BUSINESS_INFO (ACC_IDX, BUSINESS_LICENSE_CODE, CORPORATION_NAME, REPRESENTATIVE
, BUSINESS_ADDR, BUSINESS_DETAILED_ADDR, HEADHQUARTER_ADDR, HEADHQUARTER_DETAILED_ADDR, BUSINESS_CATEGORY, BUSINESS_TYPE, REG_DATE, LICENSE_IMG)
	values( 5, 333333, '법인명2', '대표자명2', '사업장 주소2', '사업장 세부주소2', '본점주소2', '본점 세부주소2', '업태2', '업종2', '2015년 2월2일', '/img/license2.jpg');

--판매글 2개
--이미지가 있는 경우
insert into SALE (ACC_IDX, TITLE, ORIGIN, CONTENT, FACE_IMG, MAIN_IMG)
			values (4, '판매글제목1', '원산지원산지', '글내용글내용', '/img/face1.jpg','/img/main1.jpg');
--이미지가 없는 경우
insert into SALE (ACC_IDX, TITLE, ORIGIN, CONTENT)
			values (5, '판매글제목1', '원산지원산지','글내용글내용');

--판매옵션, 판매글 1번에 3개, 2번에 1개.
insert into SALE_OPTION (SALE_IDX, NAME, DESCRIPTION, PRICE, UNIT, START_AMOUNT)
				values (1, '판매글1옵션1','설명설명',12,'단위수1',123);
insert into SALE_OPTION (SALE_IDX, NAME, DESCRIPTION, PRICE, UNIT, START_AMOUNT)
				values (1, '판매글1옵션2','설명설명',233,'단위수2',234);
insert into SALE_OPTION (SALE_IDX, NAME, DESCRIPTION, PRICE, UNIT, START_AMOUNT)
				values (1, '판매글1옵션3','설명설명',345,'단위수3',345);
insert into SALE_OPTION (SALE_IDX, NAME, DESCRIPTION, PRICE, UNIT, START_AMOUNT)
				values (2, '판매글2옵션1','설명설명',432,'단위수4',4563456);

--1번 계정이 뭔가 구매한 주 영수증
insert into MAIN_RECEIPT (BUYER_IDX, MONEY_AMOUNT, PAID_NAME) values (1,300,'구매이름');
--1번 주 영수증에 붙은 일반 구매 묶음 영수증, 2번 판매글에 대한 묶음.
insert into SALE_RECEIPT (MAIN_RECPT_BUYER, MAIN_RECPT_IDX, SALE_IDX) values(1, 1, 2);
--옵션...
--1번 일반 구매 묶음 영수증에 대한 평가 글.
insert into SALE_EVALUATION (SALE_RECEIPT_IDX, SCORE, TITLE) values (1,100,'평가제목');

--insert into AUCTION (WRITTER_IDX, START_PRICE, TITLE, CONTENT, ITEM_IMG, HIGHEST_BID)
--			values (1, 3000, 'auction.test', 'testcontent', 'abcabc', 3000);

*/


------------------------------------------------ 작업영역 (실행하지 마세요) -----------------------------------------------------


/*판매글 쿼리

---판매글  + 옵션 태그 리스트 조회
-- 숫자 막 써진걸 판매글 번호로 바꾸기
-- listagg 에 ', ' 안 내용을 바꾸면 옵션 카테고리가 여러가지 일 경우 사이를 , 가 아닌 다른걸로 바꿈.
-- **** 복사-붙여넣기는 아래 RAW 라고 되어있는걸로 하기!!! ****
select S.*, A.*, B.*, CAT.NAME as CATEGORY_NAME from SALE S inner join Account A on S.ACC_IDX = A.IDX inner join BUSINESS_INFO B on S.ACC_IDX = B.ACC_IDX
	left join ( 
        select listagg(convert(SC.NAME,'UTF8','AL16UTF16'), ', ')within group (order by SC.NAME) as NAME , SC.SALE_IDX 
            from (select distinct C.NAME as NAME, SO.SALE_IDX SALE_IDX from SALE_OPTION SO
            inner join SALE_OPT_CATEGORY SOC on SO.IDX = SOC.SALE_OPT_IDX
            inner join CATEGORY C on SOC.CATEGORY_IDX = C.IDX 
            where SALE_IDX = 1 and C.NAME is not null
        ) SC group by SC.SALE_IDX
    ) CAT
	on CAT.SALE_IDX = S.IDX
where S.IDX = 1 and S.ISDEL =0;

*/


/* 작업용 더미

--insert into ACCOUNT (IDX, ID, PW, NAME, TYPE_CODE, ISDEL) values (0, 'cocoSystem', 'cocoSystem#1234', '시스템', 0, -1);
insert into ACCOUNT (ID, PW, NAME) values ('계정1', 'test', '계정1이름');
insert into ACCOUNT (ID, PW, NAME) values ('계정2', 'test', '계정2이름');
insert into ACCOUNT (ID, PW, NAME) values ('계정3', 'test', '계정3이름');
insert into ACCOUNT (ID, PW, NAME) values ('계정4', 'test', '계정4이름');

insert into AUCTION (WRITTER_IDX, TIME_WINDOW_CODE, START_PRICE, TITLE, CONTENT, ITEM_IMG, HIGHEST_BID) values (1, 4, 3000, 'auction.test2', 'testcontent2', 'abcabc2', 3000);
insert into AUCTION (WRITTER_IDX, TIME_WINDOW_CODE, START_PRICE, TITLE, CONTENT, ITEM_IMG, HIGHEST_BID) values (1, 1, 3000, 'auction.test', 'testcontent', 'abcabc', 3000);

commit;

var isDone number;

exec BIDDER (1, 3300, 2, :isDone);
exec BIDDER (1, 3800, 3, :isDone);
exec BIDDER (1, 4500, 2, :isDone);
exec BIDDER (1, 5000, 3, :isDone);
exec BIDDER (1, 6000, 4, :isDone);
exec BIDDER (1, 8000, 2, :isDone);
exec BIDDER (1, 20000, 1, :isDone);
exec BIDDER (1, 10000, 3, :isDone);
exec BIDDER (1, 15000, 2, :isDone);

commit;

--시간 확인

exec CANCEL_BID (1, 15000, 2, :isDone);
exec CANCEL_BID (1, 10000, 3, :isDone);
exec CANCEL_BID (1, 20000, 1, :isDone);

commit;

exec CANCEL_BID (1, 6000, 4, :isDone);

--exec CANCEL_AUCTION (1, 1, :isDone);

commit;


select * from ACCOUNT;
select * from AUCTION;
select * from AUCTION_DUE_QUE;
select * from BID;
select * from BID_ALIVE_QUE;
select * from MESSAGE order by IDX desc;
select * from BID_CONTRACT_QUE;
select * from PLOGGER order by TIME desc;
select * from BAD_DEED_RECORD order by IDX desc;




drop sequence AUCTION_SEQ;
delete AUCTION;
drop sequence ACCOUNT_SEQ;
delete ACCOUNT;
create sequence AUCTION_SEQ start with 1 increment by 1;
create sequence ACCOUNT_SEQ start with 1 increment by 1;
purge recyclebin;

*/



/* 작업중 프로시저



	결과값
		1. 성공
		0. 오라클 에러
		-1. 해당 입찰이 존재하지 않거나 낙찰 대금을 지불할 수 없는 상태임

aaa






create procedure CONFIRM_CONTRACT (in_auction_idx AUCTION.IDX%type, in_amount AUCTION.HIGHEST_BID%type, in_bidder_idx BID.BIDDER_IDX%type, isDone out number)
is
	null_checker	number;
	bid_account		BID.BIDDER_IDX.type;
	bid_state		BID.STATE_CODE%type;
	auction_state	AUCTION.STATE_CODE%type;
	
	err_code		number;
	err_message		varchar2(255);

begin

	savepoint START_TRANSACTION;
	
	select count(1) into null_checker from BID where AUCTION_IDX = in_auction_idx and AMOUNT = in_amount;
	
	if (null_checker =0) then
		insert into PLOGGER (NAME, RESULTCODE, CONTENT) values ('CONFIRM_CONTRACT',-1,'No such bid exists. usder Bid (auctionIdx: '||in_auction_idx||',amount: '||in_amount||',bidderIdx: '||in_bidder_idx||')');
		select -1 into isDone from DUAL;
	else
		select BIDDER_IDX, STATE_CODE into bid_account, bid_state from BID where AUCTION_IDX = in_auction_idx and AMOUNT = in_amount;
		
		if(in_bidder_idx <> bid_account) then
		
		elsif(bid_state <> 1)
		
		end if;
	
	end if;
	
	
	commit;

exception when OTHERS then
	rollback to START_TRANSACTION;
	
	err_code := sqlcode;
	err_message := substr(sqlerrm, 1, 255);
	
	insert into PLOGGER (NAME, RESULTCODE, CONTENT, err_code, err_message) values ('BIDDER',0,'ERROR! (auctionIdx: '||in_auction_idx||',amount: '||in_amount||',bidderIdx: '||in_bidder_idx||')', err_code, err_message );
	commit;
	
	select 0 into isDone from DUAL;
end;
/







create procedure TEST_PROC(num in number) is
declare
	type arr_type is varray(num) of number;
	arr	arr_type;
begin
	select CODE into arr from BID_STATE_TYPE;
end;
/


*/














	