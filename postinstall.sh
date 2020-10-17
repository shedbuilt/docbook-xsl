#!/bin/bash
declare -A SHED_PKG_LOCAL_OPTIONS=${SHED_PKG_OPTIONS_ASSOC}

# If upgrading, remove old rewrite entries from catalog
if [ -f /etc/xml/catalog ]; then
    sed -i '/rewrite/d' /etc/xml/catalog
fi &&

if [ ! -d /etc/xml ]; then install -v -m755 -d /etc/xml; fi &&
if [ ! -f /etc/xml/catalog ]; then
    xmlcatalog --noout --create /etc/xml/catalog
fi &&

xmlcatalog --noout --add "rewriteSystem" \
           "https://cdn.docbook.org/release/xsl-nons/${SHED_PKG_VERSION}" \
           "/usr/share/xml/docbook/xsl-stylesheets-nons-${SHED_PKG_VERSION}" \
    /etc/xml/catalog &&

xmlcatalog --noout --add "rewriteURI" \
           "https://cdn.docbook.org/release/xsl-nons/${SHED_PKG_VERSION}" \
           "/usr/share/xml/docbook/xsl-stylesheets-nons-${SHED_PKG_VERSION}" \
    /etc/xml/catalog &&

xmlcatalog --noout --add "rewriteSystem" \
           "https://cdn.docbook.org/release/xsl-nons/current" \
           "/usr/share/xml/docbook/xsl-stylesheets-nons-${SHED_PKG_VERSION}" \
    /etc/xml/catalog &&

xmlcatalog --noout --add "rewriteURI" \
           "https://cdn.docbook.org/release/xsl-nons/current" \
           "/usr/share/xml/docbook/xsl-stylesheets-nons-${SHED_PKG_VERSION}" \
    /etc/xml/catalog &&

xmlcatalog --noout --add "rewriteSystem" \
           "http://docbook.sourceforge.net/release/xsl/current" \
           "/usr/share/xml/docbook/xsl-stylesheets-nons-${SHED_PKG_VERSION}" \
    /etc/xml/catalog &&

xmlcatalog --noout --add "rewriteURI" \
           "http://docbook.sourceforge.net/release/xsl/current" \
           "/usr/share/xml/docbook/xsl-stylesheets-nons-${SHED_PKG_VERSION}" \
    /etc/xml/catalog
