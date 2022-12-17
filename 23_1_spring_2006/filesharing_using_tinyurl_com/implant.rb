implant.rb
[begin code]
require 'net/http'

print "File to upload: "
source = gets.chomp
raise "No source found." if source == ""

bytes = ""
File.open(source, "rb") do |f|
	print "Reading file..."
	f.each_byte do |b|
		#format as hex
		bytes << sprintf("%02X", b)
	end
	puts "done"
end

Net::HTTP.start("tinyurl.com") do |http|
	puts "Sending file..."
	resp = http.post("/create.php", "url=#{bytes}")
	resp.body.scan(%r{value="http://tinyurl.com/(\w*)"})
	puts "File #{source} uploaded to http://tinyurl.com/#{$1}"
end
[end code]

