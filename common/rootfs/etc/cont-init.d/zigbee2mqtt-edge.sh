#!/usr/bin/with-contenv bashio
DATA_PATH=$(bashio::config 'data_path')

if bashio::config.true 'zigbee_inject_for_test'; then
    bashio::log.debug "Searching for directory inject_for_test in zigbee2mqtt data path..."
    if bashio::fs.directory_exists "$DATA_PATH/inject_for_test"; then
        bashio::log.info "Directory inject_for_test found, copying to ./node_modules/"
        bashio::log.info "$(cp -afv "$DATA_PATH"/inject_for_test/. ./node_modules/)"
    else
        bashio::log.warning "No inject_for_test directory found in data path, no overwrites copied."
    fi
else
    bashio::log.debug "No inject_for_test directory manipulation required"
fi
 
if bashio::config.true 'zigbee_shepherd_devices'; then
    bashio::log.debug "Searching for custom devices.js file in zigbee2mqtt data path..."
    if bashio::fs.file_exists "$DATA_PATH/devices.js"; then
        bashio::log.info "File devices.js found, copying to ./node_modules/zigbee-herdsman-converters/"
        cp -f "$DATA_PATH"/devices.js ./node_modules/zigbee-herdsman-converters/devices.js
    else
        bashio::log.warning "No devices.js file found in data path, starting with default devices.js"
    fi
else
    bashio::log.debug "No devices.js file manipulation required"
fi

if ! bashio::fs.file_exists "$DATA_PATH/configuration.yaml"; then
    mkdir -p "$DATA_PATH" || bashio::exit.nok "Could not create $DATA_PATH"

    cat <<EOF > "$DATA_PATH/configuration.yaml"
homeassistant: true
EOF
fi
