module ProMotion
  class DynamicPageView < PageView

    @@dynamic_options = [:cache, :cache_size, :page_delegate, :page]
    register_options @@dynamic_options
    attr_accessor :indexes, :cache

    def self.new(attrs = {})
      attrs[:option_keys] = @@dynamic_options
      s = super(attrs)
      s 
    end

    def screen_for_index(index, opts = {})

      # NOTE build screen by checking cache first
      screen = cached_screen(index, opts)
      screen = build_screen(index, opts) unless screen
      
      cache_screen(index, screen, opts)
      cleanup_cache(index)

      screen.navigationController || screen
    end

    def default_index

      index, opts = nil
      [:first_index, :first, :default, :default_index].find do |method_name|
        next if page_delegate == self and method_name == :default_index
        index, opts = page_delegate.public_send(method_name) if page_delegate.respond_to?(method_name)
      end

      [index || super, opts || {}]
    end

    def page_delegate
      @page_delegate ||= begin
        klass_or_obj = opts[:page_delegate]
        return self unless klass_or_obj
        klass_or_obj.kind_of?(Class) ? klass_or_obj.new : klass_or_obj
      end
    end

    # NOTE define previous/next methods for building screens
    [:next, :previous].each do |direction|
      define_method(direction) do |screen|
        current_index = indexes[screen.object_id]
        return unless current_index

        index, opts = get_index_from_delegate(current_index, direction)
        return unless index

        screen_for_index(index, opts)
      end
    end

    def build_screen(index, opts = {})

      klass = opts[:page] || opts[:page_klass] || self.opts[:page] || self.opts[:page_class]

      klass.new opts
    end

    def cache
      @cache ||= {}
    end

    def indexes
      @indexes ||= {}
    end

    protected
    def get_index_from_delegate(index, direction)
      if page_delegate == self or not page_delegate.respond_to?(direction)
        index = direction == :next ? index + 1 : index > 0 ? index - 1 : nil
      else
        index, opts = page_delegate.send(direction, index)
      end

      [index, opts || {}]
    end

    def cached_screen(index, opts = {})
      # NOTE check if the screen is cached
      return if opts[:no_cache] or not opts[:cache]
      return cache[index]
    end

    def cache_screen(index, screen, opts = {})
      indexes[(screen.navigationController || screen).object_id] = index

      return if opts[:no_cache] or not self.opts[:cache]
      cache[index] = screen
    end

    def cleanup_cache(index)
      return unless opts[:cache_size]
      while cache.length > opts[:cache_size]
        removal_index = cache.keys.index(index) < cache.keys.length ? cache.keys.pop : cache.keys.shift
        object_id = cache.delete(removal_index)
        indexes.delete(object_id)
      end
    end
  end
end
