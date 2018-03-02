set echo on
spool bui.pkg.sql.err

/*------------------------------------------------------------------------*/

CREATE OR REPLACE PACKAGE creater AS
	/*========================================================================*/
		FUNCTION building
			(
			in_payload IN VARCHAR2
			)
			RETURN SYS_REFCURSOR;
	/*=======================*/
		FUNCTION room
			(
			in_key IN rm.bldgKey%TYPE,
			in_payload IN VARCHAR2
			)
			RETURN SYS_REFCURSOR;
	/*=======================*/
	END creater;
	/*========================================================================*/

/

SHOW ERRORS PACKAGE creater;

/*------------------------------------------------------------------------*/

CREATE OR REPLACE PACKAGE getter AS
	/*========================================================================*/
		FUNCTION everything
			RETURN SYS_REFCURSOR;
	/*=======================*/
		FUNCTION types
			RETURN SYS_REFCURSOR;
	/*=======================*/
		FUNCTION buildingAndRooms
			(
			in_key IN bldg.key%TYPE
			)
			RETURN SYS_REFCURSOR;
	/*=======================*/
		FUNCTION buildingAndRooms
			(
			in_name IN bldg.name%TYPE
			)
			RETURN SYS_REFCURSOR;
	/*=======================*/
		FUNCTION room
			(
			in_key IN rm.key%TYPE
			)
			RETURN SYS_REFCURSOR;
	/*=======================*/
	END getter;
	/*========================================================================*/

/

SHOW ERRORS PACKAGE getter;

/*------------------------------------------------------------------------*/

CREATE OR REPLACE PACKAGE updater AS
	/*========================================================================*/
		FUNCTION building
			(
			in_key IN bldg.key%TYPE,
			in_payload IN VARCHAR2
			)
			RETURN SYS_REFCURSOR;
	/*=======================*/
		FUNCTION room
			(
			in_key IN rm.key%TYPE,
			in_payload IN VARCHAR2
			)
			RETURN SYS_REFCURSOR;
	/*=======================*/
	END updater;
	/*========================================================================*/

/

SHOW ERRORS PACKAGE updater;

/*------------------------------------------------------------------------*/

CREATE OR REPLACE PACKAGE deleter AS
	/*========================================================================*/
		FUNCTION building
			(
			in_key IN bldg.key%TYPE
			)
			RETURN SYS_REFCURSOR;
	/*=======================*/
		FUNCTION room
			(
			in_key IN rm.key%TYPE
			)
			RETURN SYS_REFCURSOR;
	/*=======================*/
	END deleter;
	/*========================================================================*/

/

SHOW ERRORS PACKAGE deleter;

/*------------------------------------------------------------------------*/

spool off
