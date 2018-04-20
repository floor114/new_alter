//= require toastr.min

var Alerts = {
  init: function(messages) {
    this.messages = messages;
    this.types = { alert: 'error', notice: 'info' };

    this.setDefaultOptions();
    this.parse();
  },

  setDefaultOptions: function () {
    toastr.options = {
      closeButton: true,
      debug: false,
      newestOnTop: false,
      progressBar: true,
      positionClass: 'toast-top-left',
      preventDuplicates: true,
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
  },

  parse: function () {
    Object.keys(Alerts.messages).forEach(function (key) {
      if (Alerts.types.hasOwnProperty(key)) {
        var message = Alerts.messages[key];

        if (Array.isArray(message)) {
          message.forEach(function (val) {
            toastr[Alerts.types[key]](val);
          });
        } else {
          toastr[Alerts.types[key]](message);
        }
      }
    });
  },

  show: function (message, key) {
    toastr[Alerts.types[key]](message);
  }
};
