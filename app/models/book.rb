require 'csv'

class Book < ApplicationRecord
  has_many :customer_books, -> { order(created_at: :desc) }, dependent: :destroy
  has_many :customers, -> { order(created_at: :desc) }, through: :customer_books

  validates :title, :author, :category, presence: true
  validates :isbn, presence: true, uniqueness: true
  
  scope :pending,   -> { where(status: "pending") }
  scope :delivered, -> { where(status: "delivered") }

  def self.import(file)
    return [] unless file

    imported = []
    CSV.foreach(file.path, headers: true) do |row|
      data = row.to_h.transform_keys { |k| k.to_s.downcase }
      raw_isbn = data["isbn"].to_s.strip
      isbn_int = raw_isbn.to_i
      book = Book.find_or_initialize_by(isbn: isbn_int)
      allowed_attrs = data.slice("title", "author", "category", "isbn", "type")
      book.assign_attributes(allowed_attrs)
      book.isbn = isbn_int
      book.status = "pending" if book.new_record? || book.status.blank?
      book.save
      imported << book
    end
    imported
  end

  def self.order_by_latest
    Book.order("created_at DESC")
  end
end
