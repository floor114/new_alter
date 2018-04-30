class Modal {
  constructor(window, container, link, form) {
    this.window = window || '#modal-window';
    this.container = container || '#modal-container';
    this.link = link || 'a[data-modal]';
    this.form = form || 'form[data-modal]';

    this.openInit();
    this.closeInit();
    this.formSuccess();
    this.formError();
  }

  openInit() {
    $(document).on('click', this.link, (event) => {
      event.preventDefault();

      $.get(event.currentTarget.href, (html) => {
        $(this.container).html(html).find(this.window).modal();
      });
    });
  }

  closeInit() {
    $(document).on('hidden.bs.modal', this.window, (event) => {
      Alerts.clear();

      $(event.currentTarget).remove();
    });
  }

  formSuccess() {
    $(document).on('ajax:success', this.form, (event, data, status, xhr) => {
      let url = xhr.getResponseHeader('Location');

      url ? window.location = url : Alerts.parse(data);
    });
  }

  formError() {
    $(document).on('ajax:error', this.form, (event, data) => {
      Alerts.parse(data.responseJSON);
    });
  }
}

new Modal();
