class Page < PM::Screen

  def on_load(opts = {})

    puts title
    puts nav_bar?
    #view.backgroundColor = UIColor.blueColor

  end


end
