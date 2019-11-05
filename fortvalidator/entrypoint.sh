#!/bin/bash
set -e -u -o pipefail

if [[ "$*" != *standalone* ]]; then
    # In standalone mode FORT Validator logs to STDOUT and STDERR.
    # In other modes FORT Validator logs ONLY to syslog.
    # See: https://nicmx.github.io/FORT-validator/logging.html
    # Redirect writes from rsyslog to /var/log/syslog to the STDOUT of PID 1.
    # Perhaps there is a proper way to do this with rsyslog output modules?
    # The end result is:
    #   fort -> rsyslog -> /var/log/syslog -> /proc/1/fd/1 -> Docker
    ln -sf /proc/1/fd/1 /var/log/syslog
    /etc/init.d/rsyslog start
fi

/usr/bin/fort --tal /tals --local-repository /repo $@