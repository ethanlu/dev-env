# rabbitmq key download
rabbitmq-key:
    cmd.run:
        - name: |
            curl -L https://packagecloud.io/rabbitmq/rabbitmq-server/gpgkey -s | gpg --import
            curl -L https://packagecloud.io/gpg.key  -s | gpg --import

# install erlang dependenchy
rabbitmq-erlang-repo:
    pkgrepo.managed:
        - name: rabbitmq_erlang
        - baseurl: https://packagecloud.io/rabbitmq/erlang/el/7/$basearch
        - repo_gpgcheck: True
        - gpgcheck: False
        - enabled: True
        - gpgkey: https://packagecloud.io/rabbitmq/erlang/gpgkey
        - sslverify: True
        - sslcacert: /etc/pki/tls/certs/ca-bundle.crt
        - metadata_expire: 300

# install repo
rabbitmq37-repo:
    pkgrepo.managed:
        - name: bintray-rabbitmq-rpm
        - baseurl: https://dl.bintray.com/rabbitmq/rpm/rabbitmq-server/v3.7.x/el/7/
        - enabled: True
        - gpgcheck: False
        - repo_gpgcheck: False

# install package
rabbitmq37:
    pkg.installed:
        - names:
            - erlang
            - rabbitmq-server

# setup service
rabbitmq37-service:
    service.running:
        - name: rabbitmq-server
        - enable: True

# setup user
rabbitmq37-user:
    rabbitmq_user.present:
        - name: vagrant
        - password: vagrant
        - tags: administrator
        - perms:
            - '/':
                - '.*'
                - '.*'
                - '.*'

# env file
rabbitmq_env_config:
    file.managed:
        - name: /etc/rabbitmq/rabbitmq-env.conf
        - source:
            - /srv/salt/templates/rabbitmq-env.conf

            # env file
rabbitmq_config:
    file.managed:
        - name: /etc/rabbitmq/rabbitmq.conf
        - source:
            - /srv/salt/templates/rabbitmq-env.conf