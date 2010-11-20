class Sheet
  include Mongoid::Document

  field :semester
  field :company
  embeds_one :application_address, :class_name => "Address"
  embeds_one :job_site_address, :class_name => "Address"
  #field :address_application
  #field :job_site
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
end

