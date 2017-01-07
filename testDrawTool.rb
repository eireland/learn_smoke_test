require './lara_object.rb'
require 'selenium-webdriver'

url = 'http://authoring.staging.concord.org/activities/762/pages/3686/'

learn = LARAObject.new()
learn.setup_one(:chrome)
learn.visit(url)
learn.verify_page('Drawing tool drawing')

learn.open_draw_tool
learn.draw_shape

sleep(10)