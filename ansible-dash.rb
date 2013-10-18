require 'nokogiri'

doc_file = ARGV.first
file_name = doc_file.match(/(.*)\/(.*)/)[2]


doc = Nokogiri::HTML(ARGF.read)
modules = doc.css('a.reference')
puts "DROP TABLE searchIndex;"
puts "CREATE TABLE IF NOT EXISTS searchIndex(id INTEGER PRIMARY KEY, name TEXT, type TEXT, path TEXT);"

modules.each do |mod|
  mod[:href].match(/(.*)#(.*)/)
  href = "#{file_name}##{$2}"
  if href
    puts "INSERT INTO searchIndex(name, type, path) VALUES ('#{mod.text}', 'func', '#{href}');"
  end
end

