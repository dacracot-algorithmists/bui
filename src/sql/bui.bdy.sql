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
			tox.tox.into_spool('<bui call="creater.building" timestamp="'||v_timestamp||'" feedback="ok">');
			tox.tox.into_spool('creater.building('||in_payload||')');
			tox.tox.into_spool('</bui>');
		/*-----------------------*/
			COMMIT;
			RETURN tox.tox.end_spool;
			EXCEPTION WHEN OTHERS THEN
				tox.tox.reset_spool;
				v_error:= tox.tox.encode(Sqlerrm);
				tox.tox.into_spool('<bui call="creater.building" timestamp="'||v_timestamp||'" feedback="error: '||v_error||'"/>');
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
			tox.tox.into_spool('<bui call="creater.room" timestamp="'||v_timestamp||'" feedback="ok">');
			tox.tox.into_spool('creater.room('||in_key||','||in_payload||')');
			tox.tox.into_spool('</bui>');
		/*-----------------------*/
			COMMIT;
			RETURN tox.tox.end_spool;
			EXCEPTION WHEN OTHERS THEN
				tox.tox.reset_spool;
				v_error:= tox.tox.encode(Sqlerrm);
				tox.tox.into_spool('<bui call="creater.room" timestamp="'||v_timestamp||'" feedback="error: '||v_error||'"/>');
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
		v_rm_key rm.key%TYPE;
		v_rm_name rm.name%TYPE;
		v_rm_length rm.length%TYPE;
		v_rm_width rm.width%TYPE;
		v_rm_height rm.height%TYPE;
		v_rm_bldgKey rm.bldgKey%TYPE;
		by_rm_bldgKey rm.bldgKey%TYPE;
		v_rm_typeKey rm.typeKey%TYPE;
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
	/*========================================================================*/
		PROCEDURE types
		AS
		/*-----------------------*/
		BEGIN
		/*=======================*/
			tox.tox.into_spool('<types>');
			OPEN c_type_all;
			LOOP
				FETCH c_type_all INTO v_type_key, v_type_name;
				EXIT WHEN (c_type_all%NOTFOUND);
				tox.tox.into_spool('<type key="'||v_type_key||'" name="'||tox.tox.encode(v_type_name)||'"/>');
			END LOOP;
			CLOSE c_type_all;
			tox.tox.into_spool('</types>');
		/*=======================*/
		END types;
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
			tox.tox.into_spool('<bui call="getter.everything" timestamp="'||v_timestamp||'" feedback="ok">');
		/*-----------------------*/
			getter.types;
		/*-----------------------*/
			tox.tox.into_spool('<bldgs>');
			OPEN c_bldg_all;
			LOOP
				FETCH c_bldg_all INTO v_bldg_key, v_bldg_name, v_bldg_addr;
				EXIT WHEN (c_bldg_all%NOTFOUND);
				tox.tox.into_spool('<bldg key="'||v_bldg_key||'" name="'||tox.tox.encode(v_bldg_name)||'" addr="'||tox.tox.encode(v_bldg_addr)||'">');
			/*-----------------------*/
				tox.tox.into_spool('<rms>');
				by_rm_bldgKey:= v_bldg_key;
				OPEN c_rm_by_bldgKey;
				LOOP
					FETCH c_rm_by_bldgKey INTO v_rm_key, v_rm_name, v_rm_length, v_rm_width, v_rm_height, v_rm_bldgKey, v_rm_typeKey;
					EXIT WHEN (c_rm_by_bldgKey%NOTFOUND);
					tox.tox.into_spool('<rm key="'||v_rm_key||'" name="'||tox.tox.encode(v_rm_name)||'" length="'||v_rm_length||'" width="'||v_rm_width||'" height="'||v_rm_height||'" bldgKey="'||v_rm_bldgKey||'" typeKey="'||v_rm_typeKey||'"/>');
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
				tox.tox.into_spool('<bui call="getter.everything" timestamp="'||v_timestamp||'" feedback="error: '||v_error||'"/>');
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
			tox.tox.into_spool('<bui call="getter.types" timestamp="'||v_timestamp||'" feedback="ok">');
			getter.types;
			tox.tox.into_spool('</bui>');
		/*-----------------------*/
			COMMIT;
			RETURN tox.tox.end_spool;
			EXCEPTION WHEN OTHERS THEN
				tox.tox.reset_spool;
				v_error:= tox.tox.encode(Sqlerrm);
				tox.tox.into_spool('<bui call="getter.types" timestamp="'||v_timestamp||'" feedback="error: '||v_error||'"/>');
				COMMIT;
				RETURN tox.tox.end_spool;
		/*=======================*/
		END types;
	/*========================================================================*/
		PROCEDURE buildingAndRooms
		AS
		/*-----------------------*/
		BEGIN
		/*=======================*/
			tox.tox.into_spool('<bldgs>');
			OPEN c_bldg_by_key;
			LOOP
				FETCH c_bldg_by_key INTO v_bldg_key, v_bldg_name, v_bldg_addr;
				EXIT WHEN (c_bldg_by_key%NOTFOUND);
				tox.tox.into_spool('<bldg key="'||v_bldg_key||'" name="'||tox.tox.encode(v_bldg_name)||'" addr="'||tox.tox.encode(v_bldg_addr)||'">');
			/*-----------------------*/
				tox.tox.into_spool('<rms>');
				by_rm_bldgKey:= v_bldg_key;
				OPEN c_rm_by_bldgKey;
				LOOP
					FETCH c_rm_by_bldgKey INTO v_rm_key, v_rm_name, v_rm_length, v_rm_width, v_rm_height, v_rm_bldgKey, v_rm_typeKey;
					EXIT WHEN (c_rm_by_bldgKey%NOTFOUND);
					tox.tox.into_spool('<rm key="'||v_rm_key||'" name="'||tox.tox.encode(v_rm_name)||'" length="'||v_rm_length||'" width="'||v_rm_width||'" height="'||v_rm_height||'" bldgKey="'||v_rm_bldgKey||'" typeKey="'||v_rm_typeKey||'"/>');
				END LOOP;
				CLOSE c_rm_by_bldgKey;
				tox.tox.into_spool('</rms>');
			/*-----------------------*/
				tox.tox.into_spool('</bldg>');
			END LOOP;
			CLOSE c_bldg_by_key;
			tox.tox.into_spool('</bldgs>');
		/*=======================*/
		END buildingAndRooms;
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
			tox.tox.into_spool('<bui call="getter.buildingAndRooms('||in_key||')" timestamp="'||v_timestamp||'" feedback="ok">');
		/*-----------------------*/
			by_bldg_key:= in_key;
			getter.buildingAndRooms;
		/*-----------------------*/
			tox.tox.into_spool('</bui>');
		/*-----------------------*/
			COMMIT;
			RETURN tox.tox.end_spool;
			EXCEPTION WHEN OTHERS THEN
				tox.tox.reset_spool;
				v_error:= tox.tox.encode(Sqlerrm);
				tox.tox.into_spool('<bui call="getter.buildingAndRooms('||in_key||')" timestamp="'||v_timestamp||'" feedback="error: '||v_error||'"/>');
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
			tox.tox.into_spool('<bui call="getter.buildingAndRooms('||tox.tox.encode(in_name)||')" timestamp="'||v_timestamp||'" feedback="ok">');
		/*-----------------------*/
			SELECT
				key
			INTO
				by_bldg_key
			FROM
				bldg
			WHERE
				name = in_name;
			getter.buildingAndRooms;
		/*-----------------------*/
			tox.tox.into_spool('</bui>');
		/*-----------------------*/
			COMMIT;
			RETURN tox.tox.end_spool;
			EXCEPTION WHEN OTHERS THEN
				tox.tox.reset_spool;
				v_error:= tox.tox.encode(Sqlerrm);
				tox.tox.into_spool('<bui call="getter.buildingAndRooms('||tox.tox.encode(in_name)||')" timestamp="'||v_timestamp||'" feedback="error: '||v_error||'"/>');
				COMMIT;
				RETURN tox.tox.end_spool;
		/*=======================*/
		END buildingAndRooms;
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
			tox.tox.into_spool('<bui call="updater.building" timestamp="'||v_timestamp||'" feedback="ok">');
			tox.tox.into_spool('updater.building('||in_key||','||in_payload||')');
			tox.tox.into_spool('</bui>');
		/*-----------------------*/
			COMMIT;
			RETURN tox.tox.end_spool;
			EXCEPTION WHEN OTHERS THEN
				tox.tox.reset_spool;
				v_error:= tox.tox.encode(Sqlerrm);
				tox.tox.into_spool('<bui call="updater.building" timestamp="'||v_timestamp||'" feedback="error: '||v_error||'"/>');
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
			tox.tox.into_spool('<bui call="updater.room" timestamp="'||v_timestamp||'" feedback="ok">');
			tox.tox.into_spool('updater.room('||in_key||','||in_payload||')');
			tox.tox.into_spool('</bui>');
		/*-----------------------*/
			COMMIT;
			RETURN tox.tox.end_spool;
			EXCEPTION WHEN OTHERS THEN
				tox.tox.reset_spool;
				v_error:= tox.tox.encode(Sqlerrm);
				tox.tox.into_spool('<bui call="updater.room" timestamp="'||v_timestamp||'" feedback="error: '||v_error||'"/>');
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
			tox.tox.into_spool('<bui call="deleter.building" timestamp="'||v_timestamp||'" feedback="ok">');
			tox.tox.into_spool('deleter.building('||in_key||')');
			tox.tox.into_spool('</bui>');
		/*-----------------------*/
			COMMIT;
			RETURN tox.tox.end_spool;
			EXCEPTION WHEN OTHERS THEN
				tox.tox.reset_spool;
				v_error:= tox.tox.encode(Sqlerrm);
				tox.tox.into_spool('<bui call="deleter.building" timestamp="'||v_timestamp||'" feedback="error: '||v_error||'"/>');
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
			tox.tox.into_spool('<bui call="deleter.room" timestamp="'||v_timestamp||'" feedback="ok">');
			tox.tox.into_spool('deleter.room('||in_key||')');
			tox.tox.into_spool('</bui>');
		/*-----------------------*/
			COMMIT;
			RETURN tox.tox.end_spool;
			EXCEPTION WHEN OTHERS THEN
				tox.tox.reset_spool;
				v_error:= tox.tox.encode(Sqlerrm);
				tox.tox.into_spool('<bui call="deleter.room" timestamp="'||v_timestamp||'" feedback="error: '||v_error||'"/>');
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

