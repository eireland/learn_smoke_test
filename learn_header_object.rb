module LearnHeaderObject
  LOGOUT = {xpath: "//li[contains(@class,'portal-pages-main-nav-item')]/a[contains(@title,'Log Out')]"}
  LOGOUT_SUCCESS = {xpath: '//div[(@class="flash notice") and contains(text(),"Signed out successfully")]'}

  LOGIN_BUTTON = {css: '.portal-pages-main-nav-item > .log-in'}
  REGISTER_BUTTON = {css: '.portal-pages-main-nav-item > .register'}
  COLLECTION_LINK = {css: '.portal-pages-main-nav-collections'}
  ABOUT_LINK = {css: '.portal-pages-main-nav-about'}
  SRF_HOME_LINK = {css: '.concord-logo'}
  HOME_BUTTON = {xpath: "//li[contains(@class,'portal-pages-main-nav-item')]/a[contains(@title,'View Recent Activity')]"}

  SRF_HEADER = {xpath: '//h1[contains(text(),"Interactive STEM activities")]'}

  def logout
    click_on(LOGOUT)
    sign_out = find(LOGOUT_SUCCESS)
    wait_for {displayed? LOGOUT_SUCCESS}
    if displayed? LOGOUT_SUCCESS
      puts "Sign out successful"
    else
      puts "Sign out did not happen"
    end
  end

  def click_link(link)
    case (link)
      when "collection"
        element = COLLECTION_LINK
      when "about"
        element = ABOUT_LINK
      when "logo"
        element = SRF_HOME_LINK
    end
    wait_for {displayed? (element)}
    click_on(element)
  end

  def click_button(button)
    case (button)
      when 'login'
        element = LOGIN_BUTTON
      when 'register'
        element = REGISTER_BUTTON
      when 'search'
        element = SEARCH_BUTTON
    end
    wait_for {displayed? (element)}
    click_on(element)
    # verify_element(element)
  end

end