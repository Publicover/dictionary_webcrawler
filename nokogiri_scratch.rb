require 'httparty'
require 'nokogiri'
require 'rubygems'
require 'mechanize'

BASE_URL = 'http://johnsonsdictionaryonline.com'.freeze
LETTERS = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'K', 'L', 'M', 'N', 'O',
           'P', 'Q', 'R', 'S', 'T', 'W', 'X', 'Y', 'Z'].freeze
noko_page = HTTParty.get("#{BASE_URL}/?page_id=50&whichLetter=Q")
parse_page = Nokogiri::HTML(noko_page)
agent = Mechanize.new
mech_page = agent.get("#{BASE_URL}/?page_id=50&whichLetter=Q")
hrefs = []

linkset = parse_page.xpath('//a/@href')
# puts linkset
linkset.each do |href|
  hrefs << href.text
end

puts hrefs

hrefs.delete_if { |text| text[0..3] != '/?p=' }

print hrefs
