#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

ENV_FILE=$DIR/../etc/env.sh

if [ -f $ENV_FILE ]; then
	source $ENV_FILE
fi

TEMP_FILE=`tempfile -p wastl-`

curl -s -b $COOKIE_FILE -c $COOKIE_FILE $DEMO_XML_URL > $TEMP_FILE

sed -i "s/utf\-16/utf\-8/g" $TEMP_FILE

xsltproc $XSL_FILE $TEMP_FILE