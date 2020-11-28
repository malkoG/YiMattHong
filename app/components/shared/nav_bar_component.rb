# frozen_string_literal: true

module Shared
  class NavBarComponent < ViewComponent::Base
    def initialize(user: nil)
      super
      @user = user
    end
  end
end
