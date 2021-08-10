require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validation,' do
    it { validates_presence_of :email }
    it { validates_uniqueness_of :email }
    it { validates_presence_of :password_digest }
  end
end
