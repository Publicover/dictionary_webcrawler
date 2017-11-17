require 'httparty'
require 'nokogiri'
require 'rubygems'
require 'mechanize'

BASE_URL = 'http://johnsonsdictionaryonline.com'.freeze
start_time = Time.now

noko_page = HTTParty.get("#{BASE_URL}/?page_id=50&whichLetter=Q")
parse_page = Nokogiri::HTML(noko_page)
agent = Mechanize.new
mech_page = agent.get("#{BASE_URL}/?page_id=50&whichLetter=Q")
definitions = Hash.new('Not found')
links = []

link_names = parse_page.xpath('//td/a')
link_names.each do |tag|
  links << tag.text
end

links.each do |link|
  next_page = mech_page.link_with(text: "#{link}").click
  definitions["#{link}"] = next_page.parser.css('//*[@id="storycontent"]/div').text.strip
end

# puts "MADE IT! It took #{Time.now - start_time}."
puts links
puts definitions
