class Address
  include Mongoid::Document
  field :street
  field :city
  field :post_code
  field :country
  embedded_in :addressable, :inverse_of => :application_address
  embedded_in :addressable, :inverse_of => :job_site_address

  validates_presence_of :street,
                        :city,
                        :post_code,
                        :country
end

