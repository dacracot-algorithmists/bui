set echo on
spool bui.bdy.sql.err
set define off

/*------------------------------------------------------------------------*/

CREATE OR REPLACE PACKAGE BODY creater
	AS
	/*========================================================================*/
		FUNCTION building
			(
			in_payload IN VARCHAR2
			)
		RETURN SYS_REFCURSOR
		AS
		/*-----------------------*/
		v_timestamp VARCHAR(16);
		v_error VARCHAR2(1024);
		/*=======================*/
		BEGIN
		/*=======================*/
			tox.tox.begin_spool;
			v_timestamp:= tox.tox.timestamp;
		/*-----------------------*/
			tox.tox.into_spool('<bui timestamp="'||v_timestamp||'" feedback="ok">');
			tox.tox.into_spool('creater.building('||in_payload||')');
			tox.tox.into_spool('</bui>');
		/*-----------------------*/
			COMMIT;
			RETURN tox.tox.end_spool;
			EXCEPTION WHEN OTHERS THEN
				tox.tox.reset_spool;
				v_error:= tox.tox.encode(Sqlerrm);
				tox.tox.into_spool('<bui timestamp="'||v_timestamp||'" feedback="error: '||v_error||'"/>');
				COMMIT;
				RETURN tox.tox.end_spool;
		/*=======================*/
		END building;
	/*========================================================================*/
		FUNCTION room
			(
			in_key IN rm.bldgKey%TYPE,
			in_payload IN VARCHAR2
			)
		RETURN SYS_REFCURSOR
		AS
		/*-----------------------*/
		v_timestamp VARCHAR(16);
		v_error VARCHAR2(1024);
		/*=======================*/
		BEGIN
		/*=======================*/
			tox.tox.begin_spool;
			v_timestamp:= tox.tox.timestamp;
		/*-----------------------*/
			tox.tox.into_spool('<bui timestamp="'||v_timestamp||'" feedback="ok">');
			tox.tox.into_spool('creater.room('||in_key||','||in_payload||')');
			tox.tox.into_spool('</bui>');
		/*-----------------------*/
			COMMIT;
			RETURN tox.tox.end_spool;
			EXCEPTION WHEN OTHERS THEN
				tox.tox.reset_spool;
				v_error:= tox.tox.encode(Sqlerrm);
				tox.tox.into_spool('<bui timestamp="'||v_timestamp||'" feedback="error: '||v_error||'"/>');
				COMMIT;
				RETURN tox.tox.end_spool;
		/*=======================*/
		END room;
	/*========================================================================*/
	END creater;
	/*========================================================================*/

/

SHOW ERRORS PACKAGE BODY creater;

/*------------------------------------------------------------------------*/

CREATE OR REPLACE PACKAGE BODY getter
	AS
	/*========================================================================*/
		FUNCTION everything
		RETURN SYS_REFCURSOR
		AS
		/*-----------------------*/
		v_timestamp VARCHAR(16);
		v_error VARCHAR2(1024);
		/*=======================*/
		BEGIN
		/*=======================*/
			tox.tox.begin_spool;
			v_timestamp:= tox.tox.timestamp;
		/*-----------------------*/
			tox.tox.into_spool('<bui timestamp="'||v_timestamp||'" feedback="ok">');
			tox.tox.into_spool('getter.everything');
			tox.tox.into_spool('</bui>');
		/*-----------------------*/
			COMMIT;
			RETURN tox.tox.end_spool;
			EXCEPTION WHEN OTHERS THEN
				tox.tox.reset_spool;
				v_error:= tox.tox.encode(Sqlerrm);
				tox.tox.into_spool('<bui timestamp="'||v_timestamp||'" feedback="error: '||v_error||'"/>');
				COMMIT;
				RETURN tox.tox.end_spool;
		/*=======================*/
		END everything;
	/*========================================================================*/
		FUNCTION types
		RETURN SYS_REFCURSOR
		AS
		/*-----------------------*/
		v_timestamp VARCHAR(16);
		v_error VARCHAR2(1024);
		/*=======================*/
		BEGIN
		/*=======================*/
			tox.tox.begin_spool;
			v_timestamp:= tox.tox.timestamp;
		/*-----------------------*/
			tox.tox.into_spool('<bui timestamp="'||v_timestamp||'" feedback="ok">');
			tox.tox.into_spool('getter.types');
			tox.tox.into_spool('</bui>');
		/*-----------------------*/
			COMMIT;
			RETURN tox.tox.end_spool;
			EXCEPTION WHEN OTHERS THEN
				tox.tox.reset_spool;
				v_error:= tox.tox.encode(Sqlerrm);
				tox.tox.into_spool('<bui timestamp="'||v_timestamp||'" feedback="error: '||v_error||'"/>');
				COMMIT;
				RETURN tox.tox.end_spool;
		/*=======================*/
		END types;
	/*========================================================================*/
		FUNCTION buildingAndRooms
			(
			in_key IN bldg.key%TYPE
			)
		RETURN SYS_REFCURSOR
		AS
		/*-----------------------*/
		v_timestamp VARCHAR(16);
		v_error VARCHAR2(1024);
		/*=======================*/
		BEGIN
		/*=======================*/
			tox.tox.begin_spool;
			v_timestamp:= tox.tox.timestamp;
		/*-----------------------*/
			tox.tox.into_spool('<bui timestamp="'||v_timestamp||'" feedback="ok">');
			tox.tox.into_spool('getter.buildingAndRooms('||in_key||')');
			tox.tox.into_spool('</bui>');
		/*-----------------------*/
			COMMIT;
			RETURN tox.tox.end_spool;
			EXCEPTION WHEN OTHERS THEN
				tox.tox.reset_spool;
				v_error:= tox.tox.encode(Sqlerrm);
				tox.tox.into_spool('<bui timestamp="'||v_timestamp||'" feedback="error: '||v_error||'"/>');
				COMMIT;
				RETURN tox.tox.end_spool;
		/*=======================*/
		END buildingAndRooms;
	/*========================================================================*/
		FUNCTION buildingAndRooms
			(
			in_name IN bldg.name%TYPE
			)
		RETURN SYS_REFCURSOR
		AS
		/*-----------------------*/
		v_timestamp VARCHAR(16);
		v_error VARCHAR2(1024);
		/*=======================*/
		BEGIN
		/*=======================*/
			tox.tox.begin_spool;
			v_timestamp:= tox.tox.timestamp;
		/*-----------------------*/
			tox.tox.into_spool('<bui timestamp="'||v_timestamp||'" feedback="ok">');
			tox.tox.into_spool('getter.buildingAndRooms('||in_name||')');
			tox.tox.into_spool('</bui>');
		/*-----------------------*/
			COMMIT;
			RETURN tox.tox.end_spool;
			EXCEPTION WHEN OTHERS THEN
				tox.tox.reset_spool;
				v_error:= tox.tox.encode(Sqlerrm);
				tox.tox.into_spool('<bui timestamp="'||v_timestamp||'" feedback="error: '||v_error||'"/>');
				COMMIT;
				RETURN tox.tox.end_spool;
		/*=======================*/
		END buildingAndRooms;
	/*========================================================================*/
		FUNCTION room
			(
			in_key IN rm.key%TYPE
			)
		RETURN SYS_REFCURSOR
		AS
		/*-----------------------*/
		v_timestamp VARCHAR(16);
		v_error VARCHAR2(1024);
		/*=======================*/
		BEGIN
		/*=======================*/
			tox.tox.begin_spool;
			v_timestamp:= tox.tox.timestamp;
		/*-----------------------*/
			tox.tox.into_spool('<bui timestamp="'||v_timestamp||'" feedback="ok">');
			tox.tox.into_spool('getter.room('||in_key||')');
			tox.tox.into_spool('</bui>');
		/*-----------------------*/
			COMMIT;
			RETURN tox.tox.end_spool;
			EXCEPTION WHEN OTHERS THEN
				tox.tox.reset_spool;
				v_error:= tox.tox.encode(Sqlerrm);
				tox.tox.into_spool('<bui timestamp="'||v_timestamp||'" feedback="error: '||v_error||'"/>');
				COMMIT;
				RETURN tox.tox.end_spool;
		/*=======================*/
		END room;
	/*========================================================================*/
	END getter;
	/*========================================================================*/

/

SHOW ERRORS PACKAGE BODY getter;

/*------------------------------------------------------------------------*/

CREATE OR REPLACE PACKAGE BODY updater
	AS
	/*========================================================================*/
		FUNCTION building
			(
			in_key IN bldg.key%TYPE,
			in_payload IN VARCHAR2
			)
		RETURN SYS_REFCURSOR
		AS
		/*-----------------------*/
		v_timestamp VARCHAR(16);
		v_error VARCHAR2(1024);
		/*=======================*/
		BEGIN
		/*=======================*/
			tox.tox.begin_spool;
			v_timestamp:= tox.tox.timestamp;
		/*-----------------------*/
			tox.tox.into_spool('<bui timestamp="'||v_timestamp||'" feedback="ok">');
			tox.tox.into_spool('updater.building('||in_key||','||in_payload||')');
			tox.tox.into_spool('</bui>');
		/*-----------------------*/
			COMMIT;
			RETURN tox.tox.end_spool;
			EXCEPTION WHEN OTHERS THEN
				tox.tox.reset_spool;
				v_error:= tox.tox.encode(Sqlerrm);
				tox.tox.into_spool('<bui timestamp="'||v_timestamp||'" feedback="error: '||v_error||'"/>');
				COMMIT;
				RETURN tox.tox.end_spool;
		/*=======================*/
		END building;
	/*========================================================================*/
		FUNCTION room
			(
			in_key IN rm.key%TYPE,
			in_payload IN VARCHAR2
			)
		RETURN SYS_REFCURSOR
		AS
		/*-----------------------*/
		v_timestamp VARCHAR(16);
		v_error VARCHAR2(1024);
		/*=======================*/
		BEGIN
		/*=======================*/
			tox.tox.begin_spool;
			v_timestamp:= tox.tox.timestamp;
		/*-----------------------*/
			tox.tox.into_spool('<bui timestamp="'||v_timestamp||'" feedback="ok">');
			tox.tox.into_spool('updater.room('||in_key||','||in_payload||')');
			tox.tox.into_spool('</bui>');
		/*-----------------------*/
			COMMIT;
			RETURN tox.tox.end_spool;
			EXCEPTION WHEN OTHERS THEN
				tox.tox.reset_spool;
				v_error:= tox.tox.encode(Sqlerrm);
				tox.tox.into_spool('<bui timestamp="'||v_timestamp||'" feedback="error: '||v_error||'"/>');
				COMMIT;
				RETURN tox.tox.end_spool;
		/*=======================*/
		END room;
	/*========================================================================*/
	END updater;
	/*========================================================================*/

/

SHOW ERRORS PACKAGE BODY updater;

/*------------------------------------------------------------------------*/

CREATE OR REPLACE PACKAGE BODY deleter
	AS
	/*========================================================================*/
		FUNCTION building
			(
			in_key IN bldg.key%TYPE
			)
		RETURN SYS_REFCURSOR
		AS
		/*-----------------------*/
		v_timestamp VARCHAR(16);
		v_error VARCHAR2(1024);
		/*=======================*/
		BEGIN
		/*=======================*/
			tox.tox.begin_spool;
			v_timestamp:= tox.tox.timestamp;
		/*-----------------------*/
			tox.tox.into_spool('<bui timestamp="'||v_timestamp||'" feedback="ok">');
			tox.tox.into_spool('deleter.building('||in_key||')');
			tox.tox.into_spool('</bui>');
		/*-----------------------*/
			COMMIT;
			RETURN tox.tox.end_spool;
			EXCEPTION WHEN OTHERS THEN
				tox.tox.reset_spool;
				v_error:= tox.tox.encode(Sqlerrm);
				tox.tox.into_spool('<bui timestamp="'||v_timestamp||'" feedback="error: '||v_error||'"/>');
				COMMIT;
				RETURN tox.tox.end_spool;
		/*=======================*/
		END building;
	/*========================================================================*/
		FUNCTION room
			(
			in_key IN rm.key%TYPE
			)
		RETURN SYS_REFCURSOR
		AS
		/*-----------------------*/
		v_timestamp VARCHAR(16);
		v_error VARCHAR2(1024);
		/*=======================*/
		BEGIN
		/*=======================*/
			tox.tox.begin_spool;
			v_timestamp:= tox.tox.timestamp;
		/*-----------------------*/
			tox.tox.into_spool('<bui timestamp="'||v_timestamp||'" feedback="ok">');
			tox.tox.into_spool('deleter.room('||in_key||')');
			tox.tox.into_spool('</bui>');
		/*-----------------------*/
			COMMIT;
			RETURN tox.tox.end_spool;
			EXCEPTION WHEN OTHERS THEN
				tox.tox.reset_spool;
				v_error:= tox.tox.encode(Sqlerrm);
				tox.tox.into_spool('<bui timestamp="'||v_timestamp||'" feedback="error: '||v_error||'"/>');
				COMMIT;
				RETURN tox.tox.end_spool;
		/*=======================*/
		END room;
	/*========================================================================*/
	END deleter;
	/*========================================================================*/

/

SHOW ERRORS PACKAGE BODY deleter;

/*------------------------------------------------------------------------*/

spool off
