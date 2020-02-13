document.addEventListener('turbolinks:load', function(){
  if (document.getElementById('responses-area')) {
    let scroll = document.getElementById('responses-area');
    scroll.scrollTop = scroll.scrollHeight;
  }
})