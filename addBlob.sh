#!/bin/sh

function usage() {
  echo "Error!! Needs 2 arguments: <Path to Blob file> <Directory or folder under ./blobs to save it>"
  echo ""
  echo "Example: ./addBlob.sh /tmp/coherence.jar coherence"
  echo "This would add the 'coherence.jar' as blob under 'blobs/coherence' "
  echo ""
}

if [ "$#" -lt 2 ]; then
  usage
  exit -1
fi

givenBlobFile=$1

# The path to the file can have other directories
# Trim the directories
blobFile=`echo $givenBlobFile | awk  -F '/' '{print $NF } '`
blobPath=$2

bosh -n add blob $givenBlobFile $blobPath
bosh -n upload blobs

if [ "$blobFile" == "*tar.gz" ]; then
  PACKAGE_SPEC_FILE=`echo packages/jre/spec`
elif [ "$blobFile" == "*jar" ]; then
  PACKAGE_SPEC_FILE=`echo packages/coherence/spec`
else
  PACKAGE_SPEC_FILE=`echo packages/${blobPath}/spec`
fi
echo "- ${blobPath}/${blobFile}" >> $PACKAGE_SPEC_FILE

find jobs -name "*.bak" | xargs rm 
find packages -name "*.bak" | xargs rm 

echo ""
