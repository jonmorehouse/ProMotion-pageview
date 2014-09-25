module ProMotion
  class PageView < UIPageViewController
    include ScreenModule

    class << self
      [:scroll_style, :orientation, :direction].each do |attr| 
        attr_accessor "_#{attr}"

        maps = 

        define_method(attr) do |arg|
          case attr
          when :scroll_style

          when :orientation

          when :direction

          end
        end
      end



    end



    def self.new(attrs = {})
      s = self.alloc
      s.initWithTransitionStyle(self.class

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
