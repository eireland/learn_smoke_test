require 'selenium-webdriver'
require 'rspec/expectations'
include RSpec::Matchers

class BaseObject

  def setup_one(browser)
    @@driver = Selenium::WebDriver.for browser
  end

  def teardown
    @@driver.quit
  end

  def manage_window_size
    target_size = Selenium::WebDriver::Dimension.new(1680,1050)
    @@driver.manage.window.size = target_size
  end

  def visit(url='/')
    @@driver.get(url)
    manage_window_size
  end

  def verify_page(title)
    puts "Page title is #{@@driver.title}"
    expect(@@driver.title).to include(title)
  end

  def find(locator)
    @@driver.find_element locator
  end

  def find_all(locator)
    @@driver.find_elements locator
  end

  def clear(locator)
    find(locator).clear
  end

  def type(locator, input)
    find(locator).send_keys input
  end

  def click_on(locator)
    find(locator).click
  end

  def click_with_offset(locator,xoffset, yoffset)
    puts "in click with offset"
    element = find(locator)
    @@driver.action.move_to(element, xoffset, yoffset).click.perform
  end

  def click_hold(locator,duration)
    element = @@driver.find(locator)
    @@driver.action.click_and_hold(element).perform
    sleep(duration)
    @@driver.action.release(element).perform
  end

  def displayed?(locator)
    @@driver.find_element(locator).displayed?
    true
  rescue Selenium::WebDriver::Error::NoSuchElementError
    false
  end

  def text_of(locator)
    find(locator).text
  end

  def title
    @@driver.title
  end

  def wait_for(seconds=25)
    Selenium::WebDriver::Wait.new(:timeout => seconds).until { yield }
  end

  def switch_to_main()
    @@driver.switch_to.default_content()
  end

  def switch_to_alert()
    @@driver.switch_to.alert()
  end

  def switch_to_modal()
    @@driver.switch_to.active_element()
  end

  def switch_to_iframe(locator)
    @@driver.switch_to.frame(locator)
  end

  def get_tab_handles
    return @@driver.window_handles
  end

  def switch_to_tab(handle)
    puts "in switch to tab"
    @@driver.switch_to.window(handle)
  end

  def switch_to_first_tab()
    puts "in switch to first tab"
    @@driver.switch_to.window(@@driver.window_handles.first)
    window_handle = @@driver.window_handles.first
    return window_handle
  end

  def switch_to_last_tab()
    puts "in switch to last tab"
    # @@driver.action.send_keys(:control + :tab).perform
    @@driver.switch_to.window(@@driver.window_handles.last)
    window_handle = @@driver.window_handles.last
    return window_handle
  end

  def close_tab(handle)
    puts "in close tab"
    @@driver.switch_to.window(handle)
    @@driver.close
  end


  def switch_to_last_window()
    @@driver.switch_to.window(@@driver.window_handles.last)
  end

  def select_menu_item(menu, menu_item)
    puts 'in select_menu_item'
    find(menu)
    wait_for {displayed? (menu_item)}
  end

  def select_from_dropdown(dropdown, dropdown_locator, item)
    puts "In select from dropdown"
    dropdown_loc = find(dropdown)
    puts "Found dropdown_loc at #{dropdown_loc}"
    click_on(dropdown)
    sleep(3)
    list_item = {xpath: "#{dropdown_locator}ul/li/a[contains(text(),'#{item}')]"}#templatePulldown>span>ul>li
    click_on(list_item)
  end

  def get_link(page_locator)
    return page_locator.attribute('href')
  end

  def drag_and_drop(element)
    @@driver.action.drag_and_drop_by(element, 100, 50).perform
  end

  def chrome_print(type)
    print_save_button =  {css: '#print-header > div > button.print.default'}
    change_destination = {css: '#destination-settings > div.right-column > button'}
    pdf = {xpath: '//ul/li/span/span[contains(@title,"Save as PDF")]'}

    case (type)
      when "pdf"
        destination = pdf
    end
    switch_to_last_window
    click_on(change_destination)
    sleep(2)
    click_on(destination)
    click_on(print_save_button)
    sleep(1)
    keys = 'return'
    system('osascript -e \'tell application "System Events" to keystroke ' + keys + "'")
  end
end