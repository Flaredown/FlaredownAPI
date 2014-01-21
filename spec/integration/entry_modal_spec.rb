require "spec_helper"

feature "Entry Modal" do
  
  let(:user) { create :user }
  before(:each) do
    3.times{ create :cdai_entry, user: user }
  end
  
  scenario "bring up modal for today" do
    login_and_click_today
    expect(find(".modal")).to be_visible
    expect_fragment_is "/entry/today/1"
  end
  
  scenario "navigate through modal sections" do
    login_and_click_today
    
    expect_section_selected "1"
    expect_fragment_is "/entry/today/1"
    
    click_on "2"
    expect_section_selected "2"
    expect_fragment_is "/entry/today/2"
  end  
  scenario "navigate through yesterday's entry" do
    login
    entry = Entry.by_date.last
    entry_date = entry.date.strftime('%b-%d-%Y')
    visit "/#/entry/#{entry_date}/1"
    
    expect_section_selected "1"
    expect_fragment_is "/entry/#{entry_date}/1"
  end
  
  scenario "go to URL with modal section" do
    login
    visit("/#/entry/today/4")
    expect_section_selected "4"
  end
  
  scenario "go to URL with unavailable section defaults to 1" do
    login
    visit("/#/entry/today/99")
    expect_section_selected "1"
    expect_fragment_is "/entry/today/1"
  end
  
  scenario "go to the next section when submitting a response" do
    Capybara.current_driver = :selenium
    login_and_click_today
    expect_section_selected "1"
    
    all(".response-input-link").first.click()
    
    expect_section_selected "2"
    expect_fragment_is "/entry/today/2"
  end
  
  scenario "navigate through modal with previous/next" do
    login_and_click_today
    
    find("#questioner .previous-link").click() # can't go back further than 1
    expect_section_selected "1"
    
    find("#questioner .next-link").click()
    find("#questioner .next-link").click()
    expect_section_selected "3"
    expect_fragment_is "/entry/today/3"
    
    find("#questioner .previous-link").click()
    expect_section_selected "2"
    expect_fragment_is "/entry/today/2"
  end
  
  scenario "user arrows and numbers to navigate" do
    Capybara.current_driver = :selenium
    login_and_click_today
    
    find("#questioner").native.send_keys(3)
    expect_section_selected "3"
    
    find("#questioner").native.send_keys(:arrow_right)
    expect_section_selected "4"
    
    find("#questioner").native.send_keys(:arrow_left)
    expect_section_selected "3"
  end
  
  scenario "closing modal goes back to index" do
    login_and_click_today
    click_on "Close"
    expect_fragment_is "/"
  end

end

def expect_section_selected section
  expect(find("#questioner nav .selected")).to have_text section
end
def expect_fragment_is path
  uri = URI.parse(current_url)
  expect(uri.fragment).to eq path
end
def login_and_click_today
  login
  click_on "Today"
end

def keypress_on(elem, key, charCode = 0)
  keyCode = case key
  when :enter then 13
  else key.to_i
  end
  # puts elem.base.class

  elem.base.invoke('keypress', false, false, false, false, keyCode, charCode);
end
