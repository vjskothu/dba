set lines 154 verify off
column sid format 999999
column opname format a16
column target format a20
column username format a12
column TIME_REMAINING format 999999 heading "Time|Remain"
column ELAPSED_SECONDS format 999999 heading "Elaps.|Sec"
column units format a6
column start_time heading "Start|Time|ddmon hh:mi" for a11
column LAST_UPDATE_TIME heading "Last|Updated|ddmon hh:mi" for a11
column sofar format 9999999
column TOTALWORK format 9999999 heading "Total|Work"
column qcsid format 99999
column work_done format a15 heading "So Far/|TotalWork"
column sid_qcsid format a11 heading "sid,qcsid"
set long 999999
set line 200
set pagesize 1000

select sid, SERIAL# ||','||qcsid sid_qcsid, decode(opname, 'Index Fast Full Scan', 'Index FFS', opname) opname, 
 target, sofar || '/' || TOTALWORK work_done, UNITS, to_char(START_TIME, 'ddmon hh24:mi') start_time,
 to_char(LAST_UPDATE_TIME, 'ddmon hh24:mi') LAST_UPDATE_TIME, TIME_REMAINING, ELAPSED_SECONDS,
USERNAME, SQL_ID--, QCSID
from gv$session_longops where time_remaining >0-- and username='LSDRRT'
/

