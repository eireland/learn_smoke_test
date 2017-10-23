require '~/development/learn_smoke_test/base_object'
require './learn_component_objects/login_modal_object'
require './learn_component_objects/portal_landing_object'
require './learn_component_objects/learn_header_object'
require './learn_component_objects/home_page_object'

class PortalMainObject < BaseObject
  include PortalLandingObject
  include LoginModalObject
  include LearnHeaderObject
  include HomePageObject


  def initialize()
    puts "Initializing"
  end

end