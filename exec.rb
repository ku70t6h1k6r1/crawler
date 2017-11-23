require 'nokogiri'
require 'net/https'
require 'open-uri'
require 'date'

dt = DateTime.now

time = 1
while time < 1298
	
	begin
		#dtStr = dt.strftime('%Y-%m-%d')
		@tempUrl = "http://labaq.com/?p=#{time}/"
		doc = Nokogiri.HTML(open(@tempUrl, :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE).read)

		doc.xpath("//h2[@class='title']/a").each do |u|
			@url =   u["href"] 
			puts @url
			begin
				doc2 = Nokogiri.HTML(open(@url, :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE).read)
			#	
				puts "dt:" + doc2.xpath("//div[@class='date']")[0].inner_text
				puts "title:" + doc2.xpath("//h1[@class='title']")[0].inner_text
				puts "body:" + doc2.xpath("//div[@class='main']")[0].inner_text.gsub(/\n/,"") + doc2.xpath("//div[@class='mainmore']")[0].inner_text.gsub(/\n/,"")
			#	prof1 = doc2.xpath("//div[@id='profData']").inner_text
			#	prof2 = doc2.xpath("//div[@id='myMessage']").inner_text
			#	prof3 = doc2.xpath("//div[@id='profileList']").inner_text
			#	@body = prof1 + prof2 + prof3				
			rescue =>e
				puts e
			end
		end
	rescue => e
		puts e
	end
	time = time + 1
end