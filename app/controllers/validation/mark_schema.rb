MarkSchema = Dry::Validation.Schema do
  configure do
    def is_record?(klass, value)
      klass.where(id: value).any?
    end
  end

  required(:mark).filled(:int?, gteq?: 1, lteq?: 5)
  required(:post_id).filled(is_record?: Post)
end