require "./base_object"
require './draw_tool_object'
require './lab_interactive_object'

class LARAObject < BaseObject
  include DrawToolObject
  include LabInteractiveObject


  ROOT_URL = 'https://authoring.staging.concord.org/'
  SEQUENCE_TITLE = {css: '.sequence_title'}
  ACTIVITY_TITLE = {css: '.h2'}
  PAGE_TITLE = {css: '.intro-mod>h4'}#main > div.activity-mod > div.site-width > div.intro-mod > h4
  PAGE_ICONS = {css: '.pagination-link'}
  SNAPSHOT_BUTTON = {css: '.image_snapshot_button'}
  DRAWING_BUTTON = {css: '.image_drawing_button'}
  IMAGE_DIALOG = {css: '.image-question-dialog'}
  IMAGE_DONE_BUTTON = {css: '.image_done_button'}
  SPINNER = {css: '.wait-for'}
  IFRAME = {tag_name: 'iframe'}
  LABBOOK_SNAPSHOT_BUTTON ={css: ".lb-action-btn"}
  LABBOOK_DIALOG = {css: '.lb-dialog'}
  LABBOOK_SAVE = {xpath: "//div[contains(@class,'snapshot-form')]/form/div[contains(@class,'right')]/div[contains(@class,'actions')]/input"}
  LABBOOK_CLOSE_BUTTON = {xpath: ".//div[contains(@class,'ui-dialog-titlebar')]/button[contains(@class,'ui-dialog-titlebar-close')]"}
  LABBOOK_SNAPSHOT_FORM = {css: '.snapshot-form'}
  LABBOOK_IFRAME = {css: '.labbook-content'}




  def initialize()
    puts "Initialized"
  end

  def verify_activity(title)
    puts "Activity is #{title}"
    activity_name = find(ACTIVITY_TITLE).text
    expect(activity_name).to include(title)
  end

  def verify_page_header(title)
    puts "Page title is #{title}"
    page_title = find(PAGE_TITLE).text
    puts "PAGE_TITLE text is #{page_title}"
    expect(page_title).to include(title)
  end

  def get_page_title()
    puts "In get_page_title"
    titles = find_all(PAGE_TITLE)
    if titles.length == 0
      title = "Completion Page"
    else
      title = find(PAGE_TITLE).text
    end
    puts "PAGE_TITLE is #{title}"
    return title
  end

  def get_pages
    find_all(PAGE_ICONS)
  end

  def switch_to_interactive()
    puts "In switch to interactive"
    interactive = find(IFRAME)
    switch_to_iframe(interactive)
  end

  def take_snapshot()
    wait_for{ displayed?(SNAPSHOT_BUTTON) }
    click_on(SNAPSHOT_BUTTON)
    wait_for{ displayed?(IMAGE_DIALOG) }
    switch_to_modal()
    sleep(20)
    click_on(IMAGE_DONE_BUTTON)
    wait_for {!displayed? (SPINNER)}
    sleep(20)
    puts "took snapshot"
    switch_to_main()
  end

  def take_labbook_snapshot()
    "puts in take labbook snapshot"
    wait_for{ displayed? (LABBOOK_SNAPSHOT_BUTTON) }
    click_on(LABBOOK_SNAPSHOT_BUTTON)
    wait_for{displayed? (LABBOOK_DIALOG)}
    switch_to_modal
    iframe = find(LABBOOK_IFRAME)
    puts "found iframe at #{iframe}"
    switch_to_iframe(iframe)
    sleep(30)
    # form = find(LABBOOK_SNAPSHOT_FORM)
    # puts "form is at #{form}"
    # sleep(5)
    click_on(LABBOOK_SAVE)
    sleep(20)
    switch_to_main
    click_on(LABBOOK_CLOSE_BUTTON)
    switch_to_main
  end

  def open_draw_tool
    wait_for { displayed?(DRAWING_BUTTON) }
    click_on(DRAWING_BUTTON)
    wait_for { displayed? (IMAGE_DIALOG)}
    switch_to_modal()
    sleep (8)
  end

  def draw(pencil, palette)
    puts "in draw"
    paper = find(palette)
    click_on(pencil)
    @@driver.action.move_to(paper).click.perform
    puts "do second click"
    @@driver.action.move_to(paper, 350, 250).click.perform
    sleep(1)
  end

end