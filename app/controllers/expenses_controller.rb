class ExpensesController < ApplicationController
  before_action :set_expense, only: [:update, :destroy]

  def index
    respond_to do |format|
      format.html
      format.json { @expenses = Expense.all }
    end
  end

  def create
    @expense = Expense.new(expense_params)

    if @expense.save
      render json: { expense: @expense }
    else
      render json: { errors: @expense.errors.full_messages }
    end
  end

  def update
    if @expense.update(expense_params)
      render json: { expense: @expense }
    else
      render json: { errors: @expense.errors.full_messages }
    end
  end

  def destroy
    @expense.destroy
    head :no_content
  end

  private
  def set_expense
    @expense = Expense.find(params[:id])
  end

  def expense_params
    params.require(:expense).permit(:amount)
  end
end
