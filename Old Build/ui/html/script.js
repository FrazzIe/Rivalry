//[
    //Script created by: Frazzle

    //Contact: frazzle9999@gmail.com

    //Note: this script is licensed under "No License", you are allowed to:

    //Use and Edit the Script.

    //you are not allowed to:

    //Copy, re-release, re-distribute it without my written permission.
//
var btnCount = 0;
var btnSelected = 0;

$(function() {
    window.addEventListener('message', function(event) {
        if (event.data.type == "enableui") {
            document.body.style.display = event.data.enable ? "block" : "none";
        } else if (event.data.type == "reset") {
            btnCount = 0;
            btnSelected = 0;
           $("#menu-form").empty();
        } else if (event.data.type == "addButton") {
            var f = document.getElementById("menu-form");
            btnCount++;
            var i = document.createElement("button");
            event.id = btnCount;
            i.setAttribute('id', 'btn' + btnCount);
            i.setAttribute('class', "button button1");
            i.setAttribute('value', event.data.functionname);
            i.setAttribute('type', "button");
            i.innerHTML = event.data.name;
            i.onclick = function () { 
                $.post('http://ui/runfunction', JSON.stringify({event_func: event.data.functionname, params: event.data.params})); 
            }; 
            i.onmouseover = function () {
                $( "#btn" + btnSelected ).removeClass('selected');
                btnSelected = event.id;
                $( "#btn" + btnSelected ).addClass('selected');
            };

            f.appendChild(i);

            if (btnCount == 1) {
                btnSelected = btnCount;
                $( "#btn" + btnSelected ).addClass('selected');
            }
        } else if (event.data.type == "click") {
            btnDeSelect();
        } else if (event.data.type == "up") {
            btnUp();
        } else if (event.data.type == "down") {
            btnDown();
        } else if(event.data.type == "enter") {
            btnEnter()
        } else if(event.data.type == "back") {
            $.post('http://ui/backfunction', JSON.stringify({}));
        } else if(event.data.type == "scroll_down") {
            var scroll = $("#menu-form").scrollTop();
            var max_scroll = $('#menu-form')[0].scrollHeight;
            if(scroll != max_scroll) {
                var new_scroll = scroll + 25
                if(new_scroll >= max_scroll) {
                    new_scroll = max_scroll
                } 
                $("#menu-form").scrollTop(new_scroll)
            }
        } else if(event.data.type == "scroll_up") {
            var scroll = $("#menu-form").scrollTop();
            if( scroll != 0 ) {
                var new_scroll = scroll - 25
                if( new_scroll < 0) {
                    new_scroll = 0
                }
                $("#menu-form").scrollTop(new_scroll)
            }
        }

    });

    $(document).mousedown(function(event) {
        if (event.which == 3) {
            $.post('http://ui/backfunction', JSON.stringify({}));
        }
        if (event.which == 2) {
            $.post('http://ui/cursor', JSON.stringify({}));
        }
    });

    document.onkeydown = function (data) {
        if (data.which == 27) { // Escape key
           $.post('http://ui/escape', JSON.stringify({}));
        }
        if (data.which == 38) { // Up
            btnUp();
        }
        if (data.which == 40) { // Down
            btnDown();
        }
        if (data.which == 13) { // Enter
            btnEnter();
        }
        if (data.which == 8) { // Backspace
            $.post('http://ui/backfunction', JSON.stringify({}));
        }
    };

    $("#menu-form button").click(function (ev) {
        ev.preventDefault(); // cancel form submission

        if ($(this).attr("value") == "close") {
            $.post('http://ui/escape', JSON.stringify({}));
        }

    });

    function btnUp() {
        $( "#btn" + btnSelected ).removeClass('selected');
        btnSelected--;
        if (btnSelected <= 0) {
            btnSelected = btnCount;
        }
        $( "#btn" + btnSelected ).addClass('selected');
    }

    function btnDown() {
        $( "#btn" + btnSelected ).removeClass('selected');
        btnSelected++;
        if (btnSelected > btnCount) {
            btnSelected = 1;
        }
        $( "#btn" + btnSelected ).addClass('selected');
    }

    function btnEnter() {
        if (btnSelected > 0) {
            $( "#btn" + btnSelected )[0].onclick();
        }
    }

    function btnDeSelect() {        
        $( "#btn" + btnSelected ).removeClass('selected');
    }

});