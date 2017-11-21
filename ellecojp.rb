require 'nokogiri'
require 'net/https'
require 'open-uri'
require 'date'
require 'mysql2'

#######################

class SqlSet
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
@media_name = "ellecojp"
@crawler_name = "ellecojpRB"
@etc1 = ""
@etc5 = ""

time = 1
while time < 9 #6418
	
	begin
		@tempUrl = "http://www.elle.co.jp/culture/celebgossip/(offset)/#{time}"
		doc = Nokogiri.HTML(open(@tempUrl, :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE).read)

		doc.xpath("//ul[@class='article-list-type-a']/li/a").each do |u|
			@url = "http://www.elle.co.jp"+ u["href"] 
			puts @url
			begin
				sleep(2)
				doc2 = Nokogiri.HTML(open(@url, :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE).read)

				#puts "dt:" + Time.parse(doc2.xpath("//p[@class='entry-date']")[0]).strftime('%Y-%m-%d')
				#puts "title:" + doc2.xpath("//h1[@class='entry-title']")[0].inner_text
				#puts "body:" + doc2.xpath("//section[@class='entry-content']")[0].inner_text
				@etc1 = ""
				@title = ""
				@body = ""
				@etc5 = ""
				@etc1 = doc2.xpath("//span[@class='label-date']")[0].inner_text
				@title = doc2.xpath("//header[@class='title-main']/h2")[0].inner_text
				@body = doc2.xpath("//section[@id='area-entry']").inner_text.gsub(/\n/,"")
				#@body = @body.encode('SJIS', 'UTF-8', invalid: :replace, undef: :replace, replace: '').encode('UTF-8')
				begin
					@sql.insert(@client, @media_name, @url, @title, @body, @crawler_name, @etc1, @etc5)
				rescue =>e
					puts e
				end		
			rescue =>e
				puts e
				begin
					@etc1 = ""
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
