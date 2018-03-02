set echo on
spool bui.usr.sql.err

/*------------------------------------------------------------------------*/

CREATE USER bui IDENTIFIED BY p8ssw0rd DEFAULT TABLESPACE users TEMPORARY TABLESPACE temp;

ALTER USER bui QUOTA UNLIMITED ON users; 

GRANT CONNECT TO bui;
GRANT RESOURCE TO bui;

/*------------------------------------------------------------------------*/

spool off
