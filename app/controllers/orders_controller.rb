class OrdersController < ApplicationController
  before_action :set_order, only: [:edit, :update, :destroy]

  def new
    @customer = Customer.new
    @order = Order.new
  end

  def create
    @order = Order.new(order_params)
    if @order.valid?
      @order.save
      redirect_to customer_path(@order.customer.id)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @order.update(order_params)
      redirect_to customer_path(@order.customer.id)
    else
      render :edit
    end
  end

  def destroy
    @order.destroy
    redirect_to customer_path(@order.customer.id)
  end

  private

  def order_params
    params.require(:order).permit(:date, :people, :table, :drink, :food, :pay,
                                  :order_memo).merge(customer_id: params[:customer_id])
  end

  def set_order
    @order = Order.find(params[:id])
  end
end
