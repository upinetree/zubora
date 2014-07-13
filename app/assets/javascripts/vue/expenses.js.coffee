$ ->
  expense = Vue.extend
    template: "#expense-template"

  new Vue
    el: "#vue-expenses"

    paramAttributes: ['json']

    data:
      expenses: []

    components:
      expense: expense

    created: ->
      @expenses = JSON.parse(@json)

