#!/bin/sh

function usage() {
  echo "Error!! needs 1 argument: <Name of Blob file> "
  echo ""
  echo "Example: ./removeBlob.sh coherence.jar"
  echo "This would remove all references to the 'coherence.jar' from 'blobs/coherence', 'config/blobs.yml' and .blobs folder "
  echo ""
}

if [ "$#" -lt 1 ]; then
  usage
  exit -1
fi

blobFileName=$1

shaFileId=`grep -A2 $blobFileName config/blobs.yml | grep sha  | awk '{print $2}' `
echo "Deleting the blob entry: $blobFileName, cancel to stop"
sleep 5
rm .blobs/$shaFileId
find blobs -name $blobFileName | xargs rm 
sed -i.bak "/$blobFileName/,/size: / { d; }" config/blobs.yml
rm config/blobs.yml.bak

