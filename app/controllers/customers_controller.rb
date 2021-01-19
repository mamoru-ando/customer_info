class CustomersController < ApplicationController

  before_action :search_customer, only: [:index, :search]

  def index
    @customers = Customer.all
    # @keyword = Customer.ransack(params[:q])
    # @customers = @keyword.result
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
  # binding.pry
    @customer = Customer.find(params[:id])
    @orders = Order.where(customer_id: @customer.id).order("created_at DESC")
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to action: :show
    else
      render :edit
    end
  end

  def destroy
    @customer = Customer.find(params[:id])
    @customer.destroy
    redirect_to root_path
  end

  def search
    @results  = @keyword.result#.include(:customer)
    # binding.pry
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :sex_id, 
                                     :tell1, :tell2, :email, :address, :memo, :appearance).merge(user_id: current_user.id)
  end

  def search_customer
    @keyword = Customer.ransack(params[:q])
  end

end
