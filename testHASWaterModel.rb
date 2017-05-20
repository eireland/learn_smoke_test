require './lara_object.rb'
require 'selenium-webdriver'

HAS_DROPDOWN = {css: '.selectboxit-arrow'} #templatePulldown > span.selectboxit-container > span > span.selectboxit-arrow-container
HAS_DROPDOWN_SELECTION_LIST = {css: "#templatePulldown>span>ul>li"}
HAS_ADD_WELL = {id: "add-wells-button-set"}
HAS_MAIN_IMAGE = {id: '#mouse-catcher'}
HAS_INTRO_CLOSE = {xpath: '//div[contains(@class,"about-dialog")]/div/button[contains(@class,"ui-dialog-titlebar-close")]'}

url = 'https://authoring.staging.concord.org/activities/762/pages/3680/'
dropdown_loc = "//div[contains(@id,'templatePulldown')]/span/"

learn = LARAObject.new()
learn.setup_one(:chrome)
learn.visit(url)
learn.verify_page('HAS water interactive')

learn.switch_to_interactive
sleep(2)
learn.click_on(HAS_INTRO_CLOSE)
learn.select_from_dropdown(HAS_DROPDOWN,dropdown_loc,"Rural vs. urban areas")
learn.play_interactive
sleep(10)