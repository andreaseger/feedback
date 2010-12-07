namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    require 'faker'
    require 'backports/1.9.2'

    [Sheet, User].each(&:delete_all)
    load "#{::Rails.root.to_s}/db/seeds.rb"

    r = Random.new(Time.now.hash)

    (r.rand(1000..5000)).times do
      firstname  = Faker::Name.first_name
      lastname   = Faker::Name.last_name
      nds        = "#{lastname[0..1]}#{firstname[0..0]}#{r.rand(10000..90000)}".downcase
      name       = "#{firstname} #{lastname}"
      email      = Faker::Internet.email(name)
      case r.rand(0..30)
      when 0..10
        roles = ['student']
      when 10..20
        roles = ['student', 'intern']
      when 20..30
        roles = ['extern']
      end

      user = User.create!(:firstname => firstname, :lastname => lastname, :nds => nds, :email => email, :name => name, :roles => roles, :created_at => r.rand(2.years.ago..Time.now))
      if user.role? :intern
        y=r.rand(1990..2020)
        semester = r.rand(0..1) == 0 ? "SS#{y}" : "WS#{y}/#{y+1}"
        Sheet.create!(
          :user => user,
          :semester           => semester,
          :company            => Faker::Company.name,
          :boss               => Faker::Name.name,
          :handler            => Faker::Name.name,
          :intership_length   => r.rand(18..22),
          :reachability       => r.rand(1..4),
          :accessibility      => r.rand(1..4),
          :working_atmosphere => r.rand(1..4),
          :satisfaction_with_support => r.rand(1..4),
          :stress_factor => r.rand(1..4),
          :apartment_market => r.rand(1..4),
          :satisfaction_with_internship => r.rand(1..4),
          :big_project => [true, false].rand,
          :independent_work => r.rand(1..4),
          :reference_to_the_study => r.rand(1..4),
          :learning_effect => r.rand(1..4),
          :required_previous_knowledge => r.rand(1..4),
          :application_address => Address.new(:street => Faker::Address.street_name, :city => Faker::Address.city, :post_code => Faker::Address.zip_code, :country => "Germany"),
          :job_site_address    => Address.new(:street => Faker::Address.street_name, :city => Faker::Address.city, :post_code => Faker::Address.zip_code, :country => "Germany"),
          :department => Faker::Lorem.sentence(r.rand(1..5)),
          :note_company => Faker::Lorem.paragraph(r.rand(3..6)),
          :extendable => [true, false].rand,
          :vacation => [true, false].rand,
          :release => [true, false].rand,
          :working_hours => r.rand(35..45),
          :flextime => [true, false].rand,
          :salary => r.rand(600..800),
          :required_languages => Faker::Lorem.sentence(r.rand(1..5)),
          :note_conditions => Faker::Lorem.paragraph(r.rand(3..6)),
          :percentage_of_women => r.rand(1..100),
          :note_personal_impression => Faker::Lorem.paragraph(r.rand(3..6)),
          :teamsize => r.rand(5..50),
          :note_project => Faker::Lorem.paragraph(r.rand(3..6)),
          :note_general => Faker::Lorem.paragraph(r.rand(5..10))   )
      end
    end
    puts "#{User.count} User und "
    puts "#{Sheet.count} Sheets generiert"
  end
end

