require 'nokogiri'
require 'net/https'
require 'open-uri'
require 'date'


dt = DateTime.now

time = 1
while time < 2
	
	begin
		#dtStr = dt.strftime('%Y-%m-%d')
		@tempUrl = "https://myjitsu.jp/page/1"
		doc = Nokogiri.HTML(open(@tempUrl, :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE).read)

		doc.xpath("//h1[@class='entry-title']/a").each do |u|
			@url = u["href"]
			puts @url
			begin
				doc2 = Nokogiri.HTML(open(@url, :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE).read)
			#	
				puts "dt:" + Time.parse(doc2.xpath("//p[@class='entry-date']")[0]).strftime('%Y-%m-%d')
				puts "title:" + doc2.xpath("//h1[@class='entry-title']")[0].inner_text
				puts "body:" + doc2.xpath("//section[@class='entry-content']")[0].inner_text
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