require 'httparty'
require 'nokogiri'
require 'rubygems'
require 'mechanize'
require 'rspec'

BASE_URL = 'http://johnsonsdictionaryonline.com'.freeze
LETTERS = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'K', 'L', 'M', 'N',
           'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'W', 'X', 'Y', 'Z'].freeze
start_time = Time.now

LETTERS.each do |letter|
  noko_page = HTTParty.get("#{BASE_URL}/?page_id=50&whichLetter=#{letter}")
  parse_page = Nokogiri::HTML(noko_page)
  agent = Mechanize.new
  mech_page = agent.get("#{BASE_URL}/?page_id=50&whichLetter=#{letter}")
  definitions = Hash.new('Not found')
  links = []

  # linkset = parse_page.xpath('//a/@href')
  # linkset.each do |href|
  #   hrefs << href.text
  # end
  # hrefs.delete_if { |text| text[0..3] != '/?p=' }

  # link_names = parse_page.xpath('//*[@id="storycontent"]/div/center[2]/table/tbody/tr/td[1]/a')
  # link_names = noko_page.xpath('//*[@id="storycontent"]/div/center[2]/table/tbody/tr/td[1]/a')


  link_names = parse_page.xpath('//td/a')
  link_names.each do |tag|
    links << tag.text
  end
  links.delete_if { |text| text[0] == '~' }

  #
  # hrefs.each_with_index do |href, index|
  #   next_page = mech_page.link_with(href: "#{href}").click
  #   definitions["#{links[index]}"] = next_page.parser.css('//*[@id="storycontent"]/div').text.strip
  # end

  links.each do |link|
    next_page = mech_page.link_with(text: "#{link}").click
    definitions["#{link}"] = next_page.parser.css('//*[@id="storycontent"]/div').text.strip
  end

#   text_file = File.open("#{letter[0]}", 'a')
#   definitions.each do |key, value|
#     text_file << "\n#{key}"
#     text_file << "\n#{value}\n"
#   end
#   text_file.close
end

puts "MADE IT! It took #{Time.now - start_time}."
# puts links
