#!/bin/sh

echo -n "Please provide path to JRE Linux 64 bit binary (in tar.gz format) : "
read jre_binary_path
./addBlob.sh ${jre_binary_path} jre

echo -n "Please provide path to Coherence Jar : "
read coherence_jar_path
./addBlob.sh ${coherence_jar_path} coherence

echo "Done adding dependencies"
echo ""
