module LabInteractiveObject
  PLAY_BUTTON = {css: '.play-pause'}

  def play_interactive
    click_on(PLAY_BUTTON)
  end
end