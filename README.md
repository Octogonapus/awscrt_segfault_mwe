# AWSCRT Segfault MWE

This repository is an MWE for a segfault that occurs when using AWSCRT inside a sysimage.

## To Reproduce

Instantiate this package:

```sh
julia --project -e 'import Pkg; Pkg.instantiate()'
```

Build the sysimage:

```sh
MQTT_ENABLED="false" julia --project=sysimage -e 'import Pkg; Pkg.build(); include(joinpath("sysimage", "build_sysimage.jl")); build()'
```

Set these environment variables in your shell (these need to point to real AWS infra):

```sh
export MQTT_ENDPOINT="..." AWS IoT > Settings > Device data endpoint
export MQTT_CERT_PATH="..." # the xxx-certificate.pem.crt file
export MQTT_PRIVATE_KEY_PATH="..." # the xxx-private.pem.key file
export MQTT_CA_PATH="..." # AmazonRootCA1.pem
```

Run the test with the sysimage (optionally under `rr`):

```sh
MQTT_ENABLED="true" rr julia -J sysimage/sysimage.so test/test.jl
```
