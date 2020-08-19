set line 250 pagesize 1000
undef sql_id
--@$ORACLE_HOME/rdbms/admin/utlxpls.sql

SET LINESIZE 25250 
SET PAGESIZE 0
SELECT *  FROM   TABLE(DBMS_XPLAN.DISPLAY);

	set linesize 230
	set pagesize 500
	select * from TABLE(dbms_xplan.display_awr('&sql_id'));
SELECT * FROM table(DBMS_XPLAN.DISPLAY_CURSOR('&sql_id'));
