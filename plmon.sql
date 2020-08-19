set pages 2000 lines 2000 verify off trimsp on feed off
col inst_id for 99 head "i|n"
col ses head "start|time"         for a6
col pli head "plan|line"     for 9999
col par head "plan|parent"     for 9999
col plo head "plan|operation"     for a35 trunc
col obj head "plan|object"        for a30 trunc
col typ head "plan object|type"          for a15 trunc
col wam head "work|mem(mb)"  for 99999.9
col wat head "work|temp(mb)" for 99999.9
col mint for a12 head "first|change"
col maxt for a12 head "last|change"
col sid for 999999
col starts for 9,999,999,999 head "start|rows"
col output_rows for 9,999,999,999 head "output|rows"
break on inst_id skip 1
break on sid skip 1

select sql_id, SQL_EXEC_ID from gv$session where sql_id='&sql_id';

-- by sql_id
 col id for 999
  col plan_op for a50
   col warea_mb for 9999.9
    col warea_mb for 99999
     select PLAN_LINE_ID id, plan_operation || ' ' || plan_options plan_op,
              sum(starts) starts, sum(output_rows) out_rows,
               to_char(min(first_change_time), 'dd-mon hh24:mi') min_t,
                to_char(max(last_change_time), 'dd-mon hh24:mi') max_t,
         sum(workarea_mem)/1024/1024 warea_mb,
          sum(WORKAREA_TEMPSEG)/1024/1024 temp_mb
           from gv$sql_plan_monitor
                   where sql_id = '&1'
                  and SQL_EXEC_ID='&2'
            group by PLAN_LINE_ID,  plan_operation || ' ' || plan_options
order by PLAN_LINE_ID ;