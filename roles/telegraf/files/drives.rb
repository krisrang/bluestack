#!/bin/env ruby

host = `hostname`.strip
maxtemp = 0
maxrealloc = 0
maxpending = 0
maxoffline = 0

(0..20).each do |i|
  temp = `sudo smartctl -a -d megaraid,#{i} /dev/sda | grep Temperature_Celsius | awk '{print $10}'`.strip.to_i
  reallocated = `sudo smartctl -a -d megaraid,#{i} /dev/sda | grep Reallocated_Sector_Ct | awk '{print $10}'`.strip.to_i
  pending = `sudo smartctl -a -d megaraid,#{i} /dev/sda | grep Current_Pending_Sector | awk '{print $10}'`.strip.to_i
  offline = `sudo smartctl -a -d megaraid,#{i} /dev/sda | grep Offline_Uncorrectable | awk '{print $10}'`.strip.to_i

  maxtemp = [maxtemp, temp].max
  maxrealloc = [maxrealloc, reallocated].max
  maxpending = [maxpending, pending].max
  maxoffline = [maxoffline, offline].max

  if temp > 0
    Kernel.puts("hddsmart,host=#{host},drive=#{i} temp=#{temp},reallocated_sectors=#{reallocated},pending_sectors=#{pending},offline_uncorrectable=#{offline}")
  end
end

if maxtemp >= 55 || maxrealloc > 0 || maxpending > 0 || maxoffline > 0
  Kernel.puts("hddsmart,host=#{host} health=2")
elsif maxtemp >= 50
  Kernel.puts("hddsmart,host=#{host} health=1")
else
  Kernel.puts("hddsmart,host=#{host} health=0")
end
