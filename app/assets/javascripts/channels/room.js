document.addEventListener("turbolinks:load", function() {
  App.room = App.cable.subscriptions.create("RoomChannel", {
    connected: function() {
    },

    disconnected: function() {
    },

    received: function(message) {
      const messages = document.getElementById('message-area')
      messages.innerHTML += message
    },

    speak: function(content) {
      return this.perform('speak', {message: content, conversation_id: gon.conversation.id, current_user: gon.current_user});
    },
  });
  
  if (document.getElementById('button') && document.getElementById('chat-input')) {
    const input = document.getElementById('chat-input')
    const button = document.getElementById('button')
    button.addEventListener('click', function(){
      const content = input.value
      App.room.speak(content)
      location.reload();
      input.value = ""
    })  
  }
})