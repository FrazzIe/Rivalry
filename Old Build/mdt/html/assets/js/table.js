$(document).ready(function(){
var logo = '#logo';
var logintext = '#logintext'
var departments = '#departments'
var playersearch = '#playersearch'
var playertable = '#playertable'
var stats = '#stats'
var tabs = '#tabs'
var reports = '#reports'
var reportstable = '#reportstable'
var policefooter = '#policefooter'
var arrestRow = '#ArrestsRow'
var ticketsRow = '#TicketsRow'
var vehiclesRow = '#VehiclesRow'
var addArrestRow = '#AddArrestRow'
var addCitationRow = '#AddCitationRow'
var notepadRow = '#NotepadRow'
var firstnamev = ""
var homepage = '#homepage'
var lastnamev = ""
var warrants = '#selectedwarrant'
var warrantsedit = '#warrantsedit'

function openMDT(){ 
    $('body').css("display", "block");
    $('body').show();
};
function closeMDT(){
    document.close();
    $('body').css("display", "none");
    $('body').hide();
};

function closeWarrants(){
    $('#WarrantHeader').hide();
    $('#WarrantRowOne').hide();
    $('#WarrantRowTwo').hide();
    $('#WarrantRowThree').hide();
    $('#WarrantRowFour').hide();
}

function openWarrants(){
    $('#WarrantHeader').show();
    $('#WarrantRowOne').show();
    $('#WarrantRowTwo').show();
    $('#WarrantRowThree').show();
    $('#WarrantRowFour').show();
    $('#warrant-add').show();
}

$(playersearch).hide();
$(playertable).hide();
$(stats).hide();
$(tabs).hide();
$(warrants).hide();
$(warrantsedit).hide();
$(reports).hide();
$(reportstable).hide();
$(policefooter).hide();
$(arrestRow).hide();
$(ticketsRow).hide();
$(vehiclesRow).hide();
$(addArrestRow).hide();
$(addCitationRow).hide();
$(notepadRow).hide();
$(homepage).hide();
$('body').hide();
$('#WarrantHeader').hide();
$('#WarrantRowOne').hide();
$('#WarrantRowTwo').hide();
$('#WarrantRowThree').hide();
$('#WarrantRowFour').hide();
$('#warrant-add').hide();
$('#report-submit').hide();
$('#reportst').hide();

function closeAllPoliceNoFooter() {
    $(playersearch).hide();
    $(playertable).hide();
    $(stats).hide();
    $(tabs).hide();
    $(warrants).hide();
    $(warrantsedit).hide();
    $(reports).hide();
    $(reportstable).hide();
    $(arrestRow).hide();
    $(ticketsRow).hide();
    $(vehiclesRow).hide();
    $(addArrestRow).hide();
    $(addCitationRow).hide();
    $(notepadRow).hide();
    $(homepage).hide();
    $('#WarrantHeader').hide();
    $('#WarrantRowOne').hide();
    $('#WarrantRowTwo').hide();
    $('#WarrantRowThree').hide();
    $('#WarrantRowFour').hide();
    $('#warrant-add').hide();
    $('#report-submit').hide();
    $('#reportst').hide();
};

function closeAllPoliceWithFooter() {
    $(playersearch).hide();
    $(playertable).hide();
    $(stats).hide();
    $(tabs).hide();
    $(warrants).hide();
    $(warrantsedit).hide();
    $(reports).hide();
    $(reportstable).hide();
    $(policefooter).hide();
    $(arrestRow).hide();
    $(ticketsRow).hide();
    $(vehiclesRow).hide();
    $(addArrestRow).hide();
    $(addCitationRow).hide();
    $(notepadRow).hide();
    $(homepage).hide();
    $('#WarrantHeader').hide();
    $('#WarrantRowOne').hide();
    $('#WarrantRowTwo').hide();
    $('#WarrantRowThree').hide();
    $('#WarrantRowFour').hide();
    $('#warrant-add').hide();
    $('#report-submit').hide();
    $('#reportst').hide();
};

    $("#playerarrestrow").delegate('.cell-which-triggers-popup', 'click', function(event){
        var cell_value = $(event.target).text();
        showPopup(cell_value)    
    });
    $("#playerticketsrow").delegate('.cell-which-triggers-popup', 'click', function(event){
        var cell_value = $(event.target).text();
        showPopup(cell_value)    
    });
    $(".row-which-fills-table").click(function(event){
        var $row = jQuery(this).closest('tr');
        var $columns = $row.find('td');

        var values = [];

        jQuery.each($columns, function(i, item) {
            values.push(item.innerHTML);
        });
        
        fillRow(values[0], values[1], values[2], values[3])
        jQuery("#SelectedWarrant").show();
    });

    $("#reportsdirectory").delegate('#reportstable', 'click', function(event){
        var $row = jQuery(this).closest('tr');
        var $columns = $row.find('td');

        var values = [];

        jQuery.each($columns, function(i, item) {
            values.push(item.innerHTML);
        });
        
        idv = values[0]
        
        $.post('http://mdt/load-report', JSON.stringify({id: idv}));
    });

    $("#WarrantRowOne").delegate('#playerwarrant', 'click', function(event){
        var $col = jQuery(this).closest('div')
        var $warrant = $col.find('p')

        var values = [];

        jQuery.each($warrant, function(i, item) {
            values.push(item.innerHTML);
        });
        
        var namev = values[0]

        $.post('http://mdt/load-warrant', JSON.stringify({name: namev}))
    });

    $("#playertablez").delegate('.playerrow', 'click', function(event){
        var $row = jQuery(this).closest('tr');
        var $columns = $row.find('td');

        var values = [];

        jQuery.each($columns, function(i, item) {
            values.push(item.innerHTML);
        });
        
        firstnamev = values[2]
        lastnamev = values[1]
        
        $.post('http://mdt/player', JSON.stringify({lastname: lastnamev, firstname: firstnamev}));
        $.post('http://mdt/arrests', JSON.stringify({lastname: lastnamev, firstname: firstnamev}));
        $.post('http://mdt/tickets', JSON.stringify({lastname: lastnamev, firstname: firstnamev}));
        $.post('http://mdt/vehicles', JSON.stringify({lastname: lastnamev, firstname: firstnamev}));
        $.post('http://mdt/load-notepad', JSON.stringify({firstname: firstnamev, lastname: lastnamev}));
    });

    $("#searchplayer").click(function(event){
        
        var firstnamevz = $("#firstname").val();
        var lastnamevz = $("#lastname").val();

        if($("#firstname").val()) {
           $.post('http://mdt/search', JSON.stringify({firstname: firstnamevz, lastname: lastnamevz})); 
        }
        
    });

    function closeLoginScreen() {
        $(logo).hide();
        $(departments).hide();
        $(logintext).hide();
    };

    function openLoginScreen() {
        $(logo).show();
        $(departments).show();
        $(logintext).show();
    };

    function openPlayerInformation(){
        $(playersearch).hide();
        $(playertable).hide();
        $(stats).show();
        $(tabs).show();
        $(arrestRow).show();
    };

    function closeSelectedRows(){
        $(arrestRow).hide();
        $(ticketsRow).hide();
        $(vehiclesRow).hide();
        $(addArrestRow).hide();
        $(addCitationRow).hide();
        $(notepadRow).hide();
    };

      document.onkeyup = function (data) {
        if (data.which == 115 ) {
          $.post('http://mdt/close', JSON.stringify({}));
          closeMDT()
        }
      };

    $("#lspdmdt").click(function(event){
        $.post('http://mdt/policeopen', JSON.stringify({}));
    });

    $("#searchplayer").click(function(event){
        $(playertable).show();
    });

    $("#Arrests").click(function(event){
        closeSelectedRows();
        $(arrestRow).show();
    });

    $("#Tickets").click(function(event){
        closeSelectedRows();
        $(ticketsRow).show();
    });

    $("#Vehicles").click(function(event){
        closeSelectedRows();
        $(vehiclesRow).show();
    });

    $("#AddArrest").click(function(event){
        closeSelectedRows();
        $(addArrestRow).show();
    });

    $("#AddCitation").click(function(event){
        closeSelectedRows();
        $(addCitationRow).show();
    });

    $("#Notepad").click(function(event){
        closeSelectedRows();
        $(notepadRow).show();
    });
    
    $("#databasebtn").click(function(event){
            closeAllPoliceNoFooter();
            $(playersearch).show();
    });

    $("#warrantbtn").click(function(event){
            closeAllPoliceNoFooter();
            $('#WarrantRowOne').empty();
            openWarrants();
            $.post('http://mdt/warrantload', JSON.stringify({}));
    });

    $("#reportbtn").click(function(event){
            closeAllPoliceNoFooter();
            $('#reportst').show();
            $('#reportsdirectory').empty();
            $.post('http://mdt/load-reports', JSON.stringify({}));
    });

    $("#logoutbtn").click(function(event){
            closeAllPoliceWithFooter();
            openLoginScreen();
    });
    $("#arrest-submit").click(function(event){
            var arrestofficername = jQuery("#arrest-officer_name").val();
            var arrestoffender_first_name = jQuery("#arrest-firstname").val();
            var arrestoffender_last_name = jQuery("#arrest-lastname").val();
            var arrestcharges = jQuery("#arrest-charges").val();
            var arrestfine = jQuery("#arrest-fine").val();
            var arrestsentence = jQuery("#arrest-sentence").val();
            $.post('http://mdt/submit-arrest', JSON.stringify({officer_name: arrestofficername, firstname: arrestoffender_first_name, lastname: arrestoffender_last_name, charges: arrestcharges, fine: arrestfine, sentence: arrestsentence}));
    });
    $("#citation-submit").click(function(event){
            var citationofficername = jQuery("#citation-officer_name").val();
            var citationoffender_first_name = jQuery("#citation-firstname").val();
            var citationoffender_last_name = jQuery("#citation-lastname").val();
            var citationcharges = jQuery("#citation-charges").val();
            var citationfine = jQuery("#citation-fine").val();
            $.post('http://mdt/submit-citation', JSON.stringify({officer_name: citationofficername, firstname: citationoffender_first_name, lastname: citationoffender_last_name, charges: citationcharges, fine: citationfine}));
    });
    $("#warrant-add").click(function(event){
        closeWarrants();
        $('#warrantsedit').show();
    });
    $("#submit-warrant").click(function(event){
        closeWarrants();
        var newwarrantdate = jQuery('#newwarrantdate').val();
        var newwarrantofficer = jQuery('#newwarrantofficer').val();
        var newwarrantname = jQuery('#newwarrantname').val();
        var newwarrantdescription = jQuery('#newwarrantdescription').val();
        var newwarrantcharges = jQuery('#newwarrantcharges').val();
        $.post('http://mdt/submit-warrant', JSON.stringify({timestamp: newwarrantdate,officer_name: newwarrantofficer,offender_name: newwarrantname,location: newwarrantdescription,notes: newwarrantcharges}));
        $('#warrantsedit').hide();
    });
    $("#warrant-remove").click(function(){
	    if (confirm('Are you sure you want permanently delete this warrant?') === true) {
	      $.post('http://mdt/warrantDelete', JSON.stringify({desc: $("#selectedwarrantdescription").val()}));
	    }
  	});
    $("#notepad-submit").click(function(event){
            var notepadtext = $("#notepad").val();
            var firstnamecheck = $("#playerfirstname").html();
            var lastnamecheck = $("#playerlastname").html();
            $.post('http://mdt/submit-notepad', JSON.stringify({firstname: firstnamecheck, lastname: lastnamecheck, notes: notepadtext}));
    });
    $('#citation-autofill').click(function(event){
        $.post('http://mdt/autofillCitations', JSON.stringify({}));
    });
    $('#arrest-autofill').click(function(event){
        $.post('http://mdt/autofillArrest', JSON.stringify({}));
    });
    $('#report-submit').click(function(event){
        if (confirm('Are you sure you want to submit this report?') === true) {
        	var reportfullname = $('#reportfullname').val();
        	var reportage = $('#reportage').val();
        	var reportphonenumber = $('#reportphonenumber').val();
        	var reportdate = $('#reportdate').val();
        	var reporttime = $('#reporttime').val();
        	var reportpolice = $('#reportpolice').val();
        	var reportlocation = $('#reportlocation').val();
        	var reportdescription = $('#reportdescription').val();
        	var reportwchecky = $('#reportwchecky').is(":checked");
        	var reportwcheckn = $('#reportwcheckn').is(":checked");
        	var reportdetails = $('#reportdetails').val();
        	var reportinjury = $('#reportinjury').val();
        	var reportmedicaly = $('#reportmedicaly').is(":checked");
        	var reportmedicaln = $('#reportmedicaln').is(":checked");
        	var reportmedicalr = $('#reportmedicalr').is(":checked");
        	var reportmedicalon = $('#reportmedicalon').is(":checked");
        	var reportmedicaluc = $('#reportmedicaluc').is(":checked");
        	var reportmedicaler = $('#reportmedicaler').is(":checked");
        	var reportmedicalother = $('#reportmedicalother').is(":checked");
        	var reportofficername = $('#reportofficername').val();
        	var reportsignature = $('#reportsignature').val();
        	var reportcompleted = $('#reportcompleted').val();
            $(reports).hide();
            $.post('http://mdt/submit-report', JSON.stringify({r1: reportfullname, r2: reportage, r3: reportphonenumber, r4: reportdate, r5: reporttime, r6: reportpolice, r7: reportlocation, r8: reportdescription, r9: reportwchecky, r10: reportwcheckn, r11: reportdetails, r12: reportinjury, r13: reportmedicaly, r14: reportmedicaln, r15: reportmedicalr, r16: reportmedicalon, r17: reportmedicaluc, r18: reportmedicaler, r19: reportmedicalother, r20: reportofficername, r21: reportsignature, r22: reportcompleted}));
        }
    });
    var olddescription = ""
    $('#warranteditbtn').click(function(event){
    	$('#selectedwarrantdescription').attr("readonly", false); 
    	$('#selectedwarrantcharges').attr("readonly", false); 
    	olddescription = jQuery('#selectedwarrantdescription').val();
    });
    $('#warrantsubmitchanges').click(function(event){ 
    	var editdesc = jQuery('#selectedwarrantdescription').val();
        var editcharge = jQuery('#selectedwarrantcharges').val();
    	$.post('http://mdt/edit-warrant', JSON.stringify({description: olddescription, charges: editcharge, newdescription: editdesc}));
    	$('#selectedwarrantdescription').text("" ); 
    	$('#selectedwarrantcharges').text(" ");
    	$('#selectedwarrantdescription').attr("readonly", true); 
    	$('#selectedwarrantcharges').attr("readonly", true);
    });
    $('#report-new').click(function(event){
    	$(reports).hide();
    	$('#reportst').hide();
    	$('#reportfullname').val("");
    	$('#reportage').val("");
    	$('#reportphonenumber').val("");
    	$('#reportdate').val("");
    	$('#reporttime').val("");
    	$('#reportpolice').val("");
    	$('#reportlocation').val("");
    	$('#reportdescription').val("");
    	$('#reportwchecky').prop('checked', false);
    	$('#reportwcheckn').prop('checked', false);
    	$('#reportdetails').val("");
    	$('#reportinjury').val("");
    	$('#reportmedicaly').prop('checked', false);
    	$('#reportmedicaln').prop('checked', false);
    	$('#reportmedicalr').prop('checked', false);
    	$('#reportmedicalon').prop('checked', false);
    	$('#reportmedicaluc').prop('checked', false);
    	$('#reportmedicaler').prop('checked', false);
    	$('#reportmedicalother').prop('checked', false);
    	$('#reportofficername').val("");
    	$('#reportsignature').val("");
    	$('#reportcompleted').val(""); 
    	$(reports).show();
    	$('#report-submit').show();
    });

    function fillWarrant(datez, officer, suspect, description, charges) {
    	var dateVal ="/Date(" + (datez * 1000) + ")/"; var date = new Date( parseFloat( dateVal.substr(6 ))); let timestamp = (date.getMonth() + 1) + "/" +    date.getDate() + "/" + date.getFullYear() + " " + date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds()    
        jQuery('#selectedwarrantdate').val(timestamp);
        jQuery('#selectedwarrantofficer').val(officer);
        jQuery('#selectedwarrantname').text(suspect);
        jQuery('#selectedwarrantdescription').text(description);
        jQuery('#selectedwarrantcharges').text(charges);
        $('#selectedwarrant').show();
        closeWarrants();
    }

    var jobs = ["","Unemployed","Police","Pharmacist","futurjob2","futurjob","Farmer","Gang","Miner","Fisher","Docker","Brewer","Vigneron","Livreur","Emergency","Mechanic","Taxi","FBI","Courier","Pool Cleaner","Garbage Collector","Tow","DOJ","Trucker","Bus Driver","Journalist"];

    function PlayerSearch(items) {
        $('#playertablez').empty();
	    for(let i in items) {
            let item = items[i];
        	$('#playertablez').append('<tr id = "playersearchzz" class="playerrow"><td>' + item.character_id + '</td><td>' + item.last_name + '</td><td>' + item.first_name + '</td><td>'  + jobs[item.job_id] + '</td></tr>')
	    }
    }
    
    function PlayerArrests(items) {
        for(let i in items) {
            let item = items[i];
            var dateVal ="/Date(" + (item.timestamp * 1000) + ")/"; var date = new Date( parseFloat( dateVal.substr(6 ))); let timestamp = (date.getMonth() + 1) + "/" +    date.getDate() + "/" + date.getFullYear() + " " + date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds()    
            $('#playerarrestrow').append('<tr id = "playerarrestszz"><td>' + timestamp + '</td><td>' + item.officer_name + '</td><td class="cell-which-triggers-popup">' + item.charges + '</td><td>'  + item.fine + '</td><td>' + item.sentence + '</td></tr>');
        }
    }
    function PlayerTickets(items) {
        for(let i in items) {
            let item = items[i];
            var dateVal ="/Date(" + (item.timestamp * 1000) + ")/"; var date = new Date( parseFloat( dateVal.substr(6 ))); let timestamp = (date.getMonth() + 1) + "/" +    date.getDate() + "/" + date.getFullYear() + " " + date.getHours() + ":" + date.getMinutes() + ":" + date.getSeconds()                
            $('#playerticketsrow').append('<tr id = "playerticketszz"><td>' + timestamp + '</td><td>' + item.officer_name + '</td><td class="cell-which-triggers-popup">' + item.violations + '</td><td>'  + item.fine + '</td></tr>');
        }
    }
    function PlayerVehicles(items) {
        for(let i in items) {
            let item = items[i];
             $('#playervehiclesrow').append('<tr id = "playervehicleszz"><td>' + item.model + '</td><td>' + item.plate + '</td><td>' + item.state + '</td></tr>');
        }
    }
    function LoadWarrants(items) {
        for(let i in items) {
            let item = items[i];
            $('#WarrantRowOne').append('<div class="col-md-4 playerwarrant" id = "playerwarrant" style="background-color:#ffffff;border:groove;"><p class="text-center">'+ item.offender_name +'</p></div>');
        }
    }
    function PlayerNotepad(items){
        for(let i in items) {
            let item = items[i];
            $('#notepad').text(item.notes)   
        }
    }
    function loadReports(items){
    	for(let i in items) {
    		let item = items[i]
    		$('#reportsdirectory').append(('<tr id = "reportstable"><td>' + item.id + '</td><td>' + item.r20 + '</td><td>' + item.r4 + '</td></tr>'))
    	}
    }

    function showPopup(your_variable) {
        jQuery("#myDialog").text(your_variable);
        document.getElementById("myDialog").showModal();
    }

    function LoadInformation(warrants, arrests, citations, citizenid, firstname, lastname, weapons, drivers) {
        jQuery("#playerwarrants").text(warrants);
        jQuery("#playerarrests").text(arrests);
        jQuery("#playercitations").text(citations);
        jQuery("#playercitizenid").text(citizenid);
        jQuery("#playerfirstname").text(firstname);
        jQuery("#playerlastname").text(lastname);
        if (weapons === "true"){
        	jQuery("#playerweaponsl").text("True");
        } else{
        	jQuery("#playerweaponsl").text("False");
        }
        if (drivers === "true"){
        	jQuery("#playerdriversl").text("Active");
        } else{
        	jQuery("#playerdriversl").text("Suspended");
        }
    }

    // Listen for NUI Events
  window.addEventListener('message', function(event){
    var item = event.data;
    if(item.openSection == "police_mdt") {
        closeLoginScreen();
        $(policefooter).show();
        $('#homepage').show();
    }
    if(item.openSection == "tableofplayers") {
      PlayerSearch(item.list);
      $(playertable).show();
    }
    if(item.openSection == "playerinformation") {
        LoadInformation(item.warrants, item.arrests, item.citations, item.citizenid, item.firstname, item.lastname, item.weaponsl, item.driversl);
        openPlayerInformation();
    }
    if(item.openSection == "playerarrests") {
        jQuery("#playerarrestrow").empty();
        PlayerArrests(item.list);
    }
    if(item.openSection == "playertickets") {
        jQuery("#playerticketsrow").empty();
        PlayerTickets(item.list);
    }
    if(item.openSection == "playervehicles") {
        jQuery("#playervehiclesrow").empty();
        PlayerVehicles(item.list);
    }
    if(item.openSection == "addNewArrest") {
        $('#arrest-officer_name').text("");
        $('#arrest-firstname').text("");
        $('#arrest-lastname').text("");
        $('#arrest-charges').text("");
        $('#arrest-fine').text("");
        $('#arrest-sentence').text("");
    }
    if(item.openSection == "addNewCitation") {
        $('#citation-officer_name').text("");
        $('#citation-firstname').text("");
        $('#citation-lastname').text("");
        $('#citation-charges').text("");
        $('#citation-fine').text("");
    }
    if(item.openSection == "openNotepad") {
        $("#notepad").empty();
        PlayerNotepad(item.list)
    }
    if(item.active === true) {
        openMDT();
    }
    if(item.active === false) {
       closeMDT();
    }
    if(item.openSection == "loadwarrants") {
        LoadWarrants(item.list);
    }
    if(item.openSection == "loadReports"){
    	loadReports(item.list)
    }
    if(item.openSection == "loadselectedwarrant") {
        fillWarrant(item.timestamp, item.officer_name, item.offender_name, item.notes, item.location);
    }
    if(item.openSection == "autofill_arrests"){
        var splitString = item.offender_name.split(" ");
        $('#arrest-officer_name').text(item.officer_name);
        $('#arrest-firstname').text(splitString[0]);
        $('#arrest-lastname').text(splitString[1]);
        $('#arrest-charges').text(item.charges);
        $('#arrest-fine').text(item.fine);
        $('#arrest-sentence').text(item.sentence);
    }
    if(item.openSection == "autofill_citations"){
        var splitString = item.offender_name.split(" ");
        $('#citation-officer_name').text(item.officer_name);
        $('#citation-firstname').text(splitString[0]);
        $('#citation-lastname').text(splitString[1]);
        $('#citation-charges').text(item.charges);
        $('#citation-fine').text(item.fine);
    }
    if(item.openSection == "loadReport"){
    	$(reports).show();
    	$('#reportst').hide();

    	$('#reportfullname').val("");
    	$('#reportage').val("");
    	$('#reportphonenumber').val("");
    	$('#reportdate').val("");
    	$('#reporttime').val("");
    	$('#reportpolice').val("");
    	$('#reportlocation').val("");
    	$('#reportdescription').val("");
    	$('#reportwchecky').prop('checked', false);
    	$('#reportwcheckn').prop('checked', false);
    	$('#reportdetails').val("");
    	$('#reportinjury').val("");
    	$('#reportmedicaly').prop('checked', false);
    	$('#reportmedicaln').prop('checked', false);
    	$('#reportmedicalr').prop('checked', false);
    	$('#reportmedicalon').prop('checked', false);
    	$('#reportmedicaluc').prop('checked', false);
    	$('#reportmedicaler').prop('checked', false);
    	$('#reportmedicalother').prop('checked', false);
    	$('#reportofficername').val("");
    	$('#reportsignature').val("");
    	$('#reportcompleted').val(""); 

    	$('#reportfullname').val(item.reportfullname);
    	$('#reportage').val(item.reportage);
    	$('#reportphonenumber').val(item.reportphonenumber);
    	$('#reportdate').val(item.reportdate);
    	$('#reporttime').val(item.reporttime);
    	$('#reportpolice').val(item.reportpolice);
    	$('#reportlocation').val(item.reportlocation);
    	$('#reportdescription').val(item.reportdescription);
    	if(item.reportwchecky == 0){
    		$('#reportwchecky').prop('checked', false);
    	} else {
    		$('#reportwchecky').prop('checked', true);
    	}
    	if(item.reportwcheckn == 0){
    		$('#reportwcheckn').prop('checked', false);
    	} else {
    		$('#reportwcheckn').prop('checked', true);
    	}
    	$('#reportdetails').val(item.reportdetails);
    	$('#reportinjury').val(item.reportinjury);
    	if(item.reportmedicaly == 0){
    		$('#reportmedicaly').prop('checked', false);
    	} else {
    		$('#reportmedicaly').prop('checked', true);
    	}
    	if(item.reportmedicaln == 0){
    		$('#reportmedicaln').prop('checked', false);
    	} else {
    		$('#reportmedicaln').prop('checked', true);
    	}
    	if(item.reportmedicalr == 0){
    		$('#reportmedicalr').prop('checked', false);
    	} else {
    		$('#reportmedicalr').prop('checked', true);
    	}
    	if(item.reportmedicalon == 0){
    		$('#reportmedicalon').prop('checked', false);
    	} else {
    		$('#reportmedicalon').prop('checked', true);
    	}
    	if(item.reportmedicaluc == 0){
    		$('#reportmedicaluc').prop('checked', false);
    	} else {
    		$('#reportmedicaluc').prop('checked', true);
    	}
    	if(item.reportmedicaler == 0){
    		$('#reportmedicaler').prop('checked', false);
    	} else {
    		$('#reportmedicaler').prop('checked', true);
    	}
    	if(item.reportmedicalother == 0){
    		$('#reportmedicalother').prop('checked', false);
    	} else {
    		$('#reportmedicalother').prop('checked', true);
    	}
    	$('#reportofficername').val(item.reportofficername);
    	$('#reportsignature').val(item.reportsignature);
    	$('#reportcompleted').val(item.reportcompleted);
    }
  });
});