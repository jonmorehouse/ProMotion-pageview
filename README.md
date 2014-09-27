# ProMotion-pageview

ProMotion PageView is a gem that attempts to tackle UIPageViewControllers with ProMotion. PageViewControllers are helpful tutorials, Snapchat style interfaces and galleries of all different sorts. With ProMotion PageView's dsl you can create a static or dynamic pageview controller.

## Installation

Add this line to your application's Gemfile:

    gem 'ProMotion-pageview'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ProMotion-pageview

## Usage

### Static Usage

> A static pageviewcontroller is for pages that are not dynamically generated. A great example would be a Snapchat style interface or a tutorial.

Screens can be added through the class DSL. ProMotionPageView inflects the page name and order from the `*_screen` dsl which allows you to declare a screen with either a class and initialization attributes or an already created object.

~~~ ruby
class TutorialScreen < PM::StaticPageView
   
  intro_screen PM::Screen.new title: :home, nav_bar: true
  tutorial_1_screen PM::Screen, {title: :tutorial_1, nav_bar: true}
  tutorial_2_screen PM::Screen, {nav_bar: false}

  def on_load

  end
end
~~~




## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Todo / Pipeline

1. Tests! This started as me just hacking around and focusing on the DSL. I didn't want to dedicate much time to testing
