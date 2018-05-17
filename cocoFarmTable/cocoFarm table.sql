

------------------------코코팜 테이블-------------------------

/*
--DD 출력
select T.OWNER, T.TABLE_NAME, T.COLUMN_NAME, T.QUALIFIED_COL_NAME, C.COMMENTS, T.DATA_TYPE, T.DATA_LENGTH, T.DATA_PRECISION, T.NULLABLE, T.DATA_DEFAULT, T.CHARACTER_SET_NAME, T.CHAR_LENGTH
from all_tab_cols T inner join ALL_COL_COMMENTS C  on T.TABLE_NAME = C.TABLE_NAME and T.COLUMN_NAME=C.COLUMN_NAME where T.OWNER='COCOFARM' order by T.TABLE_NAME;

--USER_TABLES.TABLE_NAME
--USER_SEQUENCES.SEQUENCE_NAME
--USER_TRIGGERS.TRIGGER_NAME
--USER_INDEXES.INDEX_NAME
*/

--drop table SITE_IMG_SETTING cascade constraints

drop trigger ANNOUNCEMENT_EDITED_TRG;
drop trigger ANNOUNCEMENT_TRG;
drop sequence ANNOUNCEMENT_SEQ;
drop table ANNOUNCEMENT cascade constraints;

drop trigger TODAYS_FARM_COMM_TRG;
drop sequence TODAYS_FARM_COMM_SEQ;
drop table TODAYS_FARMER_COMMENT cascade constraints;

--drop table TODAYS_FARMER_RECOMMEND cascade constraints;

--drop trigger TODAYS_FARMER_EDIT_TRG;
drop table TODAYS_FARMER cascade constraints;

--drop trigger ACC_SUPPORT_ANS_TRG;
--drop trigger ACC_SUPPORT_INSERT_TRG;
--drop sequence ACC_SUPPORT_SEQ;
--drop table ACCOUNT_SUPPORT cascade constraints;

drop trigger MESSAGE_TRG;
drop sequence MESSAGE_SEQ;
drop table MESSAGE cascade constraints;

drop table MESSAGE_TYPE cascade constraints;

drop table PAYMENT_TYPE cascade constraints;

drop trigger CART_TRG;
drop sequence CART_SEQ;
drop table CART cascade constraints;

drop trigger SALE_INQUIRE_ANSWER_TRG;
drop trigger SALE_INQUIRE_INSERT_TRG;
drop sequence SALE_INQUIRE_SEQ;
drop table SALE_INQUIRE cascade constraints;

drop table SALE_OPT_CATEGORY cascade constraints;

drop trigger SALE_OPTION_WRITTENTIME_TRG;
drop trigger SALE_OPT_UPDATE_TRG;
drop table SALE_OPTION cascade constraints;

drop trigger SALE_LAST_EDITED_TRG;
drop trigger SALE_TRG;
drop sequence SALE_SEQ;
drop table SALE cascade constraints;

drop table CATEGORY_MAP cascade constraints;

drop trigger CATEGORY_TRG;
drop sequence CATEGORY_SEQ;
drop table CATEGORY cascade constraints;

drop trigger BUSINESS_INFO_TRG;
drop table BUSINESS_INFO cascade constraints;

--drop table ENTREPRENEUR_SCORE;

drop trigger ACCOUNT_TRG;
drop sequence ACCOUNT_SEQ;
drop table ACCOUNT cascade constraints;

drop table ACCOUNT_TYPE cascade constraints;

drop table ISDEL_TYPE cascade constraints;


---------------------------- 뭔가 에러가 나면 아래 코드 실행해보기. 매번 할 필요는 없음 ------------------------------------
/*
ALTER SESSION SET PLSCOPE_SETTINGS = 'IDENTIFIERS:NONE';
*/

------------------------------- 설명 --------------------------------------------------

/*

비즈니스 코드, 서브타입 분류 코드 등은 엔티티 내부 TYPE 이름 속성으로 들어감.
비즈니스 코드, 서브타입 분류 정보 테이블은 '원형타입이름_TYPE' 으로 처리함.

서브타입 추가 속성용 테이블 이름:

식별 번호: IDX
인조식별자 : sequence.nextval 을 이용해서 정수로 처리. cash 는 기본값이 15이었던듯. 사이클이나 최대 크기를 따로 고려 안함.

트리거 있음: 주로 새 인스턴스(행) 입력시(insert) 자동으로 특정 속성 기입. 아닐때도 있으니 확인.

식별관계: 외래키가 not null 처리됨 - 참조대상의 존재에 의존적일 때.
외래키 속성 이름은 주로 '대상테이블_속성이름' 으로 했음.

확인용 플래그(indicator)는 number(1,0)에 check으로 1,0 만 허용. - 기본값(default) 확인하기!!
확인용 플래그 이름은 'IS내용'.
예시) ISDEL - 지워졌나? 0:false(안지워짐) 1:true(지워짐)


쪽지
idx pk
주는사람 foreign key references ACCOUNT.IDX
받는사람 foreign key references ACCOUNT.IDX

제목
내용
시간
읽음?
타입?

*/

------------------------------------------------  삭제상태 코드 ----------------------------------------------------
-- 삭제상태 코드 정리용.. 신경 안써도 됨. 뭔가 특별한 상태값을 더 추가하고 싶으면 이용하기

create table ISDEL_TYPE (

	CODE			number(1,0)
	,NAME			nvarchar2(15) not null
	,DESCRIPTION	nvarchar2(400)

	,constraint ISDEL_TYPE_PK primary key (CODE)
);


comment on table ISDEL_TYPE is '삭제상태 코드';

comment on column ISDEL_TYPE.CODE is '삭제상태 코드 - 기본키. 시퀀스 없음. 0: 삭제안됨, 1: 삭제됨';

comment on column ISDEL_TYPE.NAME is '상태 이름';

comment on column ISDEL_TYPE.DESCRIPTION is '상태 설명';


insert all
	into ISDEL_TYPE (CODE, NAME) values (0, '삭제안됨')
	into ISDEL_TYPE (CODE, NAME) values (1, '삭제됨')
select 1 from dual;

commit;


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


comment on table ACCOUNT_TYPE is '계정코드 테이블';

comment on column ACCOUNT_TYPE.CODE is '계정코드 번호';

comment on column ACCOUNT_TYPE.NAME is '계정코드 이름';

comment on column ACCOUNT_TYPE.DESCRIPTION is '계정코드 설명';

insert all
	into ACCOUNT_TYPE (CODE, NAME) values (0, '시스템')
	into ACCOUNT_TYPE (CODE, NAME) values (1, '관리자 계정')
	into ACCOUNT_TYPE (CODE, NAME) values (2, '사업자 계정')
	into ACCOUNT_TYPE (CODE, NAME) values (3, '일반 계정')
select 1 from dual;

commit;


--drop table ACCOUNT_TYPE cascade constraints;


------------------------------------------------  계정  ----------------------------------------------------
--세션 [ "idx" : IDX (INTEGER - int 아님, 널 확인 코드용), "type": TYPE (String), +옵션사항 "name" : NAME (String) ]

create table ACCOUNT (

	IDX					number(8,0)
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
	,ISDEL				number(1,0)		default 0 not null

	,THUMB_LOC			varchar2(100 char)
	,REG_DATE			timestamp (0) with local time zone	not null

	,constraint ACCOUNT_PK primary key (IDX)
	,constraint FK_ACC_ISDEL_TYPE foreign key (ISDEL) references ISDEL_TYPE (CODE)
	,constraint FK_ACCOUNT_ACCTYPE foreign key (TYPE_CODE) references ACCOUNT_TYPE (CODE)
);

create sequence ACCOUNT_SEQ start with 1 increment by 1;

create trigger ACCOUNT_TRG
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
--트리거 설명: 행 추가시 IDX가 없을 때 sequence.nextval 을 자동으로 넣음, REG_DATE 가 없을 때 시스템 시간을 넣음


comment on table ACCOUNT is '계정 테이블';

comment on column ACCOUNT.IDX is '게정번호- 기본키, 인조식별자 - 트리거 있음';

comment on column ACCOUNT.ID is '계정 아이디 - null 안됨, unique';

comment on column ACCOUNT.PW is '계정 암호 null 안됨';

comment on column ACCOUNT.NAME is '사용자 이름 null 안됨';

comment on column ACCOUNT.EMAIL is '이메일';

comment on column ACCOUNT.PHONE is '전화번호';

comment on column ACCOUNT.PHONE2 is '전화번호2';

comment on column ACCOUNT.POSTNUM is '우편번호';

comment on column ACCOUNT.ADDR is '주소 - 도 시 구 동 까지만, api 따름';

comment on column ACCOUNT.DETAILED_ADDR is '세부주소';

comment on column ACCOUNT.TYPE_CODE is '계정타입 - 외래키, null 안됨(식별관계)';

comment on column ACCOUNT.ISDEL is '삭제 확인 코드 - 외래키 null 안됨 기본값:0';

comment on column ACCOUNT.THUMB_LOC is '썸네일 위치 디렉토리 이름';

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
------------------------------------------------  사업자 정보  ----------------------------------------------------
-- 사업자 등록증에 등록일자가 따로 있으면, 우리쪽에 정보를 입력한 시점을 기록하는 등록일자와 구분해서 하나 더 속성을 추가해야함.

create table BUSINESS_INFO (

	ACC_IDX							number(8,0)		not null
	,BUSINESS_LICENSE_CODE			number(10,0)	not null
	,CORPORATION_NAME				nvarchar2(20)	not null
	,REPRESENTATIVE					nvarchar2(20)	not null

	,BUSINESS_ADDR					nvarchar2(4)	not null
	,BUSINESS_DETAILED_ADDR			nvarchar2(50)	not null

	,HEADHQUARTER_ADDR				nvarchar2(20)	not null
	,HEADHQUARTER_DETAILED_ADDR		nvarchar2(50)	not null

	,BUSINESS_CATEGORY				nvarchar2(25)	not null
	,BUSINESS_TYPE					nvarchar2(25)	not null

	,REG_DATE						timestamp (0) with local time zone	not null

	,constraint BUSINESS_INFO_PK primary key (ACC_IDX, BUSINESS_LICENSE_CODE)
	,constraint FK_BUSINESS_INFO_ACCOUNT_IDX foreign key (ACC_IDX) references ACCOUNT (IDX) on delete cascade
);

create trigger BUSINESS_INFO_TRG
	before insert on BUSINESS_INFO 
	for each row
	when (NEW.REG_DATE is null)
begin
	:NEW.REG_DATE := SYSTIMESTAMP;
end;
/
--트리거 설명: REG_DATE 가 없을 때 시스템 시간을 넣음


comment on table BUSINESS_INFO is '사업자 등록 정보 - 전체가 null안됨';

comment on column BUSINESS_INFO.ACC_IDX is '계정번호 참조 외래키 + 복합 기본키 = 계정마다 서로 다른 여러 개의 사업자 정보를 등록 가능.';

comment on column BUSINESS_INFO.BUSINESS_LICENSE_CODE is '사업자 번호 + 복합 기본키';

comment on column BUSINESS_INFO.CORPORATION_NAME is '법인명/단체명';

comment on column BUSINESS_INFO.REPRESENTATIVE is '대표자';

comment on column BUSINESS_INFO.BUSINESS_ADDR is '사업장 세부주소 앞 까지';

comment on column BUSINESS_INFO.BUSINESS_DETAILED_ADDR is '사업장 소재지 - 세부주소';

comment on column BUSINESS_INFO.HEADHQUARTER_ADDR is '본점주소 - 도 시 동 까지';

comment on column BUSINESS_INFO.HEADHQUARTER_DETAILED_ADDR is '본점주소 - 세부주소';

comment on column BUSINESS_INFO.BUSINESS_CATEGORY is '사업의 업태';

comment on column BUSINESS_INFO.BUSINESS_TYPE is '사업의 종류';

comment on column BUSINESS_INFO.REG_DATE is '등록일 - 트리거있음';


--drop trigger BUSINESS_INFO_TRG;
--drop table BUSINESS_INFO cascade constraints;


---------------------------------------------- 카테고리 노드 ----------------------------------------------------

create table CATEGORY (

	IDX					number(3,0)
	,NAME				nvarchar2(15) not null
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


comment on table CATEGORY is '카테고리 노드';

comment on column CATEGORY.IDX is '카테고리 식별 번호 - 인조식별자 기본키. 트리거있음';

comment on column CATEGORY.NAME is '카테고리 노드 이름 - null 안됨';

comment on column CATEGORY.DESCRIPTION is '카테고리 노드 설명';


--drop trigger CATEGORY_TRG;
--drop sequence CATEGORY_SEQ;
--drop table CATEGORY cascade constraints;


---------------------------------------------- 카테고리 맵 ----------------------------------------------
-- 트리가 아니라 그래프 구조로 바꿈. 순환구조 허용됨.

create table CATEGORY_MAP (

	SUPER_CATEGORY		number(3,0)
	,SUB_CATEGORY		number(3,0)

	,DESCRIPTION		nvarchar2(300)

	,constraint PROD_CAT_MAP_PK primary key (SUPER_CATEGORY, SUB_CATEGORY)
	,constraint PROD_SUPERCAT_MAP_FK foreign key (SUPER_CATEGORY) references CATEGORY (IDX) on delete cascade
	,constraint PROD_SUBCAT_MAP_FK foreign key (SUB_CATEGORY) references CATEGORY (IDX) on delete cascade
	,constraint PROD_CAT_MAP_CHECKER check (SUPER_CATEGORY <> SUB_CATEGORY)
);


comment on table CATEGORY_MAP is '카테고리 맵 (카테고리간 관계 설정)';

comment on column CATEGORY_MAP.SUPER_CATEGORY is '상위 분류 - 기본키 + 외래키 (카테고리 IDX) 식별관계';

comment on column CATEGORY_MAP.SUB_CATEGORY is '하위 분류 - 기본키 + 외래키 (카테고리 IDX) 식별관계';

comment on column CATEGORY_MAP.DESCRIPTION is '관계 설명';


--drop table CATEGORY_MAP cascade constraints;


---------------------------------------------- 판매글 (거래 중개) ----------------------------------------------------

create table SALE(

	IDX				number(9,0)
	,ACC_IDX		number(8,0)		not null
	,TITLE			nvarchar2(40)	not null

-- 원산지 일단 한 속성에 몰아서 처리함. 어차피 한개 속성에 뭉쳐서 처리한다면 원산지를 개별 옵션에 주는걸 추천..
	,ORIGIN			nvarchar2(60)	not null

	,WRITTEN_TIME	timestamp (0) with local time zone	not null
	,LAST_EDITED	timestamp (0) with local time zone

	,CONTENT		nvarchar2(1000)

	,IMG_FACE		varchar2(100 char)
	,IMG_MAIN		varchar2(100 char)

-- 아래는 평균점수, 쿼리를 편하게 처리하기 위해 추가할 만한 중복 데이터. 쓰려면 주석해제하고 쓰기. 트리거 이용 금지(삭제시 문제유발). procedure을 이용하거나 application에서 무결성을 지키기 위한 로직 만들기.
--	,AVG_SCORE		number(3,2)

	,ISDEL			number(1,0) default 0 not null
-- 이렇게 삭제 처리시 옵션도 같이 삭제처리를 이렇게 하고 조회를 막아야함. (필요하면 VIEW를 만들어 사용)
	,constraint SALE_PK primary key (IDX)
	,constraint FK_SALE_ACC_IDX foreign key (ACC_IDX) references ACCOUNT (IDX) on delete cascade
	,constraint FK_SALE_ISDEL_TYPE foreign key (ISDEL) references ISDEL_TYPE (CODE)
);

create sequence SALE_SEQ start with 1 increment by 1;

create trigger SALE_TRG
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
--트리거 설명: 행 추가시 IDX가 없을 때 sequence.nextval 을 자동으로 넣음, WRITTEN_TIME 가 없을 때 시스템 시간을 넣음

create trigger SALE_LAST_EDITED_TRG
	before update on SALE
	for each row
begin
	:NEW.LAST_EDITED := SYSTIMESTAMP;
end;
/
--트리거 설명: update 시 해당 행에 LAST_EDITED 값을 시스템 시간으로 처리.

comment on table SALE is '판매 목록';

comment on column SALE.IDX is '판매글 번호 - 기본키 인조식별자. 트리거 있음';

comment on column SALE.ACC_IDX is '판매글 올린이 idx - 외래키 null안됨 : 식별관계';

comment on column SALE.TITLE is '판매글제목 - null 안됨';

comment on column SALE.origin is '원산지. - null안됨';

comment on column SALE.WRITTEN_TIME is '글 쓴 시간 - 트리거 있음';

comment on column SALE.LAST_EDITED is '마지막 수정 시간 - 트리거 있음 (옵션의 변경에 대해서는 트리거가 안되어있음. 필요하면 만들 수 있을듯)';

comment on column SALE.CONTENT is '부가설명(글내용)';

comment on column SALE.IMG_FACE is '대표이지미 파일 위치 (디렉토리와 이름을 모두 포함해서 저장하기, 원래이름은 필요없음)';

comment on column SALE.IMG_MAIN is '본문이미지 파일 위치 (디렉토리와 이름을 모두 포함해서 저장하기, 원래이름은 필요없음)';

--comment on column SALE.AVG_SCORE is '평균점수 - 중복데이터, 무결성 주의';

comment on column SALE.ISDEL is '삭제 확인 코드 - 외래키, 기본값:0, null안됨';


--drop trigger SALE_LAST_EDITED_TRG;
--drop trigger SALE_TRG;
--drop sequence SALE_SEQ;
--drop table SALE cascade constraints;


---------------------------------------------- 판매 옵션 ----------------------------------------------------

create table SALE_OPTION (

	SALE_IDX		number(9,0)
	,NAME			nvarchar2(25)
	,DESCRIPTION	nvarchar2(200)

	,PRICE			number(7,0)		not null

	,UNIT			nvarchar2(20)	not null
	,START_AMOUNT	number(7,0)		not null
	,LEFT_AMOUNT	number(7,0)		not null
	
	,LASTSOLD_TIME	timestamp(0) with local time zone

	,WRITTEN_TIME	timestamp(0) with local time zone not null
	,LAST_EDITED	timestamp(0) with local time zone

	,ISDEL			number(1,0)		default 0 not null

	,constraint SALE_OPTION_PK primary key (SALE_IDX, NAME)
	,constraint FK_SALE_OPT_SALE foreign key (SALE_IDX) references SALE (IDX) on delete cascade
	,constraint FK_SALE_OPT_ISDEL foreign key (ISDEL) references ISDEL_TYPE (CODE)
	,constraint SALE_OPT_PRICE_CHECK check ( PRICE > 0 )
	,constraint SALE_OPT_AMOUNT_CHECK check ( START_AMOUNT > 0 and LEFT_AMOUNT >= 0 )

);

create trigger SALE_OPTION_WRITTENTIME_TRG
	before insert on SALE_OPTION
	for each row
	when (NEW.WRITTEN_TIME is null)
begin
	:NEW.WRITTEN_TIME := SYSTIMESTAMP;
end;
/
--트리거 설명: 판매옵션 들어간 시간 저장. (혹시 나중에 판매글마다 별개로 추가 할 수 있으므로..)

create trigger SALE_OPT_UPDATE_TRG
	before update of NAME, DESCRIPTION, PRICE, UNIT on SALE_OPTION
	for each row
	when (NEW.LAST_EDITED is null)
begin
	:NEW.LAST_EDITED := SYSTIMESTAMP;
end;
/
--트리거 설명: 판매옵션 내용이 마지막으로 수정된 시각 저장.

comment on table SALE_OPTION is '판매 옵션 목록 테이블';

comment on column SALE_OPTION.SALE_IDX is '판매글 번호 - 복합기본키 + 외래키 판매글번호 참조 : 식별관계';

comment on column SALE_OPTION.NAME is '판매 옵션 이름 - 복합기본키 : 같은 판매글에 같은 이름의 옵션 불허 - 만약 허용하려면 인조식별자 쓰기';

comment on column SALE_OPTION.DESCRIPTION is '판매 옵션 설명';

comment on column SALE_OPTION.PRICE is '판매 옵션 가격 - null안됨 0초과.';

comment on column SALE_OPTION.UNIT is '판매 옵션 (개수당)단위 - null안됨';

comment on column SALE_OPTION.START_AMOUNT is '판매 옵션 시작 개수 - null안됨 0초과';

comment on column SALE_OPTION.LEFT_AMOUNT is '판매 옵션 남은 개수 - null안됨 0이상';

comment on column SALE_OPTION.LASTSOLD_TIME is '마지막으로 해당 옵션이 팔린 시각';

comment on column SALE_OPTION.WRITTEN_TIME is '해당 옵션을 등록한 시각 - 트리거 있음';

comment on column SALE_OPTION.LAST_EDITED is '해당 옵션 내용이 마지막으로 수정된 시각 - 트리거 있음';

comment on column SALE_OPTION.ISDEL is '삭제 확인 코드 - 외래키, 기본값:0, null안됨';


--drop trigger SALE_OPTION_WRITTENTIME_TRG;
--drop trigger SALE_OPT_UPDATE_TRG;
--drop table SALE_OPTION cascade constraints;


----------------------------------------------  옵션 카테고리 매핑  ----------------------------------------------
-- 옵션에 복수 카테고리 허용(안써도 작동에 전혀 문제 없음)

create table SALE_OPT_CATEGORY (

	SALE_IDX			number(9,0)
	,OPT_NAME			nvarchar2(25)
	,CATEGORY_IDX		number(3,0)

	,constraint SALE_OPT_CAT_PK primary key (SALE_IDX, OPT_NAME, CATEGORY_IDX)
	,constraint FK_OPT_CATMAP_SALEOPT foreign key (SALE_IDX, OPT_NAME) references SALE_OPTION (SALE_IDX, NAME) on delete cascade
	,constraint FK_OPT_CATMAP_CATNODE foreign key (CATEGORY_IDX) references CATEGORY (IDX)
);

comment on table SALE_OPT_CATEGORY is '판매옵션 카테고리 매핑 - 복수 카테고리 허용';

comment on column SALE_OPT_CATEGORY.SALE_IDX is '대상 옵션의 판매글 번호 - 복합 기본키 + 복합 외래키';

comment on column SALE_OPT_CATEGORY.OPT_NAME is '대상 옵션의 이름 - 복합 기본키 + 복합 외래키';

comment on column SALE_OPT_CATEGORY.CATEGORY_IDX is '카테고리 - 복합 기본키 + 외래키';

--drop table SALE_OPT_CATEGORY;

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
*/

---------------------------------------------- 판매 평가 댓글 (삭제중) ----------------------------------------------------
/*
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

*/
---------------------------------------------- 판매글  조회수..? ----------------------------------------------------

---------------------------------------------- 판매글에 대한 문의글 ----------------------------------------------------

create table SALE_INQUIRE(

	IDX				number(11,0)
	,SALE_IDX		number(9,0)		not null
	,WRITER_IDX		number(8,0)		not null

	,TITLE			nvarchar2(40)	not null
	,CONTENT		nvarchar2(2000)
	,WRITTEN_TIME	timestamp (0) with local time zone not null

	,ANSWER			nvarchar2(2000)
	,ANSWER_TIME	timestamp (0) with local time zone

	,ISDEL			number(1,0)		default 0 not null

	,constraint SALE_INQUIRE_PK primary key (IDX)
	,constraint FK_SALE_INQUIRE_SALE_IDX foreign key (SALE_IDX) references SALE (IDX) on delete cascade
	,constraint FK_SALE_INQUIRE_ACC_IDX foreign key (WRITER_IDX) references ACCOUNT (IDX) on delete cascade
	,constraint FK_SALE_INQUIRE_ISDEL foreign key (ISDEL) references ISDEL_TYPE (CODE)
);

create sequence SALE_INQUIRE_SEQ start with 1 increment by 1;

create trigger SALE_INQUIRE_INSERT_TRG
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

comment on column SALE_INQUIRE.IDX is '판매 문의 번호 - 인조식별자, 기본키';

comment on column SALE_INQUIRE.SALE_IDX is '대상 판매글 - 외래키 (판매글.IDX). null 안됨';

comment on column SALE_INQUIRE.WRITER_IDX is '글쓴이 - 외래키 (계정.IDX). null 안됨';

comment on column SALE_INQUIRE.TITLE is '제목 - null 안됨';

comment on column SALE_INQUIRE.CONTENT is '내용';

comment on column SALE_INQUIRE.WRITTEN_TIME is '글 쓴 시각 - null 안됨. 트리거 있음';

comment on column SALE_INQUIRE.ANSWER is '응답 - 당연히 해당 글이 속한 판매글의 판매자 만이 응답 가능하게 해야 함.';

comment on column SALE_INQUIRE.ANSWER_TIME is '응답 시각 - 트리거 있음';

comment on column SALE_INQUIRE.ISDEL is '삭제 확인 코드 - 외래키, 기본값:0, null안됨';


--drop trigger SALE_INQUIRE_ANSWER_TRG;
--drop trigger SALE_INQUIRE_INSERT_TRG;
--drop sequence SALE_INQUIRE_SEQ;
--drop table SALE_INQUIRE cascade constraints;


------------------------------------------------  장바구니  ----------------------------------------------------
--ACC_IDX 와 SALE_IDX, SALE_OPT_NAME 을 묶어서 유일성 부여. -> 장바구니에 이미 있는 목록에 또 추가버튼을 누르거나 하는 식의 작동방식은 일단 어플리케이션에서 잘 처리해야 함. (아니면 트리거를 쓸 수도 있고.)

create table CART (

	IDX				number(9,0) not null unique
	,ACC_IDX		number(8,0)
	,SALE_IDX		number(9,0)
	,SALE_OPT_NAME	nvarchar2(25)
	,COUNT			number(7,0)		not null
	
	,ADDED_TIME		timestamp(0) with local time zone

	,constraint CART_PK primary key (ACC_IDX, SALE_IDX, SALE_OPT_NAME)
	,constraint FK_CART_ACCOUNT foreign key (ACC_IDX) references ACCOUNT (IDX) on delete cascade
	,constraint FK_CART_SALE_OPT foreign key (SALE_IDX, SALE_OPT_NAME) references SALE_OPTION (SALE_IDX, NAME) on delete cascade
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

comment on column CART.IDX is '식별번호 - 후보키 인조식별자. 순전히 쿼리를 쉽게 하기 위한 도구로 넣음';

comment on column CART.ACC_IDX is '계정번호 - 복합기본키 + 외래키 (계정.계정번호)';

comment on column CART.SALE_IDX is '해당 옵션의 판매글 번호 - 복합기본키 + 외래키 (판매옵션.판매글번호)';

comment on column CART.SALE_OPT_NAME is '해당 옵션의 이름 - 복합기본키 + 외래키 (판매옵션.옵션이름)';

comment on column CART.COUNT is '갯수, 실제 남은 숫자는 비교를 안하니 조심. - application에서 무결성을 확인 해야 하는 부분';

comment on column CART.ADDED_TIME is '등록시간 - 트리거 있음';


--drop trigger CART_TRG;
--drop sequence CART_SEQ;
--drop table CART cascade constraints;


--------------------------------------------------------------------------------------------------
/*
--결제 타입
구매/입찰 구분자 코드
경매 보증금/입찰가 구분
배송

영수증
	산사람
	판사람
	결제 타입
	결제 금액
	결제 시간
	배송 참조

경매물품
	원래글 참조키
	이름
	보증금여부?
	가격
	환불 여부
	환불 시간
	
판매물품
	원래 옵션 참조
	이름
	가격
	단위
	개수
	환불 여부
	환불 시간
*/
---------------------------------------------- 결제 타입 ----------------------------------------------------
-- 결제형태가 여러개 나올 수 있다는 가정 하에 만듬. 안쓰일듯?

create table PAYMENT_TYPE (

	CODE			number(2,0)
	,NAME			nvarchar2(20) not null
	,DESCRIPTION	nvarchar2(200)

	,constraint PAYMENT_TYPE_PK primary key (CODE)
);

comment on table PAYMENT_TYPE is '결제타입(코드) 테이블';

comment on column PAYMENT_TYPE.CODE is '결제타입 코드 -트리거나 시퀀스 없음';

comment on column PAYMENT_TYPE.NAME is '결제타입 코드 이름';

comment on column PAYMENT_TYPE.DESCRIPTION is '결제타입 코드 설명';


--drop table PAYMENT_TYPE cascade constraints;


-----------------------------------------------  경매  -------------------------------------------------------
-----------------------------------------------  입찰  -------------------------------------------------------
-----------------------------------------------  구매  -------------------------------------------------------
-----------------------------------------------  배송  -------------------------------------------------------

------------------------------------------------  쪽지 타입 -------------------------------------------------
-- 일단 쪽지 조회를 쉽게 처리하기 위해 넣은 테이블. 추가적인 타입을 지정하면서 여러 용도로 사용 가능

create table MESSAGE_TYPE (

	CODE				number(2,0)
	,NAME				nvarchar2(50) not null
	,DESCRIPTION		nvarchar2(2000)

	,constraint PK_MESSAGE_TYPE primary key (CODE)
);

comment on table MESSAGE_TYPE is '쪽지 타입 비즈니스 코드 테이블';

comment on column MESSAGE_TYPE.CODE is '쪽지 타입 코드 - 기본키 시퀀스없음';

comment on column MESSAGE_TYPE.NAME is '쪽지 타입 이름 - null 안됨';

comment on column MESSAGE_TYPE.DESCRIPTION is '쪽지 타입 설명';


--drop table MESSAGE_TYPE cascade constraints;


------------------------------------------------  쪽지  ----------------------------------------------------

create table MESSAGE (

	IDX					number(12,0)
	,SENDER_IDX			number(8,0)			not null
	,RECEIVER_IDX		number(8,0)			not null

	,TITLE				nvarchar2(200)		not null
	,CONTENT			nvarchar2(1000)
	,WRITTEN_TIME		timestamp(0) with local time zone not null

	,IS_READ			number(1,0)			default 0 not null
	,READ_TIME			timestamp(0) with local time zone

	,TYPE_CODE			number(2,0)			not null

	,ISDEL				number(1,0)			default 0 not null

	,constraint MESSAGE_PK primary key (IDX)
	,constraint FK_MESSAGE_SENDER_ACCIDX foreign key (SENDER_IDX) references ACCOUNT (IDX) on delete cascade
	,constraint FK_MESSAGE_RECEIVER_ACCIDX foreign key (RECEIVER_IDX) references ACCOUNT (IDX) on delete cascade
	,constraint FK_MESSAGE_MSGTYPE foreign key (TYPE_CODE) references MESSAGE_TYPE (CODE)
	,constraint FK_MESSAGE_ISDEL foreign key (ISDEL) references ISDEL_TYPE (CODE)
);

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

comment on column MESSAGE.IDX is '쪽지번호 - 기본키, 인조식별자';

comment on column MESSAGE.SENDER_IDX is '보낸사람 - 외래키 (계정.계정번호) null안됨';

comment on column MESSAGE.RECEIVER_IDX is '받는사람 - 외래키 (계정.계정번호) null안됨';

comment on column MESSAGE.TITLE is '제목 - null 안됨';

comment on column MESSAGE.CONTENT is '내용';

comment on column MESSAGE.WRITTEN_TIME is '작성시각 - null안됨 트리거 있음';

comment on column MESSAGE.IS_READ is '조회 여부 표시. 1:읽음, 0:안읽음, 기본값:0';

comment on column MESSAGE.READ_TIME is '읽은 시각 기록 - 조회여부 확인용.';

comment on column MESSAGE.TYPE_CODE is '메세지 타입 - 일단은 시스템 알림이나 관리자 문의사항 조회를 쉽게 하기 위한 부분인데, 더 세분화 해서 기능을 확장할 수 있는 부분(추가 테이블이 필요할 수도 있음). 예시) 중요 메세지 표시';

comment on column MESSAGE.ISDEL is '삭제 확인 코드 - 외래키, 기본값:0, null안됨';


--drop trigger MESSAGE_TRG;
--drop sequence MESSAGE_SEQ;
--drop table MESSAGE cascade constraints;


------------------------------------------------  1:1 문의(취소됨?)  ----------------------------------------------------

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

	,TITLE			nvarchar2(30)	not null
	,CONTENT		nclob
--(내용 nclob. 각종html 을 넣다보면 매우 길어질 거라 생각해서 nclob. 대신 문자열로 바꾸기 위해서 to_nclob 함수 이용. 불편하고 쓸데없다 싶으면 nvarchar2 로 변경:최대 2000자)
	,WRITTEN_TIME	timestamp (0) with local time zone default SYSTIMESTAMP not null
	
	,VIEW_COUNT		number(9,0) default 0
	,LAST_EDITED	timestamp (0) with local time zone

--	,RECOMMEND		number(8,0)	(매번 전체조회를 피하기 위해 넣을 수 있는 속성, 무결성 관리를 하려면 별도의 뷰를 생성하고 트리거를 쓰는 짓을 해야 되서 일단 보류)

	,IMG			varchar2(100 char)
--이미지를 제대로 여럿 넣으려면 별도의 테이블 쓰기

	,ISDEL			number(1,0) default 0 not null

	,constraint TODAYS_FARMER_PK primary key (ACC_IDX)
	,constraint FK_TODAYS_FARMER_ACC foreign key (ACC_IDX) references ACCOUNT (IDX) on delete cascade
	,constraint TODAYS_FARM_VCOUNT_CHECK check (VIEW_COUNT >=0)
	,constraint FK_TODAYS_FARMER_ISDEL foreign key (ISDEL) references ISDEL_TYPE (CODE)
);

/* nclob/clob 에 update 트리거 불가능..,
create trigger TODAYS_FARMER_EDIT_TRG
	before update of TITLE, CONTENT, IMG on TODAYS_FARMER
	for each row
	when (NEW.LAST_EDITED is null)
begin
	:NEW.LAST_EDITED := SYSTIMESTAMP;
end;
/
--트리거 설명: 오늘의 농부 마지막 수정시각 처리
*/

comment on table TODAYS_FARMER is '오늘의 농부';

comment on column TODAYS_FARMER.ACC_IDX is '계정 번호- 기본키 + 외래키 (계정.계정번호) = 1:1. 계정타입에 대한 규칙은 application에서 관리하기';

comment on column TODAYS_FARMER.TITLE is '제목 - null 안됨';

comment on column TODAYS_FARMER.CONTENT is '내용 - 각종html 을 넣다보면 매우 길어질 거라 생각해서 nclob. 대신 문자열로 바꾸기 위해서 to_nclob 함수 이용. 불편하고 쓸데없다 싶으면 nvarchar2 로 변경';

comment on column TODAYS_FARMER.WRITTEN_TIME is '작성 시각 - null 안됨, 기본값: 시스템 시각';

comment on column TODAYS_FARMER.VIEW_COUNT is '조회수';

comment on column TODAYS_FARMER.LAST_EDITED is '마지막 수정시각 - 트리거 없음. 글내용의 data type 이 clob 라서 update 관련 트리거가 안됨';

--comment on column TODAYS_FARMER.RECOMMEND is '추천? 점수? 보류중';

comment on column TODAYS_FARMER.IMG is '이미지 위치(경로+파일이름 전부) 저장. 원래이름은 필요 없음, 아마도.';

comment on column TODAYS_FARMER.ISDEL is '삭제 확인 코드 - 외래키, 기본값:0, null안됨';


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
------------------------------------------------  오늘의 농부 댓글 ----------------------------------------------------

create table TODAYS_FARMER_COMMENT (

	IDX						number(10,0)
	,TODAYS_FARMER_IDX		number(8,0)		not null
	,WRITER_IDX					number(8,0)		not null
	,CONTENT				nvarchar2(400)	not null

	,WRITTEN_TIME			timestamp (0) with local time zone not null
	,LAST_EDITED			timestamp (0) with local time zone

	,SUPER_COMMENT			number(10,0)

	,ISDEL					number(1,0) default 0 not null

	,constraint TODAYS_FARM_COMM_PK primary key (IDX)
	,constraint FK_TODAYS_FARM_COMM foreign key (TODAYS_FARMER_IDX) references TODAYS_FARMER (ACC_IDX) on delete cascade
	,constraint FK_FARM_COMM_WRITER foreign key (WRITER_IDX) references ACCOUNT (IDX) on delete cascade
	,constraint FK_TODAYS_FARM_ISDEL foreign key (ISDEL) references ISDEL_TYPE (CODE)
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

comment on column TODAYS_FARMER_COMMENT.IDX is '오늘의 농부 댓글번호 - 기본키, 인조식별자';

comment on column TODAYS_FARMER_COMMENT.TODAYS_FARMER_IDX is '오늘의 농부 글번호 - 외래키. null 안됨';

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
