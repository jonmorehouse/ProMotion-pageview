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

### Dynamic PageView

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

### Dynamic PageView

> A dynamic pageview allows you to set a delegate for generating indexes for new pages. Caching can be enabled for immutable indexes (ie: where index 0 always corresponds to the same page). Your index has the option of attaching other information for the creation of pages

~~~ ruby
class FaceFeed < PM::DynamicPageView
  
  cache_size 5
  page PM::Screen, {nav_bar: true}

  def next(index)
    index + 1
  end

  def previous(index)
    return nil unless index > 0
    index - 1
  end

end
~~~

~~~ ruby
class FeedModel
  
  def next(index)
    ...
  end

  def previous(index)
    ...
  end

  def screen_with_index(index, attrs = {})
    # you can use this is you have specific needs for your screen
    ...
  end
end

class Feed < PM::DynamicPageView

  page_delegate FeedModel # you can pass an object here as well if you don't want it created lazily
  page PM::Screen 

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
