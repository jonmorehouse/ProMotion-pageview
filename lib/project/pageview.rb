module ProMotion
  class PageView < UIPageViewController
    include ScreenModule

    attr_accessor :opts

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

    @@available_options = [:options, :animated, :completion, :default_index]
    @@defaults = {
      :default_index => 0,
    }

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

      @@available_options.each do |key|
        attr_accessor key

        define_method(key) do |*args|
          return instance_variable_set("@#{key}", args.first) unless args.empty?
          instance_variable_get("@#{key}") || @@defaults[key]
        end
      end
    end

    def self.new(attrs = {})
      s = self.alloc

      opts = [@@map.keys + @@defaults.keys].flatten.inject({}) do |hash, key|
        hash[key] = attrs.delete(key) || self.send(key)
        hash
      end

      s.opts = opts
      s.initWithTransitionStyle(opts[:transition], navigationOrientation: opts[:orientation], options:opts[:options])
      s.screen_init(attrs)
      s.set_screens(s.screen_for_index(opts[:default_index]))

      s
    end

    def set_screens(screen, opts = {})
      opts = @opts.merge(opts)
      setViewControllers([screen], direction: opts[:direction], animated: opts[:animated], completion: opts[:completion])
    end

    #def presentationIndexForPageViewController(pageview)
      #pageview.opts[:default_index] || 0
    #end



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
