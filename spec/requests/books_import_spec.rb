require "rails_helper"

RSpec.describe "Books import", type: :request do
  let(:csv_path)  { Rails.root.join("spec/fixtures/files/books.csv") }
  let(:txt_path)  { Rails.root.join("spec/fixtures/files/fake.txt") }

  it "imports books from a CSV upload" do
    file = fixture_file_upload(csv_path, "text/csv")

    expect {
      post import_books_path, params: { file: file }
    }.to change(Book, :count).by(2)

    expect(response).to redirect_to(new_book_path)
    follow_redirect!
    expect(response.body).to include("Imported 2 books")
  end

  it "redirects with an alert when the uploaded file is not a CSV" do
    file = fixture_file_upload(txt_path, "text/plain")

    expect {
      post import_books_path, params: { file: file }
    }.not_to change(Book, :count)

    expect(response).to redirect_to(new_book_path)
    follow_redirect!
    expect(response.body).to include("Please choose a CSV file to upload.")
  end

  it "redirects with an alert when no file is provided" do
    expect {
      post import_books_path, params: { file: nil }
    }.not_to change(Book, :count)
  
    expect(response).to redirect_to(new_book_path)
    follow_redirect!
    expect(response.body).to include("File was blank. Please choose a valid CSV file to upload.")
  end
end
