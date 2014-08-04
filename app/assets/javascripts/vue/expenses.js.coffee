$ ->
  expense = Vue.extend
    template:'#expense-template'

    data:
      editing: false
      editingAmount: ''

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

      edit: ->
        @editing = true
        @editingAmount = @amount
        setTimeout =>
          $('input', @$el).focus()
        , 5

      update: ->
        @editing = false
        $.ajax
          type: 'POST'
          url: @url
          data:
            _method: 'PATCH'
            expense:
              amount: @editingAmount
          success: (response) =>
            if (response.errors)
              alert '更新に失敗しました\n' + response.errors.join('\n')
            else
              @amount = response.expense.amount
          error: (response) =>
            alert '更新に失敗しました（通信エラー）'

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
          error: (response) =>
            alert '作成に失敗しました（通信エラー）'
        @newExpense = ''

