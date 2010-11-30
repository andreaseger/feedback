class User
  include Mongoid::Document
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :rememberable,
         :trackable,
         :database_authenticatable
         #:registerable,
         #:validatable

  references_one :sheet

  #weiß noch nicht was ich alles aus LDAP bekommen
  field :nds
  field :firstname   #Vorname
  field :lastname    #Nachname

  validates_presence_of :nds
  validates_uniqueness_of :nds

  #field :roles_mask, :type => Integer, :default => 2
  field :roles, :type => Array, :default => ["student"]
  validate :check_roles

  ROLES = %w[admin student intern prof]

  def role?(role)
    roles.include? role.to_s
  end
  def self.with_role(role)
    where(:roles => /#{role}/i)
  end

  def fullname
    [firstname , lastname].join(" ")
  end

  def self.find_for_ldap(params)
    nds = params[:nds]
    password = params[:password]
    if user = User.authenticate_or_create(nds, password)
      return user
    else
      return User.new
    end
  end

  private
  def check_roles
    if self.role?("intern") && !self.role?("student")
      errors.add :roles, "a intern has to be a student too"
    end
    if self.role?("prof") && self.role?("student")
      errors.add :roles, "a student can't be prof at the same time'"
    end
  end

  # put in a config file
  LDAPBASE = 'foo'
  LDAPSERVER = 'bar'

  def self.authenticate_or_create(nds, password)

    if (password.empty?) then
      return nil
    end

    ldap = Net::LDAP.new(:host => LDAPSERVER, :port => 389)
    filter = Net::LDAP::Filter.eq( "cn", nds )
    results = ldap.search(:base => LDAPBASE, :filter => filter, :return_result => true)
    if results.count != 1
      return nil
    else
      ldap = Net::LDAP.new(:host => LDAPSERVER, :port => 636, :base => LDAPBASE, :encryption => :simple_tls)
      result = results[0]
      dn = result.dn
      ldap.auth(dn, password)
      if ldap.bind
        # authentication succeeded
          user = User.where(:nds => nds).first
          if user
            # existing user found
            return user
          else
            #find the initial user roles
            uid = result.ndsuid[0].to_i
            if (!dn.include?("stud") && (uid >= 38000 && uid < 40000))
              # supervisor, kA ob ich das irgendwie genauer bekomme
              # der gemeine Prof darf ja eh nix machen
              roles = ["prof"]
            else
              # student
              roles = ["student"]
            end
            user = User.new(:nds => nds,
                            :email => result.mail,
                            :firstname => result.urrzgivenname,
                            :lastname => result.urrzsurname,
                            :roles => roles)
            if user.save
              return user
            else
              return nil
            end
          end
      else
        # authentication failed
        return nil
      end
    end
  end

end

