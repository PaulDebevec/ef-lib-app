require "rails_helper"

RSpec.describe Customer, type: :model do
  describe "relationships" do
    it {should have_many(:customer_books)}
    it {should have_many(:books).through(:customer_books)}
    it {should have_many(:audio_books).through(:customer_books)}
    it {should have_many(:physical_books).through(:customer_books)}
  end

  describe "different book types" do
    it "returns only audio and physical books" do
      customer = create(:customer)
      audio    = create(:audio_book)
      physical = create(:physical_book)

      create(:customer_book, customer: customer, book: audio)
      create(:customer_book, customer: customer, book: physical)

      expect(customer.audio_books).to contain_exactly(audio)
      expect(customer.physical_books).to contain_exactly(physical)
    end
  end
end
