User.create!(:nds => "admin", :email => "admin@bar.com", :name => "Admin Doe", :firstname => "Admin", :lastname => "Doe", :roles => ["admin"])
User.create!(:nds => "student", :email => "student@bar.com", :name => "Student Doe", :firstname => "Student", :lastname => "Doe", :matnr => '2222222', :roles => ["student"])
i=User.create!(:nds => "intern", :email => "intern@bar.com", :name => "Intern Doe", :firstname => "Intern", :lastname => "Doe", :matnr => '3333333', :roles => ["student"])
s=Semester.current
s.interns << i
s.save
User.create!(:nds => "extern", :email => "extern@bar.com", :name => "Extern Doe", :firstname => "Extern", :lastname => "Doe", :roles => ["extern"])

Factory(:full_sheet, :user => i)

