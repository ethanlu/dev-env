ftp:
    pkg:
        - installed

git:
    pkg:
        - installed

mlocate:
    pkg:
        - installed

tree:
    pkg:
        - installed

wget:
    pkg:
        - installed

xterm256:
    file.managed:
        - name: /etc/profile.d/xterm256.sh
        - contents: |
            export TERM=xterm-256color