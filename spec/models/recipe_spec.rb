require File.join( File.dirname(__FILE__), '..', "spec_helper" )

describe Recipe do

  it 'should have name property' do
    @recipe = Recipe.new(:name => 'recipe name').name.should == 'recipe name'
  end

  it 'name property should not be null' do
    Recipe.new.valid?.should be_false
  end

  it 'should have difficulty property' do
    @recipe = Recipe.new(:difficulty => 0).difficulty.should == 0
  end

end
