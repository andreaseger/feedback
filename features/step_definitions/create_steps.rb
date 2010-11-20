Given /(?:|I )have a "([^\"]*)" with the following:/ do |klass, table|
  table.hashes.each do |hash|
    klass.constantize.create!(hash)
  end
end

Given /(?:|I )have a "([^\"]*)" with "([^\"]*)" equals "([^\"]*)"/ do |klass, attribut, value|
  klass.constantize.create!(attribut => value)
end

