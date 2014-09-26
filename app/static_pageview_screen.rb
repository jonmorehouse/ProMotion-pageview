class StaticPageView < PM::StaticPageView

  default_index :right

  left_screen Page, {nav_bar: true, title: "left"}
  middle_screen Page, {nav_bar: true, title: "middle"}
  right_screen Page, {nav_bar: true, title: "right"}

  def on_load

  end

end
