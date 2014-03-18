$(function () {

  var $newsletter = $('#newsletter-form'),
      $newsletterInput = $('.js-newsletter-input'),
      $newsletterSubmit = $('.js-newsletter-submit'),
      $newsletterResponse = $('.js-newsletter-result');

  $newsletter.on('submit', function () {
    if ($newsletterInput.val() === '') {
      return false;
    }
  });

  $newsletter.on('ajax:success', function (xhr, response) {
    $newsletterInput.val('');
    $newsletterSubmit.blur();
    $newsletterResponse.show().text("Great, we've got " + response.email + " on our list!").animate({ opacity: 1 }, 500);

    setTimeout(function () {
      $newsletterResponse.animate({ opacity: 0 }, 500, function () {
        $newsletterResponse.html('&nbsp;').hide();
      });
    }, 5000);
  });

  $newsletter.on('ajax:error', function (event, xhr) {
    $newsletterSubmit.blur();
    $newsletterResponse.text(xhr.responseText).animate({
      opacity: 1
    }, 500);
  });

});