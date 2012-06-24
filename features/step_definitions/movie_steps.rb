Given /^the following movies exist:$/ do |table|
  table.hashes.each do |movie|
    Movie.create!(movie)
  end
end

Then /^the director of "([^"]*)" should be "([^"]*)"$/ do |arg1, arg2|
  page.body.should =~ /.*<h2>Details about #{arg1}<\/h2>.*<li>\s+Director:\s+#{arg2}\s+<\/li>.*/m
end

