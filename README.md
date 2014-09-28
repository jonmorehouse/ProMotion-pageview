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

### Static PageView

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

#### Example
~~~ ruby
class FaceFeed < PM::DynamicPageView
  
  cache true
  cache_size 5
  page PM::Screen, {nav_bar: true}
  page_delegate PageDelegate

end
~~~

#### Page Callbacks

~~~ ruby
class FaceFeed < PM::DynamicPageView
  
  page Page
end

class Page

  def will_transition
    ... Called when the page is about to be displayed
  end

  def did_transition
    ... called right after the page is transitioned away from 
  end
end

~~~~

#### Options
###### page_delegate

By setting a page_delegate class or object, the DynamicPageView will delegate to this object to get the next/previous index. You can optionally return an attributes hash to be passed on initialize to the new page.

~~~ ruby
class DynamicPageView < PM::DynamicPageView

  page PM::Screen
  page_delegate PageDelegate

end

class PageDelegate
  
  def next(index)
    index = index + 1
    # NOTE opts will be passed to the PM::Screen.new method
    opts = {title: :next_page, nav_bar: true}
    [index, opts] 
  end

  def default_index
    5 
  end
end

~~~

###### page

The class method allows you to set screen page for new screens to be allocated with

###### cache 

Allows you to set whether or not screens will be cached internally. By default the PageViewController will cache a few screens on its internal stack, but in theory this page will cache as many screens as you like.

###### cache_size

Sets maximum length for cache 

### Global Options

###### show_dots

Sets whether or not to show presentation view on the controller. Default: ```false```

###### direction

Sets [direction](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIPageViewControllerClassReferenceClassRef/index.html#//apple_ref/c/tdef/UIPageViewControllerNavigationDirection) of paging on the UIPageViewController. Options: ```:forward, :backward, :reverse```. Default: ```:forward```

###### orientation

Sets [orientation](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIPageViewControllerClassReferenceClassRef/index.html#//apple_ref/c/tdef/UIPageViewControllerNavigationDirection) of the pageview. 
Options: ```:horizontal, :vertical ``` Default: ```:horizontal```

###### transition

Sets [transition](https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIPageViewControllerClassReferenceClassRef/index.html#//apple_ref/c/tdef/UIPageViewControllerNavigationDirection) style of the pageviewcontroller. Options: ```:page_curl, :page, :scroll```. Default: ```:scroll```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Todo / Pipeline

1. Tests! This started as me just hacking around and focusing on the DSL. I didn't want to dedicate much time to testing
