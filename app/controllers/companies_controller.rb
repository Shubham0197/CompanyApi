class CompaniesController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  before_action :authorize_admin!, only: [:create]

  def index
    if params[:name]
      companies = Company.where(name: params[:name])
    else
      companies = Company.all
    end

    render json: companies, only: [:name, :location]
  end

  def show
    company = Company.find(params[:id])
    render json: company, only: [:name, :location]
  end

  def create
    return render json: { error: 'Company name and location both are required' }, status: :bad_request if company_params[:name].blank? || company_params[:location].blank?

    company = Company.create(company_params)
    render json: company, only: [:name, :location]
  end

  private

  def company_params
    params.require(:company).permit(:name, :location)
  end

end
