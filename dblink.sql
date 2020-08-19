set line 280 pagesize 1000
col owner for a15
col USERNAME for a30
col HOST for a90 trunc
col DB_LINK for a30
select * from dba_db_links where DB_LINK like '%&DB_LINK%';

