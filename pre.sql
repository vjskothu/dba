set line 250 pagesize 1000 
col USERNAME for a20
col module for a35
col status for a20
set time off timing off feed off feedback off 
 ALTER SESSION SET nls_date_format='DD-MON-YYYY HH24:MI:SS';
select DBID, NAME, CREATED, LOG_MODE, OPEN_MODE, DATABASE_ROLE, PROTECTION_MODE from v$database ;
col HOST_NAME for a22
select INSTANCE_NUMBER, INSTANCE_NAME, HOST_NAME, STARTUP_TIME, STATUS, PARALLEL, THREAD#, INSTANCE_ROLE, INSTANCE_MODE from v$instance ;
set time on timing on
set feed on feedback on head on heading on
select distinct sid from v$mystat ;

