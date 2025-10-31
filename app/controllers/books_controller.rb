class BooksController < ApplicationController
  def new
  end
  
  def list
    @customer = Customer.find_customer(params[:customer_id])
    @customer_books = @customer.customer_books
  end
  
  def returned
    @customer = Customer.find_customer(params[:customer_id])
    book = CustomerBook.find_customers_books(params[:id], params[:customer_id])
    book.status = 'returned'
    
    if book.save
      flash[:success] = "Book has been marked as returned."
    else
      flash[:error] = "Book could not be marked as returned."
    end
    
    redirect_back(fallback_location: customer_users_path)
  end

  def import
    file = params[:file]
    if file.blank?
      redirect_to new_book_path, alert: "File was blank. Please choose a valid CSV file to upload."
      return
    end
    unless File.extname(file.original_filename).downcase == ".csv"
      redirect_to new_book_path, alert: "File must be a '.csv'. Please choose a CSV file to upload."
      return
    end
    imported = Book.import(file)
    count = imported.respond_to?(:size) ? imported.size : 0
    redirect_to new_book_path, notice: "Imported #{count} book#{'s' if count > 1}."
  end

  def index
    @books = Book.order_by_latest
  end
end
 