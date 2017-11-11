require 'nokogiri'
require 'open-uri'
require 'date'
require 'mysql2'

#######################

class SqlSet
	def select(client){
		client.query(
			"
				SELECT url 
				FROM karapaia_url
				LIMIT 10
			"
		)
	}

	def insert(client,m_n, u, t, b, c_n, e1, e5)
		client.query(
			" INSERT INTO crawler_raw_data_for_test (
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
				,\"#{b}\"
				,\"#{c_n}\"
				,\"#{e1}\"
				,\"#{e5}\"
				)
			 "
		)
	end
end


#######################
@client = Mysql2::Client.new(:host => "localhost", :username => "", :password => "", :database => "")
@sql = SqlSet.new
@url = ""
@title = ""
@body = ""
@media_name = "plalaorjp"
@crawler_name = "plalaorjpRB"
@etc1 = ""
@etc5 = ""

begin
	tempUrl = "http://www5.plala.or.jp/zatsugaku/entame.html"
	doc = Nokogiri.HTML(open(tempUrl))


	doc.xpath("//ul[@class='submenu']/li/a").each do |u|
		catUrl =  u["href"]
		@url = catUrl		
		
		begin
			doc2 = Nokogiri.HTML(open(catUrl))		
			doc2.xpath('//section').each do |b|
				@body = ""
				@etc5 = ""
				@body = b.inner_text
				begin
					@sql.insert(@client, @media_name,@url, @title, @body, @crawler_name, @etc1, @etc5)
				rescue
				end
							
			end
		rescue
			begin
				@etc5 = "error"
				@sql.insert(@client, @media_name,@url, @title, @body, @crawler_name, @etc1, @etc5)
			rescue
			end
		end
	end
rescue => e
	puts e
end
	
