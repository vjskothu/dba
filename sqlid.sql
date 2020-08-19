clear buffer 
set line 230 pagesize 1000 long 9999
col SQL_FULLTEXT for a150 WORD_WRAPPED
select SQL_FULLTEXT,rows_processed from gv$sql where SQL_ID='&SQL_ID';
