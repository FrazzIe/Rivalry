// make dial draggable
Draggable.create(".dial", {
  type:"rotation",
  throwProps:true
});
// values 40 or above will be set to 0
const combo = [20, 5, 30],
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
              $(".num" + (i + 1)).addClass("found");
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
for (let i = 0; i < combo.length; ++i) {
  if (combo[i] >= 40) {
    combo[i] = 0;
  }
  $(".num" + (i + 1)).html(combo[i]);
}
// dial interaction (mouse)
$(".dial").on("click",function(){
    findCombo(combo);
});
// dial interaction (touch)
$(".dial").on("touchend",function(){
    findCombo(combo);
});