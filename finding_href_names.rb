require 'httparty'
require 'nokogiri'
require 'rubygems'
require 'mechanize'

BASE_URL = 'http://johnsonsdictionaryonline.com'.freeze
LETTERS = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'K', 'L', 'M', 'N',
           'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'W', 'X', 'Y', 'Z'].freeze
start_time = Time.now

# LETTERS.each do |letter|
  noko_page = HTTParty.get("#{BASE_URL}/?page_id=50&whichLetter=Q")
  parse_page = Nokogiri::HTML(noko_page)
  agent = Mechanize.new
  mech_page = agent.get("#{BASE_URL}/?page_id=50&whichLetter=Q")
  hrefs = []
  definitions = Hash.new('Not found')

  linkset = parse_page.xpath('//a/@href')
  linkset.each do |href|
    hrefs << href.text
  end
  hrefs.delete_if { |text| text[0..3] != '/?p=' }
# end

links = []
link_names = parse_page.xpath('//td/a')
link_names.each do |tag|
  links << tag.text
end

hrefs = []
hrefs.each_with_index do |href, index|
  next_page = mech_page.link_with(href: "#{href}").click
  definitions["#{links[index]}"] = next_page.parser.css('//*[@id="storycontent"]/div').text.strip
end

text_file = File.open("Q", 'a')
definitions.each do |key, value|
  text_file << "\n#{key}"
  text_file << "\n#{value}\n"
end
text_file.close
