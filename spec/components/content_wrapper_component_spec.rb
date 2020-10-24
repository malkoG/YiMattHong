require "rails_helper"

RSpec.describe ContentWrapperComponent, type: :component do
  it "renders inner contents" do
    render_inline(described_class.new(content: "value")) do 
      "Hello, components!"
    end

    expect(page).to have_content("Hello, components!")
  end
end
