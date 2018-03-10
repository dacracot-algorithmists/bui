set echo on
set define off

/*------------------------------------------------------------------------*/

CREATE OR REPLACE PACKAGE BODY creater
	AS
	/*========================================================================*/
		v_timestamp VARCHAR(16);
		v_error VARCHAR2(1024);
		/*=======================*/
	/*========================================================================*/
		FUNCTION building
			(
			in_payload IN VARCHAR2
			)
		RETURN SYS_REFCURSOR
		AS
		/*-----------------------*/
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
		v_timestamp VARCHAR(16);
		v_error VARCHAR2(1024);
		/*=======================*/
		by_bldg_key bldg.key%TYPE;
		v_bldg_key bldg.key%TYPE;
		v_bldg_name bldg.name%TYPE;
		v_bldg_addr bldg.addr%TYPE;
		/*=======================*/
		CURSOR c_bldg_all IS
			SELECT
				key,
				name,
				addr
			FROM
				bldg;
		/*=======================*/
		CURSOR c_bldg_by_key IS
			SELECT
				key,
				name,
				addr
			FROM
				bldg
			WHERE
				key = by_bldg_key;
		/*=======================*/
		v_type_key type.key%TYPE;
		v_type_name type.name%TYPE;
		/*=======================*/
		CURSOR c_type_all IS
			SELECT
				key,
				name
			FROM
				type;
		/*=======================*/
		by_rm_key rm.key%TYPE;
		v_rm_key rm.key%TYPE;
		v_rm_name rm.name%TYPE;
		v_rm_length rm.length%TYPE;
		v_rm_width rm.width%TYPE;
		v_rm_height rm.height%TYPE;
		v_rm_bldgKey rm.bldgKey%TYPE;
		by_rm_bldgKey rm.bldgKey%TYPE;
		v_rm_typeKey rm.typeKey%TYPE;
		by_rm_typeKey rm.typeKey%TYPE;
		/*=======================*/
		CURSOR c_rm_by_key IS
			SELECT
				key,
				name,
				length,
				width,
				height,
				bldgKey,
				typeKey
			FROM
				rm
			WHERE
				key = by_rm_key;
		/*=======================*/
		CURSOR c_rm_by_bldgKey IS
			SELECT
				key,
				name,
				length,
				width,
				height,
				bldgKey,
				typeKey
			FROM
				rm
			WHERE
				bldgKey = by_rm_bldgKey;
		/*=======================*/
		CURSOR c_rm_by_typeKey IS
			SELECT
				key,
				name,
				length,
				width,
				height,
				bldgKey,
				typeKey
			FROM
				rm
			WHERE
				typeKey = by_rm_typeKey;
		/*=======================*/
		CURSOR c_rm_by_typeKey_and_bldgKey IS
			SELECT
				key,
				name,
				length,
				width,
				height,
				bldgKey,
				typeKey
			FROM
				rm
			WHERE
				bldgKey = by_rm_bldgKey
					AND
				typeKey = by_rm_typeKey;
	/*========================================================================*/
		FUNCTION everything
		RETURN SYS_REFCURSOR
		AS
		/*-----------------------*/
		BEGIN
		/*=======================*/
			tox.tox.begin_spool;
			v_timestamp:= tox.tox.timestamp;
		/*-----------------------*/
			tox.tox.into_spool('<bui timestamp="'||v_timestamp||'" feedback="ok">');
		/*-----------------------*/
			tox.tox.into_spool('<types>');
			OPEN c_type_all;
			LOOP
				FETCH c_type_all INTO v_type_key, v_type_name;
				EXIT WHEN (c_type_all%NOTFOUND);
				tox.tox.into_spool('<type key="'||v_type_key||'" name="'||v_type_name||'"/>');
			END LOOP;
			CLOSE c_type_all;
			tox.tox.into_spool('</types>');
		/*-----------------------*/
			tox.tox.into_spool('<bldgs>');
			OPEN c_bldg_all;
			LOOP
				FETCH c_bldg_all INTO v_bldg_key, v_bldg_name, v_bldg_addr;
				EXIT WHEN (c_bldg_all%NOTFOUND);
				tox.tox.into_spool('<bldg key="'||v_bldg_key||'" name="'||v_bldg_name||'" addr="'||v_bldg_addr||'">');
			/*-----------------------*/
				tox.tox.into_spool('<rms>');
				by_rm_bldgKey:= v_bldg_key;
				OPEN c_rm_by_bldgKey;
				LOOP
					FETCH c_rm_by_bldgKey INTO v_rm_key, v_rm_name, v_rm_length, v_rm_width, v_rm_height, v_rm_bldgKey, v_rm_typeKey;
					EXIT WHEN (c_rm_by_bldgKey%NOTFOUND);
					tox.tox.into_spool('<rm key="'||v_rm_key||'" name="'||v_rm_name||'" length="'||v_rm_length||'" width="'||v_rm_width||'" height="'||v_rm_height||'" bldgKey="'||v_rm_bldgKey||'" typeKey="'||v_rm_typeKey||'"/>');
				END LOOP;
				CLOSE c_rm_by_bldgKey;
				tox.tox.into_spool('</rms>');
			/*-----------------------*/
				tox.tox.into_spool('</bldg>');
			END LOOP;
			CLOSE c_bldg_all;
			tox.tox.into_spool('</bldgs>');
		/*-----------------------*/
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
		v_timestamp VARCHAR(16);
		v_error VARCHAR2(1024);
		/*=======================*/
	/*========================================================================*/
		FUNCTION building
			(
			in_key IN bldg.key%TYPE,
			in_payload IN VARCHAR2
			)
		RETURN SYS_REFCURSOR
		AS
		/*-----------------------*/
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
		v_timestamp VARCHAR(16);
		v_error VARCHAR2(1024);
		/*=======================*/
	/*========================================================================*/
		FUNCTION building
			(
			in_key IN bldg.key%TYPE
			)
		RETURN SYS_REFCURSOR
		AS
		/*-----------------------*/
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

