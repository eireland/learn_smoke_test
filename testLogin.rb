require './lara_object.rb'
require './base_object.rb'
require './learn_component_objects/portal_main_object.rb'
require 'selenium-webdriver'

student_name = 'dnoble'
student_password = 'tardis'
learn_url = 'https://learn.staging.concord.org'
shutterbug_url = 'https://authoring.staging.concord.org/activities/762/'

learn = PortalMainObject.new()
lara = LARAObject.new()
learn.setup_one(:chrome)
learn.visit(learn_url)
learn.verify_page("STEM Resource Finder")
learn.click_button('login')
learn.login(student_name,student_password)
# if learn.verify_auth_user('admin')
#   puts "auth user verified"
# else
#   puts "auth not verified"
# end
learn.run_activity_solo
learn.visit(shutterbug_url)
lara.verify_activity('Shutterbug Smoke Test')