document.addEventListener('turbolinks:load', function(){
  if (document.getElementById('message-area')) {
    let scroll = document.getElementById('message-area');
    scroll.scrollTop = scroll.scrollHeight;
  }
})