repos:
    pkg.installed:
        - sources:
            - epel-release: https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
            - remi-release: http://rpms.remirepo.net/enterprise/remi-release-7.rpm

mariadb10-repo:
    pkgrepo.managed:
        - name: mariadb-repo
        - enabled: True
        - baseurl: http://yum.mariadb.org/10.2/centos7-amd64
        - gpgkey: https://yum.mariadb.org/RPM-GPG-KEY-MariaDB
        - gpgcheck: True

yum-utils:
    pkg:
        - installed

pkgupdated:
    pkg.uptodate:
        - refresh: True