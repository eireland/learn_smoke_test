require './landing_page.rb'
require 'selenium-webdriver'

@@driver = Selenium::WebDriver.for :chrome
ENV['base_url'] = 'https://learn.staging.concord.org'

learn = LandingPageObject.new()
learn.visit
learn.verify_page('Learn Portal')
learn.goto_advance_search
# @@driver.quit