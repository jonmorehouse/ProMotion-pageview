class PageDelegate

  [:next, :previous, :default].each do |attr|
    attr_accessor "#{attr}_called"
    attr_accessor "#{attr}_value"
  end

  def default
    [5, {title: "default", nav_bar: true}]
  end

  def next(index)
    @next_called = true
    @next_value = index + 1

    [@next_value, {title: @next_value.to_s, nav_bar: true}]
  end

  def previous(index)
    @previous_called = true
    @previous_value = index > 0 ? index - 1 : nil
    [@previous_value, {title: @previous_value.to_s, nav_bar: true}]
  end
end
