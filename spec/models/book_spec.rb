require "rails_helper"

RSpec.describe Book, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:author) }
    it { is_expected.to validate_presence_of(:category) }
    it { is_expected.to validate_presence_of(:isbn) }
  end
  
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

  describe ".import" do
    let(:file_path) { Rails.root.join("spec/fixtures/files/books.csv") }
    let(:file_double) { double("file", path: file_path) }

    it "creates books from the CSV" do
      expect { Book.import(file_double) }.to change(Book, :count).by(2)

      expect(Book.find_by(isbn: "978045146")&.title).to eq("The Dresden Files: Ghost Story")
    end

    it "updates existing books with the same isbn" do
      existing = Book.create!(
        title: "Duplicate",
        author: "ISBN",
        category: "Test",
        isbn: "978884526",
        type: "PhysicalBook"
      )

      Book.import(file_double)
      existing = Book.find(existing.id)
      expect(existing.title).to eq("The Fellowship of the Ring")
      expect(existing.author).to eq("J. R. R. Tolkien")
      expect(existing.category).to eq("Fantasy")
      expect(existing.type).to eq("PhysicalBook")
    end

    it "returns silently when file is nil" do
      expect { Book.import(nil) }.not_to raise_error
    end
  end
end