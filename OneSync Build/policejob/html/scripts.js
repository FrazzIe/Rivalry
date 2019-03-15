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
    $(".warrant-container").css("display", "none");
    $(".arrest-view-container").css("display", "none");
    $(".violation-view-container").css("display", "none");
    $(".newViolation-container").css("display", "none");
    // Clear input boxes
    $("#warrant-notes").val('');

    $("#newWarrant-form #name").val('');
    $("#newWarrant-form #loc").val('');
    $("#newWarrant-form #notes").val('');
  }
  function openContainer() {
    $(".main-container").css("display", "block");
  }
  function closeContainer() {
    $(".main-container").css("display", "none");
  }
  function openWarrants() {
    $(".history-container").css("display", "block");
  }
  function openArrests() {
    $(".arrest-container").css("display", "block");
  }
  function openViolations() {
    $(".violation-container").css("display", "block");
  }
  function openWarrantRead(id, timestamp, officer_name, offender_name, location, notes) {
    $(".warrant-container").css("display", "block");
    $("#warrant-timestamp").html(timestamp);
    $("#warrant-officer").html(officer_name);
    $("#warrant-name").html(offender_name);
    $("#warrant-loc").html(location);
    $("#warrant-notes").val(notes);
    $("#warrant-id").val(id);
  }
  function viewArrest(id, timestamp, officer, offender, sentenceORfine, sentence, charges, fine) {
    $(".arrest-view-container").css("display", "block");
    $("#arrest-officer").html(officer);
    $("#arrest-time").html(timestamp);
    $("#arrest-offender").html(offender);
    $("#arrest-jailfine").html(sentenceORfine);
    $("#arrest-jailtime").html(sentence);
    $("#arrest-charges").html(charges);
    $("#arrest-fine").html(fine);
    $("#arrest-id").val(id);
  }
  function viewViolation(id, timestamp, officer, offender, fine, violations) {
    $(".violation-view-container").css("display", "block");
    $("#violation-officer").html(officer);
    $("#violation-offender").html(offender);
    $("#violation-timestamp").html(timestamp);
    $("#violation-fine").html(fine);
    $("#violation-violations").html(violations);
    $("#violation-id").val(id);
  }
  function openNewWarrant() {
    $(".newWarrant-container").css("display", "block");
  }
  function openArrestCreation() {
    $(".newMDT-container").css("display", "block");
  }
  function openViolationCreation() {
    $(".newViolation-container").css("display", "block");
  }
  function openNewWarrantReply(number) {
    $(".newWarrant-container").css("display", "block");
    $("#newWarrant-form #number").val(number);
  }
  function openContacts() {
    $(".contacts-container").css("display", "block");
  }
  function openNewContact() {
    $(".newContact-container").css("display", "block");
  }
  function openAlerts() {
    $(".alerts-container").css("display", "block");
  }

  function addWarrants(items) {
    for(let i in items) {
      let item = items[i];
      var dateVal ="/Date(" + (item.timestamp * 1000) + ")/"; var date = new Date( parseFloat( dateVal.substr(6 ))); let timestamp = (date.getMonth() + 1) + "/" +    date.getDate() + "/" + date.getFullYear() + " " + date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds()
      $('#warrants').append('<tr id="warrant-' + item.id + '"><td>' + timestamp + '</td><td>' + item.officer_name + '</td><td>' + item.offender_name + '</td><td width="50%"><textarea rows="3" placeholder="" class="sans" disabled="true">' + item.notes + '</textarea></td></tr>')
      $("#warrant-" + item.id + "").click(function(){
        $.post('http://policejob/warrantRead', JSON.stringify({id: item.id, timestamp: timestamp, officer_name: item.officer_name, offender_name: item.offender_name, location: item.location, notes: item.notes}));  
      })
    }
  }
  function addWarrant(item) {
    var dateVal ="/Date(" + (item.timestamp * 1000) + ")/"; var date = new Date( parseFloat( dateVal.substr(6 ))); let timestamp = (date.getMonth() + 1) + "/" +    date.getDate() + "/" + date.getFullYear() + " " + date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds()
    $('#warrants').append('<tr id="warrant-' + item.id + '"><td>' + timestamp + '</td><td>' + item.officer_name + '</td><td>' + item.offender_name + '</td><td width="50%"><textarea rows="3" placeholder="" class="sans" disabled="true">' + item.notes + '</textarea></td></tr>')
    $("#warrant-" + item.id + "").click(function(){
      $.post('http://policejob/warrantRead', JSON.stringify({id: item.id, timestamp: timestamp, officer_name: item.officer_name, offender_name: item.offender_name, location: item.location, notes: item.notes}));  
    })
  }
  function addArrests(items) {
    for(let i in items) {
      let item = items[i];
      var dateVal ="/Date(" + (item.timestamp * 1000) + ")/"; var date = new Date( parseFloat( dateVal.substr(6 ))); let timestamp = (date.getMonth() + 1) + "/" +    date.getDate() + "/" + date.getFullYear() + " " + date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds()
      $('#arrests').append('<tr id="arrest-' + item.id + '"><td>' + timestamp + '</td><td>' + item.officer_name + '</td><td>' + item.offender_name + '</td><td>' + item.sentence + '</td><td>' + item.fine + '</td><td width="50%"><textarea rows="3" placeholder="" class="sans" disabled="true">' + item.charges + '</textarea></td></tr>')
      $("#arrest-" + item.id + "").click(function(){
        $.post('http://policejob/viewArrest', JSON.stringify({id: item.id, timestamp: timestamp, officer_name: item.officer_name, offender_name: item.offender_name, sentenceORfine: item.sentenceORfine, sentence: '' + item.sentence + ' seconds', charges: item.charges, fine: '$' + item.fine + ''}));  
      })
    }
  }

  function addArrest(item) {
    var dateVal ="/Date(" + (item.timestamp * 1000) + ")/";
    var date = new Date( parseFloat( dateVal.substr(6 )));
    let timestamp = (date.getMonth() + 1) + "/" +    date.getDate() + "/" + date.getFullYear() + " " + date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds()
    $('#arrests').append('<tr id="arrest-' + item.id + '"><td>' + item.timestamp + '</td><td>' + item.officer_name + '</td><td>' + item.offender_name + '</td><td>' + item.sentence + '</td><td>' + item.fine + '</td><td width="50%"><textarea rows="3" placeholder="" class="sans" disabled="true">' + item.charges + '</textarea></td></tr>')
    $("#arrest-" + item.id + "").click(function(){
      $.post('http://policejob/viewArrest', JSON.stringify({id: item.id, timestamp: timestamp, officer_name: item.officer_name, offender_name: item.offender_name, sentenceORfine: item.sentenceORfine, sentence: '' + item.sentence + ' seconds', charges: item.charges, fine: '$' + item.fine + ''}));  
    })    
  }

  function addViolations(items) {
    for(let i in items) {
      let item = items[i];
      var dateVal ="/Date(" + (item.timestamp * 1000) + ")/"; var date = new Date( parseFloat( dateVal.substr(6 ))); let timestamp = (date.getMonth() + 1) + "/" +    date.getDate() + "/" + date.getFullYear() + " " + date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds()
      $('#violations').append('<tr id="violation-' + item.id + '"><td>' + timestamp + '</td><td>' + item.officer_name + '</td><td>' + item.offender_name + '</td><td>' + item.fine + '</td><td width="50%"><textarea rows="3" placeholder="" class="sans" disabled="true">' + item.violations + '</textarea></td></tr>')
      $("#violation-" + item.id + "").click(function(){
        $.post('http://policejob/viewViolation', JSON.stringify({id: item.id, timestamp: timestamp, officer_name: item.officer_name, offender_name: item.offender_name, violations: item.violations, fine: '$' + item.fine + ''}));  
      })
    }
  }

  function addViolation(item) {
    var dateVal ="/Date(" + (item.timestamp * 1000) + ")/";
    var date = new Date( parseFloat( dateVal.substr(6 )));
    let timestamp = (date.getMonth() + 1) + "/" +    date.getDate() + "/" + date.getFullYear() + " " + date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds()
    $('#violations').append('<tr id="violation-' + item.id + '"><td>' + timestamp + '</td><td>' + item.officer_name + '</td><td>' + item.offender_name + '</td><td>' + item.fine + '</td><td width="50%"><textarea rows="3" placeholder="" class="sans" disabled="true">' + item.violations + '</textarea></td></tr>')
    $("#violation-" + item.id + "").click(function(){
      $.post('http://policejob/viewViolation', JSON.stringify({id: item.id, timestamp: timestamp, officer_name: item.officer_name, offender_name: item.offender_name, violations: item.violations, fine: '$' + item.fine + ''}));  
    })    
  }
  // Listen for NUI Events
  window.addEventListener('message', function(event){
    var item = event.data;
    // Trigger adding a new warrant to the log and create its display
    if (item.newWarrant === true) {
      addWarrant(item.warrant);
    }
    // Open & Close main warrants window
    if(item.active === true) {
      closeAll();
      openContainer();
      openMain();
    }
    if(item.active === false) {
      closeContainer();
      closeMain();
    }
    // Open sub-windows / partials
    if(item.openSection == "warrants") {
      $("#warrants").empty();
      $("#warrants").append("<th>Timestamp</th><th>Officer</th><th>Name or Description</th><th>Notes</th>")
      addWarrants(item.list);
      closeAll();
      openWarrants();
    }
    if(item.openSection == "warrantRead") {
      closeAll();
      openWarrantRead(item.id, item.timestamp, item.officer_name, item.offender_name, item.location, item.notes);
    }
    if(item.openSection == "viewArrest") {
      closeAll();
      viewArrest(item.id, item.timestamp, item.officer_name, item.offender_name, item.sentenceORfine, item.sentence, item.charges, item.fine);
    }
    if(item.openSection == "newWarrant") {
      closeAll();
      openNewWarrant();
      if (item.location) {        
        $("#newWarrant-form #loc").val(item.location);
      }
    }
    if(item.openSection == "arrests") {
      $("#arrests").empty();
      $("#arrests").append("<th>Timestamp</th><th>Officer</th><th>Offender</th><th>Sentence</th><th>Fine</th><th>Charges</th>");
      addArrests(item.list);
      closeAll();
      openArrests();
    }
    if(item.openSection == "newArrest") {
      closeAll();
      openArrestCreation();
    }
    if(item.openSection == "autofill_arrests") {
      $("#new-arrest-entry-form #arrest_officer").val(item.officer_name);
      $("#new-arrest-entry-form #Charges").val(item.charges);
      $("#new-arrest-entry-form #FineTicketAmount").val(item.fine);
      $("#new-arrest-entry-form #arrest_offender").val(item.offender_name);
      $("#new-arrest-entry-form #Jailtime").val(item.jail);
    }
    if(item.openSection == "addNewArrest") {
      addArrest(item.new_arrest);
    }
    if(item.openSection == "violations") {
      $("#violations").empty();
      $("#violations").append("<th>Timestamp</th><th>Officer</th><th>Offender</th><th>Fine</th><th>Violations</th>");
      addViolations(item.list);
      closeAll();
      openViolations();
    }
    if(item.openSection == "viewViolation") {
      closeAll();
      viewViolation(item.id, item.timestamp, item.officer_name, item.offender_name, item.fine, item.violations);
    }
    if(item.openSection == "newViolation") {
      closeAll();
      openViolationCreation();
    }
    if(item.openSection == "addNewViolation") {
      addViolation(item.new_violation);
    }
    if(item.openSection == "autofill_violations") {
      $("#violation_officer").val(item.officer_name);
      $("#violation_offender").val(item.offender_name);
      $("#Violations").val(item.violations);
      $("#Fine").val(item.fine);
    }
  });

  // On 'Esc' call close method
  document.onkeyup = function (data) {
    if (data.which == 27 ) {
      $.post('http://policejob/close', JSON.stringify({}));
    }
  };

  // Handle Button Presses
  $(".btnHome").click(function(){
      closeAll();
      openMain();
  });
  $(".btnClose").click(function(){
  	  $.post('http://policejob/close', JSON.stringify({}));
  });
  $(".btnWarrants").click(function(){
      $.post('http://policejob/loadWarrants', JSON.stringify({}));
  });
  $(".btnMDT").click(function(){
      $.post('http://policejob/loadArrests', JSON.stringify({}));
  });
  $(".btnViolations").click(function(){
      $.post('http://policejob/loadViolations', JSON.stringify({}));
  });
  $(".btnRemove").click(function(){
    if (confirm('Are you sure you want permanently delete this warrant?') === true) {
      $.post('http://policejob/warrantDelete', JSON.stringify({
          id: $("#warrant-id").val(),
      }));
      setTimeout(function(){
        closeAll();
        openMain();
      }, 500);
    }
  });
  $(".btnRemove2").click(function(){
    if (confirm('Are you sure you want permanently delete this arrest record?') === true) {
      $.post('http://policejob/removeArrest', JSON.stringify({
          id: $("#arrest-id").val(),
      }));
      setTimeout(function(){
        closeAll();
        openMain();
      }, 500);
    }
  });
  $(".btnRemove3").click(function(){
    if (confirm('Are you sure you want permanently delete this violation?') === true) {
      $.post('http://policejob/removeViolation', JSON.stringify({
          id: $("#violation-id").val(),
      }));
      setTimeout(function(){
        closeAll();
        openMain();
      }, 500);
    }
  });
  $(".btnNewWarrant").click(function(){
      $.post('http://policejob/newWarrant', JSON.stringify({}));
  });
  
  // Handle Form Submits
  $("#newWarrant-form").submit(function(e) {
      e.preventDefault();
      $.post('http://policejob/newWarrantSubmit', JSON.stringify({
          offender_name: $("#newWarrant-form #name").val(),
          location: $("#newWarrant-form #loc").val(),
          notes: $("#newWarrant-form #notes").val()
      }));
      $("#newWarrant-form #name").prop('disabled', true);
      $("#newWarrant-form #loc").prop('disabled', true);
      $("#newWarrant-form #notes").prop('disabled', true);
      $("#newWarrant-form #submit").css('display', 'none');
      setTimeout(function(){
        $("#newWarrant-form #name").prop('disabled', false);
        $("#newWarrant-form #loc").prop('disabled', false);
        $("#newWarrant-form #notes").prop('disabled', false);
        $("#newWarrant-form #name").val('');
        $("#newWarrant-form #loc").val('');
        $("#newWarrant-form #notes").val('');
        $("#newWarrant-form #submit").css('display', 'block');
        $.post('http://policejob/close', JSON.stringify({}));
      }, 1500);
  });
  $(".btnNewMDT").click(function(){
      $.post('http://policejob/newArrest', JSON.stringify({}));
  });
  $("#new-arrest-entry-form").submit(function(e) {
      e.preventDefault();
      $.post('http://policejob/newArrestSubmit', JSON.stringify({
        officer_name: $("#new-arrest-entry-form #arrest_officer").val(),
        offender_name: $("#new-arrest-entry-form #arrest_offender").val(),
        sentenceORfine: $("#new-arrest-entry-form #JailorTicket").val(),
        sentence: $("#new-arrest-entry-form #Jailtime").val(),
        fine: $("#new-arrest-entry-form #FineTicketAmount").val(),
        charges: $("#new-arrest-entry-form #Charges").val(),
      }));
      $("#new-arrest-entry-form #arrest_officer").prop('disabled', true);
      $("#new-arrest-entry-form #arrest_offender").prop('disabled', true);
      $("#new-arrest-entry-form #JailorTicket").prop('disabled', true);
      $("#new-arrest-entry-form #Jailtime").prop('disabled', true);
      $("#new-arrest-entry-form #Charges").prop('disabled', true);
      $("#new-arrest-entry-form #FineTicketAmount").prop('disabled', true);
      $("#new-arrest-entry-form #submit2").css('display', 'none');
      setTimeout(function(){
        $("#new-arrest-entry-form #arrest_officer").prop('disabled', false);
        $("#new-arrest-entry-form #arrest_offender").prop('disabled', false);
        $("#new-arrest-entry-form #JailorTicket").prop('disabled', false);
        $("#new-arrest-entry-form #Jailtime").prop('disabled', false);
        $("#new-arrest-entry-form #Charges").prop('disabled', false);
        $("#new-arrest-entry-form #FineTicketAmount").prop('disabled', false);
        $("#new-arrest-entry-form #submit2").css('display', 'block');
        $("#new-arrest-entry-form #arrest_officer").val('');
        $("#new-arrest-entry-form #arrest_offender").val('');
        $("#new-arrest-entry-form #JailorTicket").val('');
        $("#new-arrest-entry-form #Jailtime").val('');
        $("#new-arrest-entry-form #Charges").val('');
        $("#new-arrest-entry-form #FineTicketAmount").val('');
        $.post('http://policejob/close', JSON.stringify({}));
      }, 1500);
  });
  $(".btnMDTAutofill").click(function(){
      $.post('http://policejob/autofillArrest', JSON.stringify({}));
  });
  $(".btnNewViolation").click(function(){
      $.post('http://policejob/newViolation', JSON.stringify({}));
  });
  $("#new-violation-entry-form").submit(function(e) {
      e.preventDefault();
      $.post('http://policejob/newViolationSubmit', JSON.stringify({
        officer_name: $("#new-violation-entry-form #violation_officer").val(),
        offender_name: $("#new-violation-entry-form #violation_offender").val(),
        fine: $("#new-violation-entry-form #Fine").val(),
        violations: $("#new-violation-entry-form #Violations").val(),
      }));
      $("#new-violation-entry-form #violation_officer").prop('disabled', true);
      $("#new-violation-entry-form #violation_offender").prop('disabled', true);
      $("#new-violation-entry-form #Violations").prop('disabled', true);
      $("#new-violation-entry-form #Fine").prop('disabled', true);
      $("#new-violation-entry-form #submit3").css('display', 'none');
      setTimeout(function(){
        $("#new-violation-entry-form #violation_officer").prop('disabled', false);
        $("#new-violation-entry-form #violation_offender").prop('disabled', false);
        $("#new-violation-entry-form #Violations").prop('disabled', false);
        $("#new-violation-entry-form #Fine").prop('disabled', false);
        $("#new-violation-entry-form #submit3").css('display', 'block');
        $("#new-violation-entry-form #officer").val('');
        $("#new-violation-entry-form #offender").val('');
        $("#new-violation-entry-form #Violations").val('');
        $("#new-violation-entry-form #Fine").val('');
        $.post('http://policejob/close', JSON.stringify({}));
      }, 1500);
  });
  $(".btnViolationAutofill").click(function(){
      $.post('http://policejob/autofillViolation', JSON.stringify({}));
  });
  // Handle warrant search filtering
  $("#search_warrants").bind('input', function(elem){
    var search = elem.target.value.trim();
    $("#warrants").find("tr[id*='warrant-']").each(function(i, el){  
      if (search.length === 0) {
          el.style.display = "table-row";
          return;
      }
      
      var offender_name = el.children[2].innerHTML;
      var reg = new RegExp('(.*)' + search + '(.*)', 'ig');
      if (!reg.test(offender_name)) {
        el.style.display = "none";
      }
    });
  });

  $("#search_arrests").bind('input', function(elem){
    var search2 = elem.target.value.trim();
    $("#arrests").find("tr[id*='arrest-']").each(function(i, el){  
      if (search2.length === 0) {
          el.style.display = "table-row";
          return;
      }
      
      var offender_name = el.children[2].innerHTML;
      var reg2 = new RegExp('(.*)' + search2 + '(.*)', 'ig');
      if (!reg2.test(offender_name)) {
        el.style.display = "none";
      }
    });
  });

  $("#search_violations").bind('input', function(elem){
    var search2 = elem.target.value.trim();
    $("#arrests").find("tr[id*='violation-']").each(function(i, el){  
      if (search2.length === 0) {
          el.style.display = "table-row";
          return;
      }
      
      var offender_name = el.children[2].innerHTML;
      var reg2 = new RegExp('(.*)' + search2 + '(.*)', 'ig');
      if (!reg2.test(offender_name)) {
        el.style.display = "none";
      }
    });
  });
  $("#search_warrants").keypress(function(event) {
      if (event.keyCode == 13) {
          event.preventDefault();
      }
  });
  $("#search_arrests").keypress(function(event) {
      if (event.keyCode == 13) {
          event.preventDefault();
      }
  });
  $("#search_violations").keypress(function(event) {
      if (event.keyCode == 13) {
          event.preventDefault();
      }
  });
});