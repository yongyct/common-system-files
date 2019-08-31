# Logstash Helpful Tools

## Securing secrets in logstash configs
* https://www.elastic.co/guide/en/logstash/current/keystore.html

## Offline installation of logstash plugins

### For machine with internet access
* 1) Install plugin (from internet if necessary): `/path/to/bin/logstash-plugin install [pluginname]`
* 2) Prepare offline pack: `/path/to/bin/logstash-plugin prepare-offline-pack --output /path/to/plugin.zip [pluginname]`

### For machine without internet access
* 3) Copy offline pack over and install: `/path/to/bin/logstash-plugin install file:///path/to/plugin.zip`

## Useful options when running `logstash` binary
* Check config file syntax: `--config.test_and_exit`
* Auto-reload changes in config file: `--config.reload.automatic`
