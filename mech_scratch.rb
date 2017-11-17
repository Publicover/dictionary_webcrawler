require 'rubygems'
require 'mechanize'

agent = Mechanize.new
agent.history_added = Proc.new { sleep 0.5 }
BASE_URL = 'http://johnsonsdictionaryonline.com'.freeze
page = agent.get("#{BASE_URL}/?page_id=50&whichLetter=Q").at('#content div div#storycontent.storycontent')
# new_page = page.at('#content div div#storycontent.storycontent')
# puts page.at('#storycontent div center:nth-child(7) table tbody tr td:nth-child(1) a:nth-child(599)')
# puts new_page
puts page.class

# real_page = Mechanize::Page.new(new_page, agent, page)
# real_page.class
