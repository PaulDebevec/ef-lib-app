require "rails_helper"

RSpec.describe Book, type: :model do
  describe "scopes" do
    it "returns pending books" do
      pending_book   = create(:book, status: "pending")
      delivered_book = create(:book, status: "delivered")

      expect(Book.pending).to include(pending_book)
      expect(Book.pending).not_to include(delivered_book)
    end
  end
end