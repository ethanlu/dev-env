# install repo
postgres11-repo:
    pkg.installed:
        - sources:
            - pgdg-centos11: https://download.postgresql.org/pub/repos/yum/11/redhat/rhel-7-x86_64/pgdg-centos11-11-2.noarch.rpm

# install package
postgres11:
    pkg.installed:
        - names:
            - postgresql11-server
            - postgresql11-contrib
            - postgresql11-devel

# init database
postgres11-init:
    cmd.run:
        - name: |
            /usr/pgsql-11/bin/postgresql-11-setup initdb
            sed -i -r 's|^(host\s+all\s+all\s+127\.0\.0\.1/32\s+).*$|\1md5|' /var/lib/pgsql/11/data/pg_hba.conf
            sed -i -r 's|^(host\s+all\s+all\s+\:\:1/128\s+).*$|\1md5|' /var/lib/pgsql/11/data/pg_hba.conf
        - unless: test -e /var/lib/pgsql/11/data/pg_hba.conf

# setup service
postgres11-service:
    service.running:
        - name: postgresql-11
        - enable: True

# # create generic vagrant user that has access to all
postgres11-vagrant-user:
    postgres_user.present:
        - name: vagrant
        - password: vagrant
        - createdb: True
        - createroles: True
        - createuser: True
        - superuser: True

postgres11-vagrant-db:
    postgres_database.present:
        - name: db
        - owner: vagrant