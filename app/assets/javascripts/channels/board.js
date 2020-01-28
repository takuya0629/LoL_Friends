App.board = App.cable.subscriptions.create("BoardChannel", {
  connected: function() {
    console.log('board')
    // Called when the subscription is ready for use on the server
  },

  disconnected: function() {
    // Called when the subscription has been terminated by the server
  },

  received: function(response) {
    // Called when there's incoming data on the websocket for this channel
    const responses = document.getElementById('responses')
    responses.innerHTML += response
  },

  speak: function(content) {
    return this.perform('speak', {response: content, user_id: gon.current_user.id, board_id: gon.board.id});
  }
});

//'全てのjsが読み込まれたら起動っていう処理'
document.addEventListener('DOMContentLoaded', function(){
  //inputをviewから取得
  const input = document.getElementById('response-input')
  //buttonをviewから取得
  const button = document.getElementById('board-button')
  button.addEventListener('click', function(){
    const content = input.value
    // サーバ側に送る
    App.board.speak(content)
    input.value = ""
  })
})
