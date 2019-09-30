require 'rack/test'
require 'rspec'
require 'capybara'
require 'capybara/dsl'
ENV['RACK_ENV'] = 'test'
require '../../server'

RSpec.describe Server do
  include Capybara::DSL 
  before do
    Capybara.app = Server.new
  end

  after do
    Server.clear_game
  end

  it 'logs in to a page with the name James' do
    visit '/'
    fill_in :name with: 'James'
    click_on 'Login'
    expect(page).to have_content('Game')
    expect(page).to have_content('James')
  end
end