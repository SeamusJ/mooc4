require 'spec_helper'

describe Movie do
  describe '#similar' do
    it 'should use the find method to find the movie by id'
    it 'should use the find_all_by_directory method to find similar movies'
    it 'should return the matched movies'
  end
end
