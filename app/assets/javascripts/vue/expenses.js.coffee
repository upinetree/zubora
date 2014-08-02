$ ->
  expense = Vue.extend
    template:'#expense-template'

    methods:
      destroy: ->
        return unless confirm('削除しても良いですか？')
        $.ajax
          type: 'DELETE'
          url: @url
          success: =>
            @$destroy()
          error: =>
            alert '削除に失敗しました（通信エラー）'

  new Vue
    el: '#vue-expenses'

    paramAttributes: ['expensesUrl']

    data:
      expenses: []
      newExpense: ''

    components:
      expense: expense

    created: ->
      $.getJSON @expensesUrl, (expenses) =>
        @expenses = expenses

    methods:
      createExpense: ->
        $.ajax
          type: 'POST'
          url:  @expensesUrl
          data: { expense: { amount: @newExpense } }
          success: (response) =>
            if (response.errors)
              alert '作成に失敗しました\n' + response.errors.join('\n')
            else
              @expenses.push(response.expense)
            end
          error: =>
            alert '作成に失敗しました（通信エラー）'
        @newExpense = ''
