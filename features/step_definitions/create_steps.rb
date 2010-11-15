Angenommen /(?:ich )habe einen "([^\"]*)" mit folgenden Daten:/ do |klass, table|
  table.hashes.each do |hash|
    klass.constantize.create!(hash)
  end
end

Angenommen /(?:ich )habe einen "([^\"]*)" mit "([^\"]*)" gleich "([^\"]*)"/ do |klass, attribut, value|
  klass.constantize.create!(attribut => value)
end

