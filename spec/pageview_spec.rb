describe PM::PageView do

  before do
    @klass = DefaultPageView
    @obj = @klass.new
  end

  it "sets reasonable defaults for the dsl" do
    [:transition, :orientation, :direction].each do |key|
      @klass.send(key).should.equal @klass.class_variable_get("@@map")[key][:default]

    end
  end

  it "correctly stores values in the dsl format" do
    [:transition, :orientation, :direction].each do |key|
      @klass.send(key, key) 
      @klass.send(key).should.equal key
    end
  end


end
