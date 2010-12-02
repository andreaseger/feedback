Factory.sequence :nds, 10000 do |n|
  "abc#{n}"
end

FactoryGirl.define do
  factory :user do
    #password "secret"
    #password_confirmation "secret"
    nds
  end

  factory :bob, :parent => :user do
    firstname "Bob"
    lastname "Doe"
    name {"#{firstname} #{lastname}"}
    email { "#{firstname}.#{lastname}@example.com".downcase }
    nds
  end
  factory :amy, :parent => :user do
    firstname "Amy"
    lastname "Doe"
    name {"#{firstname} #{lastname}"}
    email { "#{firstname}.#{lastname}@example.com".downcase }
    roles ["student"]
    nds
  end

  factory :student, :parent => :user do
    firstname "Student"
    lastname "Doe"
    name {"#{firstname} #{lastname}"}
    email { "#{firstname}.#{lastname}@example.com".downcase }
    roles ["student"]
    nds
  end

  factory :intern, :parent => :user do
    firstname "Intern"
    lastname "Doe"
    name {"#{firstname} #{lastname}"}
    email { "#{firstname}.#{lastname}@example.com".downcase }
    roles ["student", "intern"]
    nds
  end

  factory :prof, :parent => :user do
    firstname "Prof"
    lastname "Doe"
    name {"#{firstname} #{lastname}"}
    email { "#{firstname}.#{lastname}@example.com".downcase }
    roles ["prof"]
    nds
  end

  factory :admin, :parent => :user do
    firstname "John"
    lastname "Doe"
    name {"#{firstname} #{lastname}"}
    email { "#{firstname}.#{lastname}@example.com".downcase }
    roles ["admin"]
    nds
  end
end

