require 'rails_helper'

RSpec.describe Board, type: :model do
  describe "association" do
    it { is_expected.to have_many(:notices) }
    it { is_expected.not_to belong_to(:curation) }
    it { is_expected.to belong_to(:curation).optional(true) }
  end
end
