module ProMotion
  class StaticPageView < PageView

    def self.method_missing(method_name, obj_or_klass, opts = {})

      @screens ||= {}
      @indexes ||= []

      screen_name = String(method_name).gsub!(/_screen/, "").to_sym
      index = opts.delete(:index) || @indexes.length

      # NOTE store the information needed to produce the screen
      @screens[screen_name] ||= {}
      @screens[screen_name][obj_or_klass.kind_of?(Class) ? :klass : :object] = obj_or_klass
      @screens[screen_name][:opts] = opts unless opts.nil?

      # NOTE store required index information
      @indexes[index] = screen_name
    end

    def screen_for_index(index)

      # NOTE normalize
      index = self.class.indexes.index(index) unless index.kind_of?(Integer)
      screen_name = self.class.indexes[index]
      return if screen_name.nil?

      @screens ||= {}
      @indexes ||= {}

      opts = self.class.screens[screen_name]
      screen = @screens[screen_name] || opts[:object] || opts[:klass].new(opts[:opts])
      
      @screens[screen_name] = screen
      @indexes[screen.object_id] = index

      screen.navigationController || screen
    end

  end
end
