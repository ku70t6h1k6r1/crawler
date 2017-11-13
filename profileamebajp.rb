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
@media_name = "profileamebajp"
@crawler_name = "profileamebajpRB"
@etc1 = ""
@etc5 = ""


time = 1
while time < 100	
	begin

		@tempUrl = "http://search.profile.ameba.jp/profileSearch/search?MT=%E4%BA%BA&target=all&row=100&pageNo=#{time}"
		doc = Nokogiri.HTML(open(@tempUrl, :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE).read)
		sleep(2)
		@i = 0
		doc.xpath("//div[@class='resultDetail']/a").each do |u|
			@i = @i + 1
			@url = u["href"].to_s  
			begin
				@title = ""
				@body = ""
				doc2 = Nokogiri.HTML(open(@url, :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE).read)
				sleep(1.5)
				prof1 = doc2.xpath("//div[@id='profData']").inner_text
				prof2 = doc2.xpath("//div[@id='myMessage']").inner_text
				prof3 = doc2.xpath("//div[@id='profileList']").inner_text
				@title = doc2.xpath("//a[@id='cntNaviName']").inner_text
				@body = @client.escape(prof1 + prof2 + prof3)				
				puts @body
				begin
					@sql.insert(@client, @media_name, @url, @title, @body, @crawler_name, @etc1, @etc5)
				rescue =>e
					puts e
				end				
			rescue =>e
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
	if @i < 100 then
		break
	end
	time = time + 1
end
