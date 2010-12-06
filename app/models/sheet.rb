class Sheet
  include Mongoid::Document
  include Mongoid::Timestamps

  field :semester
  field :company
  embeds_one :application_address, :class_name => "Address"
  accepts_nested_attributes_for :application_address
  embeds_one :job_site_address, :class_name => "Address"
  accepts_nested_attributes_for :job_site_address
  field :department
  field :boss
  field :handler
  field :note_company

  field :intership_length
  field :extention, :type => Boolean
  field :vacation, :type => Boolean
  field :release, :type => Boolean
  field :working_hours, :type => Integer
  field :flextime, :type => Boolean                       #Gleitzeit - Fixzeit
  field :salary, :type => Integer
  field :speeches, :type => Array
  field :reachability, :type => Integer
  field :accessibility, :type => Integer
  field :note_conditions

  field :percentage_of_women, :type => Integer            #Prozent
  field :working_atmosphere, :type => Integer
  field :satisfaction_with_support, :type => Integer
  field :stress_factor, :type => Integer
  field :apartment_market, :type => Integer
  field :satisfaction_with_internship, :type => Integer
  field :note_personal_impression

  field :big_project, :type => Boolean                    # ein großes Projekt - mehrere kleine Projekte
  field :teamsize, :type => Integer
  field :independent_work, :type => Integer
  field :reference_to_the_study, :type => Integer
  field :learning_effect, :type => Integer
  field :required_previous_knowledge, :type => Integer

  field :note_project
  field :note_general

  referenced_in :user

  #validations
  validates_associated  :application_address,
                        :job_site_address
  validates_presence_of :semester,
                        :company,
                        :boss,
                        :handler,
                        :intership_length,
                        :reachability,
                        :accessibility,
                        :working_atmosphere,
                        :satisfaction_with_support,
                        :stress_factor,
                        :apartment_market,
                        :satisfaction_with_internship,
                        :big_project,
                        :independent_work,
                        :reference_to_the_study,
                        :learning_effect,
                        :required_previous_knowledge

  validates_each  :reachability,
                  :accessibility,
                  :working_atmosphere,
                  :satisfaction_with_support,
                  :stress_factor,
                  :apartment_market,
                  :satisfaction_with_internship,
                  :independent_work,
                  :reference_to_the_study,
                  :learning_effect,
                  :required_previous_knowledge  do |record, attr, value|
    record.errors.add attr, 'not in 1..4' unless ( value == nil || (1..4).include?(value) )
  end

  def required_languages=(value)
    unless value.nil?
      self.speeches = value.scan(/\w+|,|\./).delete_if{|t| t =~ /,|\./}
    end
  end

  def required_languages
    speeches.join(" ") if speeches
  end

  def self.search(hash)
    aa = []
    hash.each do |key, value|
      if Sheet::STEXT.include?(key)
        aa.push(Sheet.where(key.to_sym => /#{value}/i))
      elsif Sheet::SBOOLEAN.include?(key)
        aa.push(Sheet.where(key.to_sym => value))
      elsif Sheet::SNUMBER_MIN.include?(key)
        aa.push(Sheet.where(key.to_sym.gte => value))
      elsif Sheet::SNUMBER_MAX.include?(key)
        aa.push(Sheet.where(key.to_sym.lte => value))
      elsif key == "people"
        aa.push(Sheet.any_of({:handler => /#{value}/i}, {:boss => /#{value}/i}))
      end
    end
    c = all
    aa.each {|a| c.merge(a)}
    return c
  end

private
  STEXT=%w(company boss semester handler note_project note_company note_personal_impression note_conditions note_general department required_languages)
  SBOOLEAN=%w(vacation extention flextime big_project release)
  SNUMBER_MIN=%w(apartment_market satisfaction_with_support teamsize reference_to_the_study independent_work satisfaction_with_internship intership_length reachability required_previous_knowledge percentage_of_women accessibility salary learning_effect working_atmosphere)
  SNUMBER_MAX=%(working_hours stress_factor)
end

