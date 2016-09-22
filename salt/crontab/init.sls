extract:
  cron.present:
    - name: docker run -itv {{ salt['pillar.get']('id_rsa', '/root/.ssh/id_rsa') }}:/root/id_rsa  dngroup/girafe-ixp-data-extractor ./extract.sh
    - hour: '*/4'
    - user: {{ salt['pillar.get']('user', 'root') }}

compile:
  cron.present:
    - name: docker run -itv {{ salt['pillar.get']('id_rsa', '/root/.ssh/id_rsa') }}:/root/id_rsa -v {{ salt['pillar.get']('outfloder', '/var/www/girafe-data') }}:/root/tohost/girafe-ixp-data-extractor  dngroup/girafe-ixp-data-extractor ./compile.sh
    - minute: 30
    - hour: '1'
    - user: {{ salt['pillar.get']('user', 'root') }}

webupdate:
  cron.present:
    - name: docker run -itv {{ salt['pillar.get']('id_rsa', '/root/.ssh/id_rsa') }}:/root/id_rsa -v {{ salt['pillar.get']('outfloder', '/var/www/girafe-data') }}:/root/tohost/girafe-ixp-data-extractor  dngroup/girafe-ixp-data-extractor ./docker/webupdate.sh
    - minute: 30
    - hour: '2'
    - user: {{ salt['pillar.get']('user', 'root') }}

mv out folder:
  cron.present:
    - name: cp -r {{ salt['pillar.get']('outfloder', '/var/www/girafe-data') }}/out {{ salt['pillar.get']('outfloder', '/var/www/girafe-data') }}/web
    - minute: 30
    - hour: '3'
    - user: {{ salt['pillar.get']('user', 'root') }}

peeringdb extractor:
  cron.present:
    - name: docker run -itv {{ salt['pillar.get']('id_rsa', '/root/.ssh/id_rsa') }}:/root/id_rsa  dngroup/girafe-ixp-data-extractor ./ixp.sh
    - hour: '2'
    - user: {{ salt['pillar.get']('user', 'root') }}
