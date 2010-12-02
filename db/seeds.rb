User.create!(:nds => "admin", :email => "admin@bar.com", :name => "John Doe", :firstname => "John", :lastname => "Doe", :roles => ["admin"])
User.create!(:nds => "student", :email => "student@bar.com", :name => "John Doe", :firstname => "John", :lastname => "Doe", :roles => ["student"])
User.create!(:nds => "intern", :email => "intern@bar.com", :name => "John Doe", :firstname => "John", :lastname => "Doe", :roles => ["student", "intern"])
User.create!(:nds => "extern", :email => "extern@bar.com", :name => "John Doe", :firstname => "John", :lastname => "Doe", :roles => ["extern"])

