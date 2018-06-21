$(document).ready(function(){  // Mouse Controls
  var documentWidth = document.documentElement.clientWidth;
  var documentHeight = document.documentElement.clientHeight;

  // Partial Functions
  function closeMain() {
    $(".news-container").css("display", "none");
  }
  function openMain() {
    $(".news-container").css("display", "block");
  }
  function closeAll() {
    $(".body").css("display", "none");
    $(".news-container").css("display", "none");
    $(".home").css("display", "none");
    // Clear input boxes
    $("#newnews-form #editor").val('');
    $("#newnews-form #time").val('');
    $("#newnews-form #header").val('');
    $("#newnews-form #body").val('');
    $("#newnews-form #header2").val('');
    $("#newnews-form #body2").val('');
  }
  function openContainer() {
    $(".main-container").css("display", "block");
  }
  function closeContainer() {
    $(".main-container").css("display", "none");
  }
  function opennews() {
    $(".news-container").css("display", "block");
  }
  function closenews() {
    $(".news-container".css("display", "none"));
    $(".full-screen".css("display", "none"));
  }

  function addnews(items) {
    for(let i in items) {
      let item = items[i];
      var dateVal ="/Date(" + (item.time * 1000) + ")/"; var date = new Date( parseFloat( dateVal.substr(6 ))); let time = (date.getMonth() + 1) + "/" +    date.getDate() + "/" + date.getFullYear() + " " + date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds()
      $('#news').append('<tr id="news-' + item.id + '"><td>' + time + '</td><td>' + item.editor_name + '</td><td>' + item.header + '</td><td width="50%"><textarea rows="3" placeholder="" class="sans" disabled="true">' + '</textarea></td></tr>')
      $("#news-" + item.id + "").click(function(){
        $.post('http://core_modules/news-form', JSON.stringify({id: item.id, time: item.time, editor_name: item.editor_name, header: item.header, body: item.body, header2: item.header2, body2: item.body2}));  
      })
    }
  }
  function addnews(item) {
    var dateVal ="/Date(" + (item.time * 1000) + ")/"; var date = new Date( parseFloat( dateVal.substr(6 ))); let time = (date.getMonth() + 1) + "/" +    date.getDate() + "/" + date.getFullYear() + " " + date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds()
    $('#news').append('<tr id="news-' + item.id + '"><td>' + time + '</td><td>' + item.editor_name + '</td><td>' + item.header + '</td><td width="50%"><textarea rows="3" placeholder="" class="sans" disabled="true">' + '</textarea></td></tr>')
    $("#news-" + item.id + "").click(function(){
      $.post('http://core_modules/news-form', JSON.stringify({id: item.id, time: item.time, editor_name: item.editor_name, header: item.header, body: item.body, header2: item.header2, body2: item.body2}));  
    })
  }

  // Listen for NUI Events
  window.addEventListener('message', function(event){
    var item = event.data;
    // Trigger adding a new news to the log and create its display
    if (item.news === true) {
      addnews(item.news);
    }
    // Open & Close main news window
    if(item.active === true) {
      closeAll();
      openContainer();
      openMain();
    }
    if(item.active === false) {
      closeContainer();
      closeMain();
    }
  });

  // On 'Esc' call close method
  document.onkeyup = function (data) {
    if (data.which == 27 ) {
      $.post('http://core_modules/close', JSON.stringify({}));
    }
  };

  $(".btnClose").click(function(){
  	  $.post('http://core_modules/close', JSON.stringify({}));
  });

  // Handle Form Submits
  $("#newnews-form").submit(function(e) {
      e.preventDefault();
      $.post('http://core_modules/submit', JSON.stringify({
          time: $("#newnews-form #time").val(),
          editor_name: $("#newnews-form #editor_name").val(),
          header: $("#newnews-form #header").val(),
          body: $("#newnews-form #body").val(),
          header2: $("#newnews-form #header2").val(),
          body2: $("#newnews-form #body2").val()        
      }));
      $("#newnews-form #time").prop('disabled', true);
      $("#newnews-form #editor_name").prop('disabled', true);
      $("#newnews-form #header").prop('disabled', true);
      $("#newnews-form #body").prop('disabled', true);
      $("#newnews-form #header2").prop('disabled', true);
      $("#newnews-form #body2").prop('disabled', true);
      $("#newnews-form #submit").css('display', 'none');
      setTimeout(function(){
        $("#newnews-form #time").prop('disabled', false);
        $("#newnews-form #editor_name").prop('disabled', false);
        $("#newnews-form #header").prop('disabled', false);
        $("#newnews-form #body").prop('disabled', false);
        $("#newnews-form #header2").prop('disabled', false);
        $("#newnews-form #body2").prop('disabled', false);
        $("#newnews-form #submit").css('display', 'block');
        $("#newnews-form #time").val('')
        $("#newnews-form #editor_name").val('')
        $("#newnews-form #header").val('')
        $("#newnews-form #body").val('');
        $("#newnews-form #header2").val('');
        $("#newnews-form #body2").val('');
        $.post('http://core_modules/close', JSON.stringify({}));
      }, 1500);
  });
});