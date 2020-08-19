clear columns 
 set lines 230 pages 100 
 accept sql_id prompt "enter sql_id: " 
 col min_time for a5 head min_t 
 col max_time for a5 head max_t 
 col av_ela for 999,999 
 col av_cpu for 999,999 
 col av_ela_ms for 999999999.9 
 col av_cpu_ms for 999999999.9 
 col av_ela for 999,999 
 col av_rows for 999,999,999 
 col av_gets for 999,999,999,999 
 col av_prds for 999,999,999,999 
 col av_fetch for 999,999 
 col sql_id for a14
 col execs for a22
 col execs for 99999999999999 
select '&sql_id' sql_id 
 -- , dbid 
    , s_day 
    , phv 
    , min_snap, 
         (select min(to_char(begin_interval_time, 'hh24:mi')) from dba_hist_snapshot t where t.snap_id = min_snap) min_time, 
         max_snap, 
         (select max(to_char(end_interval_time, 'hh24:mi')) from dba_hist_snapshot t where t.snap_id = max_snap) max_time 
    , execs 
    , decode(execs, 0, 0, rowsp/execs)  av_rows 
    , decode(fetches, 0, 0, rowsp/fetches)  av_fetch 
 -- average in seconds 
    , av_ela_ms 
    , av_cpu_ms 
 -- average in milliseconds 
 -- , case when av_ela_ms > 99999000 then round(av_ela_ms/1000/60,0) || 'm' 
 --         when av_ela_ms between 1000 and  round(ela_ms/execs/1000, 2) || ' s' 
 --           when decode(execs, 0, 0, ela_ms/execs) > 0 then round(ela_ms/execs, 2) || ' ms' 
 --         when execs = 0 then '0' 
 --    end as av_ela 
 -- , av_ela_ms 
 -- , av_cpu_ms 
    , decode(execs, 0, 0, gets/execs) av_gets 
    , decode(execs, 0, 0, prds/execs) av_prds 
 from ( 
 select min(q.snap_id) min_snap, max(q.snap_id) max_snap 
    , sum(executions_delta) execs 
    , sum(elapsed_time_delta/1000000) ela_sec 
    , sum(cpu_time_delta/1000000) cpu_sec 
    , sum(elapsed_time_delta/1000) ela_ms 
    , sum(cpu_time_delta/1000) cpu_ms 
    , sum(rows_processed_delta) rowsp 
    , sum(buffer_gets_delta) gets 
    , sum(disk_reads_delta) prds 
    , sum(fetches_delta) fetches 
    , decode(sum(executions_delta), 0, 0, sum(elapsed_time_delta/1000)/sum(executions_delta)) av_ela_ms 
    , decode(sum(executions_delta), 0, 0, sum(cpu_time_delta/1000)/sum(executions_delta)) av_cpu_ms 
    , decode(sum(executions_delta), 0, 0, sum(buffer_gets_delta)/sum(executions_delta)) av_gets 
    , decode(sum(executions_delta), 0, 0, sum(disk_reads_delta)/sum(executions_delta)) av_prds 
    , to_char(begin_interval_time, 'yyyy/mm/dd') s_day 
    , plan_hash_value phv 
    , q.dbid 
 from dba_hist_sqlstat q, dba_hist_snapshot h 
 where q.sql_id like '&sql_id%' 
   and q.snap_id = h.snap_id
and q.DBID=h.DBID
  and q.INSTANCE_NUMBER=h.INSTANCE_NUMBER
 group by plan_hash_value 
    , q.dbid 
    , to_char(begin_interval_time, 'yyyy/mm/dd') 
 ) 
 order by s_day 
 ;

 undef sql_id

