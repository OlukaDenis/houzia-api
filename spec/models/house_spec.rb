require 'rails_helper'

RSpec.describe House, type: :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:image) }
  it { should validate_presence_of(:price) }
  it { should belong_to(:user) }
  it { should have_many(:favorites).dependent(:destroy)}
end
