var Modal = {
  init: function () {
    this.container = $('#modal-container');
    this.window = '#modal-window';

    this.openInit();
    this.closeInit();
    this.formSuccess();
    this.formError();
  },

  open: function (href) {
    $.get(href, function (html) {
      Modal.container.html(html).find(Modal.window).modal();
    });
  },

  openInit: function () {
    $(document).on('click', 'a[data-modal]', function () {
      event.preventDefault();

      Modal.open(this.href);
    });
  },

  close: function ($modal) {
    Alerts.clear();
    $modal.remove();
  },

  closeInit: function () {
    $(document).on('hidden.bs.modal', Modal.window, function () {
      Modal.close($(this));
    });
  },

  formSuccess: function () {
    $(document).on('ajax:success', 'form[data-modal]', function(e, data, status, xhr) {
      var url = xhr.getResponseHeader('Location');

      if (url) {
        window.location = url;
      } else {
        Alerts.parse(data);
      }
    });
  },

  formError: function () {
    $(document).on('ajax:error', 'form[data-modal]', function(e, data) {
      Alerts.parse(data.responseJSON);
    });
  }
};

$(function( ) {
  Modal.init();
});
