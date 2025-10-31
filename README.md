## Introduction

*   The purpose of this application is to showcase your technical, analytical, written and verbal skills.
*   Once your system has been configured, please spend an hour reviewing, enhancing, pseudo-coding, coding and/or commenting on the application. Feel free to spend more than an hour, but it is not required.
*   Your code changes, enhancements and/or comments will be used as the starting point of a technical discussion with the team. It will be a unstructured format that will focus on the entire stack.

## Application Overview:

This application displays the relationship between a customer and a library. It includes 8 models:

1.  User
2.  Librarian
3.  Customer
4.  Library
5.  Book
6.	AudioBook
7.	PhysicalBook
8.	CustomerBook

The db/seeds.rb file is preloaded with test data. Please use this when you setup your DB.

## Suggested Tasks:

*		Review the code for best practices, efficiencies or logic flaws.
*		Review the test suite for any gaps.
*		Build a new report that lists customers with a count of different types of books.
*		Build an import process to retrieve new books from a file.
*		Build a process to review new books and deliver then to the customer.

## Extra Credit:

*		Review and/or update the code for any potenial security issues.
*		Review and/or update the code for any performance related changes.
*		Enhance the usability and/or design.

## Project Setup

Clone this repo locally, and from the top-level directory run:

`bundle install`

`bundle exec rake db:setup`

To make sure it's all working,

`rails s`

You should see this same information.

## Project Review

Please commit any updates and/or comments to the repo. Add any additional comments, notes and/or instructions in the README under the "Enhancements" section. Also note if the db/seeds.rb file has been updated. The development team will review your submission and be ready for the technical portion of your interview.

# Enhancements

## Suggested Tasks:
**Setup**
- Verified all existing tests passed before making changes
- Added the csv gem to silence Ruby 3.3 warnings and ensure CSV import compatibility
- Cleaned up unused lines in the Gemfile and submitted a separate PR for dependency updates

**1. Review the code for best practices, efficiencies, or logic flaws**
- Installed RSpec and Shoulda-Matchers for a modern testing workflow
- Added comprehensive model relationship and validation tests across all resources
- Implemented presence and uniqueness validations to ensure data integrity
- Updated factories to generate unique data and prevent test collisions
- Ensured all existing and new tests passed successfully

**2. Build a new report that lists customers with a count of different types of books**
- Added a new class method Customer.count_of_books using ActiveRecord aggregation
- Implemented counts for total, audio, and physical books per customer
- Added a /users/report route and view to display customer book counts
- Verified functionality with new model specs and manual testing

**3. Build an import process to retrieve new books from a file**
- Hardened the existing import functionality to safely handle CSV uploads
- Whitelisted permitted attributes
- Added validation for file presence and .csv extension
- Created request specs for both success and sad-path scenarios (missing or invalid files)
- Provided user feedback via simple flash messages after upload

**4. Build a process to review new books and deliver them to the customer**
- Added a status column to books with pending as the default
- Updated imports so new books start as pending
- Added librarian-only review page (`/books/review`) listing pending books
- Added a Deliver button to approve books and mark them as delivered
- Updated the customer catalog to show only delivered books
- Verified end-to-end workflow with RSpec tests and manual testing

## Extra:
**Security**
- Replaced unsafe/raw query patterns with ActiveRecord-style queries (counting books per customer for example) to avoid SQL injection risks.
- Whitelisted attributes in Book.import so CSV uploads can’t mass-assign unexpected fields.
- Validated file presence and extension on upload to prevent malformed requests.

**Performance**
- Moved the customer report to a single aggregated query (Customer.count_of_books) using LEFT JOINs and SQL aggregates instead of per-customer queries.
- Added ordering and scoping (e.g. Book.pending, Book.delivered) so pages only load the records they need.

**Usability / Design**
- NA

## TODO:
- I found a bug on user show page. `Return book` appears does nothing. Clicking it still shows the customer has x books. Unsure if UI or BE issue.
