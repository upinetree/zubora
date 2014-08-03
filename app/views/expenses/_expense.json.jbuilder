json.expense do |json|
  json.extract! @expense, :id, :amount
  json.url expense_url(@expense)
end
