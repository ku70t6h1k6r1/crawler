require 'rubygems'
require 'net/ssh/gateway'
require 'mysql2'


gateway = Net::SSH::Gateway.new(
  'gateway.host',
  'kubota',
  port: 10001,
  keys: ['~/.ssh/ssh-key']
)

gateway.open('database.host', 3306) do |local_port|

  client = Mysql2::Client.new(

    host: '127.0.0.1',
    port: local_port,

    username: 'username',
    password: 'password',
    database: 'database'
  )

  client.query('SHOW TABLES;').each do |row|
    p row
  end
end