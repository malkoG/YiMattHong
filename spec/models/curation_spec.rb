require 'rails_helper'

RSpec.describe Curation, type: :model do
  describe "association" do
    it { is_expected.to have_many(:boards) }
  end
end
