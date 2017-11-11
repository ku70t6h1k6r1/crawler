require 'nokogiri'
require 'open-uri'
require 'date'


dt = DateTime.now

time = 0
#while time < 10
	
	begin
		#dtStr = dt.strftime('%Y%m%d')
		@url = "http://www5.plala.or.jp/zatsugaku/entame.html"
		
		doc = Nokogiri.HTML(open(@url))

		#title = doc.xpath('//section').inner_text
		doc.xpath("//ul[@class='submenu']/li/a").each do |u|
			puts u["href"]		
		end
		

		puts 
		

		
	rescue => e
		puts e
	end
	
	time = time + 1
#end