User.create!(:nds => "admin", :email => "admin@bar.com", :name => "John Doe", :firstname => "John", :lastname => "Doe", :matnr => '1111111', :roles => ["admin"])
User.create!(:nds => "student", :email => "student@bar.com", :name => "John Doe", :firstname => "John", :lastname => "Doe", :matnr => '1111111', :roles => ["student"])
i=User.create!(:nds => "intern", :email => "intern@bar.com", :name => "John Doe", :firstname => "John", :lastname => "Doe", :matnr => '1111111', :roles => ["student", "intern"])
User.create!(:nds => "extern", :email => "extern@bar.com", :name => "John Doe", :firstname => "John", :lastname => "Doe", :matnr => '1111111', :roles => ["extern"])

Factory(:full_sheet, :user => i)

