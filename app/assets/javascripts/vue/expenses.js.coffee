$ ->
  new Vue
    el: "#vue-expenses"

    paramAttributes: ['json']

    data:
      expenses: []

    created: ->
      @expenses = JSON.parse(@json)

