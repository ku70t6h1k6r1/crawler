require 'nokogiri'
require 'net/https'
require 'open-uri'
require 'date'
require 'mysql2'

#######################

class SqlSet
	def insert(client,m_n, u, t, b, c_n, dt, e5)
		client.query(
			" INSERT INTO crawler_raw_data_for_test (
				  media_name
				, url
				, title
				, body
				, crawler_name
				, dt_published
				, etc5
				)
			VALUES(
				\"#{m_n}\"
				,\"#{u}\"
				,\"#{t}\"
				,LEFT(\"#{b}\", 9999)
				,\"#{c_n}\"
				,\"#{dt}\"
				,\"#{e5}\"
				)
			 "
		)
	end
end


#######################
@client = Mysql2::Client.new(:host => "", :username => "", :password => "", :database => "")
@sql = SqlSet.new
@url = ""
@title = ""
@body = ""
@media_name = "myjitsujp"
@crawler_name = "myjitsujpRB"
@dt = ""
@etc5 = ""

time = 1
while time < 492
	
	begin
		@tempUrl = "https://myjitsu.jp/page/#{time}"
		doc = Nokogiri.HTML(open(@tempUrl, :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE).read)

		doc.xpath("//h1[@class='entry-title']/a").each do |u|
			@url = u["href"]
			begin
				doc2 = Nokogiri.HTML(open(@url, :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE).read)

				#puts "dt:" + Time.parse(doc2.xpath("//p[@class='entry-date']")[0]).strftime('%Y-%m-%d')
				#puts "title:" + doc2.xpath("//h1[@class='entry-title']")[0].inner_text
				#puts "body:" + doc2.xpath("//section[@class='entry-content']")[0].inner_text
				@dt = ""
				@title = ""
				@body = ""
				@etc5 = ""
				@dt = Time.parse(doc2.xpath("//p[@class='entry-date']")[0]).strftime('%Y-%m-%d')
				@title = doc2.xpath("//h1[@class='entry-title']")[0].inner_text
				@body = doc2.xpath("//section[@class='entry-content']")[0].inner_text
				begin
					@sql.insert(@client, @media_name, @url, @title, @body, @crawler_name, @dt, @etc5)
				rescue =>e
					puts e
				end		
			rescue =>e
				puts e
				begin
					@dt = ""
					@title = ""
					@body = ""
					@etc5 = "error"
					@sql.insert(@client, @media_name,@url, @title, @body, @crawler_name, @dt, @etc5)
				rescue => e
					puts e
				end	
			end
		end
	rescue => e
		puts e
	end
	time = time + 1
end