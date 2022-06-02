class ContactSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :birthdate#, :author

  belongs_to :kind do
    link(:related) { contact_kind_url(object.id) }
  end

  belongs_to :phones do
    link(:related) { contact_phones_url(object.id) }
  end

  belongs_to :address do
    link(:related) { contact_address_url(object.id) }
  end

  has_many :phones
  has_one :address

  # link(:self) { contact_url(object.id) }
  # link(:kind) { kind_url(object.kind.id) }
  
  # def author
  #   "Danilo Isidoro"
  # end

  meta do 
    { author: "Danilo Isidoro" }
  end

  def attributes(*args)
    h = super(*args)
    # pt-BR ----> h[:birthdate] = (I18n.l(object.birthdate) unless object.birthdate.blank?)
    h[:birthdate] = object.birthdate.to_time.iso8601 unless object.birthdate.blank?
    h
  end
end
