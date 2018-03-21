#!/bin/bash
echo -------------------------------
curl -X GET -u tester:testerpass "http://localhost:8080/tox/bui.getter.everything" >> test/testResult.txt
echo -------------------------------
curl -X GET -u tester:testerpass "http://localhost:8080/tox/bui.getter.types" >> test/testResult.txt
echo -------------------------------
curl -X GET -u tester:testerpass "http://localhost:8080/tox/bui.getter.buildingAndRooms?in_key=10022" >> test/testResult.txt
echo -------------------------------
curl -X GET -u tester:testerpass "http://localhost:8080/tox/bui.getter.buildingAndRooms?in_name=B123" >> test/testResult.txt
echo -------------------------------
# outer quotes must be single, inner quotes must be double
curl -X POST -d '<bui><bldg name="B256"/></bui>' -u tester:testerpass "http://localhost:8080/tox/bui.creater.building" >> test/testResult.txt
echo -------------------------------
curl -X POST -d '<bui><rm name="1234A" bldgKey="10021" typeKey="10001"/></bui>' -u tester:testerpass "http://localhost:8080/tox/bui.creater.room" >> test/testResult.txt
echo -------------------------------
curl -X POST -d '<bui><bldg key="10040" name="Building 255"/></bui>' -u tester:testerpass "http://localhost:8080/tox/bui.updater.building" >> test/testResult.txt
echo -------------------------------
curl -X POST -d '<bui><rm key="10026" name="Roo" bldgKey="10022" typeKey="10005"/></bui>' -u tester:testerpass "http://localhost:8080/tox/bui.updater.room" >> test/testResult.txt
echo -------------------------------
curl -X GET -u tester:testerpass "http://localhost:8080/tox/bui.deleter.building?in_key=10021" >> test/testResult.txt
echo -------------------------------
curl -X GET -u tester:testerpass "http://localhost:8080/tox/bui.deleter.room?in_key=10025" >> test/testResult.txt
echo -------------------------------
echo ------------------------------- >> test/testResult.txt
date >> test/testResult.txt
echo ------------------------------- >> test/testResult.txt
echo -----------------------------