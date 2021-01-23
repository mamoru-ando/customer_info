class OrdersController < ApplicationController

  def new
    @customer = Customer.new
    @order = Order.new
  end

  def create
    # binding.pry
    @order = Order.new(order_params)
    if @order.valid?
      @order.save
      redirect_to customer_path(@order.customer.id)
    else
      render :new
    end
  end

  def edit
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      redirect_to customer_path(@order.customer.id)
    else
      render :edit
    end
  end

  def destroy
    @order = Order.find(params[:id])
    @order.destroy
    redirect_to customer_path(@order.customer.id)
  end

  private

  def order_params
    params.require(:order).permit(:date, :people, :table, :drink, :food, :pay, :order_memo).merge(customer_id: params[:customer_id])
  end
end
