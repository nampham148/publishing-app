jQuery(function() {
  if ($('.pagination').length) {
    $(window).scroll(function() {
      var url;
      url = $('.pagination .next_page').attr('href');
      if (url && $(window).scrollTop() > $(document).height() - $(window).height() - 100) {
        $('.pagination').text("Fetching more posts...");
        return $.getScript(url);
      }
    });
    return $(window).scroll();
  }
});