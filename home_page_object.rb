module HomePageObject
  WELCOME_TEXT = {css: '#utility-links > p > strong'} #utility-links > p > strong
  AUX_LINKS = {css: ".aux-links > li"}
  RUN_SOLO_BUTTON ={css: 'div.run_buttons > a.solo.button'}



  def verify_auth_user(user)
    puts "In verify_auth_user"
    text = text_of(WELCOME_TEXT)
    puts "text is #{text}"
    case user
      when 'admin'
        text.include? 'Admin'
        return true
      when 'teacher'
        text.include? 'Teacher'
        return true
      when 'project'
        text.include? 'Project'
        return true
      when 'researcher'
        text.include? 'Researcher'
        return true
      when 'author'
        text.include? 'Author'
        return true
      when 'student'
        text.include? 'Student'
        return true
      else
        return false
    end
  end

  def verify_user_menu(user)
    nav_bar_list = find_all(AUX_LINKS)
    case user
      when 'admin'
        nav = ['ADMIN']
      when 'teacher'
        nav = []
      when 'project'
        nav = ['ADMIN']
      when 'researcher'
        nav = ['ADMIN']
      when 'author'
        nav = []
      when 'student'
        nav = []
      when 'itsi'
        nav = ['CAREERSIGHT','PROBESIGHT','SCHOOLOGY','ACTIVITIES']
    end

    if nav.length!=(nav_bar_list.length - 1)
      puts 'not the right number of menu items'
    end
    nav_bar_list.each do |menu_item|
      if nav.include? menu_item.text
        puts "#{menu_item.text} is correctly in the menu"
      else
        puts "#{menu_item.text} should not be in the menu"
      end
    end
  end

  def run_activity_solo
    click_on(RUN_SOLO_BUTTON)
  end
end