class CustomersController < ApplicationController

  def index
    @customers = Customer.all
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

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :sex_id, 
                                     :tell1, :tell2, :email, :address, :memo).merge(user_id: current_user.id)
  end

end
