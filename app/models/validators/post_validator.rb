class PostValidator < SimpleDelegator
  include ActiveModel::Validations

  validates_presence_of %i[title body author_ip author]
end