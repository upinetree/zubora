$ ->
  new Vue
    el: "#vue-expenses"

    paramAttributes: ['expensesUrl']

    data:
      expenses: []

    created: ->
      @featch()

    methods:
      featch: ->
        $.getJSON @expensesUrl, (expenses) =>
          @expenses = expenses

