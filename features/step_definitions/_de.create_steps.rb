Angenommen /(?:ich )habe einen "Feedbackbogen" mit folgenden Daten:/ do |table|
  table.hashes.each do |hash|
    Sheet.create!(hash)
  end
end

