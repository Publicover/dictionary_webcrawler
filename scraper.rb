require 'httparty'
require 'nokogiri'
require 'rubygems'
require 'mechanize'

# https://stackoverflow.com/questions/2080799/how-do-i-use-xpath-in-nokogiri
# got xpath for xpath_link

agent = Mechanize.new

BASE_URL = 'http://en.wikipedia.org'.freeze

page = HTTParty.get("#{BASE_URL}/wiki/Samuel_Johnson")
# page = agent.get("#{BASE_URL}/wiki/Samuel_Johnson")
# page.links.each do |link|
#   puts link.text
# end

parse_page = Nokogiri::HTML(page)
title_array = []
# next_page = agent.page.link.find { |l| l.text == 'OS' }.click

title_array << parse_page.css('#content').css('h1').text
# first_link = parse_page.css('#bodyContent').css('#mw-content-text').css('div').css('p').css('a').text
first_link = parse_page.at('#bodyContent #mw-content-text div p a').text
# xpath_link = parse_page.xpath('//*[@id="mw-content-text"]/div/p[4]/a[2]')
xpath_link = parse_page.xpath('//*[@id="mw-content-text"]/div/p[1]/a[1]').text

puts title_array
puts first_link
puts xpath_link
# puts next_page.at('//*[@id="firstHeading"]')
