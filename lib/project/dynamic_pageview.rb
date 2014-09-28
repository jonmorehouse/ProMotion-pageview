module ProMotion
  class DynamicPageView < PageView

    @@dynamic_options = [:cache, :cache_size, :page_delegate, :page]
    register_options @@dynamic_options

    def self.new(attrs = {})
      attrs[:option_keys] = @@dynamic_options
      s = super(attrs)
      s 
    end

    def screen_for_index(index, opts = {})

      PM::Screen.new
    end

    def default_index

      index = nil
      [:first_index, :first, :default, :default_index].find do |method_name|
        next if page_delegate == self and method_name == :default_index
        index = page_delegate.public_send(method_name) if page_delegate.respond_to?(method_name)
      end

      index || super
    end

    def page_delegate
      @page_delegate ||= begin
        klass_or_obj = opts[:page_delegate]
        return self unless klass_or_obj
        klass_or_obj.kind_of?(Class) ? klass_or_obj.new : klass_or_obj
      end

    end

    def cached_screen(index)
      # NOTE check if the screen is cached

    end

    def cleanup_cache(index)
      # NOTE keep cache within the proper size

    end

  end
end
