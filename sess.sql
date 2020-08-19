
-------- Session -----------------

clear buffer
set line 200 pagesize 100
set feed off
col USERNAME for a15
col MODULE for a20
col PROCESS for a15
col MACHINE for a22
col MODULE for a20
col SERIAL# for 999999999
set line 200 pagesize 1000
col MACHINE for a20
col osuser for a15
col spid for a15
col SERIAL# for a10
col SERIAL# for 999999999

set line 230 pagesize 1000 
col SQL_TEXT for a60 trun 
  set feed off
   col USERNAME for a15
    col MODULE for a20
     col PROCESS for a15
      col MACHINE for a15
       col MODULE for a20 trun
       col program for a30 trun 
	col SERIAL# for 999999999
	 col LOGON_TIME for a25
	 col module for a30 trun 
--	  select s.SID, s.SERIAL#, s.inst_id, s.USERNAME, s.PROCESS, s.MACHINE, s.LOGON_TIME, s.module, s.status, s.osuser,  s.SQL_ID,a.SQL_TEXT from gv$session s, gv$sqlarea a
	--  where s.SQL_ID=a.SQL_ID and s.INST_ID=a.INST_ID and s.SQL_ID is not null order by s.LOGON_TIME;


set line 230 pagesize 10000 long 999999
col USERNAME for a15
col LOGON_TIME for a20
break on SQL_EXEC_START on SQL_EXEC_ID on SQL_ID on USERNAME on LOGON_TIME 
select INST_ID,SID,SERIAL#,USERNAME,LOGON_TIME,SQL_EXEC_START,SQL_EXEC_ID,SQL_ID,OSUSER,PROGRAM,MODULE,MACHINE from gv$session where sql_id='&sql_id' order by PROGRAM;
col event for a30
select inst_id, USERNAME, PROCESS, MACHINE, SQL_ID, LOGON_TIME, status, event,LAST_CALL_ET from gv$session where sql_id like '&sql_id';

-- Shadow Process 
--SELECT p.spid oracle_dedicated_process, s.process clientpid FROM gv$process p, gv$session s WHERE p.addr = s.paddr AND s.sid = &sid;

set line 200 pagesize 1000
col MACHINE for a20
col osuser for a15
col spid for a15    
col SERIAL# for a10
col SERIAL# for 999999999
select s.sid, s.serial#, s.process, p.spid, osuser, machine, sql_id, status
    from gv$session s, v$process p
    where --s.module = 'SQL*Plus'
sql_id like '&sql_id'
and  s.paddr = p.addr;


set verify off feedback off linesize 200 pagesize 90 echo off
  --  define session_id=378

    col username format a22 head 'User Name' trunc
    col osuser format a12
    col inst_id for 99 head 'I'
    col sid format 99999
    col spid format a8     head "SHADOW"
    col process format a8  head "PROCESS"
    col serial# head Ser# format 99999999
    col terminal format a18 trunc
    col program  format a20 trunc
    col machine format a20  trunc
    col running_sec format a15   head "RUNNING_SECS"
    col sql_id for a13
    col sql for a110 trunc

    break on username on sid on serial# on osuser
    select 
        s.inst_id,
        s.username, osuser,
        s.sid, s.serial#,
        s.program,s.terminal,
        s.machine,s.process,
        p.spid,s.status,
        to_char(logon_time,'DD/MM/YYYY HH24:MI') logon_time,
        regexp_substr(NUMTODSINTERVAL(last_call_et, 'SECOND'),'+\d{2} \d{2}:\d{2}:\d{2}') running_sec
    from 
        gv$session s, 
        gv$process p
    where 
        p.addr (+) = s.paddr 
        and p.inst_id (+) = s.inst_id
        and s.sid=&session_id;
        
    prompt 
    set pages 0
    select 
        'Rows processed = ' || ROWS_PROCESSED || 
        ' (sql_id='||s.sql_id||')  first load time = ' || 
        FIRST_LOAD_TIME || '   ('||sid||','||serial#||')' ||chr(10) as sql, 
        'Event = ' || event
    from
        gv$sqlarea a , 
        gv$session s
    where 
        s.sid = &session_id
        and s.sql_id = a.sql_id 
        and s.inst_id=a.inst_id;


