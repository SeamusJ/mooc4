require 'spec_helper'

describe MoviesController do
  describe '#similar' do
    before :each do
      @fake_results = [mock('movie1'), mock('movie2')]
    end
    it 'should call the model method that finds movies by field' do
      Movie.should_receive(:similar).with("1").and_return(@fake_results)
      post :similar, {:id => 1}
    end 
    it 'should select the similar movies template for rendering' do
      Movie.stub(:similar).and_return(@fake_results)
      post :similar, {:id => 1}
      response.should render_template('similar')
    end
    it 'should make the matched movies available to that template' do
      Movie.stub(:similar).and_return(@fake_results)
      post :similar, {:id => 1}
      assigns(:movies).should == @fake_results
    end
  end
end
