require './lara_object.rb'
require 'selenium-webdriver'

SNAPSHOT_BUTTON = {css: '.image_snapshot_button'}
PREDICTION_PENCIL = {css: '.draw'}
PREDICTON_PALETTE = {id: "predictionGraph"}
SHOW_ALL_ANSWERS_BUTTON = {css: '.gen-report'}
EXIT_ACTIVITY_BUTTON = {css: '.finish-links'}
PRINT_BUTTON = {xpath: '//li/a[contains(text(),"Print")]'}
PRINT_DIALOG_SAVE_BUTTON = {css: '#print-header > div > button.print.default'}


url = "https://authoring.staging.concord.org/activities/762/pages/302324/"
lara = LARAObject.new()
lara.setup_one(:chrome)
lara.visit(url)
# learn.verify_page('Labbook with no interactive')
# page_title = learn.get_page_title

# puts "in Sensor connector"
# sleep(4)
# # popup = learn.switch_to_modal()
# # popup.click
# # sleep(2)
# # puts "popup is #{popup.inspect}"
# learn.take_snapshot

page_title = lara.get_page_title
puts "in #{page_title}"
sleep(2)
lara.click_on(SHOW_ALL_ANSWERS_BUTTON)
sleep(2)
lara.switch_to_last_tab
lara.click_on(PRINT_BUTTON)
sleep(3)
lara.switch_to_last_tab
lara.chrome_print("pdf")
sleep(5)