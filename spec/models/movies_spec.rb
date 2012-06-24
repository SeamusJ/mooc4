require 'spec_helper'

describe Movie do
  describe '#similar' do
    it 'should use the find_all_by_director method to find similar movies' do
      fake_matches = [mock('movie1'), mock("movies2")]
      Movie.should_receive(:find_all_by_director).with("sumbody!").and_return(fake_matches)
      Movie.similar("sumbody!")
    end
    it 'should return the matched movies' do
      fake_matches = [mock('movie1'), mock("movies2")]
      Movie.stub(:find_all_by_director).with("sumbody!").and_return(fake_matches)
      Movie.similar("sumbody!").should == fake_matches
    end
  end
end
