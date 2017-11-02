#! /bin/bash
DATA_PATH=~/.rally/benchmarks/data/companies
FILENAME=documents
DOWNLOAD_URL=https://opendata.camden.gov.uk/api/views/iix4-id37/rows.csv?accessType=DOWNLOAD

if [ ! -d $DATA_PATH ]; then
    mkdir $DATA_PATH
fi

curl -o $DATA_PATH/$FILENAME.csv $DOWNLOAD_URL
python3 toJsonWithID.py > $DATA_PATH/$FILENAME.json
bzip2 -9 -c $DATA_PATH/$FILENAME.json > $DATA_PATH/$FILENAME.json.bz2

echo "The following values will be required in the meta section of track.json:"
wc -l $DATA_PATH/$FILENAME.csv | awk {'print "Document count: " $1'}

UNCOMPRESSED_BYTES="$(wc -c < "$DATA_PATH/$FILENAME.json")"
echo "Uncompressed Bytes: $UNCOMPRESSED_BYTES"

COMPRESSED_BYTES="$(wc -c < $DATA_PATH/$FILENAME.json.bz2)"
echo "Compressed Bytes: $COMPRESSED_BYTES"
