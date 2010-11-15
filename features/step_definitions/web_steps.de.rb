Wenn /(?:ich )gehe auf (.+)/ do |page|
  # nutze den vorhandenen englischen Schritt
  Given %{I go to #{page}}
end

Dann /(?:|sollte ich |ich sollte )folgendes sehen:/ do |table|
  table.raw.each do |text|
    page.should have_content(text)
  end
end

Dann /(?:|sollte ich |ich sollte )"([^\"]*)" sehen/ do |text|
  page.should have_content(text)
end

