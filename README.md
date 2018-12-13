# jarvus/web-relay

This package provides a bare-bones service for forwarding web traffic for any number of domains to a new server. It is (currently) based on Traefik, and can leverage Traefik's automatic HTTPS via Let's Encrypt as well as its HTTP2 support. You can leave this running on a deprecated server/IP to log and forward traffic to a new machine while you weed out any domains still driving traffic to the old IP.

As a Habitat package, this is a "config-only plan" that wraps around the binary built by the [core/traefik](https://github.com/habitat-sh/core-plans/tree/master/traefik) plan and just provides a new set of config+hooks.

## HTTPS support

While Traefik will set up HTTPS hands-free, I haven't been able to get any solution working that supports acquiring SSL certs on-the-fly based on what hostnames receive HTTPS requests.

Currently, all hostnames that will be available over HTTPS must be declared upfront in the config, and must be resolvable to the IP this service is running on at the time they get added to the config. The service will obtain and store an SSL certificate automatically when a hostname is added, so after that the public DNS can then be switched to the new destination.

## Quick start

```console
$ hab svc load --strategy at-once jarvus/web-relay
The jarvus/web-relay service was successfully loaded
$ mkdir -p /hab/user/web-relay/config
$ cat > /hab/user/web-relay/config/user.toml <<- END_OF_TOML
```

```toml
# optional: list of hosts to obtain SSL certificates for
secure_hosts = "example.com,oldsite.example.org"

# optional: configure to enable obtaining SSL certificates automatically via Let's Encrypt
[webmaster]
email = "webmaster@example.org"

# REQUIRED: where to forward traffic
[remote]
url = "http://next.example.org"
```

```console
END_OF_TOML
```
