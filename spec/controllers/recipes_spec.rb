require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

describe Recipes  do

  before do
    @recipe = mock('recipe', :valid? => true)
    @property = mock('property')
    @property.stub!(:name).and_return(:id, :name, :level)
    Recipe.stub!(:properties).and_return([@property, @property, @property])
  end

  describe 'index action' do

    before do
      @recipe.stub!(:length)
      Recipe.stub!(:all).and_return([@recipe])
    end

    it 'should fetch all recipes' do
      Recipe.should_receive(:all).and_return([@recipe])
      dispatch_to(Recipes, :index) do |controller|
        controller.stub!(:display)
      end
    end

    it 'should display all recipes' do
      dispatch_to(Recipes, :index) do |controller|
        controller.should_receive(:display)
      end
    end

  end

  describe 'create action' do

    before do
      @recipe.stub!(:save)
      Recipe.stub!(:new).and_return(@recipe)
    end

    it 'should create a new record' do
      @recipe = mock('recipe', :save => true)
      Recipe.should_receive(:new).with('name' => 'New recipe', 'level' => 'medium').and_return(@recipe)
      dispatch_to(Recipes, :create, :name => 'New recipe', :level => 'medium') do |controller|
        controller.stub!(:display)
      end
    end

    it 'should respond with success if validation succeeds' do
      @recipe = mock('recipe', :save => true)
      Recipe.stub!(:new).and_return(@recipe)
      dispatch_to(Recipes, :create) do |controller|
        controller.should_receive(:display).with(:success => true)
      end
    end

    it 'should respond with an error json message if validation fails' do
      @recipe = mock('recipe', :save => false)
      @recipe.stub!(:errors).and_return({:name => ['error msg']})
      Recipe.stub!(:new).and_return(@recipe)
      dispatch_to(Recipes, :create, :format => :json).body.should == { 
        :success => false, :errors => [{:id => 'name', :msg => ['error msg']}] 
      }.to_json
    end

  end

  describe 'update action' do

    it 'should update the given record' do
      @recipe.should_receive(:update_attributes).with('name' => 'updated name').and_return(true)
      Recipe.should_receive(:get!).with('1').and_return(@recipe)
      dispatch_to(Recipes, :update, :id => '1', :name => 'updated name') do |controller|
        controller.stub!(:display)
      end
    end

    it 'when validation succeeds should return a json object containing success message' do
      @recipe.stub!(:update_attributes).and_return(true)
      Recipe.stub!(:get!).and_return(@recipe)
      dispatch_to(Recipes, :update, :format => :json).body.should == { :success => true }.to_json
    end

    it 'when validation fails should return a json object with field/error messages' do
      @recipe.stub!(:update_attributes).and_return(false)
      Recipe.stub!(:get!).and_return(@recipe)
      @recipe.stub!(:errors).and_return({:name => ['error msg']})
      dispatch_to(Recipes, :update, :format => :json).body.should == { 
        :success => false, :errors => [{:id => 'name', :msg => ['error msg']}] 
      }.to_json
    end

  end

  describe 'delete action' do

    it 'should delete the given record' do
      Recipe.should_receive(:get!).with('1').and_return(@recipe)
      @recipe.should_receive(:destroy)
      dispatch_to(Recipes, :delete, :id => '1') do |controller|
        controller.stub!(:display)
      end
    end

  end

end
