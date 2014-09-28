class Page < PM::Screen

  def on_load(opts = {})

    puts "CREATED"

  end

  def did_transition

    puts "did transition"
  end

  def will_transition

    puts "will transition"
  end


end
