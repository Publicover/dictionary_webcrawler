require 'rubygems'
require 'mechanize'

agent = Mechanize.new
agent.history_added = Proc.new { sleep 0.5 }
BASE_URL = 'http://johnsonsdictionaryonline.com'.freeze
# page = agent.get("#{BASE_URL}/?page_id=50&whichLetter=Q").links_with(:href => %r{/\/[?]p=/})
# table = page.link_with(:href => '/?p=')
# rows = page.css('//*[@id="storycontent"]/div/center[2]/table/tbody/tr')
page = agent.get("#{BASE_URL}/?page_id=50&whichLetter=Q")#.search('//*[@id="storycontent"]/div')
# link_table = page.links.find_all { |link| link.attributes.parent.name == 'td' }
# link_table = page.parser.css('//*[@id="storycontent"]/div/center[2]/table/tbody/tr/td')
node = page.css('table')

definitions = []

node.links.each do |link|
  # next_page = link.click
  # if next_page.parser.css('//*[@id="storycontent"]/div').css('style')
  #   definitions << "NOPE DIDN'T WORK"
  # # elsif next_page.parser.css('')
  #   # definitions << "DEAD URL"
  # else
  #   definitions << next_page.parser.css('//*[@id="storycontent"]/div').text
  # end
  puts link.text
end

# next_page = page.link_with(:href => '/?p=21079').click
# if next_page.parser.css('//*[@id="storycontent"]/div').css('style')
#   definitions << "NOPE DIDN'T WORK"
# else
#   definitions << next_page.parser.css('//*[@id="storycontent"]/div').text
# end
# definitions << next_page.parser.css('//*[@id="storycontent"]/div').text

definitions.each do |definition|
  puts definition
end
