Factory.sequence :nds, 10000 do |n|
  "abc#{n}"
end

Factory.sequence :matnr, 1000000 do |n|
  n
end


FactoryGirl.define do
  factory :user do
    nds
    matnr
  end

  factory :bob, :parent => :user do
    firstname "Bob"
    lastname "Doe"
    name {"#{firstname} #{lastname}"}
    email { "#{firstname}.#{lastname}@example.com".downcase }
  end
  factory :amy, :parent => :user do
    firstname "Amy"
    lastname "Doe"
    name {"#{firstname} #{lastname}"}
    email { "#{firstname}.#{lastname}@example.com".downcase }
    roles ["student"]
  end

  factory :student, :parent => :user do
    firstname "Student"
    lastname "Doe"
    name {"#{firstname} #{lastname}"}
    email { "#{firstname}.#{lastname}@example.com".downcase }
    roles ["student"]
  end

  factory :intern, :parent => :user do
    firstname "Intern"
    lastname "Doe"
    name {"#{firstname} #{lastname}"}
    email { "#{firstname}.#{lastname}@example.com".downcase }
    roles ["student", "intern"]
  end

  factory :extern, :parent => :user do
    firstname "extern"
    lastname "Doe"
    name {"#{firstname} #{lastname}"}
    email { "#{firstname}.#{lastname}@example.com".downcase }
    roles ["extern"]
  end

  factory :admin, :parent => :user do
    firstname "John"
    lastname "Doe"
    name {"#{firstname} #{lastname}"}
    email { "#{firstname}.#{lastname}@example.com".downcase }
    roles ["admin"]
  end
end

