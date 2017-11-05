require 'nokogiri'
require 'open-uri'
require 'date'


dt = DateTime.now

time = 0
while time < 10
	dt = dt - 1
	
	begin
		dtStr = dt.strftime('%Y%m%d')
		url = "http://kyoko-np.net/" + dtStr + "01" + ".html" 
	
		doc = Nokogiri.HTML(open(url))

		doc.xpath('//article').each do |element|
			puts element.inner_text
		end
		dt = dt - 1
	rescue => e
		puts e
		dt = dt - 1
		retry
	end
	
	time = time + 1
end