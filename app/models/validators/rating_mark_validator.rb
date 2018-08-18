class RatingMarkValidator < SimpleDelegator
  include ActiveModel::Validations

  validates_numericality_of :mark,
                            only_integer: true,
                            greater_than_or_equal_to: 1,
                            less_than_or_equal_to: 5

end