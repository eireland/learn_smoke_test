require "./base_object"
require './draw_tool_object'
require './lara_object'

class Activity4Object < BaseObject
  include (DrawToolObject)
  include (LARAObject)

  ROOT_URL = 'https://authoring.staging.concord.org/'
  ACTIVITY_TITLE = {css: '.h2'}
  PAGE_TITLE = {css: '.h4'}
  PAGE_ICONS = {css: '.pagination-link'}
  SNAPSHOT_BUTTON = {css: '.image_snapshot_button'}
  DRAWING_BUTTON = {css: '.image-drawing-button'}
  IMAGE_DIALOG = {css: '.image-question-dialog'}
  IMAGE_DONE_BUTTON = {css: '.image_done_button'}
  SPINNER = {css: '.wait-for'}


  def initialize()
    puts "Initialized"
  end

  def verify_activity(title)
    puts "Activity is #{title}"
    header = find(ACTIVITY_TITLE).text
    expect(header).to include(title)
  end

  def verify_page(title)
    puts "Page title is #{title}"
    header = find(PAGE_TITLE).text
    expect(header).to include(title)
  end

  def get_pages
    find_all(PAGE_ICONS)
  end

  # def take_snapshot(link)
  #   visit(link)
  #   wait_for{ displayed?(SNAPSHOT_BUTTON) }
  #   click_on(SNAPSHOT_BUTTON)
  #   wait_for{ displayed?(IMAGE_DIALOG) }
  #   switch_to_modal()
  #   sleep(18)
  #   click_on(IMAGE_DONE_BUTTON)
  #   wait_for {!displayed? (SPINNER)}
  # end

  def open_draw_tool
    wait_for { displayed?(DRAWING_BUTTON) }
    click_on(DRAWING_BUTTON)
    wait_for { displayed? (IMAGE_DIALOG)}
    switch_to_modal()
    sleep (8)
  end


end