Factory.define :valid_address, :class => :address do |f|
  f.street "Ampelstrasse 23"
  f.city "Musterhausen"
  f.post_code "24113"
  f.country "Albania"
end
Factory.define :job_site_address, :class => :address do |f|
  f.street "Firmenstrasse 23"
  f.city "AHmburg"
  f.post_code "76234"
  f.country "Germany"
end
Factory.define :application_address, :class => :address do |f|
  f.street "23th Street"
  f.city "New York"
  f.post_code "73423"
  f.country "United States"
end

