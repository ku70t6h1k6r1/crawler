# encoding: utf-8
require 'nokogiri'
require 'open-uri'
require 'date'
require 'mysql2'

#######################

class SqlSet
	def select(client)
		client.query(
			"
				SELECT 
					url
					,media_name
					,url
					,title
					,body
					,crawler_name
					,serial
				FROM crawler_raw_data
				WHERE media_name = 'karapaiacom'
				GROUP BY url
			"
		)
	end

	def insert(client,m_n, u, t, b, c_n, e1)
		client.query(
			" INSERT INTO crawler_raw_data_for_test (
				  media_name
				, url
				, title
				, body
				, crawler_name
				, etc1
				)
			VALUES(
				\"#{m_n}\"
				,\"#{u}\"
				,\"#{t}\"
				,\"#{b}\"
				,\"#{c_n}\"
				,\"#{e1}\"
				)
			 "
		)
	end
end


#######################
@client = Mysql2::Client.new(:host => "localhost", :username => "pma", :password => "M656n26n5pma", :database => "crawler")
@url = ""
@title = ""
@body = ""
@media_name = ""
@crawler_name = ""
@etc1 = ""




@sql = SqlSet.new

results = @sql.select(@client)

results.each do |reader|
	@url = ""
	@title = ""
	@body = ""
	@etc1 = ""

	begin
		@url = reader["url"]
		@title = reader["title"]
		@etc1 = reader["serial"]
		@body = reader["body"]
		
		@body = @body.slice(0, @body.index("‚ ‚í‚¹‚Ä“Ç‚Ý‚½‚¢")).gsub("(adsbygoogle = window.adsbygoogle || []).push({});","").gsub("\n", "").gsub("	","").gsub("<br />","")
		puts @body
	rescue => e
		@title = ""
		@body = ""
		@etc1 = ""
		@etc5 = "error"
		puts @etc5
	end
	
	
	begin	
		#@sql.insert(@client, @media_name,@url, @title, @body, @crawler_name, @etc1, @etc5)
	rescue => e
		puts e
	end
end

