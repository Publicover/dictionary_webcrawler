require 'spec_helper'
require 'nokogiri'
require 'mechanize'

RSpec.describe 'Web craler' do
  before do
    @noko_doc = Nokogiri::HTML(open('spec/support/Q_index.html'))
    # @agent = Mechanize.new
    # @mech_doc = @agent.get('/spec/support/Q_index.html')
  end

  it 'should be true' do
    the_truth = true
    expect(the_truth).to be true
  end

  it 'should return doc' do
    allow(@doc).to receive(:parse)
  end

  it 'should accept mechanize' do
    allow(@doc).to recieve
  end
end
