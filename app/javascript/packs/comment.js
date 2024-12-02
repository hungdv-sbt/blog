export default class Comment {
  showInputComment(id) {
    $('.btn-cancel-edit-comment').click();
    $(`.show-comment-${id}`).addClass('d-none');
    $(`.input-comment-${id}`).removeClass('d-none');
    $(`.btn-edit-delete-comment-${id}`).addClass('d-none');
    $(`.btn-edit-and-cancel-${id}`).removeClass('d-none').addClass('d-flex');
  }

  hideInputComment(id) {
    $(`.show-comment-${id}`).removeClass('d-none');
    $(`.input-comment-${id}`).addClass('d-none');
    $(`.btn-edit-delete-comment-${id}`).removeClass('d-none');
    $(`.btn-edit-and-cancel-${id}`).removeClass('d-flex').addClass('d-none');
  }

  updateComment(id) {
    const post_id = $('input[name="comment[post_id]"').val();
    let data = new FormData();
    let formData = $(`.form-comment-${id}`).serializeArray();
    $.each(formData, function (key, input) {
      data.append(input.name, input.value);
    });

    if ($(`#file-upload-${id}`).length > 0 && $(`#file-upload-${id}`)[0].files.length > 0) data.append("comment[image]", $(`#file-upload-${id}`)[0].files[0]);

    Shared.callAjaxRequest(Routes.post_comment_path(post_id), data, 'put', 'json', true)
    .done(function(data){
      $('.btn-cancel-edit-comment').trigger('click');
      Popup.alert('Comment success', 'SUCCESS')
      $('#show-comments').html(data.posts)
    }).fail(function(){
      // window.location.reload()
    })
  }

  showNameFile(id) {
    console.log(id);
    const filename = $(`.file-upload-${id}`)[0].files[0].name;  
    $(`.show-file-name-${id}`).removeClass('d-none').html(filename)
  }

  deleteComment(id) {
    const post_id = $('input[name="comment[post_id]"').val();
    Popup.confirm('Are you sure you want to delete this comment', {
      cancelBtn: false,
      success: () => {
        Shared.callAjaxRequest(Routes.post_comment_path(id), { comment: { post_id: post_id, id: id } }, 'delete', 'json')
        .done(function(data){
          Popup.alert('Remove Image Success', 'SUCCESS')
          $('#show-comments').html(data.posts)
        }).fail(function(){})
      }
    })
  }

  removeimageComment(id) {
    const post_id = $('input[name="comment[post_id]"').val();
    Popup.confirm('Are you sure you want remove this image comment', {
      success: () => {
        Shared.callAjaxRequest(Routes.remove_image_post_comments_path(), { record_id: id, comment: { post_id: post_id } }, 'post')
        .done(function(data){
          Popup.alert('Remove Image Success', 'SUCCESS')
          $('#show-comments').html(data.posts)
        }).fail(function(){})
      }
    })
  }
}
