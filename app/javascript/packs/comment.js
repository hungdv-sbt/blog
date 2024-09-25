export default class Comment {
  showInputComment(id) {
    $('.btn-cancel-edit-comment').click();
    $(`.show-comment-${id}`).addClass('d-none');
    $(`.input-comment-${id}`).removeClass('d-none');
    $(`.btn-show-comment-${id}`).addClass('d-none');
    $(`.btn-edit-and-cancel-${id}`).removeClass('d-none').addClass('d-flex');
  }

  hideInputComment(id) {
    $(`.show-comment-${id}`).removeClass('d-none');
    $(`.input-comment-${id}`).addClass('d-none');
    $(`.btn-show-comment-${id}`).removeClass('d-none');
    $(`.btn-edit-and-cancel-${id}`).removeClass('d-flex').addClass('d-none');
  }

  updateComment(id) {
    const post_id = $('input[name="comment[post_id]"').val();
    const comment = $(`.input-comment-${id}`).val();
    $(`input.input-comment-${id}`).focus()
    $.ajax({
      method: 'PUT',
      url: Routes.post_comment_path(post_id),
      dataType: 'json',
      data: { comment: { post_id: post_id, comment: comment, id: id } },
      headers: {
        'X-CSRF-Token': $('meta[name="csrf-token"]').attr('content')
      }
    }).done(function(data){
      Popup.alert('Comment success', 'SUCCESS')
      $('#show-comments').html(data.posts)
    }).fail(function(){
      // window.location.reload()
    })
  }
}
