require 'rails_helper'

RSpec.describe Wiki, type: :model do
  let(:wiki) { Wiki.create!(title: "Wiki Title", body: "wiki body", private: false, user: user) }

  describe "attributes" do
    it "has title and body attributes" do
      expect(wiki).to have_attributes(title: "Wiki Title", body: "wiki body")
    end
  end
end
