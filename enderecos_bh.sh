#!/bin/bash

# Already set in the command line:
#export SHAPE_ENCODING="ISO8859-1"

# Uncomment to enable debug from GDAL library:
#export CPL_DEBUG=ON
ID_FILE=$(mktemp -u TEMP_id_saved_XXXXX)
#COUNT_FILE=$(mktemp -u TEMP_count_XXXXX.xml)
SPLIT_FILE=$(mktemp -u TEMP_BHMAP_ENDERECO_PBH_XXXXXX)
MAX=10000
QUERY="http://bhmap.pbh.gov.br/v2/api/wfs?SERVICE=WFS&REQUEST=GetFeature&VERSION=2.0.0&TYPENAMES=germem:BHMAP_ENDERECO_PBH&SRSNAME=urn:ogc:def:crs:EPSG::31983&urn:ogc:def:crs:EPSG::31983&OUTPUTFORMAT=GML3"
for((x=0; ; x++))
do
EXTRA_OPTS="--saveid=$ID_FILE"
if [ $x -gt 0 ]; then EXTRA_OPTS="$EXTRA_OPTS --idfile=$ID_FILE"; fi
let INDEX=$x*$MAX
FILE="${SPLIT_FILE}_${x}.xml"
curl -o $FILE "${QUERY}&STARTINDEX=${INDEX}&COUNT=${MAX}"
let RESULTS=$(awk 'BEGIN{RS="<"; count=0}/^gml:Point.*/{count++;}END{print count}' $FILE)
if [ "$RESULTS" -le 0 ] ; then break; fi

python3 ./ogr2osm/ogr2osm.py -fv --epsg=31983 --encoding=ISO8859-1 $FILE $EXTRA_OPTS --translation=brazil_mg_bh
echo "Last saved id=$(<$ID_FILE)"
done

rm -fv $ID_FILE $COUNT_FILE ${SPLIT_FILE}_${x}.xml
osmium merge --overwrite -o BHMAP_ENDERECO_PBH.osm ${SPLIT_FILE}_*.osm
echo "Now import BHMAP_ENDERECO_PBH.osm into JOSM and double check every mispelled street and duplicated addresses"

