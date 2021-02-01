class CustomersController < ApplicationController
  before_action :search_customer, only: [:index, :search]
  before_action :set_customer, only: [:show, :edit, :update, :destroy]

  def index
    @customers = Customer.where(user_id: current_user.id).order("updated_at DESC")
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.valid?
      @customer.save
      redirect_to action: :index
    else
      render :new
    end
  end

  def show
    @orders = Order.where(customer_id: @customer.id).order("date DESC")
  end

  def edit
  end

  def update
    if @customer.update(customer_params)
      redirect_to action: :show
    else
      render :edit
    end
  end

  def destroy
    @customer.destroy
    redirect_to root_path
  end

  def search
    @results  = @keyword.result.order("updated_at DESC")
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :name_kana, :sex_id, 
                                     :tell1, :tell2, :email, :address, :memo, :appearance).merge(user_id: current_user.id)
  end

  def search_customer
    @keyword = Customer.ransack(params[:q])
  end

  def set_customer
    @customer = Customer.find(params[:id])
  end

end
