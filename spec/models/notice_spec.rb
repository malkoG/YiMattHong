require 'rails_helper'

RSpec.describe Notice, type: :model do
  describe 'association' do
    it { is_expected.to belong_to(:board) }
  end
end
