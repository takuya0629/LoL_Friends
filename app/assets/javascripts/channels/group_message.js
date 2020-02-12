document.addEventListener("turbolinks:load", function() {  
  App.group_message = App.cable.subscriptions.create("GroupMessageChannel", {
    connected: function() {
    },

    disconnected: function() {
    },

    received: function(message) {
      const group_messages = document.getElementById('group_message-area')
      messages.innerHTML += message
    },

    speak: function(content) {
      return this.perform('speak', {message: content, group_id: gon.group.id, current_user: gon.current_user});
    },
  });

  const input = document.getElementById('group-chat-input')
  const button = document.getElementById('group-chat-button')
  button.addEventListener('click', function(){
    const content = input.value
    App.group_message.speak(content)
    location.reload();
    input.value = ""
  })
})
