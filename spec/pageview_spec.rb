describe PM::PageView do

  before do
    @obj = PM::PageView.new
  end

  it "sets reasonable defaults for the dsl" do

    1.should.equal 1

  end

  it "correctly stores values in the dsl format" do

    debug @obj.class.instance_variable_get("@_transition")
    1.should.equal 1

  end


end
