# install repo
mariadb10-repo:
    pkgrepo.managed:
        - name: mariadb-repo
        - enabled: True
        - baseurl: http://yum.mariadb.org/10.2/centos7-amd64
        - gpgkey: https://yum.mariadb.org/RPM-GPG-KEY-MariaDB
        - gpgcheck: True

# install package
mariadb10:
    pkg.installed:
        - names:
            - MariaDB-server
            - MariaDB-client

# salt dependency
MySQL-python:
    pkg:
        - installed

# setup service
mariadb10-service:
    service.running:
        - name: mysqld
        - enable: True

# create generic vagrant user that has access to all
mariadb10-vagrant-user:
    mysql_user.present:
        - name: vagrant
        - host: '%'
        - password: vagrant

mariadb10-vagrant-access:
    mysql_grants.present:
        - grant: all privileges
        - database: '*.*'
        - user: vagrant
        - host: '%'

# remove anonymous access to db
mariadb10-user-cleanup:
    mysql_user.absent:
        - name: 