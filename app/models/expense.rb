class Expense < ActiveRecord::Base
  belongs_to :user

  validates :amount, presence: true

  before_validation :set_defaults

  private

  def set_defaults
    self.accrued_on ||= Date.today
  end
end
