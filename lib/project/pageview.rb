module ProMotion
  class PageView < UIPageViewController
    include ScreenModule
    include PageViewModule

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

    @@available_options = [:options, :animated, :completion, :default_index, :show_dots, :total_screens]
    @@defaults = {
      :default_index => 0,
    }

    def self.eigenclass
      class << self; self; end
    end

    # NOTE register the map based variables and their setter/getters
    def self.register_map(map)
      eigenclass.class_eval do
        map.keys.each do |key|
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
      end
    end

    def self.register_options(options)
      eigenclass.class_eval do
        options.each do |key|
          attr_accessor key

          define_method(key) do |*args|
            return instance_variable_set("@#{key}", args.first) unless args.empty?
            instance_variable_get("@#{key}") || @@defaults[key]
          end
        end
      end
    end

    def self.register_store
      [:indexes, :screens].each do |attr|
        eigenclass.class_eval { attr_accessor attr }
      end
      @index = []
      @screens = {}
    end

    register_options(@@available_options)
    register_map(@@map)
    register_store


    def self.new(attrs = {})
      s = self.alloc

      opts = [@@map.keys + @@available_options].flatten.inject({}) do |hash, key|
        value = attrs.delete(key) || self.send(key)
        hash[key] = value unless value.nil?
        hash
      end

      s.opts = opts
      s.screen_init(attrs)
      s.initWithTransitionStyle(opts[:transition], navigationOrientation: opts[:orientation], options:opts[:options])
      s.set_screens(s.screen_for_index(opts[:default_index]))
      s.dataSource = s
      s.delegate = s

      s
    end

    def presentationCountForPageViewController(pageview)
      return 0 unless self.class.show_dots
      self.class.total_screens || self.class.indexes.length
    end

    def presentationIndexForPageViewController(pageview)
      return @indexes[@current_index].object_id if @current_index

      convert_index(@opts[:default_index])
    end

    def go_to_index(index, opts = {})
      set_screens(screen_for_index(index), opts)
    end

    def convert_index(index)
      return index if index.kind_of?(Integer)

      self.respond_to?(:integer_from_index) ? integer_from_index(index) : self.class.indexes.index(index)
    end

    def set_screens(screen, opts = {})
      opts = @opts.merge(opts)
      setViewControllers([screen], direction: opts[:direction], animated: opts[:animated], completion: opts[:completion])
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
