describe ProMotion::DynamicPageView do

  before do
    @klass = DynamicPageView
    @default_klass = DefaultDynamicPageView
    @obj = @klass.new
    @default = @default_klass.new
  end

  describe "class dsl" do

    it "creates a delegate instance if a :page_delegate is specified" do
      @klass.cache.should.equal true
      @klass.cache_size.should.equal 5
      @klass.page_delegate.should.equal PageDelegate
      @klass.page.should.equal Page
    end

    it "passes these values onto the instance opts" do
      opts = @obj.opts
      opts.should.not.be.nil
      opts[:cache].should.equal true
      opts[:cache_size].should.equal 5
      opts[:page_delegate].should.equal PageDelegate
      opts[:page].should.equal Page
    end
  end

  describe "page creation" do

    it "lazily creates a page_delegate if a class type is passed" do
      @obj.page_delegate.should.be.kind_of PageDelegate
    end

    it "uses self if the page_delegate class is not specified" do
      @default.page_delegate.should.equal @default
    end
    
    it "uses the page_delegate to the return the correct indexes" do
      #@obj.screen_for_index(:default)
      pending
    end

  end
end
