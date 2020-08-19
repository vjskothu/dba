set pages 200 lines 199 verify off

    col name for a35 head "LOCKED OBJECT"
    col status head STATUS
    col inst_id for 9 head "INS"
    col process for a6 head "OS PROC" trunc
    col session_id for 99999 head SID
    col serial# for 999999
    col os_user_name for a12 head "OS USER"  trunc
    col oracle_username for a18 head "LOCKING USER" trunc
    col username for a15
    col program for a40 trunc
    col load_time for a14 trunc
    col sid for 9999999

    prompt =============================
    prompt ==   Current  Row Locks    ==
    prompt =============================

    select /*+ use_hash(a,b,c,d) */
        a.session_id,b.serial#,b.status,a.oracle_username,a.os_user_name,a.process, start_time, c.name,program
    from
        sys.obj$ c,
        gv$session b,
        gv$locked_object a,
        gv$transaction d
    where
        a.session_id=b.sid and
        c.obj#=a.object_id and
        a.xidusn=d.xidusn and
        a.xidsqn=d.xidsqn and
        a.xidslot=d.xidslot
    order by start_time desc;

set feed off pages 1000 lines 199 trimsp on

set pages 1000 lines 300 linesize 400;

    alter session set "_hash_join_enabled"=true;
    set pages 200 trimsp on lines 199
    col load_time for a14 trunc
    col inst_id for 9 head "INS"
    col session_id for 99999 head SID
    col status head STATUS
    col serial# for 999999
    col process for a6 head "OS PROC" trunc
    col os_user_name for a12 head "OS USER"  trunc
    col oracle_username for a18 head "LOCKING USER" trunc
    col name for a35 head "LOCKED OBJECT"
    col program for a40 trunc
    col username for a15
    col port for 99999

    select
        distinct a.inst_id, a.session_id,b.serial#,b.status,a.oracle_username,a.os_user_name,b.port,a.process, start_time, c.name,program
    from
        sys.obj$ c,
        gv$session b,
        gv$locked_object a,
        gv$transaction d
    where
        b.inst_id=a.inst_id and
        a.inst_id=d.inst_id (+) and
        a.session_id=b.sid and
        c.obj#=a.object_id and
        a.xidusn=d.xidusn (+) and
        a.xidsqn=d.xidsqn (+) and
        a.xidslot=d.xidslot (+) and
        to_date(start_time,'MM/DD/YY HH24:MI:SS')<sysdate-1
    order by start_time desc;



