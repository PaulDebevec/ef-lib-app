FactoryBot.define do
  sequence :isbn_seq do |n|
    100_000_000 + n
  end

  factory :customer, class: Customer do
    first_name { "John" }
    last_name  { "Doe" }
  end

  factory :book do 
    title { "A Fancy Title" }
    isbn { generate(:isbn_seq) }
    author { "Jane Smith" }
    category { "Fiction" }
  end
  
  factory :audio_book, class: AudioBook do 
    title { "A Fancy Audio Book" }
    isbn { generate(:isbn_seq) }
    author { "Jane Smith" }
    category { "Non Fiction" }
  end

  factory :physical_book, class: PhysicalBook do 
    title { "A Physical Books" }
    isbn { generate(:isbn_seq) }
    author { "Jane Hero" }
    category { "Non Fiction" }
  end

  factory :customer_book do 
    association :customer
    association :book
    status { "checked out" }
  end
end
