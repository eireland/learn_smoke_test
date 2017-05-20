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

  def draw(element)
    puts "in draw"
    puts "Element is #{element}"
    click_on(element)
    puts "clicked on #{element}"
    el = find (element)
    # @@driver.action.click_and_hold(el).move_by(150,150).release(el).perform
  end

end