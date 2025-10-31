class CustomerBook < ApplicationRecord
  belongs_to :customer
  belongs_to :book

  STATUSES = ["checked out", "returned"].freeze

  validates :status, presence: true, inclusion: { in: STATUSES }
  
  def self.find_customers_books(book, customer)
    CustomerBook.where(["book_id = ? and customer_id = ?", book, customer]).first
  end
end