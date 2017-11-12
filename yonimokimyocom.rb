require 'nokogiri'
require 'net/https'
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
@media_name = "yonimokimyocom"
@crawler_name = "yonimokimyocomRB"
@etc1 = ""
@etc5 = ""

time = 1
while time < 21
	begin
		@tempUrl = "https://yonimokimyo.com/page/#{time}"
		doc = Nokogiri.HTML(open(@tempUrl, :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE).read)

		#doc.xpath("//dl[@class='clearfix']/dt/a").each do |u|
		doc.xpath("//dl[@class='clearfix']/dd/h3/a").each do |u|
			@url =  u["href"].to_s
			@title = ""
			@title = u.inner_text.strip
			begin
				doc2 = Nokogiri.HTML(open(@url, :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE).read)
				@body = ""
				@body = doc2.xpath('//article').inner_text
				begin
					@sql.insert(@client, @media_name, @url, @title, @body, @crawler_name, @etc1, @etc5)
				rescue =>e
					puts e
				end
			rescue => e
				puts e
				begin
					@title = ""
					@body = ""
					@etc5 = "error"
					@sql.insert(@client, @media_name,@url, @title, @body, @crawler_name, @etc1, @etc5)
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