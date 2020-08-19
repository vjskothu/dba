set line 250 pagesize 1000 long 999999 
select dbms_metadata.get_ddl('&Type','&object','&user') from dual; 
