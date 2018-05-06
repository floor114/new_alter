class Tab {
  constructor(window, container, linksContainer, link, activeClass) {
    this.container = container || '#tab-container';
    this.link = link || 'a[data-tab]';
    this.linksContainer = linksContainer || '#tab-links-container';
    this.activeClass = activeClass || 'active';

    this.loadInit();
    this.activeTabInit();
  }

  load(href) {
    $.get(href, (html) => {
      $(this.container).html(html);
    });
  }

  loadInit() {
    $(document).on('click', this.link, (event) => {
      let $this = $(event.currentTarget);

      event.preventDefault();

      $this.parents(this.linksContainer).find(`.${this.activeClass}`).removeClass(this.activeClass);
      $this.parent('li').addClass(this.activeClass);

      this.load(event.currentTarget);
    });
  }

  activeTabInit() {
    $(document).ready( () => {
      let activeTab = $(this.linksContainer).find(`.${this.activeClass}`).find('a');

      if (activeTab != undefined) {
        this.load(activeTab.attr('href'))
      }
    });
  }
}

new Tab();
