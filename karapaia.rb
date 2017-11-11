require 'nokogiri'
require 'open-uri'
require 'date'
require 'mysql2'

#######################

class SqlSet
	def select(client)
		client.query(
			"
				SELECT url.url
				FROM `karapaia_url` url
				WHERE NOT EXISTS
					(SELECT DISTINCT url
					FROM  `crawler_raw_data` log 
 						WHERE url.url = log.url)
			"
		)
	end

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
@client = Mysql2::Client.new(:host => "", :username => "", :password => "", :database => "")
@url = ""
@title = ""
@body = ""
@media_name = "karapaiacom"
@crawler_name = "karapaiaRB"
@etc1 = ""
@etc5 = ""



@sql = SqlSet.new

results = @sql.select(@client)

results.each do |url|
	@url = ""
	@title = ""
	@body = ""
	@etc1 = ""
	@etc5 = ""	

	begin
		@url = url["url"]
		doc = Nokogiri.HTML(open(@url))

		@title = doc.css('.widget-header').inner_text
		doc.xpath('//div[@class="entry-body clearfix"]').each do |e|
			@body = @body + "<br />" + e.inner_text 
		end
		@etc1 = doc.css('.date')[0].inner_text
		@etc5 = ""

		puts "#########################"
		@body = @body.slice(0, @body.index("if"))
		@body = @client.escape(@body)
		#puts @body
	rescue => e
		@title = ""
		@body = ""
		@etc1 = ""
		@etc5 = "error"
	end
	
	
	begin	
		@sql.insert(@client, @media_name,@url, @title, @body, @crawler_name, @etc1, @etc5)
	rescue => e
		puts e
	end

	sleep(1.5)
end

