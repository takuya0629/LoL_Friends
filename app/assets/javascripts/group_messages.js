document.addEventListener('turbolinks:load', function(){
  if (document.getElementById('group_message-area')) {
    let scroll = document.getElementById('group_message-area');
    scroll.scrollTop = scroll.scrollHeight;
  }
})