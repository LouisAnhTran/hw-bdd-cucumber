# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
    movie=Movie.create(title: movie[:title],rating: movie[:rating],release_date: movie[:release_date])
  end
#   fail "Unimplemented"
end

Then /(.*) seed movies should exist/ do | n_seeds |
  Movie.count.should be n_seeds.to_i
end

# Make sure that one string (regexp) occurs before or after another one
#   on the same page

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  expect(page.body.index(e1)).to be < page.body.index(e2) 
#   fail "Unimplemented"
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
  rating_list.split(/,\s*/).each do |rating|
    field = "ratings_#{rating}"
    if uncheck
      uncheck(field)
    else
      check(field)
    end
  end
end

Then /I should see all the movies/ do 
  # Make sure that all the movies in the app are visible in the table
  expected_number_movies = Movie.count # should be equal to 10
  actual_number_movies = page.all('tr').count - 1  # Subtract 1 to exclude the table header
  expect(actual_number_movies).to eq(expected_number_movies)
#   fail "Unimplemented"
end

