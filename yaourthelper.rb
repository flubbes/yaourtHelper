#!/usr/bin/ruby

#imports
require 'launchy'
require 'open-uri'
#end imports

#settings
searchEngineBaseUrl = 'https://google.com/#q='
#end settings
searchEngineBaseUrl.freeze

#detect yaourt
isYaourtInstalled = File.exists? '/usr/bin/yaourt'

if !isYaourtInstalled
	puts 'yaourt is not installed.'
	Process.exit
end

#check for updates
yaourt = open('|sudo yaourt -Qua')
yaourtOutput = yaourt.readlines
yaourt.close
yaourtOutput.each do |line|
	upgrade = line.split(' ')
	packageName = upgrade[0].split('/')[1]
	newVersion = upgrade[-1].split('-')[0..-2] * ""
	url = String.new(searchEngineBaseUrl)
	url << URI::encode(packageName)
	url << URI::encode(' release notes ')
	url << URI::encode(newVersion)
	Launchy.open(url)
end
