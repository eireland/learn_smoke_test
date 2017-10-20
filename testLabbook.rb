require './lara_object.rb'
require 'selenium-webdriver'

SNAPSHOT_BUTTON = {css: '.image_snapshot_button'}
PREDICTION_PENCIL = {css: '.draw'}
PREDICTON_PALETTE = {id: "predictionGraph"}
SHOW_ALL_ANSWERS_BUTTON = {css: '.gen-report'}
EXIT_ACTIVITY_BUTTON = {css: '.finish-links'}
PRINT_BUTTON = {xpath: '//li/a[contains(text(),"Print")]'}
PRINT_DIALOG_SAVE_BUTTON = {css: '#print-header > div > button.print.default'}
SPINNER = {css: '.wait-for'}
IFRAME = {tag_name: 'iframe'}
LABBOOK_SNAPSHOT_BUTTON ={css: ".lb-action-btn"}
LABBOOK_DIALOG = {css: '.lb-dialog'}
LABBOOK_SAVE = {xpath: ".//div[contains(@class,'snapshot-form')]/form/div[contains(@class,'right')]/div[contains(@class,'actions')]/input"}
LABBOOK_CLOSE_BUTTON = {xpath: ".//div[contains(@class,'ui-dialog-titlebar')]/button[contains(@class,'ui-dialog-titlebar-close')]"}
LABBOOK_SNAPSHOT_FORM = {css: '.snapshot-form'}
LABBOOK_IFRAME = {css: '.labbook-content'}


url = "https://authoring.staging.concord.org/activities/762/pages/3687"
lara = LARAObject.new()
lara.setup_one(:chrome)
lara.visit(url)

page_title = lara.get_page_title
puts "in #{page_title}"
sleep(2)
lara.click_on(LABBOOK_SNAPSHOT_BUTTON)
sleep(10)
lara.switch_to_modal
# form=lara.find(LABBOOK_SNAPSHOT_FORM)
# puts "form at #{form}"
iframe=lara.find(LABBOOK_IFRAME)
puts "iframe at #{iframe}"
lara.switch_to_iframe(iframe)
lara.click_on(LABBOOK_SAVE)
sleep(10)
lara.switch_to_main
lara.click_on(LABBOOK_CLOSE_BUTTON)
lara.switch_to_main
sleep(5)