#!/bin/env ruby

host = `hostname`.strip

(0..20).each do |i|
  temp = `sudo smartctl -a -d megaraid,#{i} /dev/sda | grep Temperature_Celsius | awk '{print $10}'`.strip
  if temp.to_i > 0
    Kernel.puts("drive_temp,host=#{host},drive=#{i} temp=#{temp}")
  end
end
