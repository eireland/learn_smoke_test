require './lara_object.rb'
require './base_object.rb'
require './learn_component_objects/portal_main_object.rb'
require 'selenium-webdriver'

PLAY = {css: '.play'}
ELEMENT_BUTTONS = {css: '.has-no-button' }
PAUSE = {css: ".pause"}

url = 'https://authoring.staging.concord.org/activities/762/pages/3682/'
learn = PortalMainObject.new()
lara = LARAObject.new()
learn.setup_one(:chrome)
learn.visit(url)
learn.verify_page('ITSI model with line graph')

lara.switch_to_interactive
sleep(2)
# click grass, rabbit, hawk, fox buttons, click play button

el_buttons = learn.find_all(ELEMENT_BUTTONS)
puts "el_buttons are #{el_buttons}"
el_buttons.each do |button|
  button.click
end
learn.click_on(PLAY)
sleep(10)
learn.click_on(PAUSE)