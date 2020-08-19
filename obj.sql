set line 200 pagesize 1000 
col OBJECT_NAME for a30
col OWNER for a15
select OWNER, OBJECT_NAME, OBJECT_ID, CREATED, OBJECT_TYPE, LAST_DDL_TIME, STATUS from dba_objects where OBJECT_NAME='&OBJECT_NAME';

select OWNER, OBJECT_NAME, OBJECT_ID, CREATED, OBJECT_TYPE, LAST_DDL_TIME, STATUS from dba_objects where OBJECT_NAME like '%&OBJ%' and owner not in ('SYS','PUBLIC');
