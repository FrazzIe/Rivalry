//
    //Script created by: Frazzle

    //Contact: frazzle9999@gmail.com

    //Note: this script is licensed under "No License", you are allowed to:

    //Use and Edit the Script.

    //you are not allowed to:

    //Copy, re-release, re-distribute it without my written permission.
//
$(document).ready(function(){ 
	var selected_id = 0;
	var perm_ban = false;
	var bantime_type = ""
	window.addEventListener('message', function(event) {
		var item = event.data;
		if (item.open === true) {
			loadPlayers(item.players)
			$(".vertical-center").css("display", "flex");
		} else if (item.open === false) {
			$(".vertical-center").css("display", "none");
		}
	});

	function escapeHtml(unsafe) {
	    return unsafe
	         .replace(/&/g, "&amp;")
	         .replace(/</g, "&lt;")
	         .replace(/>/g, "&gt;")
	         .replace(/"/g, "&quot;")
	         .replace(/'/g, "&#039;");
	}

	function loadPlayers(players) {
		$("#player-list").empty()
		$('#player-list').append('<thead><tr><th scope="col">ID</th><th scope="col">Username</th></tr></thead>')
		$('#player-list').append('<tbody>')
		for(let i in players) {
			let player = players[i];
			$('#player-list').append('<tr id="player_' + player.id + '"><th scope="row">' + player.id + '</th><td>' + escapeHtml(player.name) + '</td>')
			if(i == 0) { $("#player_" + player.id).addClass("selected"); document.getElementById("selected-header").innerHTML = " ID: " + player.id + ", User: " + escapeHtml(player.name); selected_id = parseInt(player.id);}
			$("#player_" + player.id).click(function(){
				$("#player_" + selected_id).removeClass("selected");
				$(this).addClass("selected");
				document.getElementById("selected-header").innerHTML = " ID: " + player.id + ", User: " + escapeHtml(player.name);
				selected_id = parseInt(player.id);
			})
		}
		$('#player-list').append('</tbody>')
	}

	//Exit panel
	document.onkeyup = function (data) {
		if (data.which == 27) { // Escape key
		   $.post('http://core_panel/escape', JSON.stringify({}));
		}
	};

	$("#close").click(function(){
		$.post('http://core_panel/escape', JSON.stringify({}));
	})

	//Money, Power, Group, Kick and Ban forms
	$("#money").submit(function(e) {
		e.preventDefault(); // Prevent form from submitting
		var mselect = document.getElementById("money-multi-select");
		$.post('http://core_panel/set', JSON.stringify({
			type: "money",
			money_type: mselect.options[mselect.selectedIndex].text,
			amount: $("#money #amount").val(),
			id: selected_id,
		}));
	});

	$("#power").submit(function(e) {
		e.preventDefault(); // Prevent form from submitting
		
		$.post('http://core_panel/set', JSON.stringify({
			type: "power",
			power: $("#power #amount").val(),
			id: selected_id,
		}));
	});

	$("#ugroup").submit(function(e) {
		e.preventDefault(); // Prevent form from submitting
		console.log("why is it being gay")
		console.log($("#ugroup #amount").val())
		$.post('http://core_panel/set', JSON.stringify({
			type: "group",
			group: $("#ugroup #amount").val(),
			id: selected_id,
		}));
	});

	$("#kick").submit(function(e) {
		e.preventDefault(); // Prevent form from submitting
		
		$.post('http://core_panel/kick', JSON.stringify({
			reason: $("#kick #reason").val(),
			id: selected_id,
		}));
	});

	$("#ban").submit(function(e) {
		e.preventDefault(); // Prevent form from submitting
		
		$.post('http://core_panel/ban', JSON.stringify({
			reason: $("#ban #reason").val(),
			perm: perm_ban,
			bantime_type: bantime_type,
			time: $("#ban #time").val(),
			id: selected_id,
		}));
	});

	$("#ban-perm").click(function(){perm_ban = true;})
	$("#ban-time").click(function(){perm_ban = false;})
	$("#sec_ban").click(function(){bantime_type = "";});
	$("#min_ban").click(function(){bantime_type = "m";});
	$("#hour_ban").click(function(){bantime_type = "h";});

	//Quick options
	$("#quick_slay").click(function() {$.post('http://core_panel/quickoption', JSON.stringify({id: selected_id, type: "slay"}))})
	$("#quick_noclip").click(function() {$.post('http://core_panel/quickoption', JSON.stringify({id: selected_id, type: "noclip"}))})
	$("#quick_freeze").click(function() {$.post('http://core_panel/quickoption', JSON.stringify({id: selected_id, type: "freeze"}))})
	$("#quick_bring").click(function() {$.post('http://core_panel/quickoption', JSON.stringify({id: selected_id, type: "bring"}))})
	$("#quick_goto").click(function() {$.post('http://core_panel/quickoption', JSON.stringify({id: selected_id, type: "goto"}))})
	$("#quick_slap").click(function() {$.post('http://core_panel/quickoption', JSON.stringify({id: selected_id, type: "slap"}))})
	$("#quick_crash").click(function() {$.post('http://core_panel/quickoption', JSON.stringify({id: selected_id, type: "crash"}))})
});