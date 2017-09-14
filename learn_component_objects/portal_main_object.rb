require '../base_object'
require './login_modal_object'
require './portal_landing_object'
require './learn_header_object'
require './home_page_object'

class PortalMainObject < BaseObject
  include PortalLandingObject
  include LoginModalObject
  include LearnHeaderObject
  include HomePageObject


  def initialize()
    puts "Initializing"
  end

  private

  def wait_for(seconds=25)
    puts "Waiting"
    Selenium::WebDriver::Wait.new(:timeout => seconds).until { yield }
  end

end