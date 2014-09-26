module ProMotion
  class StaticPageView < PageView

    # NOTE they are declared by order
    # alternatively, you can pass in indexes ...
    # you can pass in an object as well, if it needs special configuration... (not sure why you would need to though)

    def self.method_missing(method_name, *args, &block)
      # check if it matches regex ...


    end

    def screen_for_index(index)
      @screens ||= {}


    end


  end
end
