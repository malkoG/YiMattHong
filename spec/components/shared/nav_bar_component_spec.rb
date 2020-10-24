require "rails_helper"

RSpec.describe Shared::NavBarComponent, type: :component do
  it "renders navigation bar" do
    render_inline(described_class.new)
    expect(page).to have_css('.nav-notices', text: '공지사항')
    expect(page).to have_css('.navbar-brand', text: 'YiMattHong')
  end
end
