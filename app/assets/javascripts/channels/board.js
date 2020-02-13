document.addEventListener("turbolinks:load", function() {
  App.board = App.cable.subscriptions.create("BoardChannel", {
    connected: function() {
      console.log('board')
    },
    disconnected: function() {
    },
    received: function(response) {
      const responses = document.getElementById('responses-area')
      responses.innerHTML += response
    },
    speak: function(content) {
      return this.perform('speak', {response: content, user_id: gon.current_user.id, board_id: gon.board.id});
    },
  });

  if (document.getElementById('board-button') && document.getElementById('response-input')) {
  const input = document.getElementById('response-input')
  const button = document.getElementById('board-button')
  button.addEventListener('click', function(){
    const content = input.value
    App.board.speak(content)
    location.reload();
    input.value = ""
    })  
  }
})