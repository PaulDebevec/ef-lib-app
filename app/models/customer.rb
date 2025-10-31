class Customer < User
  has_many :customer_books, -> { order(created_at: :desc) }, dependent: :destroy
  has_many :books, -> { order(created_at: :desc) }, through: :customer_books
  has_many :audio_books, -> { where(type: "AudioBook") }, through: :customer_books, source: :book
  has_many :physical_books, -> { where(type: "PhysicalBook") }, through: :customer_books, source: :book
  
  def self.find_customer(customer)
    Customer.where(["id = ?", customer]).first
  end

  def self.count_of_books
    left_joins(:customer_books)
      .left_joins(:books)
      .select(
        "users.*",
        "COUNT(DISTINCT customer_books.id) AS total_books_count",
        "SUM(CASE WHEN books.type = 'AudioBook' THEN 1 ELSE 0 END) AS audio_books_count",
        "SUM(CASE WHEN books.type = 'PhysicalBook' THEN 1 ELSE 0 END) AS physical_books_count"
      )
      .group("users.id")
      .order("users.last_name ASC, users.first_name ASC")
  end
end