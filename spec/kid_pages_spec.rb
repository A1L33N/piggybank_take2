require('spec_helper')

describe('viewing individual kid page', {:type => :feature}) do
  it('add parent bank') do
    visit('/parents')
    fill_in('parent_name', :with => 'Betty Smith')
    fill_in('bank_name', :with => 'Betty Bucks')
    click_button("Add Parent/Bank")
    click_link("Betty Bucks")
    expect(page).to have_content('Betty Bucks')
  end
end
