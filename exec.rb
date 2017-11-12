require 'nokogiri'
require 'net/https'
require 'open-uri'
require 'date'


dt = DateTime.now

time = 1
while time < 2
	
	begin
		#dtStr = dt.strftime('%Y%m%d')
		@tempUrl = "http://search.profile.ameba.jp/profileSearch/search?MT=%E4%BA%BA&target=all&row=100&pageNo=#{time}"
		doc = Nokogiri.HTML(open(@tempUrl, :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE).read)

		doc.xpath("//div[@class='resultDetail']/a").each do |u|
			@url = u["href"].to_s  
			begin
				doc2 = Nokogiri.HTML(open(@url, :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE).read)
				
				puts doc2.xpath("//a[@id='cntNaviName']").inner_text
				prof1 = doc2.xpath("//div[@id='profData']").inner_text
				prof2 = doc2.xpath("//div[@id='myMessage']").inner_text
				prof3 = doc2.xpath("//div[@id='profileList']").inner_text
				@body = prof1 + prof2 + prof3				
			rescue =>e
				puts e
			end
		end
	rescue => e
		puts e
	end
	time = time + 1
end