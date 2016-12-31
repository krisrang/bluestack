#!/bin/env ruby

data = []
host = `hostname`.strip
maxtemp = 0
maxrealloc = 0
maxpending = 0
maxoffline = 0

(0..12).each do |i|
  temp = `/usr/sbin/smartctl -a -d megaraid,#{i} /dev/sda | grep Temperature_Celsius | awk '{print $10}'`.strip.to_i
  reallocated = `/usr/sbin/smartctl -a -d megaraid,#{i} /dev/sda | grep Reallocated_Sector_Ct | awk '{print $10}'`.strip.to_i
  pending = `/usr/sbin/smartctl -a -d megaraid,#{i} /dev/sda | grep Current_Pending_Sector | awk '{print $10}'`.strip.to_i
  offline = `/usr/sbin/smartctl -a -d megaraid,#{i} /dev/sda | grep Offline_Uncorrectable | awk '{print $10}'`.strip.to_i

  maxtemp = [maxtemp, temp].max
  maxrealloc = [maxrealloc, reallocated].max
  maxpending = [maxpending, pending].max
  maxoffline = [maxoffline, offline].max

  if temp > 0
    data << "hddsmart,host=#{host},drive=#{i} temp=#{temp},reallocated_sectors=#{reallocated},pending_sectors=#{pending},offline_uncorrectable=#{offline}"
  end
end

if maxtemp >= 55 || maxrealloc > 0 || maxpending > 0 || maxoffline > 0
  data << "hddsmart,host=#{host} health=2"
elsif maxtemp >= 50
  data << "hddsmart,host=#{host} health=1"
else
  data << "hddsmart,host=#{host} health=0"
end

File.write("/var/lib/telegraf/drivedata", data.join("\n"))
