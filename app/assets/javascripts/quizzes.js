var current_question_number = 1;

/* Keypad */
$(function() {
  $('#keypad .key').on('click', function() {
    switch($(this).data('value')) {
      case 0:
      case 1:
      case 2:
      case 3:
      case 4:
      case 5:
      case 6:
      case 7:
      case 8:
      case 9:
        $('input[type=number]').val($('input[type=number]').val() + $(this).data('value'));
        break;

      case 'clr':
        $('input[type=number]').val('');
        break;
    }
  });
});

/* Icons and Questions */

function set_icons() {
  $('.button').each(function(index) {
    $($('.button')[index]);

    if(questions[index].answer == false) {          // Not submitted

    } else if(questions[index].review == false) {   // Submitted by save & next
      $($('.button')[index]).removeClass('not_visited').addClass('answered');
    } else if(questions[index].review == true) {      // Submitted by review
      $($('.button')[index]).removeClass('not_visited').addClass('review_answered');
    }
  });
}

function loadQuestion($id) {

  // $id is 1-indexed
  if($id < 1 || $id > questions.length)
    return false;
  else
    current_question_number = $id;

  // Load heading
  $('#question h1').html('Question ' + $id);

  // Load question
  $('.question_body .panel-body').html(questions[$id - 1].body);

  // Load options/numeric keypad
  switch(questions[$id - 1].type) {

    case 'multiple_choice':

      $('.options .panel-body ol li').remove();
      $('.numerical_answer').hide();
      $('.options').show();
      $('#radios').show();
      $('#radios .radio-inline').remove();
      var fields = 0;
      
      questions[$id - 1].options.forEach(function(option) {
        var option_letter_uc = String.fromCharCode(65 + fields);
        var option_letter_lc = String.fromCharCode(97 + fields);

        $('.options .panel-body ol').html($('.options .panel-body ol').html() + '<li>' + option.body + "</li>");

        if(option.id == currentQuestion().answer)
          $('#radios').html($('#radios').html() + '<label class="radio-inline"><input type="radio" name="correctChoice" value="' + option_letter_lc + '" required data-id="' + option.id + '" checked="true"> ' + option_letter_uc + '</label>');
        else
          $('#radios').html($('#radios').html() + '<label class="radio-inline"><input type="radio" name="correctChoice" value="' + option_letter_lc + '" required data-id="' + option.id + '"> ' + option_letter_uc + '</label>');

        fields++;
      });
      
      break;

    case 'numerical':

      $('.options').hide();
      $('#radios').hide();
      $('.numerical_answer').show();

      if(currentQuestion().answer != false) {
        $('.numerical_answer input[type=number]').val(currentQuestion().answer);
      } else {
        $('.numerical_answer input[type=number]').val('');
      }

      break;
  }

  // Mark button
  if(currentButton().hasClass('not_visited')) {
    currentButton().removeClass('not_visited').addClass('not_answered');
  }

  return true;
}

function currentQuestion() {
  return questions[current_question_number - 1];
}

function currentButton() {
  return $($('.button')[current_question_number - 1]);
}

function clearResponse() {

  switch(currentQuestion().type) {
    case 'multiple_choice':

      if($('#radios input[type=radio]:checked').length == 1)
        $('#radios input[type=radio]:checked')[0].checked = false;
      break;

    case 'numerical':

      $('.numerical_answer input[type=number]').val('');
      break;
  }

  currentButton().removeClass('not_visited').removeClass('answered').removeClass('review').removeClass('review_answered').addClass('not_answered');

  // Send data to server here
  $.ajax({
    url: '/answers/' + currentQuestion().id + '.json',
    type: 'DELETE',
    contentType: 'application/json'
  }).done(function(data) {
    if(data == true)
      $('#saved').show().delay(1500).fadeOut();
    else
      $('#not_saved').show().delay(1500).fadeOut();
  });  
}

function markForReview() {
  var answered = false;

  switch(currentQuestion().type) {
    case 'multiple_choice':

      if($('#radios input[type=radio]:checked').length === 1)
        answered = true;

      if(answered)
        questions[current_question_number - 1].answer = $('#radios input[type=radio]:checked').data('id');
      else
        questions[current_question_number - 1].answer = false;

      break;

    case 'numerical':

      if($('.numerical_answer input[type=number]').val().trim() !== '')
        answered = true;

      if(answered)
        questions[current_question_number - 1].answer = $('.numerical_answer input[type=number]').val();
      else
        questions[current_question_number - 1].answer = false;

      break;
  }

  if(answered) {
    // Send data to server here
    $.ajax({
      url: '/answers.json',
      type: 'POST',
      contentType: 'application/json',
      data: JSON.stringify({answer: {question_id: currentQuestion().id, answer: currentQuestion().answer, review: true}})
    }).done(function(data) {
      if(data == true)
        $('#saved').show().delay(1500).fadeOut();
      else
        $('#not_saved').show().delay(1500).fadeOut();
    });

    currentButton().removeClass('not_answered').removeClass('answered').removeClass('review').addClass('review_answered');
  } else {
    currentButton().removeClass('not_answered').removeClass('answered').removeClass('review_answered').addClass('review');
  }

  loadQuestion(current_question_number + 1);
}

function saveAndNext() {
  var answered = false;

  switch(currentQuestion().type) {
    case 'multiple_choice':

      if($('#radios input[type=radio]:checked').length === 1)
        answered = true;

      if(answered)
        questions[current_question_number - 1].answer = $('#radios input[type=radio]:checked').data('id');
      else
        questions[current_question_number - 1].answer = false;

      break;

    case 'numerical':

      if($('.numerical_answer input[type=number]').val().trim() !== '')
        answered = true;

      if(answered)
        questions[current_question_number - 1].answer = $('.numerical_answer input[type=number]').val();
      else
        questions[current_question_number - 1].answer = false;

      break;
  }

  if(answered) {
    // Send data to server here
    $.ajax({
      url: '/answers.json',
      type: 'POST',
      contentType: 'application/json',
      data: JSON.stringify({answer: {question_id: currentQuestion().id, answer: currentQuestion().answer, review: false}})
    }).done(function(data) {
      if(data == true)
        $('#saved').show().delay(1500).fadeOut();
      else
        $('#not_saved').show().delay(1500).fadeOut();
    });

    currentButton().removeClass('not_answered').removeClass('review_answered').removeClass('review').addClass('answered');
  } else {
    currentButton().removeClass('review').removeClass('answered').removeClass('review_answered').addClass('not_answered');
  }

  loadQuestion(current_question_number + 1);
}

/* Countdown timer */
function pad2(n){
    return n > 9 ? "" + n: "0" + n;
}

function countdown($time) {
  minutes = Math.floor($time / 60);
  seconds = $time % 60;

  $('#timer').html(pad2(minutes) + ":" + pad2(seconds));
  setTimeout(update, 1000);
}

function update() {
  if(seconds != 0) {
    seconds--;
  }
  else if(minutes != 0) {
    minutes--;
    seconds = 59;
  }
  else {
    /* Perform navigation for submission */
    timer_completed();

    return;
  }
  
  $('#timer').html(pad2(minutes) + ":" + pad2(seconds));
  setTimeout(update, 1000);
}

/* Page load and navigation */

var confirmOnPageExit = function (e) 
{
    e = e || window.event;
    var message = 'All unsaved answers will be lost.';

    if (e) {
        e.returnValue = message;
    }

    return message;
};

$(function() {
  set_icons();
  loadQuestion(1);

  $('.button').on('click', function() { loadQuestion($(this).data('id')); });
  $('#mark_for_review').on('click', markForReview);
  $('#clear_response').on('click', clearResponse);
  $('#save_and_next').on('click', saveAndNext);

  countdown(time_left)

  // window.onbeforeunload = confirmOnPageExit;
});


