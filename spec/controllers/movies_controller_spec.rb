require 'spec_helper'

describe MoviesController do
  describe '#similar' do
    fixtures :movies

    before :each do
      @fake_results = [mock('movie1'), mock('movie2')]
      @milk_movie = movies(:milk_movie)
      @superbad = movies(:superbad)
    end

    it 'should call the model method find to get the movie by id' do
      Movie.should_receive(:find).with("1").and_return(@milk_movie)
      post :similar, {:id => @milk_movie.id}
    end

    it 'should call the model method that finds movies by director' do
      Movie.should_receive(:similar).with("sumbody!").and_return(@fake_results)
      post :similar, {:id => @milk_movie.id}
    end

    it 'should not call the Movie#similar method if the movie has no director' do
      Movie.should_not_receive(:similar)
      post :similar, {:id => @superbad.id}
    end

    it 'should set flash[:notice] with a msg if director is nil' do
      post :similar, {:id => @superbad.id}
      flash[:notice].should == "'#{@superbad.title}' has no director info"
    end

    it 'should redirect to the home page if director is nil' do
      post :similar, {:id => @superbad.id}
      response.should redirect_to(movies_path)
    end

    it 'should select the similar movies template for rendering' do
      Movie.stub(:similar).and_return(@fake_results)
      post :similar, {:id => @milk_movie.id}
      response.should render_template('similar')
    end

    it 'should make the matched movies available to that template' do
      Movie.stub(:similar).and_return(@fake_results)
      post :similar, {:id => @milk_movie.id}
      assigns(:movies).should == @fake_results
    end
  end
end
