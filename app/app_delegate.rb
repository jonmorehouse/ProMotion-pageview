class AppDelegate < PM::Delegate

  def on_load(app, options)

    open StaticPageView.new
  end

end
