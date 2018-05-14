class Modal {
  constructor(window, container, link) {
    this.window = window || '#modal-window';
    this.container = container || '#modal-container';
    this.link = link || 'a[data-modal]';

    this.openInit();
    this.closeInit();
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
}

new Modal();
