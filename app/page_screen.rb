class Page < PM::Screen

  def on_load(opts = {})

  end

  def did_transition

    puts "did transition"
  end

  def will_transition

    puts "will transition"
  end


end
