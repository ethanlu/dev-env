#########################################################################################################
#########################################################################################################
# python packages
python36:
    pkg.installed:
        - names:
            - python36
            - python36-libs
            - python36-devel
            - python36-numpy
            - python36-setuptools

#########################################################################################################
#########################################################################################################
# python package manager

# install pip
pip:
    cmd.run:
        - name: curl https://bootstrap.pypa.io/get-pip.py | /usr/bin/python3.6
        - unless: /usr/local/bin/pip

# make sure pip is always latest
pip_latest:
    cmd.run:
        - name: /usr/local/bin/pip install --upgrade pip

#########################################################################################################
#########################################################################################################
# tools

# python virtual env manager
virtualenvwrapper:
    cmd.run:
        - name: /usr/local/bin/pip install virtualenvwrapper
        - unless: /usr/local/bin/lsvirtualenv

# make sure the commands are available to users when they login
virtualenvwrapper_commands:
    file.managed:
        - name: /etc/profile.d/virtualenvwrapper_setup.sh
        - contents: |
            export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3.6
            export WORKON_HOME=~/.virtualenvs
            source /usr/local/bin/virtualenvwrapper.sh