document.addEventListener('turbolinks:load', function(){
  $('.btn-one').click(function() {
    $('#btn-2').html('<span class="spinner-border spinner-border-sm mr-2" role="status" aria-hidden="true"></span>Loading...').addClass('disabled').removeClass('btn-hidden');
  });
})
  