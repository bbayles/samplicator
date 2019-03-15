UDP Sampliator packages
=======================

This repository is a fork of [sleinen/samplicator](https://github.com/sleinen/samplicator/),
with additions for building .deb and .rpm packages.

UDP Samplicator is a small program for relaying UDP datagrams to multiple destinations.
It has options for sampling and address spoofing.

Installation
------------

Check the releases page for .deb and .rpm packages.

To install on Debian, Ubuntu, and other systems that use .deb packages: `sudo dpkg -i samplicate-pkg.deb`

On RHEL, CentOS, and other systems that use .rpm packages: `sudo yum localinstall samplicate-pkg.rpm`

Usage
-----

After installation, the `samplicate` binary will be located at `/usr/local/bin/samplicate`.

```
Usage: samplicate [option...] receiver...

Supported options:

  -p <port>                UDP port to accept flows on (default 2000)
  -s <address>             Interface address to accept flows on (default any)
  -d <level>               debug level
  -t <timeout_ms>          Exit with RC 5 if no data is received for this
                           amount of milliseconds
  -b <size>                set socket buffer size (default 65536)
  -n                       don't compute UDP checksum (leave at 0)
  -S                       maintain (spoof) source addresses
  -x <delay>               transmit delay in microseconds
  -c <configfile>          specify a config file to read
  -f                       fork program into background
  -m <pidfile>             write process ID to file
  -4                       IPv4 only
  -6                       IPv6 only
  -h                       print this usage message and exit
  -u <pdulen>              size of max pdu on listened socket (default 65536)

Specifying receivers:

  A.B.C.D[/port[/freq][,ttl]]...
where:
  A.B.C.D                  is the receiver's IP address
  port                     is the UDP port to send to (default 2000)
  freq                     is the sampling rate (default 1)
  ttl                      is the outgoing packets' TTL value (default 64)

The port can be a number, a range, or a number plus the number of instances:
  7000                     means port 7000
  7000-7010                means from port 7000 to 7010 (both inclusive)
  7000+10                  means 10 instances starting at 7000, so 7000 to 7009

Config file format:

  a.b.c.d[/e.f.g.h]: receiver ...
where:
  a.b.c.d                  is the senders IP address
  e.f.g.h                  is a mask to apply to the sender (default 255.255.255.255)
  receiver                 see above.

Receivers specified on the command line will get all packets, those
specified in the config-file will get only packets with a matching source.
```

systemd service
---------------

The pacakges will install a [systemd service](./samplicator.service).
You may enable it with `sudo systemctl enable samplicator.service`.

It reads from a configuraiton file at `/usr/local/etc/samplicator.conf`.
Edit [that file](./samplicator.conf) to configure your sources and destinations.

Building packages
-----------------

You'll need GNU Automake and [fpm](https://github.com/jordansissel/fpm) to
build the packages.

After cloning the repository, run `make -f Makefile.am build` and then
`make deb` or `make rpm`.

Credits and license
-------------------

All credit for UDP Samplicator is due to [the authors](./AUTHORS).
The package is [licensed](./COPYING) under the GPL, version 2.
