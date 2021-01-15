class CustomersController < ApplicationController

  def index
    @customers = Customer.all
  end

  def new
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customer_params)
    # binding.pry
    if @customer.valid?
      @customer.save
      redirect_to action: :index
    else
      render :new
    end
  end

  def show
    @customer = Customer.find(params[:id])
    # @oreders = Order.all
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :sex_id, 
                                     :tell1, :tell2, :email, :address, :memo).merge(user_id: current_user.id)
  end

end
