# README
# Project as part of test

## Description
This API application serves as a basic user authentication and company name and location data system. It allows users to create user, add company data [name, location], login, and retrieve a list of companies. Additionally, it implements 
- JWT is used for token-based authentication,
- authorization based on role,
-  error handling, and
-  RSpec test coverage.

## Setup
We are using Ruby version 3.2.2 and Rails version 7.1.2 with Postgresql

1. Clone the repository: `git clone https://github.com/Shubham0197/CompanyApi.git`
2. Navigate to the project directory: `cd CompanyApi`
3. Install dependencies: `bundle install`
4. Set up the database: `bin/rails db:setup`
5. Start the server: `bin/rails server`
6. Run test cases:  'rspec'

## Usage of the API

1. User Authentication:
  Send a POST request to /login with the user's email and password to obtain the authentication token.

2. User Registration:
  Send a POST request to /users with the user's email and password in the request body. Include the Bearer token of an admin user in the Authorization header.
  Body eg.
{
  "user": {
    "email": "use1r@example.com",
    "password": "password",
     "role": "admin" }
   }

4. Company Retrieval:
  - Retrieve All Companies:
     Send a GET request to /companies .
     This will retrieve a list of all companies, including name and location data.
   
  - Filter Companies by Name:
     Send a GET request to /companies?name=your_company_name to filter companies by name.
   
  - Retrieve Company Details:
     Send a GET request to /company/:id with the company's id .
     This will fetch details for a specific company.
4. Create a New Company:
    Send a POST request to /company with the company name and location in the request body.
    Include the obtained token in the Bearer Authorization header to create a new company record.
    Body eg.
    {
    "company": {
    "name": "Paytm",
    "location": "Noida"
    }
  }

Ensure that the Authorization header includes the Bearer token for authentication in all relevant requests.



