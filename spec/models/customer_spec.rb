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

  describe ".count_of_books" do
    it "returns customers with seperate book counts for physical and audio" do
      customer = create(:customer, first_name: "Harry", last_name: "Dresden")
      audio = create(:audio_book)
      physical = create(:physical_book)

      create(:customer_book, customer: customer, book: audio)
      create(:customer_book, customer: customer, book: physical)

      result = Customer.count_of_books.find(customer.id)

      expect(result.total_books_count).to eq(2)
      expect(result.audio_books_count).to eq(1)
      expect(result.physical_books_count).to eq(1)
    end

    it "accounts for customers with no books" do
      customer = create(:customer, first_name: "No", last_name: "Books")

      result = Customer.count_of_books.find(customer.id)

      expect(result.total_books_count).to eq(0)
      expect(result.audio_books_count).to eq(0)
      expect(result.physical_books_count).to eq(0)
    end
  end
end
