RSpec.describe Rating, type: :model do
  it { should belong_to(:post).counter_cache(true) }
end
