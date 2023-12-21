class CompaniesController < ApplicationController
  def index
    companies = Company.all
    render json: companies, only: [:name, :location]
  end
end
