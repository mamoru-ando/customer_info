class CustomersController < ApplicationController
  before_action :search_customer, only: [:index, :search]
  before_action :set_customer, only: [:show, :edit, :update, :destroy]

  def index
    @customers = Customer.eager_load(:user, :orders).where(user_id: current_user.id).order(updated_at: 'DESC')
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
    @orders = Order.where(customer_id: @customer.id).order('date DESC')
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
    @results = @keyword.result.order('updated_at DESC')
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :name_kana, :sex_id,
                                     :tell1, :tell2, :email, :address, :memo, :appearance).merge(user_id: current_user.id)
  end

  def search_customer
    @sex = Sex.all
    if !params[:q].nil?
      params[:q]['name_or_name_kana_or_tell1_or_memo_or_appearance_cont_all'] =
        params[:q]['name_or_name_kana_or_tell1_or_memo_or_appearance_cont_all'].split(/[\p{blank}\s]+/)
      @keyword = Customer.includes(:orders).ransack(params[:q])
    else
      @keyword = Customer.includes(:orders).ransack(params[:q])
    end
  end

  def set_customer
    @customer = Customer.find(params[:id])
  end
end
