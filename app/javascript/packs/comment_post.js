$(document).ready(function(){
  $('#btn-submit-comment').on('click', function(){
    const post_id = $('input[name="comment[post_id]"').val();
    const comment = $('input[name="comment[comment]"]').val();
    if (comment == '') {
      $('input[name="comment[comment]"').addClass('blank_comment').focus();
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
      $('#show-comments').html(data.posts)
      $('input[name="comment[comment]"]').val("")
    }).fail(function(){
      window.location.reload()
    })
  })
});