//= require select2

class Extensions {
  constructor(select2) {
    this.select2 = select2 || '.select2';

    this.initSelect2();
  }

  initSelect2() {
    $(this.select2).select2({
      theme: 'bootstrap'
    })
  }
}

new Extensions();
