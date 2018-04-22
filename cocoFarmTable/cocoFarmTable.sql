/*


USER_TABLES.TABLE_NAME


USER_SEQUENCES.SEQUENCE_NAME



USER_TRIGGERS.TRIGGER_NAME



USER_INDEXES.INDEX_NAME


*/

------------------------------------------------------------------------------------------------------------------

drop trigger ACCOUNT_IDX_TRG;
drop sequence ACCOUNT_SEQ;
drop table ACCOUNT cascade constraints;


------------------------------------------------------------------------------------------------------------------

ALTER SESSION SET PLSCOPE_SETTINGS = 'IDENTIFIERS:NONE';

------------------------------------------------------------------------------------------------------------------


create table ACCOUNT (
	IDX			number(9,0)
	,ID			varchar2(50)	not null unique
	,PW   		varchar2(50) 	not null
	,REG_DATE	timestamp		not null
	,constraint ACCOUNT_PK primary key ( IDX )
	,constraint CHK_PW check ( LENGTH(PW)>7 )
);

create sequence ACCOUNT_SEQ start with 1 increment by 1;

create or replace trigger ACCOUNT_IDX_TRG
	before insert on ACCOUNT
	for each row
begin
	if :NEW.IDX is null 
		then select ACCOUNT_SEQ.nextval into :NEW.IDX from DUAL;
	end if;
	if :NEW.REG_DATE is null
		then :NEW.REG_DATE := SYSDATE;
	end if;
end;
/

comment on table ACCOUNT is '계정 테이블';

comment on column ACCOUNT.IDX is '회원번호 기본키(시퀀스++1)';

comment on column ACCOUNT.ID is '아이디 ( 고유+notnull = 인덱스)';

comment on column ACCOUNT.PW is '비밀번호';

comment on column ACCOUNT.REG_DATE is '회원번호';


--insert into ACCOUNT (ID, PW) values('aaa','12345678');
--select * from ACCOUNT;

--drop trigger ACCOUNT_IDX_TRG;
--drop sequence ACCOUNT_SEQ;
--drop table ACCOUNT cascade constraints;

------------------------------------------------------------------------------------------------------------------

--DD
--select T.OWNER, T.TABLE_NAME, T.COLUMN_NAME, T.QUALIFIED_COL_NAME, C.COMMENTS, T.DATA_TYPE, T.DATA_LENGTH, T.DATA_PRECISION, T.NULLABLE, T.DATA_DEFAULT, T.CHARACTER_SET_NAME, T.CHAR_LENGTH from all_tab_cols T inner join ALL_COL_COMMENTS C  on T.TABLE_NAME = C.TABLE_NAME and T.COLUMN_NAME=C.COLUMN_NAME where T.OWNER='cocoFarm' order by T.TABLE_NAME;
