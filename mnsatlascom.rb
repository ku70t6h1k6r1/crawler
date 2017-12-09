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
@media_name = "mnsatlascom"
@crawler_name = "mnsatlascomRB"
@etc1 = ""
@etc5 = ""

#######################
time = 1
while time < 107
	begin
		@tempUrl = "http://mnsatlas.com/?cat=17&paged=#{time}"
		doc = Nokogiri.HTML(open(@tempUrl, :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE).read)

		doc.xpath("//h4[@class='title']/a").each do |u|
			@url =   u["href"] 
			puts @url
			begin
				sleep(2)
				doc2 = Nokogiri.HTML(open(@url, :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE).read)

				@etc1 = ""
				@title = ""
				@body = ""
				@etc5 = ""
				@etc1 = doc2.xpath("//li[@class='date']")[0].inner_text
				@title = doc2.xpath("//div[@id='single_title']/h2").inner_text
				@body = doc2.xpath("//div[@class='post clearfix']").inner_text.gsub(/\n/,"")
				@body = @client.escape(@body)
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

#######################
time = 1
while time < 256
	begin
		@tempUrl = "http://mnsatlas.com/?cat=23&paged=#{time}"
		doc = Nokogiri.HTML(open(@tempUrl, :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE).read)

		doc.xpath("//h4[@class='title']/a").each do |u|
			@url =   u["href"] 
			puts @url
			begin
				sleep(2)
				doc2 = Nokogiri.HTML(open(@url, :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE).read)

				@etc1 = ""
				@title = ""
				@body = ""
				@etc5 = ""
				@etc1 = doc2.xpath("//li[@class='date']")[0].inner_text
				@title = doc2.xpath("//div[@id='single_title']/h2").inner_text
				@body = doc2.xpath("//div[@class='post clearfix']").inner_text.gsub(/\n/,"")
				@body = @client.escape(@body)
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

#######################
time = 1
while time < 79
	begin
		@tempUrl = "http://mnsatlas.com/?cat=25&paged=#{time}"
		doc = Nokogiri.HTML(open(@tempUrl, :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE).read)

		doc.xpath("//h4[@class='title']/a").each do |u|
			@url =   u["href"] 
			puts @url
			begin
				sleep(2)
				doc2 = Nokogiri.HTML(open(@url, :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE).read)

				@etc1 = ""
				@title = ""
				@body = ""
				@etc5 = ""
				@etc1 = doc2.xpath("//li[@class='date']")[0].inner_text
				@title = doc2.xpath("//div[@id='single_title']/h2").inner_text
				@body = doc2.xpath("//div[@class='post clearfix']").inner_text.gsub(/\n/,"")
				@body = @client.escape(@body)
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

#######################
time = 1
while time < 17
	begin
		@tempUrl = "http://mnsatlas.com/?cat=3&paged=#{time}"
		doc = Nokogiri.HTML(open(@tempUrl, :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE).read)

		doc.xpath("//h4[@class='title']/a").each do |u|
			@url =   u["href"] 
			puts @url
			begin
				sleep(2)
				doc2 = Nokogiri.HTML(open(@url, :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE).read)

				@etc1 = ""
				@title = ""
				@body = ""
				@etc5 = ""
				@etc1 = doc2.xpath("//li[@class='date']")[0].inner_text
				@title = doc2.xpath("//div[@id='single_title']/h2").inner_text
				@body = doc2.xpath("//div[@class='post clearfix']").inner_text.gsub(/\n/,"")
				@body = @client.escape(@body)
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

#######################
time = 1
while time < 88
	begin
		@tempUrl = "http://mnsatlas.com/?cat=33&paged=#{time}"
		doc = Nokogiri.HTML(open(@tempUrl, :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE).read)

		doc.xpath("//h4[@class='title']/a").each do |u|
			@url =   u["href"] 
			puts @url
			begin
				sleep(2)
				doc2 = Nokogiri.HTML(open(@url, :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE).read)

				@etc1 = ""
				@title = ""
				@body = ""
				@etc5 = ""
				@etc1 = doc2.xpath("//li[@class='date']")[0].inner_text
				@title = doc2.xpath("//div[@id='single_title']/h2").inner_text
				@body = doc2.xpath("//div[@class='post clearfix']").inner_text.gsub(/\n/,"")
				@body = @client.escape(@body)
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

#######################
time = 1
while time < 31
	begin
		@tempUrl = "http://mnsatlas.com/?cat=6&paged=#{time}"
		doc = Nokogiri.HTML(open(@tempUrl, :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE).read)

		doc.xpath("//h4[@class='title']/a").each do |u|
			@url =   u["href"] 
			puts @url
			begin
				sleep(2)
				doc2 = Nokogiri.HTML(open(@url, :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE).read)

				@etc1 = ""
				@title = ""
				@body = ""
				@etc5 = ""
				@etc1 = doc2.xpath("//li[@class='date']")[0].inner_text
				@title = doc2.xpath("//div[@id='single_title']/h2").inner_text
				@body = doc2.xpath("//div[@class='post clearfix']").inner_text.gsub(/\n/,"")
				@body = @client.escape(@body)
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
