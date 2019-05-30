# Example of use ogr2osm brazil_mg_bh.py filter to import address data from Belo Horizonte into openstreetmaps:

```console
$ git clone --recurse-submodules https://github.com/navegantedoalem/container_enderecos_bh.git
Cloning into 'container_enderecos_bh'...
...
$ docker build --tag=container_enderecos_bh container_enderecos_bh/
Sending build context to Docker daemon 2.437 MB
Step 1/4 : FROM fedora:30
...
Successfully built 582cb21aeceb

$ docker run -ti --name=container_enderecos_bh --hostname=container_enderecos_bh container_enderecos_bh /bin/bash
[root@container_enderecos_bh /]# cd
[root@container_enderecos_bh ~]# bash enderecos_bh.sh
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 1272k    0 1272k    0     0  1203k      0 --:--:--  0:00:01 --:--:-- 1203k
GML: Using Expat reader
HTTP: Fetch(http://bhmap.pbh.gov.br:80/v2/api/wfs?service=WFS&version=2.0.0&request=DescribeFeatureType&typeName=germem%3ABHMAP_ENDERECO_PBH)
HTTP: libcurl/7.64.0 OpenSSL/1.1.1b zlib/1.2.11 brotli/1.0.7 libidn2/2.1.1 libpsl/0.20.2 (+libidn2/2.0.5) libssh/0.8.7/openssl/zlib nghttp2/1.37.0
GML: Using /vsimem/tmp_gml_xsd_0x55cf2ae2a2d0.xsd
GDAL: GDALOpen(TEMP_BHMAP_ENDERECO_PBH_iYDmRm_0.xml, this=0x55cf2ae2a2d0) succeeds as GML.
...
[======================================================================] 100%
Now import BHMAP_ENDERECO_PBH.osm into JOSM and double check every mispelled street and duplicated addresses
[root@container_enderecos_bh ~]# exit
exit
$ docker cp container_enderecos_bh:/root/BHMAP_ENDERECO_PBH.osm .
```
