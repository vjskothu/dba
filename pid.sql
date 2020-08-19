set line 230 pagesize 1000 long 99999999
col username for a20 
col machine for a20 
col program for a35 trun 
col module for a35 trun 
SELECT s.sid, s.serial#, s.username, s.machine, s.program, s.module, s.sql_id FROM gv$process p, gv$session s WHERE p.addr = s.paddr AND p.spid=&pid;

SELECT s.sid, s.serial#, s.username, s.machine, s.program, s.module, s.sql_id, p.spid  FROM gv$process p, gv$session s WHERE p.addr = s.paddr AND s.program  like '%&program%';


 set pages 1000 lines 230 feedback off trims on
 column qcsid format 999999 heading "QC Sid"
 column logon_time format a14 heading "Logon Time"
 column program format a25 trunc
 column process format a7 heading Pid
 column username format a14
 column machine format a12
 column module format a25 trunc
 column osuser format a10 heading "OS User"
 column Degree format 999 heading "Deg"
 column ct format 99 heading "Num|Slav"
 col slaves for 999999
 col tmp_mb for 999,999.9 head "Temp used|(Mbyte)"
 col px_min for 9999 head "PX Run|Mins"
 set head off feed off timing off
  set head on feed on
 break on qcsid skip 1 on module on osuser on machine
 --on logon_time on ct
 select qcsid, s.module, s.osuser, s.machine, s.sql_id,
    to_char(s.logon_time, 'DDMON HH24:MI:SS') logon_time,
    --p.degree,
    sum(decode(qcsid, p.sid, 0, 1)) over(partition by qcsid) ct,
    p.sid, s.process, s.program
 from v$px_session p, v$session s
 where p.sid = s.sid
 and s.sql_id='&sql_id'
 order by qcsid, decode(qcsid, p.sid, 0, 1)
 /
 

