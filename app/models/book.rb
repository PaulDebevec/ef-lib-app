require 'csv'

class Book < ApplicationRecord
  has_many :customer_books, -> { order(created_at: :desc) }, dependent: :destroy
  has_many :customers, -> { order(created_at: :desc) }, through: :customer_books
  
  validates :title, :author, :category, presence: true
  validates :isbn, presence: true, uniqueness: true

  def self.import(file)
    return unless file

    CSV.foreach(file.path, headers: true) do |row|
      data = row.to_h # Convert row to ruby hash for convenience
      data = data.transform_keys { |k| k.to_s.downcase } # Downcase to normalize header
      book = Book.find_or_initialize_by(isbn: data["isbn"]) # Find existing book by ISBN or build a new one
      allowed_attrs = data.slice("title", "author", "category", "isbn", "type") # Only assign expected columns
      book.update(allowed_attrs)
    end
  end

  def self.order_by_latest
    Book.order("created_at DESC")
  end
end