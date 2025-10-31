require "rails_helper"

RSpec.describe CustomerBook, type: :model do
  describe "relationships" do
    it { is_expected.to belong_to(:customer) }
    it { is_expected.to belong_to(:book) }
  end

  describe "defaults" do
    it "defaults status to 'checked out'" do
      customer_book = create(:customer_book)
      expect(customer_book.status).to eq("checked out")
    end
  end
end
