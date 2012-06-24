Given /^the following movies exist:$/ do |table|
  table.hashes.each do |movie|
    Movie.create!(movie)
  end
end

Then /^the director of "([^"]*)" should be "([^"]*)"$/ do |arg1, arg2|
  page.body.should =~ /.*<h2>Details about #{arg1}<\/h2>.*<li>\s+Director:\s+#{arg2}\s+<\/li>.*/m
end

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  page.body.should =~ /.*#{e1}.*#{e2}.*/m
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.split(", ").each do |rating|
    if uncheck=="un" then
      uncheck("ratings_#{rating}")
    else
      check("ratings_#{rating}")
    end
  end
end

Then /I should see all of the movies/ do
  page.all('table#movies tr').count.should == 11
end

Then /I should see no movies/ do
  page.all('table#movies tr').count.should == 1
end
