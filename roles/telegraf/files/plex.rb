#!/bin/env ruby

require 'open-uri'

host = `hostname`.strip
status = open("http://192.168.1.200:32400/status/sessions").read
count = status.scan(/state="playing"\stitle="(.*)"\s\/>[\s\n\r]+<TranscodeSession/).size

Kernel.puts("plex_transcodes,host=#{host} count=#{count}")
