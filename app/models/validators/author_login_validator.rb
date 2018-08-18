class AuthorLoginValidator < SimpleDelegator
  include ActiveModel::Validations

  validates_presence_of :login

  def save
    super if valid?
  end

end