module Ip4Predicate
  include Dry::Logic::Predicates

  predicate(:ipv4?) do |value|
    ! /^(?:[0-9]{1,3}\.){3}[0-9]{1,3}$/.match(value).nil?
  end
end

PostSchema = Dry::Validation.Schema do
  configure do
    predicates(Ip4Predicate)

    def is_record?(klass, value)
      klass.where(id: value).any?
    end
  end

  required(:title).filled
  required(:body).filled
  required(:author_ip).filled(:str?, :ipv4?)
  required(:author_id).filled(is_record?: Author)
end