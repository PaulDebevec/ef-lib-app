require "rails_helper"

RSpec.describe Book, type: :model do
  describe "relationships" do
    it { is_expected.to have_many(:customer_books).dependent(:destroy) }
    it { is_expected.to have_many(:customers).through(:customer_books) }
  end

  describe ".order_by_latest" do
    it "orders by created_at desc" do
      older = create(:book, created_at: 4.days.ago)
      newer = create(:book, created_at: 2.day.ago)

      expect(Book.order_by_latest).to eq([newer, older])
    end
  end
end