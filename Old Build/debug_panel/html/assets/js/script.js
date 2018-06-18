$(document).ready(function() {
    console.log( "ready!" );
    var screenheight = $(window).height();
    $("#bug-panel").css("min-height", screenheight);

});

$(window).resize(function() {
    var screenheight = $(window).height();
    $("#bug-panel").css("min-height", screenheight);
});

//Player
$("#btn-player-coords").click(function(){
    var copyText = document.getElementById("input-player-coords");
    copyText.select();
    document.execCommand("Copy");
})

$("#btn-player-rotations").click(function(){
    var copyText = document.getElementById("input-player-rotations");
    copyText.select();
    document.execCommand("Copy");
})
//Target
$("#btn-target-coords").click(function(){
    var copyText = document.getElementById("input-target-coords");
    copyText.select();
    document.execCommand("Copy");
})

$("#btn-target-rotations").click(function(){
    var copyText = document.getElementById("input-target-rotations");
    copyText.select();
    document.execCommand("Copy");
})


$("#btn-target-id").click(function(){
    var copyText = document.getElementById("input-target-id");
    copyText.select();
    document.execCommand("Copy");
})


$("#btn-target-model").click(function(){
    var copyText = document.getElementById("input-target-model");
    copyText.select();
    document.execCommand("Copy");
})


$("#btn-target-network-id").click(function(){
    var copyText = document.getElementById("input-target-network-id");
    copyText.select();
    document.execCommand("Copy");
})


$("#btn-close").click(function(){
    $.post('http://debug_panel/close', JSON.stringify({}));
});

$('#cbox-deletegun').change(function() {
    // this will contain a reference to the checkbox   
    $.post('http://debug_panel/checkbox', JSON.stringify({type: "deletegun"}));
});

$('#cbox-network').change(function() {
    // this will contain a reference to the checkbox   
    $.post('http://debug_panel/checkbox', JSON.stringify({type: "network"}));
});

$('#cbox-rotate').change(function() {
    // this will contain a reference to the checkbox   
    $.post('http://debug_panel/checkbox', JSON.stringify({type: "rotate"}));
});

//Event listener
window.addEventListener('message', function(event) {
    var item = event.data;
    
    if (item.display === true) {
        $("#main-row").css("display", "flex")
    } else if (item.display === false) {
        $("#main-row").css("display", "none")
    }
    if (item.setPlayer === true) {
        $("#input-player-coords").val(item.position);
        $("#input-player-rotations").val(item.rotations);
    }
    if (item.setTarget === true) {
        $("#input-target-coords").val(item.position);
        $("#input-target-rotations").val(item.rotations);
        $("#input-target-id").val(item.id);
        $("#input-target-model").val(item.model);
        $("#input-target-network-id").val(item.network_id);
        $("#badge-target-networked").text(item.networked);
        $("#badge-target-controlled").text(item.controlled);
        $("#badge-target-exists").text(item.exists);
        $("#badge-target-mission").text(item.mission);
    }
});

document.onkeydown = function (data) { //Close phone
    if (data.which == 33) { // Page up
        $.post('http://debug_panel/close', JSON.stringify({display: $("#main-row").css("display")}));
    } else if(data.which == 34) { // Page down
        $.post('http://debug_panel/cursor', JSON.stringify({}));
    }
};
