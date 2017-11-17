require 'rubygems'
require 'mechanize'

# use constant for list of letters in alphabet
LETTERS = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I',
           'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R',
           'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'].freeze

# set up the page to scrape
agent = Mechanize.new
BASE_URL = 'http://johnsonsdictionaryonline.com'.freeze
page = agent.get("#{BASE_URL}/?page_id=50&whichLetter=Q")
link_titles = []
definitions = Hash.new("Not found")

# scrape page for title of links
# put those in an array
page.links.each do |link|
  link_titles << link.text
end

# delete everything in array that is not title to link
link_titles.delete_if { |word| word[0] != 'Q'}

# puts link_titles

# iterate over array using each element to click link
link_titles.each do |title|
  next_page = page.link_with(text: "#{title}").click
  # put definitions in array
  definitions["#{title}"] = next_page.parser.css('//*[@id="storycontent"]/div').text.strip
end

# output array
# pp definitions
# put definitions in file named after letter
text_file = File.open('Q.txt', 'a')
definitions.each do |key, value|
  text_file << "\n#{key}"
  text_file << "\n#{value}\n"
end
text_file.close

# move on to next letter
