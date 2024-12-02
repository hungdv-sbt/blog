$(document).ready(function(){
  $('#btn-submit-comment').on('click', function(){
    const comment = $('input[name="comment[comment]"]').val();
    let data = new FormData();
    let formData = $('#form-comment').serializeArray();
    $.each(formData, function (key, input) {
      data.append(input.name, input.value);
    });

    if ($('#image-comment').length > 0 && $('#image-comment')[0].files.length > 0) data.append("comment[image]", $('#image-comment')[0].files[0]);

    if ($('#form-comment').find('.emoji-wysiwyg-editor')[0].outerText == '' && $('#form-comment').find('.emoji-wysiwyg-editor')[0].children.length == 0) {
      $('input[name="comment[comment]"').addClass('blank_comment').focus();
      Popup.alert('Please enter a comment', 'ERROR', 'error');
      return;
    }

    Shared.callAjaxRequest(Routes.post_comments_path(), data, 'post', 'json', true)
    .done(function(data){
      Popup.alert('Comment success', 'SUCCESS')
      $('#show-comments').html(data.posts)
      $('input[name="comment[comment]"]').removeClass('blank_comment').val("");
      $('#image-comment').val('');
      $('#form-comment').find('.emoji-wysiwyg-editor').html('')
    }).fail(function(){
      window.location.reload()
    })
  })

  $('input[name="comment[comment]"]').on('input', function(){
    enabledSubmitButton($('#btn-submit-comment'), ($('#form-comment').find('.emoji-wysiwyg-editor')[0].outerText !== ''))
  });

  $('div.emoji-wysiwyg-editor').on('change', function(){
    console.log(1)
    enabledSubmitButton($('#btn-submit-comment'), ($('#form-comment').find('.emoji-wysiwyg-editor')[0].outerText !== ''))
  })

  function enabledSubmitButton(button, is_input_value){
    if (is_input_value) {
      button.removeClass('disabled');
    } else {
      button.addClass('disabled');
    }
  }
});
