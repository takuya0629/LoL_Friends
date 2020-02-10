document.addEventListener("turbolinks:load", function() {
  App.board = App.cable.subscriptions.create("BoardChannel", {
    connected: function() {
      console.log('board')
    },
    disconnected: function() {
    },
    received: function(response) {
      const responses = document.getElementById('responses')
      responses.innerHTML += response
    },
    speak: function(content) {
      return this.perform('speak', {response: content, user_id: gon.current_user.id, board_id: gon.board.id});
    },
  });
  const input1 = document.getElementById('response-input')
  const button1 = document.getElementById('board-button')
  button1.addEventListener('click', function(){
    const content1 = input1.value
    App.board.speak(content1)
    location.reload();
    input1.value = ""
  })
})