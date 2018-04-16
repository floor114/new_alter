$(function() {
  $('.news-circles').delay(250).fadeIn();
  $('.news').delay(550).fadeIn('slow');
  $('.news-circles').hover((function() {
    $('.news-circles').css('animation-play-state', 'paused');
    $('.news .title').html($(this).data('title'));
    $('.news .title').attr('title', $(this).data('title'));
    $('.news .description').html($(this).data('description'));
  }), function() {
    $('.news-circles').css('animation-play-state', 'running');
  });
});
