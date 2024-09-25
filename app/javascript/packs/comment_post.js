$(document).ready(function(){
  $('#btn-submit-comment').on('click', function(){
    const post_id = $('input[name="comment[post_id]"').val();
    const comment = $('input[name="comment[comment]"]').val();
    if (comment == '') {
      $('input[name="comment[comment]"').addClass('blank_comment').focus();
      Popup.alert('Please enter a comment', 'ERROR', 'error');
      return;
    } 

    $.ajax({
      method: 'POST',
      url: Routes.post_comments_path(),
      dataType: 'json',
      data: { comment: { post_id: post_id, comment: comment } },
      headers: {
        'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
      }
    }).done(function(data){
      Popup.alert('Comment success', 'SUCCESS')
      $('#show-comments').html(data.posts)
      $('input[name="comment[comment]"]').removeClass('blank_comment').val("");
      $('#btn-submit-comment').addClass('disabled');
    }).fail(function(){
      window.location.reload()
    })
  })

  $('input[name="comment[comment]"]').on('input', function(){
    enabledSubmitButton($('#btn-submit-comment'), ($('input[name="comment[comment]"]').val()))
  });

  function enabledSubmitButton(button, is_input_value){
    if (is_input_value) {
      button.removeClass('disabled');
    } else {
      button.addClass('disabled');
    }
  }
});
