require 'spec'
require 'selenium'

class Dashboard
  def initialize(browser)
    @browser = browser
  end
  
  def goto
    @browser.open 'http://localhost:4000/grid/'
  end

  def select_row(id)
    @browser.run_script <<EOS
Ext.getCmp('grid').getSelectionModel().selectRow('#{id}');
EOS
  end

end

Before do
  @browser = Selenium::SeleniumDriver.new("localhost", 4444, "*chrome", "http://localhost", 15000)
  @browser.start
  @page = Dashboard.new(@browser)
end

After do
  @browser.stop
end

After do
  @page.select_row(0)
  @browser.click 'delete'
  sleep(1)
end

Given /^I am on the dashboard$/ do
  @page.goto
end

Given /^I have entered (.*) in the (.*) form field$/ do |title, field|
  @browser.type field, title
end

When /^I press (.*) button$/ do |button|
  @browser.click button
  sleep(1)
end

When /^I select (.*)$/ do |recipe|
  @page.select_row(0)
end

When /^I click on the delete button$/ do
end

Then /^the Spaghetti al pomodoro recipe should disappear from the grid$/ do
end

Then /^I should see the (.*) recipe on the grid$/ do |recipe|
  @browser.get_text("//table//div[contains(@class, 'col-name')]").should match(/#{recipe}/)
end
