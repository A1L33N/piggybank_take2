require 'capybara/rspec'
require './app'
Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('adding a kid account to parent bank', {:type => :feature}) do
  it('add kid account to parent bank') do
    visit('/parents')
    # click_button('Parent Login')
    fill_in('parent_name', :with => 'Betty Smith')
    fill_in('bank_name', :with => 'Betty Bucks')
    click_button("Add Parent/Bank")
    click_link("Betty Bucks")
    expect(page).to have_content('Betty Bucks')
  end
end
