#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

ENV_FILE=$DIR/../etc/env.sh

if [ -f $ENV_FILE ]; then
	source $ENV_FILE
fi

TEMP_FILE=`tempfile -p wastl- -s .xml -d $TEMP_DIR`
HTML_FILE=`tempfile -p wastl- -s .html -d $HTML_DIR`
#HTML_FILE=$HTML_DIR/out.html
PDF_FILE=`tempfile -m 0666 -p wastl- -s .pdf -d $PDF_DIR`

curl -s -b $COOKIE_FILE -c $COOKIE_FILE $DEMO_XML_URL > $TEMP_FILE

sed -i "s/utf\-16/utf\-8/g" $TEMP_FILE

xsltproc $XSL_FILE $TEMP_FILE > $HTML_FILE

$BIN_DIR/wkhtmltopdf-xvfb --javascript-delay 10000 --debug-javascript $HTML_FILE $PDF_FILE

#lp $PDF_FILE
