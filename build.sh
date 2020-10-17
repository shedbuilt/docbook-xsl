#!/bin/bash
declare -A SHED_PKG_LOCAL_OPTIONS=${SHED_PKG_OPTIONS_ASSOC}

# Set man option, which requires docbook-xsl
SHED_PKG_LOCAL_MAN_OPTION='false'
if [ -n "${SHED_PKG_LOCAL_OPTIONS[docs]}" ]; then
    SHED_PKG_LOCAL_MAN_OPTION='true'
fi
# Patch
# Apply BLFS stack overflow patch
patch -Np1 -i "${SHED_PKG_PATCH_DIR}/docbook-xsl-nons-1.79.2-stack_fix-1.patch" &&

# Install
install -v -m755 -d "${SHED_FAKE_ROOT}/usr/share/xml/docbook/xsl-stylesheets-nons-${SHED_PKG_VERSION}" &&
cp -v -R VERSION assembly common eclipse epub epub3 extensions fo        \
         highlighting html htmlhelp images javahelp lib manpages params  \
         profiling roundtrip slides template tests tools webhelp website \
         xhtml xhtml-1_1 xhtml5                                          \
    "${SHED_FAKE_ROOT}/usr/share/xml/docbook/xsl-stylesheets-nons-${SHED_PKG_VERSION}" &&
ln -s VERSION "${SHED_FAKE_ROOT}/usr/share/xml/docbook/xsl-stylesheets-nons-${SHED_PKG_VERSION}/VERSION.xsl" &&
install -v -m644 -D README \
                    "${SHED_FAKE_ROOT}/usr/share/doc/docbook-xsl-nons-${SHED_PKG_VERSION}/README.txt" &&
install -v -m644    RELEASE-NOTES* NEWS* \
                    "${SHED_FAKE_ROOT}/usr/share/doc/docbook-xsl-nons-${SHED_PKG_VERSION}"
