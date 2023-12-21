class CompaniesController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  before_action :authorize_admin!, only: [:create]

  def index
    companies = Company.all
    render json: companies, only: [:name, :location]
  end

  def create
    return render json: { error: 'Name and location both are required' }, status: :bad_request if company_params[:name].blank? || company_params[:location].blank?

    company = Company.create(company_params)
    render json: company, only: [:name, :location]
  end

  private

  def authorize_admin!

    return if current_user && current_user.admin?
  
    render json: { error: 'Unauthorized' }, status: :unauthorized
  end

  def company_params
    params.require(:company).permit(:name, :location)
  end

end
