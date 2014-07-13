$ ->
  expense = Vue.extend
    template: "#expense-template"

    methods:
      destroy: ->
        return unless confirm('削除しても良いですか？')
        @$destroy()
        $.ajax
          type: "DELETE"
          url: @url
          success: =>
            @$destroy
          error: =>
            alert '削除に失敗しました（通信エラー）'

  new Vue
    el: "#vue-expenses"

    paramAttributes: ['json']

    data:
      expenses: []

    components:
      expense: expense

    created: ->
      @expenses = JSON.parse(@json)

