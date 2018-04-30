//= require toastr.min

class Alerts {
  constructor(container_selector = '#alerts-container') {
    this.messages = $(container_selector).data('messages');

    Alerts.setDefaultOptions();
    Alerts.parse(this.messages);
  }

  static get types() { return { alert: 'error', notice: 'success' } }

  static setDefaultOptions () {
    toastr.options = {
      closeButton: true,
      debug: false,
      newestOnTop: false,
      progressBar: true,
      positionClass: 'toast-top-left',
      preventDuplicates: false,
      onclick: null,
      showDuration: '300',
      hideDuration: '1000',
      timeOut: '5000',
      extendedTimeOut: '1000',
      showEasing: 'swing',
      hideEasing: 'linear',
      showMethod: 'fadeIn',
      hideMethod: 'fadeOut'
    };
  }

  static parse(messages) {
    Object.entries(messages).forEach(([key, value]) => {
      if (Alerts.types.hasOwnProperty(key)) {

        if (Array.isArray(value)) {
          value.forEach(message => {
            Alerts.show(message, key)
          })
        } else {
          Alerts.show(value, key)
        }
      }

    });
  }

  static show(message, key) {
    toastr[Alerts.types[key]](message);
  }

  static clear() {
    toastr.remove();
  }
}

new Alerts();
