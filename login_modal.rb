module LoginModalObject
  # LOGIN_MODAL = {id: 'log-in'}
  # USERNAME = {name: 'user[login]'}
  # PASSWORD = {xpath: '//*[@id="log-in"]/div[1]/form/dl/dd[2]/input'}
  # CLOSE_MODAL = {class: 'close'}
  #log-in > div.col-50.left > form > dl > dd:nth-child(2) > input

  LOGIN_MODAL = {id: 'login-default-modal'}
  LOGIN_MODAL_HEADER = {css: '#login-default-modal > div > form > h2 > strong'}
  LOGIN_SUBMIT_BUTTON = {css: '.login-default-modal-content > .signup-form > .submit_button-container > .submit-btn'}
  LOGIN_MODAL_GOOGLE_OPTION = {id: 'google'}
  LOGIN_MODAL_SCHOOLOGY_OPTION = {id: 'schoology'}
  LOGIN_MODAL_FORGOT_PASSWORD = {xpath: "#login-default-modal > div > form > div.submit-button-container > a"}
  USERNAME = {xpath: '//div[contains(@class,"text-input")]/input[contains(@type,"text")]'}
  PASSWORD = {xpath: '//div[contains(@class,"text-input")]/input[contains(@type,"password")]'}
  MODAL_CLOSE = {css: '.portal-page-close'}

  def login(username,password)
    puts "in login"
    sleep(2)
    # switch_to_active_modal
    login_modal = find(LOGIN_MODAL)
    puts ("login_modal is #{login_modal}")
    find(USERNAME)
    type(USERNAME, username)
    password_field = find(PASSWORD)
    type(PASSWORD, password)
    password_field.submit()
    sleep(4)
  end

  def close_login
    puts 'In login dialog'
    click_button('close_login')
  end

  def click_modal_button(button)
    case (button)
      when 'login'
        element = LOGIN_BUTTON
      when 'register'
        element = REGISTER_BUTTON
      when 'close_login'
        element = LOGIN_MODAL_CLOSE
      when 'close_signup'
        element = SIGNUP_MODAL_CLOSE
      when 'search'
        element = SEARCH_BUTTON
    end
    wait_for {displayed? (element)}
    click_on(element)
    # verify_element(element)
  end

end