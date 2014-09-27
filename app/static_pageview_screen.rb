class StaticPageView < PM::StaticPageView

  default_index :middle
  show_dots true

  left_screen Page, {nav_bar: true, title: :left}
  middle_screen Page, {title: :middle}
  right_screen Page, {nav_bar: true, title: :right}

  def on_load

  end

end
