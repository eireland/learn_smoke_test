module DrawToolObject

  CANVAS = {css: '.dt-canvas-container'} #drawing-tool-container_for_22499 > div > div.dt-canvas-container > div > canvas.upper-canvas
  PENCIL = {xpath: "//div[contains(@class,'dt-btn') and contains(@title,'Free hand drawing tool')]"}
  SHAPE = {xpath: "//div[contains(@class, 'dt-btn') and contains(@title,'Basic shape tool')]"}
  DRAW_TOOL_DONE_BUTTON = {css: '.image_done_button'}
  SPINNER = {css: '.wait-for'}



  def draw_shape
    puts "In draw_on_canvas"
    wait_for { displayed? (SHAPE) }
    click_on(SHAPE)
    puts "found SHAPE"
    sleep(5)
    canvas = find (CANVAS)
    puts "Canvas is #{canvas}"
    click_on(CANVAS)
    # draw(CANVAS)
  end

  def close_draw_tool
    wait_for { displayed? (DRAW_TOOL_DONE_BUTTON)}
    click_on(DRAW_TOOL_DONE_BUTTON)
    wait_for {!displayed? (SPINNER)}
    puts "closed draw tool"
  end

end