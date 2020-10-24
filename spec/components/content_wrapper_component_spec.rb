require "rails_helper"

RSpec.describe ContentWrapperComponent, type: :component do
  it "renders inner contents" do
    expect(
      render_inline(described_class.new(content: "value")) { "Hello, components!" }.to_html
    ).to include(
      "Hello, components!"
    )
  end
end
