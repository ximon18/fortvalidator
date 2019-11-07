#!/bin/sh
rcynic \
    --config /opt/rcynic.conf \
    --unauthenticated /unauthenticated \
    --xml-file /tmp/validator.log.xml \
    --tals /tals \
    $@
