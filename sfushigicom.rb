require 'nokogiri'
require 'open-uri'
require 'date'
require 'mysql2'

#######################

class SqlSet
	def insert(client,m_n, u, t, b, c_n, e1, e5)
		client.query(
			" INSERT INTO crawler_raw_data (
				  media_name
				, url
				, title
				, body
				, crawler_name
				, etc1
				, etc5
				)
			VALUES(
				\"#{m_n}\"
				,\"#{u}\"
				,\"#{t}\"
				,LEFT(\"#{b}\", 9999)
				,\"#{c_n}\"
				,\"#{e1}\"
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
@media_name = "sfushigicom"
@crawler_name = "sfushigicomRB"
@etc1 = ""
@etc5 = ""

begin
	tempUrl =  "http://sfushigi.com/sitemaps/"
	doc = Nokogiri.HTML(open(tempUrl))


	doc.xpath("//ul[@id='sitemap_list']/li//ul/li/a").each do |u|
	
		catUrl =  u["href"]
		@url = catUrl
		
		begin
			doc2 = Nokogiri.HTML(open(catUrl))
				@body = ""
				@body = doc2.xpath("//div[@id = 'the-content']").inner_text
				@body = @client.escape(@body)

				@title = ""
				@etc5 = ""
				
				@title = doc2.xpath("//div[@id = 'the-content']/h2").inner_text
				begin
					@sql.insert(@client, @media_name, @url, @title, @body, @crawler_name, @etc1, @etc5)
				rescue =>e
					puts e
					#puts "inError"
					#@sql.insert(@client,@media_name, @url, @title, @body, @crawler_name, @etc1, "error")
				end
		rescue =>e
			puts e
			begin
				@etc5 = "error"
				@sql.insert(@client, @media_name,@url, @title, @body, @crawler_name, @etc1, @etc5)
			rescue => e
				puts e
			end
		end
		sleep(1.5)
	end
rescue => e
	puts e
end
	
