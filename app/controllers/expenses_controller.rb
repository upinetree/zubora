class ExpensesController < ApplicationController
  before_action :set_expense, only: [:show, :update, :destroy]

  def index
    respond_to do |format|
      format.html
      format.json { @expenses = current_user.expenses.order(id: :asc) }
    end
  end

  def show
  end

  def create
    @expense = current_user.expenses.build(expense_params)

    if @expense.save
      redirect_to @expense
    else
      render json: { errors: @expense.errors.full_messages }
    end
  end

  def update
    if @expense.update(expense_params)
      redirect_to @expense
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
