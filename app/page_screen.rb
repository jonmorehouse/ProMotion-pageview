class Page < PM::Screen

  def on_load(opts = {})

    puts title
    view.backgroundColor = UIColor.blueColor

  end


end
