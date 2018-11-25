PostLengthSchema = Dry::Validation.Schema do
  required(:length).filled(:int?, gt?: 0)
end