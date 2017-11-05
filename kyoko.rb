require 'nokogiri'
require 'open-uri'
require 'date'
require 'mysql2'

client = Mysql2::Client.new(:host => "localhost", :username => "pma", :password => "M656n26n5pma", :database => "crawler")
url = ""
title = ""
body = ""
media_name = "kyokonpnet"
crawler_name = "test"
etc1 = ""
etc5 = ""

dt = DateTime.now

time = 0
while time < 10
	dt = dt - 1
	
	begin
		dtStr = dt.strftime('%Y%m%d')
		url = "http://kyoko-np.net/" + dtStr + "01" + ".html" 
		
		doc = Nokogiri.HTML(open(url))

		title = doc.xpath('//title').inner_text
		body = doc.xpath('//article').inner_text
		etc1 = doc.css('.article-update').inner_text

		#puts title
		#puts body
		#puts publishedDate
				
		dt = dt - 1
	rescue => e
		etc5 = e
		#dt = dt - 1
		#retry
	end
	
	sql = SqlSet.new
	sql.insert(client, media_name, url, title, body,  crawler_name, etc1, etc5)
	
	time = time + 1
end

#######################

class SqlSet
	def insert(client,media_name, url, title, body, crawler_name, etc1, etc5)
		client.query(
			"INSERT INTO crawler_raw_data (
				 media_name
				,url
				,title
				,body
				,crawler_name
				,etc1
				,etc5
				)
			VALUES(
				#{media_name}
				,#{url}
				,#{title}
				,#{body}
				,#{crawler_name}
				,#{etc1}
				,#{etc5}
				)
			) "
		)
	end
end
