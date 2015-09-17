#!/usr/bin/ruby

require 'launchy'
require 'open-uri'
searchEngineBaseUrl = 'https://google.com/#q='




#detect yaourt
isYaourtInstalled = File.exists? '/usr/bin/yaourt'

if !isYaourtInstalled
	puts 'yaourt is not installed.'
	Process.exit
end

#check for updates
yaourt = open('|sudo yaourt -Qua')
out = yaourt.readlines
yaourt.close
out.each do |line|
	upgrade = line.split(' ')
	packageName = upgrade[0].split('/')[1]
	newVersion = upgrade[-1].split('-')[0..-2] * ""
	url = searchEngineBaseUrl
	url << URI::encode(packageName)
	url << URI::encode(' release notes ')
	url << URI::encode(newVersion)
	Launchy.open(url)
end
