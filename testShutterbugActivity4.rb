require './lara_object.rb'
require './base_object.rb'
require './learn_component_objects/portal_main_object.rb'
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
LABBOOK_SNAPSHOT_BUTTON = {css: ".lb-action-btn"}
SHOW_ALL_ANSWERS_BUTTON = {css: '.gen-report'}
EXIT_ACTIVITY_BUTTON = {css: '.finish-links'}
PRINT_BUTTON = {xpath: '//*[@id="nav-activity-menu"]/ul/li[1]/a[contains(text(),"Print")]'}
PRINT_DIALOG_SAVE_BUTTON = {css: '#print-header > div > button.print.default'}

learn_url = 'https://learn.staging.concord.org'
shutterbug_url = 'https://authoring.staging.concord.org/activities/762/'

student_name = 'dnoble'
student_password = 'tardis'

links = []
learn = PortalMainObject.new()
lara = LARAObject.new()
learn.setup_one(:chrome)
learn.visit(learn_url)
learn.verify_page("STEM Resource Finder")
learn.click_button('login')
learn.login(student_name,student_password)
if learn.verify_auth_user('admin')
  puts "auth user verified"
else
  puts "auth not verified"
end
learn.run_activity_solo
learn.visit(shutterbug_url)
lara.verify_activity('Shutterbug Smoke Test')

pages = lara.get_pages()
# puts "pages are #{pages}"
pages.each do |page|
  link = lara.get_link(page)
  link.slice! shutterbug_url
  links<<link
end

links.shift # removes the home page of the shutterbug activity

#Fails at Page 12 because have to make a drawing first and then take a snapshot/ Look for "Drawing tool drawing?"
links.each do |link|
  puts "URL to visit #{shutterbug_url+link}"
  learn.visit(shutterbug_url+link)
  sleep(10)
  #check which page to know what to do at each page

  page_title = lara.get_page_title
  case (page_title)
    when /Drawing/
      lara.open_draw_tool
      lara.draw_shape
      lara.close_draw_tool
      sleep(20)
      lara.switch_to_main
    when /Molecular Workbench/
      lara.switch_to_interactive
      lara.play_interactive
      sleep(2)
      lara.switch_to_main
    when /Photons/
      lara.switch_to_interactive
      lara.click_on(PHOTON_RADIO)
      lara.click_on(PHOTON_CHECKBOX)
      lara.play_interactive
      sleep(2)
      lara.switch_to_main
    when /Balloon Charge/
      lara.switch_to_interactive
      lara.click_on(SHOW_ATOM_CHECKBOX)
      lara.click_on(SHOW_ELECTRON_CLOUD)
      sleep(2)
      lara.switch_to_main
    when /Model with text/
      lara.switch_to_interactive
      lara.play_interactive
      sleep(2)
      lara.switch_to_main
    when /HAS water/
      puts "In HAS water"
      dropdown_loc = "//div[contains(@id,'templatePulldown')]/span/"
      lara.switch_to_interactive
      sleep(2)
      lara.click_on(HAS_INTRO_CLOSE)
      lara.select_from_dropdown(HAS_DROPDOWN,dropdown_loc,"Rural vs. urban areas")
      lara.play_interactive
      sleep(5)
      lara.switch_to_main
    when /line graph/
      puts "In ITSI Model with line graph"
      # click grass, rabbit, hawk, fox buttons, click play button
      play = {css: '.play'}
      element_buttons = {css: '.has-no-button' }
      pause = {css: ".pause"}

      lara.switch_to_interactive
      el_buttons = learn.find_all(element_buttons)
      el_buttons.each do |button|
        button.click
      end
      lara.click_on(play)
      sleep(20)
      lara.click_on(pause)
      lara.switch_to_main
    when /bar graph/
      puts "In ITSI Model with bar graph"
       #click grass, rabbit buttons, click play button
      play = {css: '.play'}
      grass = {xpath: '//*[@id="environment"]/div/div/div[3]' }
      rabbit =  {xpath: '//*[@id="environment"]/div/div/div[4]' }
      pause = {css: ".pause"}

      lara.switch_to_interactive
      lara.click_on(grass)
      lara.click_on(rabbit)
      lara.click_on(play)
      sleep(20)
      lara.click_on(pause)
      lara.switch_to_main
    when /Biologica/
      mom_end = {css: '#mother-meiosis > .meiosis > .controls > .buttons > .end'}
      mother_cell = {css: '#mother-meiosis > div > div.cell > svg > circle:nth-child(3)'}
      father_end = {css: '#father-meiosis > .meiosis > .controls > .buttons > .end'}
      father_cell = {css: '#father-meiosis > div > div.cell > svg > circle:nth-child(6)'}
      baby_end = {css: '#offspring-meiosis > div > div.controls > div.buttons > button.end'}

      lara.switch_to_interactive
      lara.click_on(mom_end)
      lara.click_on(father_end)
      sleep(1)
      lara.click_with_offset(mother_cell,25,40)
      lara.click_with_offset(father_cell,25,40)
      sleep(1)
      lara.click_on(baby_end)
      sleep(5)
      lara.switch_to_main

    when "Labbook"
      puts "Labbook"
      learn.take_labbook_snapshot
    when /no interactive/
      puts "in Labbook with no interactive"
      #verify snapshot button not present
      if !(lara.displayed?(SNAPSHOT_BUTTON))
        puts "No snapshot button found"
      end
    when /Prediction/
      puts 'In Prediction graph'
      lara.switch_to_interactive
      sleep(1)
      lara.draw(PREDICTION_PENCIL, PREDICTON_PALETTE)
      sleep(5)
      lara.switch_to_main
    when /Convection/
      puts "In convection"
      lara.switch_to_interactive
      lara.play_interactive
      sleep(10) #wait to generate heat
      lara.switch_to_main
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
      lara.switch_to_interactive
      sleep(1)
      lara.click_on(cell1)
      sleep(1)
      lara.type(input1,"metal")
      sleep(1)
      lara.click_on(cell2)
      sleep(1)
      lara.click_on(cell3)
      sleep(1)
      lara.type(input3, "repel")
      lara.click_on(cell4)
      sleep(1)
      lara.type(input4, "negative")
      lara.switch_to_main
    when /Netlogo/
      puts "in Netlogo"
      play = {css: ".netlogo-forever-button"}
      lara.switch_to_interactive
      lara.click_on(play)
      sleep(5)
      lara.switch_to_main
    when /Seismic Explorer/
      puts "in Seismic Explorer"
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
      lara.switch_to_main
    when /Sensor connector/
      system('say "Watch the computer now!"') #Need to click the don't open the sensorconnector dialog box so it doesn't interfere with printing the answer report in the completion page.
      puts "in Sensor connector"
      learn.switch_to_main
    when /Completion/
      puts "in completion page"
      lara.click_on(SHOW_ALL_ANSWERS_BUTTON)
      sleep(2)
      lara.switch_to_last_tab
      lara.click_on(PRINT_BUTTON)
      sleep(3)
      lara.switch_to_last_tab
      lara.chrome_print("pdf")
      sleep(5)
  end

  if (page_title.include?("no interactive")) || (page_title.include?("Completion") || (page_title.include?("Video")) || (page_title.include?("Sensor connector")))
    puts "Do not take snapshot"
  else
    # if page_title == "Labbook"
    #   puts "In labbook"
    #   learn.click_on(LABBOOK_SNAPSHOT_BUTTON)
    # else
      puts "before take_snapshot"
      sleep(1)
      lara.take_snapshot
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