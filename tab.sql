set line 200 pagesize 1000 
col OWNER for a20
col TABLE_NAME for a30
select OWNER, TABLE_NAME, STATUS, NUM_ROWS, DEGREE, LAST_ANALYZED, MONITORING, blocks,PARTITIONED,DEGREE from dba_tables where upper(TABLE_NAME)=upper('&TABLE_NAME');
