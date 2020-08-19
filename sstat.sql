col name for a35 trun 
col module for a25 trun 
select module, sql_id,SQL_EXEC_START, name, value
from V$STATNAME a, v$session b , v$sesstat c 
where a.STATISTIC#=c.STATISTIC#
and b.sid=c.sid 
and c.value >0
and rownum <=25
and b.sid=&sid 
order by value desc ;
