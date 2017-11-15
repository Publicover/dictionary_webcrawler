require 'rubygems'
require 'mechanize'

agent = Mechanize.new
BASE_URL = 'http://johnsonsdictionaryonline.com'.freeze
page = agent.get("#{BASE_URL}/?page_id=50&whichLetter=Q")
link_titles = []

page.links.each do |link|
  link_titles << link.text
end

link_titles.delete_if { |word| word[0] != 'Q'}

print link_titles
