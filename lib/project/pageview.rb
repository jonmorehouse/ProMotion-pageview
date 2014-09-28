module ProMotion
  class PageView < UIPageViewController
    include ScreenModule
    include PageViewDelegatesModule
    include PageViewModule

    attr_accessor :opts
    attr_accessor :screen_delegate
        
    # NOTE declare settings / defaults for the three settings needed to configure pageview
    @@map = {
      :transition => {
        :default => UIPageViewControllerTransitionStyleScroll,
        :page_curl => UIPageViewControllerTransitionStylePageCurl,
        :page => UIPageViewControllerTransitionStylePageCurl,
        :scroll => UIPageViewControllerTransitionStyleScroll
      },
      :orientation => {
        :default => UIPageViewControllerNavigationOrientationHorizontal,
        :horizontal => UIPageViewControllerNavigationOrientationHorizontal,
        :vertical => UIPageViewControllerNavigationOrientationVertical,
      },
      :direction => {
        :default => UIPageViewControllerNavigationDirectionForward,
        :forward => UIPageViewControllerNavigationDirectionForward,
        :backward => UIPageViewControllerNavigationDirectionReverse,
        :reverse => UIPageViewControllerNavigationDirectionReverse
      }
    }

    @@options = [:options, :animated, :completion, :default_index, :show_dots, :total_screens]
    @@defaults = {
      :default_index => 0,
    }

    class << self
      attr_accessor :indexes
      attr_accessor :screens
    end

    # NOTE set up class
    register_options
    register_map

    def self.new(attrs = {})
      s = self.alloc

      opts = [@@map.keys + @@options].flatten.inject({}) do |hash, key|
        value = attrs.delete(key) || self.send(key)
        hash[key] = value unless value.nil?
        hash
      end

      s.opts = opts
      s.initWithTransitionStyle(opts[:transition], navigationOrientation: opts[:orientation], options:opts[:options])
      s.set_screens(s.screen_for_index(opts[:default_index]))
      s.screen_init(attrs)
      s.screen_delegate = opts[:screen_delegate] || s
      s.dataSource = s
      s.delegate = s

      s
    end

    def loadView
      self.respond_to?(:load_view) ? self.load_view : super
    end

    def viewDidLoad
      super
      self.view_did_load if self.respond_to?(:view_did_load)
    end

    def viewWillAppear(animated)
      super
      self.view_will_appear(animated) if self.respond_to?("view_will_appear:")
    end

    def viewDidAppear(animated)
      super
      self.view_did_appear(animated) if self.respond_to?("view_did_appear:")
    end

    def viewWillDisappear(animated)
      self.view_will_disappear(animated) if self.respond_to?("view_will_disappear:")
      super
    end

    def viewDidDisappear(animated)
      self.view_did_disappear(animated) if self.respond_to?("view_did_disappear:")
      super
    end

    def shouldAutorotateToInterfaceOrientation(orientation)
      self.should_rotate(orientation)
    end

    def shouldAutorotate
      self.should_autorotate
    end

    def willRotateToInterfaceOrientation(orientation, duration:duration)
      self.will_rotate(orientation, duration)
    end

    def didRotateFromInterfaceOrientation(orientation)
      self.on_rotate
    end
  end
end
