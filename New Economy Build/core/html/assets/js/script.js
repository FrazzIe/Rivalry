$(document).ready(function(){
console.log("Character Selection")

var selected = null;
var selected_data = null;
var selection_disabled = false;

function hide_menu() {
    
    selection_disabled = false;
    
    $(selected).removeClass("selected");
    
    selected = null;
    selected_data = null;
    
    $("#row-main-header").css("display", "none");
    $("#row-main-container").css("display", "none");
    
    $("#col-character-display").css("display", "none");    
    $("#col-changelog").css("display", "none");    
    $("#col-loading").css("display", "none");    
    $("#col-character-create").css("display", "none");
    $("#col-character-edit").css("display", "none"); 
    $("#col-character-delete").css("display", "none");
}

hide_menu();

function main_menu() {
    
    selection_disabled = false;
    
    $(selected).removeClass("selected");
    
    selected = null;
    selected_data = null;
    
    $("#row-main-header").css("display", "flex");
    $("#row-main-container").css("display", "flex");
    
    $("#col-character-display").css("display", "block");
    $("#col-changelog").css("display", "block");
    
    $("#col-loading").css("display", "none");    
    $("#col-character-create").css("display", "none");
    $("#col-character-edit").css("display", "none");
    $("#col-character-delete").css("display", "none");
}

function create_menu() {
    
    selection_disabled = false;
    
    $("#row-main-header").css("display", "flex");
    $("#row-main-container").css("display", "flex");

    $("#col-character-create").css("display", "block");
    $("#col-changelog").css("display", "block");
    
    $("#col-loading").css("display", "none");    
    $("#col-character-display").css("display", "none");
    $("#col-character-edit").css("display", "none");
    $("#col-character-delete").css("display", "none");
}

function edit_menu() {
    
    selection_disabled = false;
    
    $("#row-main-header").css("display", "flex");
    $("#row-main-container").css("display", "flex");

    $("#col-character-edit").css("display", "block");
    $("#col-changelog").css("display", "block");
    
    $("#col-loading").css("display", "none");    
    $("#col-character-display").css("display", "none");
    $("#col-character-create").css("display", "none");
    $("#col-character-delete").css("display", "none");
}

function loading_menu() {
 
    selection_disabled = false;
    
    $("#row-main-header").css("display", "flex");
    $("#row-main-container").css("display", "flex");
    
    $("#col-loading").css("display", "block");
    
    $("#col-character-edit").css("display", "none");
    $("#col-changelog").css("display", "none");
    $("#col-character-display").css("display", "none");
    $("#col-character-create").css("display", "none"); 
    $("#col-character-delete").css("display", "none");
}

function delete_menu() {
  
    selection_disabled = true;
    
    $("#row-main-header").css("display", "flex");
    $("#row-main-container").css("display", "flex");
    
    $("#col-character-display").css("display", "block");
    $("#col-character-delete").css("display", "block"); 
    
    $("#col-loading").css("display", "none");    
    $("#col-character-edit").css("display", "none");
    $("#col-changelog").css("display", "none");
    $("#col-character-create").css("display", "none");  
}

function add_characters(characters) {
    $("#div-characters").empty();
    for(let i in characters) {
        let character = characters[i];
        $("#div-characters").append('<form id="character_' + character.character_id + '" class="rounded character" style="padding-left:15px;padding-right:15px;padding-top:15px;margin-top:7.5px;margin-bottom:7.5px;"><div class="form-row"><div class="col"><p>' + character.first_name + ' ' + character.last_name + '</p></div><div class="col"><p class="float-right"><span style="color:green">$</span>' + character.wallet + '</p></div></div><div class="form-row"><div class="col"><p>' + character.dob + '</p></div><div class="col"><p class="float-right"><span style="color:red">$</span>' + character.dirty_cash + '</p></div></div><div class="form-row"><div class="col"><p>' + moment.duration(character.timeplayed, "seconds").format() + '</p></div><div class="col"><p class="float-right"><span style="color:blue">$</span>' + character.bank + '</p></div></div></form>');
        $("#character_" + character.character_id).click(function(){
            if(selection_disabled === false) {
                $(selected).removeClass("selected");
                $(this).addClass("selected");
                selected = this;
                selected_data = character;
            }
        });
    }
    $("#div-characters").append('<form id="form-add-character" class="rounded character" style="padding-left:15px;padding-right:15px;margin-top:7.5px;margin-bottom:7.5px;"><div class="form-group"><div class="form-row justify-content-center align-items-center"><div class="col-auto"><i class="fa fa-plus-circle" style="font-size:67.5px;color:#898e8c;"></i></div></div></div></form>');
    $("#form-add-character").click(function() {
        if(selection_disabled === false) {
            $(selected).removeClass("selected");
            $(this).addClass("selected");
            selected = this;
            selected_data = null;        
            create_menu();
        }
    });
}

window.addEventListener('message', function(event) {

    if(event.data.open === true) {
        loading_menu();
        add_characters(event.data.characters);
        main_menu();
    }
    else if(event.data.open === false) {
        hide_menu();
    } 
});
    
$("#form-create").submit(function(event){
    event.preventDefault();
    loading_menu();
    $.post('http://core/create_character', JSON.stringify({
        forename: $("#form-create #create-input-forename").val(),
        surname: $("#form-create #create-input-surname").val(),
        dob: $("#form-create #create-input-dob").val(),
        gender: $("#form-create #create-select-gender option:selected").val(),
    }));
});

$("#form-edit").submit(function(event){
    event.preventDefault();
    loading_menu();
    $.post('http://core/edit_character', JSON.stringify({
        forename: $("#form-edit #edit-input-forename").val(),
        surname: $("#form-edit #edit-input-surname").val(),
        dob: $("#form-edit #edit-input-dob").val(),
        gender: $("#form-edit #edit-select-gender option:selected").val(),
        character: selected_data,
    }));
});
    
$("#icon-home").click(function() {
    main_menu(); 
});

$("#icon-home2").click(function() {
    main_menu(); 
});

$("#display-btn-play").click(function() {
    if(selected != null && selected_data != null) {
        loading_menu();
        $.post('http://core/select_character', JSON.stringify({
            character: selected_data,
        }));        
    }
});
    
$("#display-btn-edit").click(function() {
    if(selected != null && selected_data != null) {
        $("#form-edit #edit-input-forename").val(selected_data.first_name)
        $("#form-edit #edit-input-surname").val(selected_data.last_name)
        $("#form-edit #edit-input-dob").val(selected_data.dob)
        $("#form-edit #edit-select-gender option:selected").val(selected_data.gender).trigger("change")
        edit_menu();
    }
});
    
$("#display-btn-delete").click(function() {
    if(selected != null && selected_data != null) {
        delete_menu();
    }
});

$("#delete-icon-accept").click(function(){
    loading_menu();
    $.post('http://core/delete_character', JSON.stringify({
        character: selected_data,
    }));
});
    
$("#delete-icon-decline").click(function(){
    main_menu();
});
    
});