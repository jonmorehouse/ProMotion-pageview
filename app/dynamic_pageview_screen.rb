class DynamicPageView < PM::DynamicPageView

  def on_load

  end

  def screen_for_index(index)
    Page.new
  end




end
