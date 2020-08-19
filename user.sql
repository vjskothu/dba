set line 280 pagesize 1000
col PASSWORD for a30
col PROFILE for a30
select USERNAME, PASSWORD, ACCOUNT_STATUS, LOCK_DATE, EXPIRY_DATE, PROFILE from dba_users where username='&USERNAME';

