#!/bin/env ruby

host = `hostname`.strip

(1..20).each do |i|
  outoct = `snmpwalk -v 2c -c public 192.168.1.110 .1.3.6.1.2.1.2.2.1.16.#{i} | awk '{print $4}'`.strip.to_i
  inoct = `snmpwalk -v 2c -c public 192.168.1.110 .1.3.6.1.2.1.2.2.1.10.#{i} | awk '{print $4}'`.strip.to_i
  Kernel.puts("switch,host=#{host},port=#{i} in=#{inoct},out=#{outoct}")
end


