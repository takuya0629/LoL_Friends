App.room = App.cable.subscriptions.create("RoomChannel", {
  connected: function() {
    // Called when the subscription is ready for use on the server
    // フロントからバックエンド側と繋がってるか確認
    console.log('connected')
  },

  disconnected: function() {
    // Called when the subscription has been terminated by the server
  },

  received: function(message) {
    const messages = document.getElementById('messages')
    messages.innerHTML += message
    // ブロードキャストされたらここで受け取ることができる。
    // Called when there's incoming data on the websocket for this channel
  },

  speak: function(content) {
    return this.perform('speak', {message: content, conversation_id: gon.conversation.id, current_user: gon.current_user});
  }
});

//'全てのjsが読み込まれたら起動っていう処理'
document.addEventListener('DOMContentLoaded', function(){
  //inputをviewから取得
  const input = document.getElementById('chat-input')
  //buttonをviewから取得
  const button = document.getElementById('button')
  button.addEventListener('click', function(){
    const content = input.value
    // サーバ側に送る
    App.room.speak(content)
    input.value = ""
  })
})
