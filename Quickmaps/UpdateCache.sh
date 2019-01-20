#! /bin/bash

function update { # search area, relId, tags
    mkdir $1
    cd $1
    QUERY="[out:json][timeout:25];area($2)->.searchArea;(node$3(area.searchArea);way$3(area.searchArea);relation$3(area.searchArea););out body;>;out skel qt;"
    wget -O "$3.json" "https://overpass-api.de/api/interpreter?data=$QUERY"
    cd ..

}

cd cache
#update Name    Relation-ID, prefixed with 3600 (should be equal length)
update "Brugge" "3600562654" '["amenity"="public_bookcase"]'
update "Brugge" "3600562654" '["leisure"="nature_reserve"]["operator"="Natuurpunt Brugge"]'
update "Gent"   "3602524008" '["natural"="tree"]["species"]'
update "Gent"   "3602524008" '["natural"="tree"]["species:nl"]'
update "Gent"   "3602524008" '["landuse"="orchard"]'

git add .
git commit -m "Update of the cache"
git push
