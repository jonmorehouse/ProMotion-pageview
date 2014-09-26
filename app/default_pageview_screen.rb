class DefaultPageView < PM::PageView

  def on_load

  end

  def screen_for_index(*args)
    PM::Screen.new
  end

end
