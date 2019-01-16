#!/bin/sh

# Test for using the undocumented pulseaudio config location.  Bug filed:
# https://gitlab.freedesktop.org/pulseaudio/pulseaudio/issues/620

PA_CONFIG_LOCATION_NONSTANDARD="$HOME/.pulse"
PA_CONFIG_LOCATION_STANDARD="$HOME/.config/pulse"

retval=0

if [ -d "$PA_CONFIG_LOCATION_NONSTANDARD" ]; then
    echo "ERROR: Pulseaudio undocumented config location used:"
    echo "ERROR: $PA_CONFIG_LOCATION_NONSTANDARD"

    if [ -d "$PA_CONFIG_LOCATION_STANDARD" ]; then
        echo "WARNING: Documented config directory also exists:"
        echo "WARNING: $PA_CONFIG_LOCATION_STANDARD"
        echo "WARNING: The non-standard directory above will take precedence."
        echo "WARNING: This may not be intended!"
    fi

    echo "INFO: Remove nonstandard location and use $PA_CONFIG_LOCATION_STANDARD to be compliant."
    retval=1
else
    if [ -d "$PA_CONFIG_LOCATION_STANDARD" ]; then
        echo "INFO: The standard config location, $PA_CONFIG_LOCATION_STANDARD, exists."
    fi
    echo "SUCCESS: Pulseaudio is not using the undocumented config location."
fi

exit $retval
