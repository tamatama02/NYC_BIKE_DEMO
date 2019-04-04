#!/bin/bash

#####
# set variables
$objectStoreURL=oci://test01bdc01@orasejapan
$IPADDRESS=127.0.0.1

#####
# https://zeppelin.apache.org/docs/0.7.0/rest-api/rest-notebook.html#import-a-note
echo "importing lab notebooks"
mkdir /tmp/notebooks
cd /tmp/notebooks
wget -nc https://github.com/millerhoo/journey2-new-data-lake/raw/master/workshops/journey2-new-data-lake/files/Notes.zip
unzip Notes.zip
sed -i -- "s~swift://\$CONTAINER.default~$objectStoreURL~g" *.json
sed -i -- "s~swift://journeyC.default~$objectStoreURL~g" *.json
for note in /tmp/notebooks/*.json
do
  echo $note
  curl -X POST -d @"$note" -H "Content-Type: application/json" http://${IPADDRESS}:9995/api/notebook/import
done

