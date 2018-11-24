redis:
    pkg:
        - installed

redis-service:
    service.running:
        - name: redis
        - enable: True