class Page < PM::Screen

  def on_load(opts = {})

    puts "LOADED"
    view.backgroundColor = UIColor.blueColor

  end


end
