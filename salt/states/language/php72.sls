enable-php72:
    cmd.run:
        - name: |
            yum-config-manager --enable remi-php72

php72:
    pkg.installed:
        - names:
            - php
            - php-cli
            - php-common
            - php-devel
            - php-mbstring
            - php-pecl-mcrypt
            - php-mysqlnd
            - php-pear
            - php-pgsql
            - php-xml