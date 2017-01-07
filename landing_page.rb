require "./base_object"

class LandingPageObject < BaseObject
  LOGIN_BUTTON = {css: "#accounts > a:nth-child(2)"}
  LOGIN_USERNAME = {name: "user[login]"}
  LOGIN_PASSWORD = {name: "user[password]"}
  ADVANCE_SEARCH_LINK = {id: 'advanced-search-link'}


  def initialize()
    puts "Initialized"
  end

  def login
    click_on(LOGIN_BUTTON)
    type(LOGIN_USERNAME, "btorres")
    type(LOGIN_PASSWORD,"voyager")
  end

  def goto_advance_search
    click_on(ADVANCE_SEARCH_LINK)
  end
end