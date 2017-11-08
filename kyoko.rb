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
@media_name = "kyokonpnet"
@crawler_name = "kyokoRB"
@etc1 = ""
@etc5 = ""

#dt = DateTime.now
dt = DateTime.new(2006, 12, 31, 0, 0)

time = 0
while dt > DateTime.new(2003 , 12 , 31 , 23, 59)	
puts dt
#while time < 10
	begin
		dtStr = dt.strftime('%Y%m%d')
		@url = "http://kyoko-np.net/" + dtStr + "01" + ".html" 
		#puts dtStr		
		doc = Nokogiri.HTML(open(@url))

		@title = doc.xpath('//title').inner_text
		@body = doc.xpath('//article').inner_text
		@etc1 = doc.css('.article-update').inner_text
		@etc5 = ""
	rescue => e
		@title = ""
		@body = ""
		@etc1 = ""
		@etc5 = "error"
		
	end
	
	sql = SqlSet.new
	
	begin	
		sql.insert(@client, @media_name,@url, @title, @body, @crawler_name, @etc1, @etc5)
	rescue => e
		puts "error url : " + @url
	end
	time = time + 1
	sleep(3)
	#puts @title
	dt = dt - 1
end


