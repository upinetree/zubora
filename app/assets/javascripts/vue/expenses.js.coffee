$ ->
  expense = Vue.extend
    template:'#expense-template'

    data:
      isAmountEditing: false
      isAccruedOnEditing: false
      editingTarget: ''
      editingValue: ''

    methods:
      # TODO: DRYにしたい
      editAmount: ->
        @isAmountEditing = true
        @editingTarget = 'amount'
        @editingValue = @amount # フィールドの初期値として現在の値を入れる
        setTimeout =>
          $('input', @$el).focus()
        , 50

      editAccruedOn: ->
        @isAccruedOnEditing = true
        @editingTarget = 'accrued_on'
        @editingValue = @accrued_on # フィールドの初期値として現在の値を入れる
        setTimeout =>
          $('input', @$el).focus()
        , 50

      update: ->
        @isAmountEditing = false
        @isAccruedOnEditing = false

        _expense = {}
        _expense[@editingTarget] = @editingValue

        $.ajax
          type: 'POST'
          url: @url
          data:
            _method: 'PATCH'
            expense: _expense
          success: (response) =>
            if (response.errors)
              alert '更新に失敗しました\n' + response.errors.join('\n')
            else
              @amount = response.expense.amount
              @accrued_on = response.expense.accrued_on
          error: (response) =>
            alert '更新に失敗しました（通信エラー）'

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
      $.getJSON @expensesUrl, (response) =>
        @expenses = response.expenses

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

      destroyExpense: (expense) ->
        expense.destroy()
        @expenses.$remove(expense.$data)

