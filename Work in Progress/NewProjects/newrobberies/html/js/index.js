$(document).ready(function(){
  var documentWidth = document.documentElement.clientWidth;
  var documentHeight = document.documentElement.clientHeight;
  // make dial draggable
    $(".container").hide();
    $(".combo").hide();
    $(".num1").hide();
    $(".num2").hide();
    $(".num3").hide();
    $('#body').hide();
  function openMain() {
    $(".container").show();
    $(".combo").show();
    $('#body').show();
  }
  function closeAll() {
    $(".container").hide();
    $('#body').hide();
  }
  function closeMain() {
    $(".container").hide();
    $(".combo").hide();
    $(".num1").hide();
    $(".num2").hide();
    $(".num3").hide();
    $(".num1").html("");
    $(".num2").html("");
    $(".num3").html("");
    $('#body').hide();
  }
  Draggable.create(".dial", {
    type:"rotation",
    throwProps:true
  });
  // values 40 or above will be set to 0
  var combo = [],
        findCombo = function(comboArr){
          let dial = $(".dial"),
              dialTrans = dial.css("transform"),
              ticks = 40,
              tickAngle = 360 / ticks,
              numOffset = 0.5, // how far red arrow can be from number
              // break down matrix value of dial transform and get angle
              matrixVal = dialTrans.split('(')[1].split(')')[0].split(','),
              cos1 = matrixVal[0],
              sin = matrixVal[1],
              negSin = matrixVal[2],
              cos2 = matrixVal[3],
              angle = Math.round(Math.atan2(sin, cos1) * (180 / Math.PI)) * -1;
          // convert negative angles to positive
          if (angle < 0) {
            angle += 360;
          }
          // check numbers found, stop loop if at first number not found
          for (let i = 0; i < comboArr.length; ++i) {
            if (!$(".num" + (i + 1)).hasClass("found")) {
              if (angle > (comboArr[i] - numOffset) * tickAngle &&
                angle < (comboArr[i] + numOffset) * tickAngle) {
                // make numbers green when found
                $.post('http://newrobberies/lockclick', JSON.stringify({}));
                setTimeout(1000);
                if (angle > (comboArr[i] - numOffset) * tickAngle &&
                angle < (comboArr[i] + numOffset) * tickAngle) {
                  $(".num" + (i + 1)).addClass("found");

                  $(".num" + (i + 1)).html(combo[i]);
                  $(".num" + (i + 1)).show();
                }
                // on unlock
                if (i == comboArr.length - 1) {
                  $(".shackle").addClass("unlocked");
                  $(".top").addClass("pivot1");
                  $(".inner").addClass("pivot2");
                  $(".left").addClass("moveRight");
                  $(".dentL, .dentR").addClass("moveLeft");
                  // then lock again
                  setTimeout(function() {
                    $(".shackle").removeClass("unlocked");
                    $(".top").removeClass("pivot1");
                    $(".inner").removeClass("pivot2");
                    $(".left").removeClass("moveRight");
                    $(".dentL, .dentR").removeClass("moveLeft");
                    for (let j = 0; j < combo.length; ++j) {
                      $(".num" + (j + 1)).removeClass("found");
                    }
                  }, 2400);
                }
            }
              break;
            }
        }
      };
  // show combination to user
  if (combo.length > 0) {
    for (let i = 0; i < combo.length; ++i) {
      if (combo[i] >= 40) {
        combo[i] = 0;
      }
      $(".num" + (i + 1)).hide();
      $(".num" + (i + 1)).html(combo[i]);
    }
  }
  // dial interaction (mouse)
  $(".dial").on("click",function(){
      findCombo(combo);
      $.post('http://newrobberies/dialsound', JSON.stringify({}));
  });
  // dial interaction (touch)
  $(".dial").on("touchend",function(){
      findCombo(combo);
      $.post('http://newrobberies/dialsound', JSON.stringify({}));
  });

  document.onkeyup = function (data) {
    if (data.which == 27 ) {
      closeMain();
      $.post('http://newrobberies/close', JSON.stringify({}));
    }
  };

  window.addEventListener('message', function(event){
    var item = event.data;
    if(item.combolock === true) {
      openMain();
    }
    if(item.combolock === false) {
      closeMain();
    }
    if(item.newnumber === true) { 
      combo = [item.numberone, item.numbertwo, item.numberthree];
    }
  });
});