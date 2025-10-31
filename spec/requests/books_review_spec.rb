require "rails_helper"

RSpec.describe "Books review", type: :request do
  it "shows pending books to review" do
    pending_book = create(:book, status: "pending")

    get review_books_path

    expect(response).to have_http_status(:ok)
    expect(response.body).to include(pending_book.title)
  end

  it "delivers a pending book" do
    pending_book = create(:book, status: "pending")

    patch deliver_book_path(pending_book)

    expect(response).to redirect_to(review_books_path)
    follow_redirect!
    expect(response.body).to include("Book delivered to customers.")
    expect(pending_book.reload.status).to eq("delivered")
  end
end