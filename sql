ORACLE_HOME=/u01/app/oracle/product/12.1.0.1/dbhome_1
export ORACLE_HOME
export PATH=$ORACLE_HOME/bin:$ORACLE_HOME/OPatch:$PATH
sqlplus system/XData#16@${1} @pre.sql


