class StaticPageView < PM::StaticPageView

  default_index :right
  show_dots true
  total_screens 5

  left_screen Page, {nav_bar: true, title: :left}
  middle_screen Page, {title: :middle}
  right_screen Page, {nav_bar: true, title: :right}

  def on_load

  end

end
