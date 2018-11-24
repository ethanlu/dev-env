repos:
    pkg.installed:
        - sources:
            - epel-release: https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
            - remi-release: http://rpms.remirepo.net/enterprise/remi-release-7.rpm

yum-utils:
    pkg:
        - installed

pkgupdated:
    pkg.uptodate:
        - refresh: True