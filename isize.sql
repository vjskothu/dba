select sum(bytes)/1024/1024 "SizeMo" 
from dba_extents 
where OWNER ='&OWNER' and segment_name ='&index_name';
