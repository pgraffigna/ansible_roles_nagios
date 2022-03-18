# dependencias
sudo apt update; sudo apt install -y apt-transport-https software-properties-common wget

# llave
wget -q -O - https://packages.grafana.com/gpg.key | sudo apt-key add -

# repositorio
echo "deb https://packages.grafana.com/enterprise/deb stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list
sudo apt-get update; sudo apt install -y grafana-enterprise

# iniciar servicio
sudo systemctl enable grafana-server --now

# pnp4nagios-grafana
sudo grafana-cli plugins install sni-pnp-datasource
sudo systemctl restart grafana-server.service
cd /usr/local/pnp4nagios/share/application/controllers/
sudo wget -O api.php "https://github.com/lingej/pnp-metrics-api/raw/master/application/controller/api.php"

# Grant localhost Permission To PNP4Nagios Site
sudo sh -c "sed -i '/Require valid-user/a\        Require ip 127.0.0.1 ::1' /etc/apache2/sites-enabled/pnp4nagios.conf"

# handler apache
sudo systemctl restart apache2.service

