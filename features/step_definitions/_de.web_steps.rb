Wenn /(?:ich )gehe auf (.+)/ do |page|
  # nutze den vorhandenen englischen Schritt
  Given %{I go to #{page}}
end

Dann /(?:|sollte ich |ich sollte )folgendes sehen:/ do |table|
  table.raw.each do |array|
    array.each do |text|
      page.should have_content(text)
    end
  end
end

Dann /(?:|sollte ich |ich sollte )"([^\"]*)" sehen/ do |text|
  page.should have_content(text)
end

Dann /zeig mir die Seite/ do
  save_and_open_page
end

