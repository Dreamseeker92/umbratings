RSpec.describe Author, type: :model do
  it { should have_many(:posts) }
end
