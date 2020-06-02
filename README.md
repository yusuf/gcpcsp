# Google Cloud SQL Proxy init.d Service
Google Cloud provides a proxy connector that allows you to connect a MySQL/PostgresSQL client to your Google Cloud SQL instance.
This is a daemon-friendly with a install, init.d service script and for use on Debian/Ubuntu servers.

To learn more about Google Cloud SQL Proxy, [check out GCP documentation](https://cloud.google.com/sql/docs/).

## Installing
Clone this repo (or download the archive):
```sh
git clone https://github.com/yusuf/gcpcsp
cd gcpcsp
sudo ./install.sh
```
This will perform the following:
  - Download the latest cloud_sql_proxy directly from Google to /opt/gcpcsp/
  - Create a default config file in /etc/gcpcsp/gcpcsp.conf
  - Install a gcpcsp service script at /etc/init.d/gcpccsp
## Configuration
As outlined in the Google Cloud SQL Proxy instructions, you will need to set up credentials to enable you to remotely access Google Cloud SQL from your server.  The configuration requires you have a JSON-formatted private key credential file.  This file will need to be copied to a secure location somewhere on your server.  We recommend /etc/gcpcsp/:
``csp
$ cp the-credential-file.json /etc/gcpcsp/
$ chmod 600 /etc/gcpcsp/the-credential-file.json
```
Then, edit the configuration file located at /etc/gcpcsp/gcpcsp.conf, using your favorite editor.  Specifically pay attention to the following settings:
``csp
# Local port to open for MySQL connections. This can be either a port or ipaddress:port
# If you use an IP address, ensure that your firewall is blocking outside traffic!
DB_PORT=5432

# Instance ID to which the proxy should connect
INSTANCE_ID=project:region:instance

# Credential file to use for the connection - FULL PATH REQUIRED!
GOOGLE_APPLICATION_CREDENTIALS=/full/path/to/credential.json
```
Note: The gcpcsp.conf file is actually a Bash-formatted script, sourced by init.d/gcpcsp.  Change as you pleascsp
## Running Cloud SQL Proxy
As with any init.d service, you can simply use the "service" command to start, stop or restart cloud_sql_proxy:
```sh
$ service gcpcsp start
$ service gcpcsp stop
$ service gcpcsp restart
```

## Cloud SQL Proxy Logging
The service will log all the output from cloud_sql_proxy to /var/log/gcpscp.locsp
## Uninstalling the init.d Script
To uninstall the service, simply run:
```sh
$ service gcpscp uninstall
```
Note that the cloud_sql_proxy will remain in /opt/gcpcsp/, also your config file will still be in /etc/gcpcsp/.
Remove these manually, along with any logs in /var/log/gcpcsp.log
## Issues?
If you have any issues with the script, feel free to open an issue on this project.
I will probably won't respond though, unless if you have a pull request.

### As Is, No Warranty
I am not responsible for what this script does to your server.
Use it at your own risk.
