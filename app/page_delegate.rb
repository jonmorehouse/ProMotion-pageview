class PageDelegate

  [:next, :previous, :default].each do |attr|
    attr_accessor "#{attr}_called"
    attr_accessor "#{attr}_value"
  end

  def default
    @default_called = true
    @default_value = 0
  end

  def next(index)
    puts "CALLED"
    @next_called = true
    @next_value = index + 1
  end

  def previous(index)
    puts "CALLED"
    @previous_called = true
    @previous_called = index > 0 ? index - 1 : nil
  end
end
