class User
  include Mongoid::Document
  include Mongoid::Timestamps
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  #devise :database_authenticatable,
  #       :registerable,
  #       :rememberable,
  #       :trackable,
  #       :validatable

  references_one :sheet

  field :nds
  field :firstname   #Vorname
  field :lastname    #Nachname
  field :name
  field :email
  field :matnr
  field :cached_dn

  validates_presence_of :nds, :email, :name
  validates_uniqueness_of :nds
  validates_uniqueness_of :matnr, :unless => Proc.new{self.matnr.nil?}
  validates_presence_of :matnr, :if => Proc.new{ self.role? :student}

  references_and_referenced_in_many :semesters
  field :roles, :type => Array, :default => ["extern"]

  after_create :assign_semester, :if => Proc.new{self.role? :student}

  validate :check_roles

  #scopes
  scope :with_role, lambda { |role|
    if !role.blank? && role.to_sym == :intern
      Semester.current.interns
    else
      where(:roles => /#{role}/i)
    end
  }
  scope :search, lambda {|query|
    any_of( {:name  => /#{query}/i },
            {:nds   => /#{query}/i },
            {:matnr => /#{query}/i }
            )
  }

  ROLES = %w[admin student extern]

  def role?(role)
    if role.to_sym == :intern
      Semester.current.interns.include? self
    else
      roles.include? role.to_s
    end
  end

  def dn
    if cached_dn
      return cached_dn
    else
      self.cached_dn = (Ldap.new).fetchDN(nds)
    end
  end
  def dn=(value)
    self.cached_dn = value
  end

  def self.create_with_ldap!(entry)
    user = new_with_ldap(entry)
    if user.save
      user
    else
      nil
    end
  end

  def self.new_with_ldap(entry)
    if entry.class == Net::LDAP::Entry.new.class
      u = new(  :nds => entry.cn.first,
                :dn  => entry.dn,
                :firstname => entry.urrzgivenname.first,
                :lastname => entry.urrzsurname.first,
                :name => entry.urrzfullname.first,
                :email => entry.mail.first,
                :roles => entry.dn.include?("stud") ? ["student"] : ["extern"])
      if entry.respond_to?(:urrzmatrikelid)
        u.matnr = entry.urrzmatrikelid.first
      end
      return u
    end
    new
  end

  private
  def check_roles
    #if self.role?("intern") && !self.role?("student")
    #  errors.add :roles, "a intern has to be a student too"
    #end
    if self.role?("extern") && self.role?("student")
      errors.add :roles, "a student can't be extern at the same time"
    end
    roles.each do |role|
      unless ROLES.include?(role)
        errors.add :roles, "the role #{role} was not defined"
      end
    end
  end
  
  def assign_semester
    all_semester = Semester.where(:unknown => self.matnr)
    unless all_semester == []
      all_semester.each do |semester|
        semester.unknown.delete_if{|m| m == self.matnr}
        semester.interns << self
        semester.save
      end
    end
    true
  end
end

