RSpec.describe RatingMarkValidator, type: :model do

  context 'with valid params' do
    it 'should pass validation' do
      validator = RatingMarkValidator.new(FactoryBot.build(:rating))
      expect(validator).to be_valid
    end
  end

  context 'with invalid params' do
    it 'can not be without mark' do
      validator = RatingMarkValidator.new(FactoryBot.build(:rating, mark: nil))
      expect(validator).to_not be_valid
      expect(validator.errors.messages).to include(mark: [%(is not a number)])
    end

    it 'can not be out of range [1..5]' do
      validator_greater = RatingMarkValidator.new(FactoryBot.build(:rating, mark: 6))
      validator_less = RatingMarkValidator.new(FactoryBot.build(:rating, mark: 0))
      expect(validator_greater).to_not be_valid
      expect(validator_less).to_not be_valid
      expect(validator_greater.errors.messages).to include(mark: [%(must be less than or equal to 5)])
      expect(validator_less.errors.messages).to include(mark: [%(must be greater than or equal to 1)])
    end

    it 'can not be float' do
      validator = RatingMarkValidator.new(FactoryBot.build(:rating, mark: 4.44))
      expect(validator).to_not be_valid
      expect(validator.errors.messages).to include(mark: [%(must be an integer)])
    end
  end

end