col OWNER for a30
col GB for 999,999,999
select * from (
select OWNER, sum(BYTES)/1024/1024/1024 GB from dba_segments group by OWNER order by 2 desc 
) where rownum<=50;

