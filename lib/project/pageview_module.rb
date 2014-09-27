module ProMotion
  module PageViewModule

    def self.included(base)
      base.extend(ClassMethods)
      base.extend(InstanceMethods)
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

      def register_options(options = nil)
        options ||= self.class_variable_get("@@options")
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

      def register_store
        [:indexes, :screens].each do |attr|
          eigenclass.class_eval { attr_accessor attr }
        end
        @index = []
        @screens = {}
      end
    end

    module InstanceMethods

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

    end
  end
end

