class AppDelegate < PM::Delegate

  def on_load(app, options)


    open DynamicPageView.new
    true
  end

end
