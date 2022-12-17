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

extract.rb
[begin code]
require 'net/http'

print "Extract file -- http://tinyurl.com/"
target = gets.chomp
raise "No target found." if target == ""

Net::HTTP.start("forwarding.tinyurl.com") do |http|
	resp = http.get("/redirect.php?num=#{target}")
	if resp.code  == "302" then
		puts "Retrieving data..."
		resp['location'] =~ %r{http://(\w*)}
		bytes = $1.split(/(..)/)
		bytes.compact!
		byte_string = bytes.pack("H*"*bytes.length)
		puts "Creating file #{target}..."
		File.open(target, 'wb') do |f|
			f << byte_string
		end
	else
		raise "HTTP #{resp.code} received. Something is fux0red somewhere..."
	end
	puts "Done!"
end
[end code]

