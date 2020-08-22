require 'rails_helper'

RSpec.describe Favorite, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:house) }
  it { should validate_presence_of(:user_id) }
  it { should validate_presence_of(:house_id) }

end
