RSpec.describe AuthorLoginValidator, type: :model do

  context 'validation' do

    it 'with valid login pass' do
      validator = AuthorLoginValidator.new(FactoryBot.build(:author))
      expect(validator).to be_valid
    end
    it 'with empty login fail' do
      validator = AuthorLoginValidator.new(FactoryBot.build(:author, login: nil ))
      expect(validator).not_to be_valid
      expect(validator.errors.messages).to include(login: [%(can't be blank)])
    end
  end

end