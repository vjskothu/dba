set pages 0 feed off lines 300 trimsp on

col bind_name for a14
col value_string for a70 trunc
col datatype for a16 trunc
col last_captured for a18
set pages 1000 trimsp on

select to_char(last_captured,'YYYY-MM-DD HH24:MI') last_captured, name as bind_name, value_string, DATATYPE_STRING datatype
from  
    v$sql_bind_capture a
    where 
	sql_id='&sql_id' and 
	    was_captured='YES'
	    union
    select distinct  to_char(last_captured,'YYYY-MM-DD HH24:MI') last_captured, name as name, value_string, DATATYPE_STRING datatype
   from  
dba_hist_sqlbind a
where
   sql_id='&sql_id' and 
was_captured='YES'
 order by 1,2;
