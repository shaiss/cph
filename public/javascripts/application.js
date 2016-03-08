var img_urls = [];
var INDEX = 0;
function bannerFadeNSwitch() {
  $('#banner_on').fadeOut(1500, function() {
    setTimeout("bannerSwitch()", 500);
  });
}

function bannerSwitch() {
  $('#banner_on').attr('src', $('#banner_on_deck').attr('src'));
  $('#banner_on').show(0, function() {
    if ( INDEX >= img_urls.length ) {
      INDEX = 0;
    }
    $('#banner_on_deck').attr('src', img_urls[INDEX++]);
  });
}

function showContent(page) {
  $('.content').hide();
  $(page).fadeIn(300);
}

function getTargetFromHref(href) {
  var page = (href.match(/#\w+/) || '#welcome') + '_content';
  if ( ! $(page).size() ) {
    return '#welcome_content';
  }
  return page;
}

function menuClick(el) {
  if ( $(el).hasClass('external_link')){
    return false;
  } else {
    var whut = getTargetFromHref($(el).attr('href'));
    showContent(whut);
  }
}


// get this going once everything is loaded up.
$(function() {
  // handles the dropdown menues.
  $('.menu_button').hover(
    function() { $(this).children('div').slideDown('fast'); },
    function() { $(this).children('div').fadeOut('fast'); }
  );

  // handles on click link for drop down
  $('.menu_button a').click(function() {
    menuClick(this);
  });
  // handles on click the menu directly
  $('#button_bar > a').click(function() {
    menuClick(this);
  });

  // build a set of 8 image urls from 1.jpg to 35.jpg
  for(i=1; i<=35; i++) {
    img_urls.push('/images/banners/' + i + '.jpg');
  }
  // now randomize the elements
  img_urls.sort(function() { return 0.5 - Math.random(); });

  $('#banner_on_deck').attr('src', img_urls[INDEX++]);

  // rotate the images.
  setInterval("bannerFadeNSwitch()", 8000);


  // load up the page that was requested
  showContent(getTargetFromHref($(location).attr('href')));

  // set all the local links on clicks to show the right content
  $('.local_link').click(function(e) {
    showContent(getTargetFromHref(e.currentTarget.href));
  });
});
