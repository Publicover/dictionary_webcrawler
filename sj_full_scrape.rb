require 'rubygems'
require 'mechanize'

BASE_URL = 'http://johnsonsdictionaryonline.com'.freeze
LETTERS = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I',
           'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R',
           'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'].freeze
# MEMBERS = ['Brandi', 'vicjunq92', 'malan1'].freeze
# DATES = ['November 18th, 2011 at 11:24 am', 'January 19th, 2012 at 9:33 pm',
#          'January 20th, 2012 at 6:20 am', 'February 7th, 2012 at 7:27 am',
#          'February 7th, 2012 at 8:31 am', 'March 10th, 2012 at 4:39 pm',
#          'March 10th, 2012 at 4:56 pm', 'April 18th, 2012 at 10:34 am',
#          'July 12th, 2012 at 4:39 pm', 'July 13th, 2012 at 6:27 am',
#          'October 25th, 2012 at 1:44 am', 'October 25th, 2012 at 8:23 am',
#          'November 23rd, 2012 at 1:07 am', 'November 23rd, 2012 at 5:42 pm',
#          'January 17th, 2013 at 1:24 pm', 'January 17th, 2013 at 1:58 pm',
#          'March 20th, 2013 at 8:53 am', 'March 20th, 2013 at 12:10 pm',
#          'June 29th, 2015 at 4:15 pm', 'June 30th, 2015 at 12:20 am'].freeze
#
start_time = Time.now

LETTERS.each do |letter|
  agent = Mechanize.new
  page = agent.get("#{BASE_URL}/?page_id=50&whichLetter=#{letter}")
  link_titles = []
  definitions = Hash.new('Not found')

  page.links.each do |link|
    link_titles << link.text
  end

  link_titles.delete_if { |word| word[0] != "#{letter}" }

  link_titles.each do |title|
    next_page = page.link_with(text: "#{title}").click
    definitions["#{title}"] = next_page.parser.css('//*[@id="storycontent"]/div').text.strip
  end

  text_file = File.open("#{letter}", 'a')
  definitions.each do |key, value|
    text_file << "\n#{key}"
    text_file << "\n#{value}\n"
  end
  text_file.close
end

puts "MADE IT! It took #{Time.now - start_time}."
