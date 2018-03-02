set echo on
spool bui.prv.sql.err

/*------------------------------------------------------------------------*/

GRANT EXECUTE ON creater TO tox;
GRANT EXECUTE ON getter TO tox;
GRANT EXECUTE ON updater TO tox;
GRANT EXECUTE ON deleter TO tox;

/*------------------------------------------------------------------------*/

spool off
