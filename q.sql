set recsep off
 set lines 200
 set pages 50000
 col PLAN_TABLE_OUTPUT head "Plan|Table" for a200
 column first_load_time format a12 heading "First Load|Time"
 column last_active format a12 heading "Last|active"
 column disk_reads heading "Disk|Reads"
 column rows_processed heading "Rows|Processed"
 column executions  format 9,999,999,999 heading "Execs"
 column sql_text heading "SQL Text"
 column child_number format 9999 heading "Child|Number"
 column buffer_gets heading "Buffer|Gets"
 col cpu_sec format 9999999.99
 col ela_sec format 9999999.99
 col gets_per_row format 9999999999 heading "gets|per|row"
 col cpu_per_row format 9999999 heading "cpu(ms)|per|row"
 col users_executing head "Users|executing"
 set verify off
 --alter session set nls_date_format='DD-MON-YY HH24:MI:SS';
 accept sql_id prompt "Enter sql_id to check for: "
 prompt Getting information for &sql_id
 select  PARSING_SCHEMA_NAME,child_number chld,
    to_char(to_date(first_load_time, 'yyyy-mm-dd/hh24:mi:ss'),  'ddmon hh24:mi') first_load_time,
    to_char(last_active_time, 'ddmon hh24:mi') last_active,
    disk_reads, buffer_gets, rows_processed, executions,
    (cpu_time/1000000) cpu_sec, (elapsed_time/1000000) ela_sec, --hash_value, sql_id,
    child_number,
    buffer_gets/(decode(rows_processed, 0, 1, rows_processed)) gets_per_row,
    cpu_time/1000/(decode(rows_processed, 0, 1, rows_processed)) cpu_per_row
    , users_executing
 from v$sql where sql_id = '&sql_id'
 /
 select sql_text from v$sqltext where sql_id = '&&sql_id' order by piece
 /
 select * from table(dbms_xplan.display_cursor('&&sql_id',null))
 /
 undef sql_id