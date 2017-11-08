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
@url = ""
@title = ""
@body = ""
@media_name = "karapaiacom"
@crawler_name = "karapaiaRB"
@etc1 = ""
@etc5 = ""



sql = SqlSet.new

results = sql.select(@client)

results.each do |url|
	begin
		@url = url

		doc = Nokogiri.HTML(open(@url))

		@title = doc.css('.widget-header').inner_text
		doc.xpath('//div[@class="entry-body clearfix"]').each do |e|
			@body = @body + "<br />" + e.inner_text 
		end
		@etc1 = doc.css('.date')[0].inner_text
		@etc5 = ""
	rescue => e
		@title = ""
		@body = ""
		@etc1 = ""
		@etc5 = "error"
	end
	
	
	begin	
		sql.insert(@client, @media_name,@url, @title, @body, @crawler_name, @etc1, @etc5)
	rescue => e
	end

	sleep(2)
end

