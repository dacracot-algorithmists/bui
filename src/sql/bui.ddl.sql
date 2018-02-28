set echo on
set feedback on
set define off
spool bui.ddl.sql.err
/*------------------------------------------------------------------------*/
CREATE SEQUENCE key START WITH 10000;
/*------------------------------------------------------------------------*/
CREATE TABLE bldg(
	key NUMBER(11) DEFAULT key.NEXTVAL NOT NULL CONSTRAINT bldgPkey PRIMARY KEY USING INDEX,
	name VARCHAR2(255) NOT NULL,
	addr VARCHAR2(1023)
);
/*------------------------------------*/
COMMENT ON TABLE bldg IS 'Buildings.';
COMMENT ON COLUMN bldg.key IS 'Artificial primary key.';
COMMENT ON COLUMN bldg.name IS 'Name of the building for display.';
COMMENT ON COLUMN bldg.addr IS 'Address of the building.';
/*------------------------------------------------------------------------*/
CREATE TABLE type(
	key NUMBER(11) DEFAULT key.NEXTVAL NOT NULL CONSTRAINT typePkey PRIMARY KEY USING INDEX,
	name VARCHAR2(255) NOT NULL
);
/*------------------------------------*/
COMMENT ON TABLE type IS 'Types of rooms.';
COMMENT ON COLUMN type.key IS 'Artificial primary key.';
COMMENT ON COLUMN type.name IS 'Name of the room type.';
/*------------------------------------------------------------------------*/
CREATE TABLE room(
	key NUMBER(11) DEFAULT key.NEXTVAL NOT NULL CONSTRAINT roomPkey PRIMARY KEY USING INDEX,
	name VARCHAR2(255) NOT NULL,
	length NUMBER(6,2),
	width NUMBER(6,2),
	height NUMBER(6,2),
	bldgKey NUMBER(11) NOT NULL,
	typeKey NUMBER(11) NOT NULL 
);
/*------------------------------------*/
COMMENT ON TABLE room IS 'Rooms within buildings with specific types.';
COMMENT ON COLUMN room.key IS 'Artificial primary key.';
COMMENT ON COLUMN room.name IS 'Name of the room.';
COMMENT ON COLUMN room.length IS 'Dimension of the room.';
COMMENT ON COLUMN room.width IS 'Dimension of the room.';
COMMENT ON COLUMN room.height IS 'Dimension of the room.';
COMMENT ON COLUMN room.bldgKey IS 'Foreign key referencing the building to which this room belongs.';
COMMENT ON COLUMN room.typeKey IS 'Foreign key referencing the type of room. Defaults to undefined.';
/*------------------------------------*/
CREATE TRIGGER typeIsUndefined
	BEFORE INSERT ON room
	FOR EACH ROW
	/*-----------------------*/
	BEGIN
	/*-----------------------*/
	IF (:NEW.typeKey IS NULL) THEN
		SELECT
			key
		INTO
			:NEW.typeKey
		FROM
			type
		WHERE
			name = 'Undefined';
	END IF;
	/*-----------------------*/
	END;
/
SHOW ERRORS
/*------------------------------------*/
ALTER TABLE
		room
	ADD CONSTRAINT
		roomBldgFKey
	FOREIGN KEY
		(bldgKey)
	REFERENCES
		bldg(key)
;
/*------------------------------------*/
CREATE INDEX roomBldgFndx ON
	room
		(
		bldgKey
		)
;
/*------------------------------------*/
ALTER TABLE
		room
	ADD CONSTRAINT
		roomTypeFKey
	FOREIGN KEY
		(typeKey)
	REFERENCES
		type(key)
;
/*------------------------------------*/
CREATE INDEX roomTypeFndx ON
	room
		(
		typeKey
		)
;
/*------------------------------------------------------------------------*/
INSERT INTO type (key,name) VALUES (key.NEXTVAL,'Undefined');
INSERT INTO type (key,name) VALUES (key.NEXTVAL,'Office');
INSERT INTO type (key,name) VALUES (key.NEXTVAL,'Closet');
INSERT INTO type (key,name) VALUES (key.NEXTVAL,'Storage');
INSERT INTO type (key,name) VALUES (key.NEXTVAL,'Utility');
INSERT INTO type (key,name) VALUES (key.NEXTVAL,'Kitchen');
COMMIT;
/*------------------------------------------------------------------------*/
spool off