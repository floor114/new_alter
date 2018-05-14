class Remote {
  constructor(link, form, deleteLink) {
    this.link = link || 'a[data-remote]';
    this.form = form || 'form[data-remote]';
    this.deleteLink = deleteLink || '.delete';

    this.formSuccess();
    this.linkSuccess();
    this.formError();
    this.linkError();
    this.delete();
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

  linkSuccess() {
    $(document).on('ajax:success', this.link, (event, data, status, xhr) => {
      let url = xhr.getResponseHeader('Location');

      url ? window.location = url : Alerts.parse(data);
    });
  }

  linkError() {
    $(document).on('ajax:error', this.link, (event, data) => {
      Alerts.parse(data.responseJSON);
    });
  }

  delete() {
    $(document).on('click', `${this.link}${this.deleteLink}`, function() {
      let parrent = $(this).data('parent'),
        $element = $(this).parents().eq(parrent);

      if ($element.length) {
        $element.fadeOut();
      }
    });
  }
}

new Remote();
