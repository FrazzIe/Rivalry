$(document).ready(function(){  // Mouse Controls
  var documentWidth = document.documentElement.clientWidth;
  var documentHeight = document.documentElement.clientHeight;

  // Partial Functions
  function closeMain() {
    $(".home").css("display", "none");
  }
  function openMain() {
    $(".home").css("display", "block");
  }
  function closeAll() {
    $(".body").css("display", "none");
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
  function openNews() {
    $(".news-container").css("display", "block");
  }

  function openNewsCreator() {
    $(".news-container").css("display", "block");
  }

  function openNewsPaper() {
    $(".news-paper").css("display", "block");
  }

  function openEditor(time, editor_name, header, body, header2, body2) {
    $(".news-container").css("display", "block");
    $("#time").val(time);
    $("#editor_name").val(editor_name);
    $("#header").val(header);
    $("#body").val(body);
    $("#header2").val(header2);
    $("#body2").val(body2);
  }

  function viewNewspaper(time, editor_name, header, body, header2, body2) {
    $(".news-paper").css("display", "block");
    $("#news-time").html(time);
    $("#news-editor_name").html(editor_name);
    $("#news-header").html(header);
    $("#news-body").html(body);
    $("#news-header2").html(header2);
    $("#news-body2").html(body2);
  }

  function addNew(item) {
    var dateVal ="/Date(" + (item.time * 1000) + ")/";
    var date = new Date( parseFloat( dateVal.substr(6 )));
    let time = (date.getMonth() + 1) + "/" +    date.getDate() + "/" + date.getFullYear() + " " + date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds()
    $('#news').append('<footer><p>' + item.time + '</p><p>' + item.editor_name + '</p></footer><head><p>' + item.header + '</p></head><body><p>' + item.body + '</p></body><header><p>' + item.header2 + '</p></header>' + '<body><p>' +item.body2 + '</p></body>')
    $("#news-" + "").click(function(){
      $.post('http://core_modules/newsRead', JSON.stringify({time: item.time, editor_name: item.editor_name, header: item.header, body: item.body, header2: item.header2, body2: item.body2 }));  
    })    
  }

  // Listen for NUI Events
  window.addEventListener('message', function(event){
    var item = event.data;
    // Trigger adding a new news to the log and create its display

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
    if(item.openSection === "news") {
      $("#news").empty();
      $("#news").append("<th>Time</th><th>Editor_Name</th><th>Header</th><th>Body</th><th>Header2</th><th>Body2</th>");
      addNew(item.list);
      closeAll();
      openNewsPaper();
    }
    if(item.openSection === "loadEdit") {
      closeAll();
      openNews();
    }
    if(item.openSection === "newsRead") {
      closeAll();
      viewNewspaper(item.time, item.editor_name, item.header, item.body, item.header, item.body2);
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

  $(".btnNews").click(function(){
      $.post('http://core_modules/loadEdit', JSON.stringify({}));
  });

  $(".btnPage").click(function(){
      $.post('http://core_modules/loadnews', JSON.stringify({}));
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