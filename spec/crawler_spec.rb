require 'spec_helper'
require 'nokogiri'
require 'mechanize'
require 'httparty'

RSpec.describe 'Web crawler' do
  let(:page) { HTTParty.get('http://johnsonsdictionaryonline.com') }
  let(:parse_page) { Nokogiri::HTML(page) }

  it 'should be true' do
    the_truth = true
    expect(the_truth).to be true
  end

  it 'should allow VCR gem' do
    VCR.use_cassette('synopsis') do
      response = Net::HTTP.get_response(URI('http://johnsonsdictionaryonline.com/?page_id=50&whichLetter=Q'))
      expect(response.code).to eq('200')
    end
  end

  it 'should return page title' do
    VCR.use_cassette('get_title') do
      title = parse_page.xpath('//title').text
      expect(title).to eq(
        ' - A Dictionary of the English Language - Samuel Johnson - 1755'
      )
    end
  end

  it 'should return links' do
    
  end
end
