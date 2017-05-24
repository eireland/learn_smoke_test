require './lara_object.rb'
require './base_object.rb'
require 'selenium-webdriver'

PHOTON_RADIO = {xpath: './/label[contains(@for,"select-model-3")]'}
PHOTON_CHECKBOX = {xpath: './/label[contains(@for,"ke-shading")]'}
SHOW_ATOM_CHECKBOX = {xpath: './/label[contains(@for,"select-show-atoms")]'}
SHOW_ELECTRON_CLOUD = {xpath: './/label[contains(@for,"select-electron-view-1")]'}
HAS_DROPDOWN = {css: '.selectboxit-arrow-container'}
HAS_ADD_WELL = {id: "add-wells-button-set"}
HAS_MAIN_IMAGE = {id: '#mouse-catcher'}
HAS_INTRO_CLOSE = {xpath: '//div[contains(@class,"about-dialog")]/div/button[contains(@class,"ui-dialog-titlebar-close")]'}
VIDEO_ERROR = {css: '.dialog-error'}
VIDEO_ERROR_CLOSE = {css: '.ui-dialog-titlebar-close'}
PREDICTION_PENCIL = {css: '.draw'}
PREDICTON_PALETTE = {id: "predictionGraph"}
SNAPSHOT_BUTTON = {css: '.image_snapshot_button'}
LABBOOK_SNAPSHOT_BUTTON = {css: '.lb-action-btn'}
EXIT_ACTIVITY_BUTTON = {css: '.finish-links'}


url = 'http://authoring.staging.concord.org/activities/762/'

links = []

learn = LARAObject.new()
learn.setup_one(:chrome)
learn.visit(url)
learn.verify_activity('Shutterbug Smoke Test')

pages = learn.get_pages()
# puts "pages are #{pages}"
pages.each do |page|
  link = learn.get_link(page)
  link.slice! url
  links<<link
end
# puts "links are #{links}"

links.shift # removes the home page of the shutterbug activity

#Fails at Page 12 because have to make a drawing first and then take a snapshot/ Look for "Drawing tool drawing?"
links.each do |link|
  learn.visit(url+link)
  sleep(10)
  #check which page to know what to do at each page
  page_title = learn.get_page_title
  puts "Page_title is #{page_title}"
  case (page_title)
    when /Drawing/
      learn.open_draw_tool
      learn.draw_shape
      learn.close_draw_tool
      sleep(2)
    when /Molecular Workbench/
      learn.switch_to_interactive
      learn.play_interactive
      sleep(2)
      learn.switch_to_main
    when /Photons/
      learn.switch_to_interactive
      learn.click_on(PHOTON_RADIO)
      learn.click_on(PHOTON_CHECKBOX)
      learn.play_interactive
      sleep(2)
      learn.switch_to_main
    when /Balloon Charge/
      learn.switch_to_interactive
      learn.click_on(SHOW_ATOM_CHECKBOX)
      learn.click_on(SHOW_ELECTRON_CLOUD)
      sleep(2)
      learn.switch_to_main
    when /Model with text/
      learn.switch_to_interactive
      learn.play_interactive
      sleep(2)
      learn.switch_to_main
    when /HAS water/
      puts "In HAS water"
      dropdown_loc = "//div[contains(@id,'templatePulldown')]/span/"
      learn.switch_to_interactive
      sleep(2)
      learn.click_on(HAS_INTRO_CLOSE)
      learn.select_from_dropdown(HAS_DROPDOWN,dropdown_loc,"Rural vs. urban areas")
      learn.play_interactive
      sleep(5)
      learn.switch_to_main
    when /line graph/
      puts "In ITSI Model with line graph"
      # click grass, rabbit, hawk, fox buttons, click play button
      play = {css: '.play'}
      element_buttons = {css: '.has-no-button' }
      pause = {css: ".pause"}

      learn.switch_to_interactive
      el_buttons = learn.find_all(element_buttons)
      el_buttons.each do |button|
        button.click
      end
      learn.click_on(play)
      sleep(10)
      learn.click_on(pause)
      learn.switch_to_main
    when /bar graph/
      puts "In ITSI Model with bar graph"
       #click grass, rabbit buttons, click play button
      play = {css: '.play'}
      grass = {xpath: '//*[@id="environment"]/div/div/div[3]' }
      rabbit =  {xpath: '//*[@id="environment"]/div/div/div[4]' }
      pause = {css: ".pause"}

      learn.switch_to_interactive
      learn.click_on(grass)
      learn.click_on(rabbit)
      learn.click_on(play)
      sleep(10)
      learn.click_on(pause)
      learn.switch_to_main
    when /Biologica/
      mom_end = {css: '#mother-meiosis > .meiosis > .controls > .buttons > .end'}
      mother_cell = {css: '#mother-meiosis > div > div.cell > svg > circle:nth-child(3)'}
      father_end = {css: '#father-meiosis > .meiosis > .controls > .buttons > .end'}
      father_cell = {css: '#father-meiosis > div > div.cell > svg > circle:nth-child(6)'}
      baby_end = {css: '#offspring-meiosis > div > div.controls > div.buttons > button.end'}

      learn.switch_to_interactive
      learn.click_on(mom_end)
      learn.click_on(father_end)
      sleep(1)
      learn.click_with_offset(mother_cell,25,40)
      learn.click_with_offset(father_cell,25,40)
      sleep(1)
      learn.click_on(baby_end)
      sleep(5)
      learn.switch_to_main

    when "Labbook"
      puts "Labbook"
    when /no interactive/
      puts "in Labbook with no interactive"
      #verify snapshot button not present
      if !(learn.displayed?(SNAPSHOT_BUTTON))
        puts "No snapshot button found"
      end
    when /Prediction/
      puts 'In Prediction graph'
      learn.switch_to_interactive
      sleep(1)
      learn.draw(PREDICTION_PENCIL, PREDICTON_PALETTE)
      sleep(5)
      learn.switch_to_main
    when /Convection/
      puts "In convection"
      learn.switch_to_interactive
      learn.play_interactive
      sleep(10) #wait to generate heat
      learn.switch_to_main
    when /Interactive table/
      puts "in interactive table"
      cell1 = {css: '.data > td:nth-child(1)'}
      input1 = {css: '.data > td:nth-child(1) > input.editor-text'}
      cell2 = {css: '.data > td:nth-child(2)'}
      input2 = {css: '.data > td:nth-child(2) > input.editor-text'}
      cell3 = {css: '.data > td:nth-child(3)'}
      input3 = {css: '.data > td:nth-child(3) > input.editor-text'}
      cell4 = {css: '.data > td:nth-child(4)'}
      input4 = {css: '.data > td:nth-child(4) > input.editor-text'}
      # type in text to four tds
      learn.switch_to_interactive
      sleep(1)
      learn.click_on(cell1)
      sleep(1)
      learn.type(input1,"metal")
      sleep(1)
      learn.click_on(cell2)
      sleep(1)
      learn.click_on(cell3)
      sleep(1)
      learn.type(input3, "repel")
      learn.click_on(cell4)
      sleep(1)
      learn.type(input4, "negative")
      learn.switch_to_main
    when /Netlogo/
      puts "in Netlogo"
      play = {css: ".netlogo-forever-button"}
      learn.switch_to_interactive
      learn.click_on(play)
      sleep(5)
      learn.switch_to_main
    when /Sensor connector/
      puts "in Sensor connector"
      # popup = learn.switch_to_modal
      # popup.cancel
    when /Completion/
      puts "in completion page"
      learn.click_on(EXIT_ACTIVITY_BUTTON)
  end

  if (page_title.include?("no interactive")) || (page_title.include?("Completion") || (page_title.include?("Video")) || (page_title.include?("Sensor connector")))
    puts "Do not take snapshot"
  else
    if page_title == "Labbook"
      puts "In labbook"
      # learn.click_on(LABBOOK_SNAPSHOT_BUTTON)
    else
      puts "before take_snapshot"
      sleep(1)
      learn.take_snapshot
      sleep(10)
      # if page_title == "Video"
      #   if learn.displayed?(VIDEO_ERROR)
      #     puts "Right error"
      #     learn.click_on(VIDEO_ERROR_CLOSE)
      #   else
      #     puts "wrong error"
      #   end
      # end
    end
  end
end

# page 1 gradient colors - take snapshot
# page 2 draw tool (Make a drawing), draw tool (Take a snapshot)
# page 3 Molecular Workbench Lab - click play button, take snapshot
# page 4 Model with image - Photons - turn on radio button, turn on checkbox, click play button, take snapshot
# page 5 CODAP - take a snapshot
# page 6 Balloon Charge - turn on checkbox, turn on  radio button take snapshot
# page 7 Text in ineractive - click play button, take snapshot
# page 8 HAS Water interactive - select from dropdown menu, add well, click play button, take snapshot
# page 9 JSMol interactive - take snapshot
# page 10 ITSI model with line graph - click grass, rabbit, hawk, fox buttons, click play button, take snapshot
# page 11 ITSI model with bar graph - click grass, rabbit buttons, click play button, take snapshot
# page 12 ITSI Biologica model - click mother end button, click circle, father end button, click circle, offspring end button, take snapshot
# page 13 iSense - take snapshot
# page 14 Labbook - take snapshot, (open album, verify snapshot in album)
# page 15 Labbook no interactive - verify no snapshot button
# page 16 Snapshot of an image - take snapshot
# page 17 Snapshot of video - take snapshot, verify error message comes up
# page 18 PhET - take snapshot
# page 19 Prediction graph - draw line, take snapshot
# page 20 Convection in house - click play button, take snapshot
# page 21 Interactive table - type in text to four tds, take snapshot
# page 22 Netlogo model - click run button, move planet, take snapshot
# page 23 Sensor connector - click cancel in alert, take snapshot
# page 24 Completion page