require 'nokogiri'
require 'open-uri'
require 'date'

class SqlSet
	def insert(url, cat_url)
		client.query(
			"INSERT INTO crawler_raw_data (
				 url
				 ,cat_url
				)
			VALUES(
				"#{url}"
				,"#{cat_url}"
				)
			"
		)
	end
end

#########################################################################
client = Mysql2::Client.new(:host => "localhost", username => "", :password => "", :database => "")

time = 0
loop{
	@url = ""
	@linkUrl = ""
	
	begin
		@url = "http://karapaia.com/archives/cat_50034584.html?p=#{time}"

		doc = Nokogiri.HTML(open(url))

		i = 0
		doc.xpath('//div[@class="widget widget-archive"]/h3/a').each do |element|
			@linkUrl = element["href"]
			#puts linkUrl
			i = i + 1
			
			begin
				sql = SqlSet.new
				sql.insert(@linkUrl , @url)
			rescue 
			end
		end
		
		if i < 48 then
			puts i
			break
		end
		
	rescue => e
	end
	
	time = time + 1
	sleep(1)
}
