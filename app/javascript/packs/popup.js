import Swal from 'sweetalert2'

export default class Popup {
  alert(content, title = '', icon = 'success', option = {}) {
    const swal = Swal.mixin({
      showConfirmButton: false,
      timerProgressBar: true,
    });
    swal.fire({
      title: title,
      icon: icon,
      html: content,
    });
  }
}
