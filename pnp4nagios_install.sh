#Step 1- Installing RRDTool
sudo apt update && sudo apt-get install -y rrdtool librrds-perl php-gd php-xml

#Step 2- Downloading PNP4Nagios Source
cd /tmp
wget -O pnp4nagios.tar.gz https://github.com/lingej/PNP4Nagios/archive/0.6.26.tar.gz
tar xzf pnp4nagios.tar.gz

#Step 3- Compiling and Installing PNP4Nagios
cd pnp4nagios-0.6.26
sudo ./configure --with-httpd-conf=/etc/apache2/sites-enabled --with-rrdtool=/usr/bin/rrdtool --with-nagios-user=nagios --with-nagios-group=nagcmd
sudo make all
sudo make install
sudo make install-webconf
sudo make install-config
sudo make install-init
sudo make fullinstall

# Step 4- Configuring NPCD service
sudo systemctl enable npcd --now

# Step 5- Modifying the nagios.cfg file
sudo nano /usr/local/nagios/etc/nagios.cfg
cambiar process_performance_data=0 por process_performance_data=1
cambiar enable_environment_macros=0 por enable_environment_macros=1

# service performance data
#
service_perfdata_file=/usr/local/pnp4nagios/var/service-perfdata
service_perfdata_file_template=DATATYPE::SERVICEPERFDATA\tTIMET::$TIMET$\tHOSTNAME::$HOSTNAME$\tSERVICEDESC::$SERVICEDESC$\tSERVICEPERFDATA::$SERVICEPERFDATA$\tSERVICECHECKCOMMAND::$SERVICECHECKCOMMAND$\tHOSTSTATE::$HOSTSTATE$\tHOSTSTATETYPE::$HOSTSTATETYPE$\tSERVICESTATE::$SERVICESTATE$\tSERVICESTATETYPE::$SERVICESTATETYPE$
service_perfdata_file_mode=a
service_perfdata_file_processing_interval=15
service_perfdata_file_processing_command=process-service-perfdata-file

#
# host performance data starting with Nagios 3.0
#
host_perfdata_file=/usr/local/pnp4nagios/var/host-perfdata
host_perfdata_file_template=DATATYPE::HOSTPERFDATA\tTIMET::$TIMET$\tHOSTNAME::$HOSTNAME$\tHOSTPERFDATA::$HOSTPERFDATA$\tHOSTCHECKCOMMAND::$HOSTCHECKCOMMAND$\tHOSTSTATE::$HOSTSTATE$\tHOSTSTATETYPE::$HOSTSTATETYPE$
host_perfdata_file_mode=a
host_perfdata_file_processing_interval=15
host_perfdata_file_processing_command=process-host-perfdata-file

# Step 6- Defining Nagios Commands
sudo nano /usr/local/nagios/etc/objects/commands.cfg

# PNP4Nagios
define command{
       command_name    process-service-perfdata-file
       command_line    /usr/local/pnp4nagios/libexec/process_perfdata.pl --bulk=/usr/local/pnp4nagios/var/service-perfdata
}

define command{
       command_name    process-host-perfdata-file
       command_line    /usr/local/pnp4nagios/libexec/process_perfdata.pl --bulk=/usr/local/pnp4nagios/var/host-perfdata
}

# DELETE DEFAULT PHP PAGE
sudo rm -f /usr/local/pnp4nagios/share/install.php

# handler - restart nagios
sudo a2enmod rewrite
sudo systemctl restart apache2
sudo systemctl restart nagios.service

# web-access
# http://192.168.121.11/pnp4nagios/

# checkers
# sudo /usr/local/nagios/bin/nagios -v /usr/local/nagios/etc/nagios.cfg --> nagios conf
# /tmp/pnp4nagios-0.6.26/scripts./verify_pnp_config_v2.pl -m bulk -c /usr/local/nagios/etc/nagios.cfg -p /usr/local/pnp4nagios/etc/ --> pnp4nagios check

