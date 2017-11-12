require 'nokogiri'
require 'net/https'
require 'open-uri'
require 'date'


dt = DateTime.now

time = 1
while time < 21
	
	begin
		#dtStr = dt.strftime('%Y%m%d')
		@tempUrl = "https://yonimokimyo.com/page/#{time}"
		doc = Nokogiri.HTML(open(@tempUrl, :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE).read)

		#title = doc.xpath('//section').inner_text
		doc.xpath("//dl[@class='clearfix']/dt/a").each do |u|
			puts "#########"
			puts u["href"].to_s  
			#["href"]
		end
	rescue => e
		puts e
	end
	time = time + 1
end