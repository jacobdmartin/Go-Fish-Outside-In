require 'rack/test'
require 'rspec'
require 'capybara'
require 'capybara/dsl'
ENV['RACK_ENV'] = 'test'
require_relative '../../server'
require 'selenium/webdriver'
require 'webdrivers'

RSpec.describe Server do
  let(:button_one) {find('#one')}
  let(:button_two) {find('#two')}
  let(:button_three) {find('#three')}
  let(:button_four) {find('#four')}
  let(:button_five) {find('#five')}
  let(:start_button) {find('#start')}

  include Capybara::DSL 
  before do
    Capybara.app = Server.new
  end

  after do
    Server.clear_game
  end

  it "logs in to a page with two cpu\'s" do
    visit '/'
    click_on '1'
    expect(page).to have_css('.player__list--text')
    expect(page).to have_content('You')
  end

  it 'distributes cards based on number of players' do
    visit '/'
    click_on '1'
    expect(page).to have_css('.card__number')
    expect(page).to have_content('7')
  end
end