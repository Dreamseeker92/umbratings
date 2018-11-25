require 'dry-validation'

LoginSchema = Dry::Validation.Schema do
  required(:login).filled(:str?)
end
