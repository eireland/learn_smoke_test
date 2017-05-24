require './lara_object.rb'
require 'selenium-webdriver'

SNAPSHOT_BUTTON = {css: '.image_snapshot_button'}
PREDICTION_PENCIL = {css: '.draw'}
PREDICTON_PALETTE = {id: "predictionGraph"}


url = "https://authoring.staging.concord.org/activities/762/pages/3691/"
learn = LARAObject.new()
learn.setup_one(:chrome)
learn.visit(url)
# learn.verify_page('Labbook with no interactive')
# page_title = learn.get_page_title

puts "in Sensor connector"
sleep(4)
popup = learn.switch_to_iframe()
popup.click
sleep(2)
puts "popup is #{popup.inspect}"