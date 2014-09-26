module ProMotion
  class PageView < UIPageViewController
    include ScreenModule

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

    @@defaults = {}

    class << self
      @@map.keys.flatten.each do |key|
        attr_accessor key

        define_method("#{key}=") do |arg|
          value = @@map[key][arg] || arg
          instance_variable_set("@#{key}", value)
        end

        define_method("#{key}") do |*args|
          return send("#{key}=", *args) unless args.empty?
          instance_variable_get("@#{key}") || @@map[key][:default]
        end
      end

      [:options, :starting_index].each do |key|
        attr_accessor key

        define_method(key) do |*args|
          return send("@#{key}", *args) unless args.empty?
          instance_variable_get("@#{key}") || @@defaults[key]
        end
      end
    end

    def self.new(attrs = {})
      s = self.alloc

      args = [:transition, :options, :orientation, :direction].inject({}) do |hash, key|
        hash[key] = attrs.delete(key) || self.send(key) 
        hash
      end

      s.initWithTransitionStyle(args[:transition], navigationOrientation:
                                args[:orientation], options: args[:options])


      s.screen_init(attrs)
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
