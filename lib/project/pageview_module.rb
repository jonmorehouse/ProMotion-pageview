module ProMotion
  module PageViewModule

    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods

      def eigenclass
        class << self; self; end
      end

      # NOTE register the map based variables and their setter/getters
      def register_map(map = nil)
        map ||= self.class_variable_get("@@map")
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

      def register_options(*options)
        options = options.empty? ? self.class_variable_get("@@options") : options
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
      @pageview_screens ||= []
      @pageview_screens << screen
      setViewControllers(@pageview_screens, direction: opts[:direction], animated: opts[:animated], completion: opts[:completion])
    end

    def destination_screen_for_screen(screen, direction)

      current_index = @indexes[screen.object_id]
      return nil unless current_index

      method_name = screen_delegate.respond_to?("#{direction}_index") ? "#{direction}_index" : direction
      index = screen_delegate.send(method_name, current_index)
      return nil unless index

      screen_for_index(index)
    end

    def previous_screen(screen)
      destination_screen_for_screen(screen, :previous)
    end

    def next_screen(screen)
      destination_screen_for_screen(screen, :next)
    end

    def presentation_screen_count
      return 0 unless self.class.show_dots
      self.class.total_screens || self.class.indexes.length
    end

    def presentation_screen_index
      return @indexes[@current_index].object_id if @current_index

      convert_index(@opts[:default_index])
    end

    def will_transition(screens)
      screens.each do |screen|
        screen.will_transition if screen.respond_to?(:will_transition)
      end
    end

    def did_transition(screen)
      screen.did_transition if screen.respond_to?(:did_transition)
    end
  end
end
