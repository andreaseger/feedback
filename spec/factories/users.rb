Factory.define :bob, :class => :user do |f|
  f.email "bob@foo.com"
  f.password "secret"
  f.password_confirmation "secret"
end

Factory.define :amy, :class => :user do |f|
  f.email "amy@foo.com"
  f.password "secret"
  f.password_confirmation "secret"
end

Factory.define :intern, :parent => :bob do |f|
  f.roles ["student", "intern"]
end

Factory.define :prof, :parent => :bob do |f|
  f.roles ["prof"]
end

Factory.define :admin, :parent => :bob do |f|
  f.roles ["admin"]
end

