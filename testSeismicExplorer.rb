require './lara_object.rb'
require 'selenium-webdriver'

KEY_BUTTON = {xpath: '//div[contains(@class,"right")]/div[contains(text(),"Key")]'}
DATA_TYPE_BUTTON = {xpath: '//div[contains(@class,"map-layer-controls")]/div[contains(text(),"Data type")]'}
DATA_TYPE_CLOSE = {css: 'div.map-layer-controls > div.modal-style.map-layer-content > i.close-icon'}
PLATE_BOUNDARIES_CHECKBOX = {id: 'plate-border-box'}
VOLCANOES_CHECKBOX = {id: 'volcano-box'}
EARTHQUAKES_CHECKBOX = {id: 'earthquake-toggle'}
PLATE_MOVEMENT_CHECKBOX = {id: 'plate-arrow-toggle'}
SATELLITE_MAP_TYPE = {xpath: '//div[contains(@class,"settings")]/div[contains(text(),"Map type")]/select/option[contains(text(),"Satellite")]'}
STREET_MAP_TYPE = {xpath: '//div[contains(@class,"settings")]/div[contains(text(),"Map type")]/select/option[contains(text(),"Street")]'}
RELIEF_MAP_TYPE = {xpath: '//div[contains(@class,"settings")]/div[contains(text(),"Map type")]/select/option[contains(text(),"Relief")]'}
OCEAN_BASEMAP_MAP_TYPE = {xpath: '//div[contains(@class,"settings")]/div[contains(text(),"Map type")]/select/option[contains(text(),"Ocean basemap")]'}
ANIMATION_BUTTON = {css: '.fa-play'}
APP = {id:'app'}
CONTROLS = {css: '.map-layer-controls'}
LAB_SNAPSHOT_BUTTON = {css: '.lb-action-btn'}

url = 'https://authoring.staging.concord.org/activities/762/pages/303474'
se_url = 'https://seismic-explorer.concord.org/'
# dropdown_loc = "//div[contains(@id,'templatePulldown')]/span/"

learn = LARAObject.new()
learn.setup_one(:chrome)
learn.visit(se_url)
# learn.verify_page('Seismic Explorer')

learn.switch_to_interactive
sleep(3)
learn.click_on(DATA_TYPE_BUTTON)
sleep(1)
learn.click_on(PLATE_BOUNDARIES_CHECKBOX)
sleep(1)
learn.click_on(VOLCANOES_CHECKBOX)
sleep(1)
learn.click_on(PLATE_MOVEMENT_CHECKBOX)
sleep(1)
learn.click_on(DATA_TYPE_CLOSE)
sleep(1)
learn.click_on(ANIMATION_BUTTON)
sleep(15)
learn.switch_to_main
sleep(1)
learn.take_labbook_snapshot
sleep(10)
learn.take_snapshot
sleep(10)
learn.save_screenshot("#{Dir.home}/Downloads", 'SeismicExplorer')
sleep(1)
learn.click_on(OCEAN_BASEMAP_MAP_TYPE)
sleep(1)
learn.save_screenshot("#{Dir.home}/Downloads", 'SeismicExplorer')
learn.click_on(RELIEF_MAP_TYPE)
sleep(1)
learn.save_screenshot("#{Dir.home}/Downloads", 'SeismicExplorer')
learn.click_on(STREET_MAP_TYPE)
sleep(1)
learn.save_screenshot("#{Dir.home}/Downloads", 'SeismicExplorer')
learn.click_on(SATELLITE_MAP_TYPE)
sleep(1)
learn.save_screenshot("#{Dir.home}/Downloads", 'SeismicExplorer')