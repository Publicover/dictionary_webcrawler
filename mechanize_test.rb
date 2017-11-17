require 'rubygems'
require 'mechanize'

start_time = Time.now
agent = Mechanize.new
BASE_URL = 'http://en.wikipedia.org'.freeze
agent.history_added = Proc.new { sleep 0.5 }
page = agent.get("#{BASE_URL}/wiki/Main_Page")
page_titles = []
page_count = 0

# link = agent.page.links.find { |l| l.text == 'English literature' }.click
next_page = page.link_with(:href => '/wiki/Special:Random').click

puts "STARTING:"
puts next_page.parser.css('h1').text

loop do
  if next_page.css('h1').text != "Philosophy"
    page = next_page
    next_page = page.link_with(xpath: '//*[@id="mw-content-text"]/div/p/a[1]').click
    # page_titles << next_page.parser.css('h1').text
    puts next_page.parser.css('h1').text
    page_count += 1
  else
    # page_titles << next_page.parser.css('h1').text
    # page_titles << "GOT IT"
    puts "GOT IT in #{Time.now - start_time}"
    break
  end
end

puts "TOTAL PAGES: #{page_count}"

print page_titles
