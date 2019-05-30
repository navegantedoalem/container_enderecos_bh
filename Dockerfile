FROM fedora:30
MAINTAINER "navegante@doalem.com"

RUN dnf -y install gdal-python-tools osmium-tool; dnf clean all

ADD enderecos_bh.sh /root
ADD ogr2osm/ /root/ogr2osm/
