#!/bin/env ruby

host = `hostname`.strip
volts = `snmpwalk -v 2c -c public 192.168.1.202 .1.3.6.1.4.1.318.1.1.1.4.3.4.0 | awk '{print $4}'`.strip.to_f / 10
amps = `snmpwalk -v 2c -c public 192.168.1.202 .1.3.6.1.4.1.318.1.1.1.4.3.1.0 | awk '{print $4}'`.strip.to_f / 10
watts = volts * amps

Kernel.puts("ups,host=#{host},agent_host=192.168.1.202 watts=#{watts.to_i}")
