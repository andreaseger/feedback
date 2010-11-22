Factory.define :user do |f|
  f.password "secret"
  f.password_confirmation "secret"
end

Factory.define :bob, :parent => :user do |f|
  f.email "bob@foo.com"
end
Factory.define :amy, :parent => :user do |f|
  f.email "amy@foo.com"
  f.roles ["student"]
end

Factory.define :intern, :parent => :user do |f|
  f.email "intern@foo.com"
  f.roles ["student", "intern"]
end

Factory.define :prof, :parent => :user do |f|
  f.email "prof@foo.com"
  f.roles ["prof"]
end

Factory.define :admin, :parent => :user do |f|
  f.email "admin@foo.com"
  f.roles ["admin"]
end

