#!/bin/bash
echo -------------------------------
curl -X POST -d "<root><date>19690720</date></root>" -u tester:testerpass "http://localhost:8080/tox/bui.creater.building" >> testResult.txt
echo -------------------------------
curl -X POST -d "<root><date>19690720</date></root>" -u tester:testerpass "http://localhost:8080/tox/bui.creater.room?in_key=1111" >> testResult.txt
echo -------------------------------
curl -X GET -u tester:testerpass "http://localhost:8080/tox/bui.getter.everything" >> testResult.txt
echo -------------------------------
curl -X GET -u tester:testerpass "http://localhost:8080/tox/bui.getter.types" >> testResult.txt
echo -------------------------------
curl -X GET -u tester:testerpass "http://localhost:8080/tox/bui.getter.buildingAndRooms?in_key=1111" >> testResult.txt
echo -------------------------------
curl -X GET -u tester:testerpass "http://localhost:8080/tox/bui.getter.buildingAndRooms?in_name=B123" >> testResult.txt
echo -------------------------------
curl -X GET -u tester:testerpass "http://localhost:8080/tox/bui.getter.room?in_key=2222" >> testResult.txt
echo -------------------------------
curl -X POST -d "<root><date>19690720</date></root>" -u tester:testerpass "http://localhost:8080/tox/bui.updater.building?in_key=1111" >> testResult.txt
echo -------------------------------
curl -X POST -d "<root><date>19690720</date></root>" -u tester:testerpass "http://localhost:8080/tox/bui.updater.room?in_key=2222" >> testResult.txt
echo -------------------------------
curl -X GET -u tester:testerpass "http://localhost:8080/tox/bui.deleter.building?in_key=1111" >> testResult.txt
echo -------------------------------
curl -X GET -u tester:testerpass "http://localhost:8080/tox/bui.deleter.room?in_key=2222" >> testResult.txt
echo -------------------------------
echo ------------------------------- >> testResult.txt
date >> testResult.txt
echo ------------------------------- >> testResult.txt
echo -----------------------------