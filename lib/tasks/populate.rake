namespace :db do
  desc "Erase and fill database, only tested under ree"
  task :populate => :environment do
    require 'faker'
    # for some reasons faker does only work with :en as local
    I18n.locale = :en
    # gets the better Random Method from 1.9.2 for REE
    require 'backports/1.9.2'
    
    [Sheet, User, Semester].each(&:delete_all)
    load "#{::Rails.root.to_s}/db/seeds.rb"
    r = Random.new(Time.now.hash)
    mat_count = 2005000

    (r.rand(3000..3500)).times do
      mat_count += 1
      firstname  = Faker::Name.first_name
      lastname   = Faker::Name.last_name
      nds        = "#{lastname[0..1]}#{firstname[0..0]}#{r.rand(10000..90000)}".downcase
      name       = "#{firstname} #{lastname}"
      email      = Faker::Internet.email(name)
      case r.rand(0..4)
      when 0..3
        roles = ['student']
        matnr = mat_count
      when 4
        roles = ['extern']
      end

      semester = Semester.find_or_create_by(:year => r.rand(1990..2011), :ws => [true, false].rand)

      user = User.create!(:firstname => firstname, :lastname => lastname, :nds => nds, :matnr => matnr, :email => email, :name => name, :roles => roles, :created_at => r.rand(2.years.ago..Time.now))
      if user.role?(:student) && r.rand(0..6) < 3
        s=Sheet.create!(
          :user => user,
          :semester           => semester,
          :company            => Faker::Company.name,
          :boss               => Faker::Name.name,
          :handler            => Faker::Name.name,
          :internship_length   => r.rand(18..22),
          :reachability       => r.rand(1..4),
          :accessability      => r.rand(1..4),
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
        user.semesters << semester
      end
    end
    puts "#{User.count} User und "
    puts "#{Sheet.count} Sheets generiert"
  end
end

