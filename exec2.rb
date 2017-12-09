# coding: utf-8

require 'rubygems'
require 'net/ssh/gateway'
require 'mysql2'


gateway = Net::SSH::Gateway.new(
  '',
  '',
  port:, 
  keys: ['/home/ec2-user/key/']

)

gateway.open() do |local_port|

  client = Mysql2::Client.new(
    host: '127.0.0.1',
    port: local_port,
    username: '',
    password: '',
    database: ''
  )

  clientEC2 = Mysql2::Client.new(
    host: '',
    username: '',
    password: '',
    database: ''
  )

 i = 1
 clientEC2.query('SELECT serial, media_name, url, title, body, crawler_name FROM crawler_data_cleaned;').each do |reader|
	@body = ""
	@body = client.escape(reader["body"])
	begin
		client.query("INSERT INTO crawler_data_cleaned (etc1, media_name, url, title, body, crawler_name)
		VALUES (\"#{reader["serial"]}\", \"#{reader["media_name"]}\", \"#{reader["url"]}\", \"#{reader["title"]}\", \"#{@body}\", \"#{reader["crawler_name"]}\");")
	rescue => e
		puts e
	end
  puts i
  i = i + 1
  end
end
