addgroup --gid 1000 --group dockergroup
adduser --system --shell /bin/bash --disabled-login --uid 1000 --gid 1000 dockeruser

gem install bundler
chown -R dockeruser:dockergroup /usr/local/bundle

apt-get update -qq
apt-get install -y --no-install-recommends libpq-dev postgresql-client-11 cron sudo

echo "dockeruser ALL=(ALL) NOPASSWD: /usr/sbin/cron" >> /etc/sudoers
