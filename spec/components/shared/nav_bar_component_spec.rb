require "rails_helper"

RSpec.describe Shared::NavBarComponent, type: :component do
  it "renders navigation bar" do
    rendered_result = render_inline(described_class.new)
    expect(rendered_result.css('.nav-notices')[0].content.strip).to eq('공지사항')
    expect(rendered_result.css('.navbar-brand')[0].content.strip).to eq('YiMattHong')
  end
end
