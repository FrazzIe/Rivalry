//
    //Script created by: Frazzle

    //Contact: frazzle9999@gmail.com

    //Note: this script is licensed under "No License", you are allowed to:

    //Use and Edit the Script.

    //you are not allowed to:

    //Copy, re-release, re-distribute it without my written permission.
//
$(document).ready(function(){
    var start = 0;
    var timer = 0;
    //Hide and show elements
    function close_phone() { //Hide everything
        
        $(".vertical-center").css("display", "none");
        //Navigation
        $(".nav-page").css("display", "none");
        //Main pages
        $(".home-page").css("display", "none");
        $(".call-page").css("display", "none");
        $(".dial-page").css("display", "none");
        $(".dial-page-answer").css("display", "none");
        $(".contact-page").css("display", "none");
        $(".messages-page").css("display", "none");
        $(".sub-messages-page").css("display", "none");
        $(".new-messages-page").css("display", "none");
        $(".services-page").css("display", "none");
        $(".other-services-page").css("display", "none");
        $(".lifealert-page").css("display", "none");
        $(".loading-page").css("display", "none");
        //Service pages
        $(".services-police-page").css("display", "none");
        $(".services-ems-page").css("display", "none");
        $(".services-taxi-page").css("display", "none");
        $(".services-mechanic-page").css("display", "none");
        //Other Service pages
        $(".other-services-helix-page").css("display", "none"); 
        //Contact page stuff
        $(".contact-page .view-contact").css("display", "none");
        $(".contact-page .add-contact").css("display", "none");
        
    }
    
    function home_page() { //Hide everything but the home page
        
        $(".vertical-center").css("display", "flex");
        //Navigation
        $(".nav-page").css("display", "flex");
        //Main pages
        $(".home-page").css("display", "flex");
        $(".call-page").css("display", "none");
        $(".dial-page").css("display", "none");
        $(".dial-page-answer").css("display", "none");
        $(".contact-page").css("display", "none");
        $(".messages-page").css("display", "none");
        $(".sub-messages-page").css("display", "none");
        $(".new-messages-page").css("display", "none");
        $(".services-page").css("display", "none");
        $(".other-services-page").css("display", "none");
        $(".lifealert-page").css("display", "none");
        $(".loading-page").css("display", "none");
        //Service pages
        $(".services-police-page").css("display", "none");
        $(".services-ems-page").css("display", "none");
        $(".services-taxi-page").css("display", "none");
        $(".services-mechanic-page").css("display", "none");
        //Other Service pages
        $(".other-services-helix-page").css("display", "none"); 
        //Contact page stuff
        $(".contact-page .view-contact").css("display", "none");
        $(".contact-page .add-contact").css("display", "none");
        
    }

    function call_page() { //Hide everything but the home page
        
        $(".vertical-center").css("display", "flex");
        //Navigation
        $(".nav-page").css("display", "flex");
        //Main pages
        $(".home-page").css("display", "none");
        $(".call-page").css("display", "flex");
        $(".dial-page").css("display", "none");
        $(".dial-page-answer").css("display", "none");
        $(".contact-page").css("display", "none");
        $(".messages-page").css("display", "none");
        $(".sub-messages-page").css("display", "none");
        $(".new-messages-page").css("display", "none");
        $(".services-page").css("display", "none");
        $(".other-services-page").css("display", "none");
        $(".lifealert-page").css("display", "none");
        $(".loading-page").css("display", "none");
        //Service pages
        $(".services-police-page").css("display", "none");
        $(".services-ems-page").css("display", "none");
        $(".services-taxi-page").css("display", "none");
        $(".services-mechanic-page").css("display", "none");
        //Other Service pages
        $(".other-services-helix-page").css("display", "none"); 
        //Contact page stuff
        $(".contact-page .view-contact").css("display", "none");
        $(".contact-page .add-contact").css("display", "none");
        
    }

    function dial_page() { //Hide everything but the home page
        
        $(".vertical-center").css("display", "flex");
        //Navigation
        $(".nav-page").css("display", "flex");
        //Main pages
        $(".home-page").css("display", "none");
        $(".call-page").css("display", "none");
        $(".dial-page").css("display", "flex");
        $(".dial-page-answer").css("display", "none");
        $(".contact-page").css("display", "none");
        $(".messages-page").css("display", "none");
        $(".sub-messages-page").css("display", "none");
        $(".new-messages-page").css("display", "none");
        $(".services-page").css("display", "none");
        $(".other-services-page").css("display", "none");
        $(".lifealert-page").css("display", "none");
        $(".loading-page").css("display", "none");
        //Service pages
        $(".services-police-page").css("display", "none");
        $(".services-ems-page").css("display", "none");
        $(".services-taxi-page").css("display", "none");
        $(".services-mechanic-page").css("display", "none");
        //Other Service pages
        $(".other-services-helix-page").css("display", "none"); 
        //Contact page stuff
        $(".contact-page .view-contact").css("display", "none");
        $(".contact-page .add-contact").css("display", "none");
        
    }

    function dial_answer_page() { //Hide everything but the home page
        
        $(".vertical-center").css("display", "flex");
        //Navigation
        $(".nav-page").css("display", "flex");
        //Main pages
        $(".home-page").css("display", "none");
        $(".call-page").css("display", "none");
        $(".dial-page").css("display", "none");
        $(".dial-page-answer").css("display", "flex");
        $(".contact-page").css("display", "none");
        $(".messages-page").css("display", "none");
        $(".sub-messages-page").css("display", "none");
        $(".new-messages-page").css("display", "none");
        $(".services-page").css("display", "none");
        $(".other-services-page").css("display", "none");
        $(".lifealert-page").css("display", "none");
        $(".loading-page").css("display", "none");
        //Service pages
        $(".services-police-page").css("display", "none");
        $(".services-ems-page").css("display", "none");
        $(".services-taxi-page").css("display", "none");
        $(".services-mechanic-page").css("display", "none");
        //Other Service pages
        $(".other-services-helix-page").css("display", "none"); 
        //Contact page stuff
        $(".contact-page .view-contact").css("display", "none");
        $(".contact-page .add-contact").css("display", "none");
        
    }
    
    function contacts_page() { //Hide everything but the contact page
        
        $(".vertical-center").css("display", "flex");
        //Navigation
        $(".nav-page").css("display", "flex");
        //Main pages
        $(".home-page").css("display", "none");
        $(".call-page").css("display", "none");
        $(".dial-page").css("display", "none");
        $(".dial-page-answer").css("display", "none");
        $(".contact-page").css("display", "flex");        
        $(".messages-page").css("display", "none");
        $(".sub-messages-page").css("display", "none");
        $(".new-messages-page").css("display", "none");
        $(".services-page").css("display", "none");
        $(".other-services-page").css("display", "none");
        $(".lifealert-page").css("display", "none");
        $(".loading-page").css("display", "none");
        //Service pages
        $(".services-police-page").css("display", "none");
        $(".services-ems-page").css("display", "none");
        $(".services-taxi-page").css("display", "none");
        $(".services-mechanic-page").css("display", "none");
        //Other Service pages
        $(".other-services-helix-page").css("display", "none"); 
        //Contact page stuff
        $(".contact-page .view-contact").css("display", "none");
        $(".contact-page .add-contact").css("display", "block");
        
    }
    
    function messages_page() { //Hide everything but the messages page
        
        $(".vertical-center").css("display", "flex");
        //Navigation
        $(".nav-page").css("display", "flex");
        //Main pages
        $(".home-page").css("display", "none");
        $(".call-page").css("display", "none");
        $(".dial-page").css("display", "none");
        $(".dial-page-answer").css("display", "none");
        $(".contact-page").css("display", "none");
        $(".messages-page").css("display", "flex");
        $(".sub-messages-page").css("display", "none");
        $(".new-messages-page").css("display", "none");
        $(".services-page").css("display", "none");
        $(".other-services-page").css("display", "none");
        $(".lifealert-page").css("display", "none");
        $(".loading-page").css("display", "none");
        //Service pages
        $(".services-police-page").css("display", "none");
        $(".services-ems-page").css("display", "none");
        $(".services-taxi-page").css("display", "none");
        $(".services-mechanic-page").css("display", "none");
        //Other Service pages
        $(".other-services-helix-page").css("display", "none");
        //Contact page stuff
        $(".contact-page .view-contact").css("display", "none");
        $(".contact-page .add-contact").css("display", "none");
        
    }

    function submessages_page() { //Hide everything but the sub-messages page
        
        $(".vertical-center").css("display", "flex");
        //Navigation
        $(".nav-page").css("display", "flex");
        //Main pages
        $(".home-page").css("display", "none");
        $(".call-page").css("display", "none");
        $(".dial-page").css("display", "none");
        $(".dial-page-answer").css("display", "none");
        $(".contact-page").css("display", "none");
        $(".messages-page").css("display", "none");
        $(".sub-messages-page").css("display", "flex");
        $(".new-messages-page").css("display", "none");
        $(".services-page").css("display", "none");
        $(".other-services-page").css("display", "none");
        $(".lifealert-page").css("display", "none");
        $(".loading-page").css("display", "none");
        //Service pages
        $(".services-police-page").css("display", "none");
        $(".services-ems-page").css("display", "none");
        $(".services-taxi-page").css("display", "none");
        $(".services-mechanic-page").css("display", "none");
        //Other Service pages
        $(".other-services-helix-page").css("display", "none"); 
        //Contact page stuff
        $(".contact-page .view-contact").css("display", "none");
        $(".contact-page .add-contact").css("display", "none");
        
    }
 
    function newmessage_page() { //Hide everything but the new message page
        $("#new-message-phonenumber").val("");
        $("#new-message-container").val("");
        
        $(".vertical-center").css("display", "flex");
        //Navigation
        $(".nav-page").css("display", "flex");
        //Main pages
        $(".home-page").css("display", "none");
        $(".call-page").css("display", "none");
        $(".dial-page").css("display", "none");
        $(".dial-page-answer").css("display", "none");
        $(".contact-page").css("display", "none");
        $(".messages-page").css("display", "none");
        $(".sub-messages-page").css("display", "none");
        $(".new-messages-page").css("display", "flex");
        $(".services-page").css("display", "none");
        $(".other-services-page").css("display", "none");
        $(".lifealert-page").css("display", "none");
        $(".loading-page").css("display", "none");
        //Service pages
        $(".services-police-page").css("display", "none");
        $(".services-ems-page").css("display", "none");
        $(".services-taxi-page").css("display", "none");
        $(".services-mechanic-page").css("display", "none");
        //Other Service pages
        $(".other-services-helix-page").css("display", "none"); 
        //Contact page stuff
        $(".contact-page .view-contact").css("display", "none");
        $(".contact-page .add-contact").css("display", "none");
        
    }

    function services_page() { //Hide everything but the services page
        
        $(".vertical-center").css("display", "flex");
        //Navigation
        $(".nav-page").css("display", "flex");
        //Main pages
        $(".home-page").css("display", "none");
        $(".call-page").css("display", "none");
        $(".dial-page").css("display", "none");
        $(".dial-page-answer").css("display", "none");
        $(".contact-page").css("display", "none");
        $(".messages-page").css("display", "none");
        $(".sub-messages-page").css("display", "none");
        $(".new-messages-page").css("display", "none");
        $(".services-page").css("display", "flex");
        $(".other-services-page").css("display", "none");
        $(".lifealert-page").css("display", "none");
        $(".loading-page").css("display", "none");
        //Service pages
        $(".services-police-page").css("display", "none");
        $(".services-ems-page").css("display", "none");
        $(".services-taxi-page").css("display", "none");
        $(".services-mechanic-page").css("display", "none");
        //Other Service pages
        $(".other-services-helix-page").css("display", "none"); 
        //Contact page stuff
        $(".contact-page .view-contact").css("display", "none");
        $(".contact-page .add-contact").css("display", "none");
        
    }

    function services_page_police() { //Hide everything but the police services page
        
        $(".vertical-center").css("display", "flex");
        //Navigation
        $(".nav-page").css("display", "flex");
        //Main pages
        $(".home-page").css("display", "none");
        $(".call-page").css("display", "none");
        $(".dial-page").css("display", "none");
        $(".dial-page-answer").css("display", "none");
        $(".contact-page").css("display", "none");
        $(".messages-page").css("display", "none");
        $(".sub-messages-page").css("display", "none");
        $(".new-messages-page").css("display", "none");
        $(".services-page").css("display", "none");
        $(".other-services-page").css("display", "none");
        $(".lifealert-page").css("display", "none");
        $(".loading-page").css("display", "none");
        //Service pages
        $(".services-police-page").css("display", "flex");
        $(".services-ems-page").css("display", "none");
        $(".services-taxi-page").css("display", "none");
        $(".services-mechanic-page").css("display", "none");
        //Other Service pages
        $(".other-services-helix-page").css("display", "none"); 
        //Contact page stuff
        $(".contact-page .view-contact").css("display", "none");
        $(".contact-page .add-contact").css("display", "none");
        
    }

    function services_page_ems() { //Hide everything but the ems services page
        
        $(".vertical-center").css("display", "flex");
        //Navigation
        $(".nav-page").css("display", "flex");
        //Main pages
        $(".home-page").css("display", "none");
        $(".call-page").css("display", "none");
        $(".dial-page").css("display", "none");
        $(".dial-page-answer").css("display", "none");
        $(".contact-page").css("display", "none");
        $(".messages-page").css("display", "none");
        $(".sub-messages-page").css("display", "none");
        $(".new-messages-page").css("display", "none");
        $(".services-page").css("display", "none");
        $(".other-services-page").css("display", "none");
        $(".lifealert-page").css("display", "none");
        $(".loading-page").css("display", "none");
        //Service pages
        $(".services-police-page").css("display", "none");
        $(".services-ems-page").css("display", "flex");
        $(".services-taxi-page").css("display", "none");
        $(".services-mechanic-page").css("display", "none");
        //Other Service pages
        $(".other-services-helix-page").css("display", "none"); 
        //Contact page stuff
        $(".contact-page .view-contact").css("display", "none");
        $(".contact-page .add-contact").css("display", "none");
        
    }

    function services_page_taxi() { //Hide everything but the taxi services page
        
        $(".vertical-center").css("display", "flex");
        //Navigation
        $(".nav-page").css("display", "flex");
        //Main pages
        $(".home-page").css("display", "none");
        $(".call-page").css("display", "none");
        $(".dial-page").css("display", "none");
        $(".dial-page-answer").css("display", "none");
        $(".contact-page").css("display", "none");
        $(".messages-page").css("display", "none");
        $(".sub-messages-page").css("display", "none");
        $(".new-messages-page").css("display", "none");
        $(".services-page").css("display", "none");
        $(".other-services-page").css("display", "none");
        $(".lifealert-page").css("display", "none");
        $(".loading-page").css("display", "none");
        //Service pages
        $(".services-police-page").css("display", "none");
        $(".services-ems-page").css("display", "none");
        $(".services-taxi-page").css("display", "flex");
        $(".services-mechanic-page").css("display", "none");
        //Other Service pages
        $(".other-services-helix-page").css("display", "none"); 
        //Contact page stuff
        $(".contact-page .view-contact").css("display", "none");
        $(".contact-page .add-contact").css("display", "none");
        
    }

    function services_page_mechanic() { //Hide everything but the mechanic services page
        
        $(".vertical-center").css("display", "flex");
        //Navigation
        $(".nav-page").css("display", "flex");
        //Main pages
        $(".home-page").css("display", "none");
        $(".call-page").css("display", "none");
        $(".dial-page").css("display", "none");
        $(".dial-page-answer").css("display", "none");
        $(".contact-page").css("display", "none");
        $(".messages-page").css("display", "none");
        $(".sub-messages-page").css("display", "none");
        $(".new-messages-page").css("display", "none");
        $(".services-page").css("display", "none");
        $(".other-services-page").css("display", "none");
        $(".lifealert-page").css("display", "none");
        $(".loading-page").css("display", "none");
        //Service pages
        $(".services-police-page").css("display", "none");
        $(".services-ems-page").css("display", "none");
        $(".services-taxi-page").css("display", "none");
        $(".services-mechanic-page").css("display", "flex");
        //Other Service pages
        $(".other-services-helix-page").css("display", "none"); 
        //Contact page stuff
        $(".contact-page .view-contact").css("display", "none");
        $(".contact-page .add-contact").css("display", "none");
        
    }
    //Lifealert
    function lifealert_page() { //Hide everything but the mechanic services page
        
        $(".vertical-center").css("display", "flex");
        //Navigation
        $(".nav-page").css("display", "flex");
        //Main pages
        $(".home-page").css("display", "none");
        $(".call-page").css("display", "none");
        $(".dial-page").css("display", "none");
        $(".dial-page-answer").css("display", "none");
        $(".contact-page").css("display", "none");
        $(".messages-page").css("display", "none");
        $(".sub-messages-page").css("display", "none");
        $(".new-messages-page").css("display", "none");
        $(".services-page").css("display", "none");
        $(".other-services-page").css("display", "none");
        $(".lifealert-page").css("display", "flex");
        $(".loading-page").css("display", "none");
        //Service pages
        $(".services-police-page").css("display", "none");
        $(".services-ems-page").css("display", "none");
        $(".services-taxi-page").css("display", "none");
        $(".services-mechanic-page").css("display", "none");
        //Other Service pages
        $(".other-services-helix-page").css("display", "none"); 
        //Contact page stuff
        $(".contact-page .view-contact").css("display", "none");
        $(".contact-page .add-contact").css("display", "none");
        
    }
    //Other Services
    function other_services_page() { //Hide everything but the services page
        
        $(".vertical-center").css("display", "flex");
        //Navigation
        $(".nav-page").css("display", "flex");
        //Main pages
        $(".home-page").css("display", "none");
        $(".call-page").css("display", "none");
        $(".dial-page").css("display", "none");
        $(".dial-page-answer").css("display", "none");
        $(".contact-page").css("display", "none");
        $(".messages-page").css("display", "none");
        $(".sub-messages-page").css("display", "none");
        $(".new-messages-page").css("display", "none");
        $(".services-page").css("display", "none");
        $(".other-services-page").css("display", "flex");
        $(".lifealert-page").css("display", "none");
        $(".loading-page").css("display", "none");
        //Service pages
        $(".services-police-page").css("display", "none");
        $(".services-ems-page").css("display", "none");
        $(".services-taxi-page").css("display", "none");
        $(".services-mechanic-page").css("display", "none"); 
        //Other Service pages
        $(".other-services-helix-page").css("display", "none"); 
        //Contact page stuff
        $(".contact-page .view-contact").css("display", "none");
        $(".contact-page .add-contact").css("display", "none");
        
    }
    function other_service_helix_page() { //Hide everything but the services page
        
        $(".vertical-center").css("display", "flex");
        //Navigation
        $(".nav-page").css("display", "flex");
        //Main pages
        $(".home-page").css("display", "none");
        $(".call-page").css("display", "none");
        $(".dial-page").css("display", "none");
        $(".dial-page-answer").css("display", "none");
        $(".contact-page").css("display", "none");
        $(".messages-page").css("display", "none");
        $(".sub-messages-page").css("display", "none");
        $(".new-messages-page").css("display", "none");
        $(".services-page").css("display", "none");
        $(".other-services-page").css("display", "none");
        $(".lifealert-page").css("display", "none");
        $(".loading-page").css("display", "none");
        //Service pages
        $(".services-police-page").css("display", "none");
        $(".services-ems-page").css("display", "none");
        $(".services-taxi-page").css("display", "none");
        $(".services-mechanic-page").css("display", "none"); 
        //Other Service pages
        $(".other-services-helix-page").css("display", "flex"); 
        //Contact page stuff
        $(".contact-page .view-contact").css("display", "none");
        $(".contact-page .add-contact").css("display", "none");
        
    }

    function loader_page() { //Hide everything but the loading page
        
        $(".vertical-center").css("display", "flex");
        //Navigation
        $(".nav-page").css("display", "flex");
        //Main pages
        $(".home-page").css("display", "none");
        $(".call-page").css("display", "none");
        $(".dial-page").css("display", "none");
        $(".dial-page-answer").css("display", "none");
        $(".contact-page").css("display", "none");
        $(".messages-page").css("display", "none");
        $(".sub-messages-page").css("display", "none");
        $(".new-messages-page").css("display", "none");
        $(".services-page").css("display", "none");
        $(".other-services-page").css("display", "none");
        $(".lifealert-page").css("display", "none");
        $(".loading-page").css("display", "flex");
        //Service pages
        $(".services-police-page").css("display", "none");
        $(".services-ems-page").css("display", "none");
        $(".services-taxi-page").css("display", "none");
        $(".services-mechanic-page").css("display", "none"); 
        //Other Service pages
        $(".other-services-helix-page").css("display", "none"); 
        //Contact page stuff
        $(".contact-page .view-contact").css("display", "none");
        $(".contact-page .add-contact").css("display", "none");
        
    }

    function formatPhoneNumber(phoneNumberString) {
      var cleaned = ('' + phoneNumberString).replace(/\D/g, '')
      var match = cleaned.match(/^(\d{3})(\d{3})(\d{4})$/)
      if (match) {
        return '(' + match[1] + ') ' + match[2] + '-' + match[3]
      }
      return 'Pester Frazzle if you see this: ' + phoneNumberString
    }
    //Call Page
    var selected_contact_id_call = -1;
    function contacts_sort_call(_contacts) {
        $("#contact_list_call").empty();
        for (let i in _contacts) {
            let contact = _contacts[i];
            $("#contact_list_call").append("<button id=contact_call_" + contact.id + " class='btn btn-primary btn-block btn-lg' type='button'>" + contact.first_name + " " + contact.last_name + "</button>");
            $("#contact_call_" + contact.id).click(function(){
                $("#contact_call_" + selected_contact_id_call).removeClass("active");
                $("#contact_call_" + contact.id).addClass("active");
                $("#input_call_number").val(contact.phone_number)
            })
        }
    }
    
    $("#call_form").submit(function(e){
        e.preventDefault();
        $.post('http://phone/call', JSON.stringify({
            type: "start",
            phone_number: $("#call_form #input_call_number").val(),
        }));
        $("#call_form #input_call_number").prop("disabled", true);
        $("#call_form #btn-submit-call").css("display", "none");
        setTimeout(function(){
            $("#call_form #btn-submit-call").css("display", "block");
            $("#call_form #input_call_number").prop("disabled", false);
        }, 2000);       
    })
    
    function secondsTimeSpanToHMS(s) {
        var h = Math.floor(s/3600); //Get whole hours
        s -= h*3600;
        var m = Math.floor(s/60); //Get remaining minutes
        s -= m*60;
        return h+":"+(m < 10 ? '0'+m : m)+":"+(s < 10 ? '0'+s : s); //zero padding on minutes and seconds
    }
    
    //Dial Page
    function call_timer() {
        $('#call-duration-heading').text(secondsTimeSpanToHMS(Math.floor((new Date - start) / 1000)));
        $('#call-duration-heading-answer').text(secondsTimeSpanToHMS(Math.floor((new Date - start) / 1000)));
    }
    
    $("#btn-cancel-call").click(function(){
        $.post('http://phone/call', JSON.stringify({
            type: "cancel"
        }));
    });
    //Answer page
    $("#btn-call-answer").click(function(){
        $.post('http://phone/call', JSON.stringify({
            type: "answer"
        }));        
    });
    $("#btn-call-decline").click(function(){
        $.post('http://phone/call', JSON.stringify({
            type: "cancel"
        }));        
    });
    //Contacts page
    
    //Contact list
    var selected_contact_id = -1;
    var selected_contact = {};
    function contacts_sort(_contacts) {
        $("#contacts_list").empty();
        for (let i in _contacts) {
            let contact = _contacts[i];
            $("#contacts_list").append("<button id=contact_" + contact.id + " class='btn btn-primary btn-block btn-lg' type='button'>" + contact.first_name + " " + contact.last_name + "</button>");
            $("#contact_" + contact.id).click(function(){
                $("#contact_" + selected_contact_id).removeClass("active");
                $("#contact_" + contact.id).addClass("active");
                selected_contact_id = contact.id;
                selected_contact = contact;
                $("#view-first-name").val(contact.first_name);
                $("#view-last-name").val(contact.last_name);
                $("#view-phone-number").val(contact.phone_number);
                $(".contact-page .view-contact").css("display", "block");
                $(".contact-page .add-contact").css("display", "none");
            })
        }
    }
    
    function add_contact(contact) {
        $("#contacts_list").append("<button id=contact_" + contact.id + " class='btn btn-primary btn-block btn-lg' type='button'>" + contact.first_name + " " + contact.last_name + "</button>");
        $("#contact_" + contact.id).click(function(){
            $("#contact_" + selected_contact_id).removeClass("active");
            $("#contact_" + contact.id).addClass("active");
            selected_contact_id = contact.id;
            selected_contact = contact;
            $("#view-first-name").val(contact.first_name);
            $("#view-last-name").val(contact.last_name);
            $("#view-phone-number").val(contact.phone_number);
            $(".contact-page .view-contact").css("display", "block");
            $(".contact-page .add-contact").css("display", "none");
        })
    }

    //Add contact
    $("#add-contact-form").submit(function(e){
        e.preventDefault();
        $.post('http://phone/add', JSON.stringify({
            type: "contact",
            first_name: $("#add-contact-form #first-name").val(),
            last_name: $("#add-contact-form #last-name").val(),
            phone_number: $("#add-contact-form #phone-number").val(),
        }));
        $("#add-contact-form #first-name").prop("disabled", true);
        $("#add-contact-form #last-name").prop("disabled", true);
        $("#add-contact-form #phone-number").prop("disabled", true);
        $("#add-contact-form #btn-create-contact").css("display", "none");
        setTimeout(function(){
            $("#add-contact-form #first-name").val("");
            $("#add-contact-form #last-name").val("");
            $("#add-contact-form #phone-number").val("");
            $("#add-contact-form #btn-create-contact").css("display", "block");
            $("#add-contact-form #first-name").prop("disabled", false);
            $("#add-contact-form #last-name").prop("disabled", false);
            $("#add-contact-form #phone-number").prop("disabled", false);
        }, 2000);
    })
    
    $("#btn-show-create-contact").click(function(){
        $("#add-contact-form #first-name").val("");
        $("#add-contact-form #last-name").val("");
        $("#add-contact-form #phone-number").val("");
        $(".contact-page .view-contact").css("display", "none");
        $(".contact-page .add-contact").css("display", "block");
    })
    
    //View contact
    
    //Message the contact
    $("#view-message-contact").click(function(){
        newmessage_page();
        $("#new-message-phonenumber").val(selected_contact.phone_number);
    })
    
    //Delete the contact
    $("#view-remove-contact").click(function(){
        $.post('http://phone/remove', JSON.stringify({
            type: "contact",
            id: selected_contact_id,
        }));
    })
    
    //Messages page
    
    //Latest messages list
    function add_messages_latest(_messages) {
        $("#latest-messages").empty()
        for (let i in _messages) {
            let latest_message = _messages[i];
            $("#latest-messages").append("<div id='latest_message_" + i + "' class='col-3 rounded' style='margin-top:5px;margin-bottom:5px;background-color:#007bff;margin-right:10px;margin-left:10px;max-height:200px;overflow-x: hidden;'><h5 style='color:#141414;'><span style='text-decoration: underline;'>" + latest_message.sender + "</span></h5><p style='color:rgb(255,255,255); word-wrap: break-word; width: inherit;'>" + latest_message.message + "</p></div>");
            $("#latest_message_" + i).click(function(){
                selected_message_name = latest_message.sender;
                selected_message_number = latest_message.phone_number;
                $.post('http://phone/open', JSON.stringify({
                    type: "loader",
                    phone_number: latest_message.phone_number,
                }));
            })
        }
    }

    //Sub messages page

    //Sub messages list
    var selected_message_name = "First Last";
    var selected_message_number = "696969";
    function add_messages(_messages) {
        $("#sub-messages-messages").empty();
        for (let i in _messages) {
            let _message = _messages[i];
            if (selected_message_number == _message.source_number) {
                $("#sub-messages-messages").append("<div class='row no-gutters justify-content-start'><div class='col-5 rounded' style='margin-top:5px;margin-bottom:5px;background-color:#007bff;margin-right:10px;margin-left:10px;'><div class='row'><div class='col'><p style=;margin-left:2.5%;>" + moment(_message.timestamp*1000).fromNow() +"</p></div><div class='col'><button id='delete_message_" + _message.id + "' class='close' style='margin-right:2.5%;'><span aria-hidden='true'>×</span></button></div></div><div class='row'><div class='col'><p class='text-center' style='color:rgb(255,255,255);word-wrap:break-word;width:95%;margin-left:2.5%;'>" + _message.message + "</p></div></div></div></div>")
                $("#delete_message_" + _message.id).click(function(){
                    $.post('http://phone/remove', JSON.stringify({
                        type: "messages",
                        id: _message.id,
                        phone_number: selected_message_number,
                    }));
                })
            } else {
                $("#sub-messages-messages").append("<div class='row no-gutters justify-content-end'><div class='col-5 rounded' style='margin-top:5px;margin-bottom:5px;background-color:#28a745;margin-right:10px;margin-left:10px;'><div class='row'><div class='col'><p style=;margin-left:2.5%;>" + moment(_message.timestamp*1000).fromNow() +"</p></div><div class='col'><button id='delete_message_" + _message.id + "' class='close' style='margin-right:2.5%;'><span aria-hidden='true'>×</span></button></div></div><div class='row'><div class='col'><p class='text-center' style='color:rgb(255,255,255);word-wrap:break-word;width:95%;margin-left:2.5%;'>" + _message.message + "</p></div></div></div></div>")
                $("#delete_message_" + _message.id).click(function(){
                    $.post('http://phone/remove', JSON.stringify({
                        type: "messages",
                        id: _message.id,
                        phone_number: selected_message_number,
                    }));
                })
            }
        }
    }
    //Sub message, instant message

    $("#instant-message-form").submit(function(e){
        e.preventDefault();
        $.post('http://phone/add', JSON.stringify({
            type: "message",
            phone_number: selected_message_number,
            message: $("#instant-message-form #instant-message-textarea").val(),
        }));
        $("#instant-message-form #instant-message-textarea").prop("disabled", true);
        $("#instant-message-form #instant-message-submit").css("display", "none");
        setTimeout(function(){
            $("#instant-message-form #instant-message-textarea").val("");
            $("#instant-message-form #instant-message-submit").css("display", "block");
            $("#instant-message-form #instant-message-textarea").prop("disabled", false);
        }, 2000);        
    })
    $("#sub-messages-heading").click(function(){
         $.post('http://phone/open', JSON.stringify({
            type: "contacts",
            add: true,
        }));       
    })
    //New message page
    $("#new-message-form").submit(function(e){
        e.preventDefault();
        $.post('http://phone/add', JSON.stringify({
            type: "message",
            phone_number: $("#new-message-form #new-message-phonenumber").val(),
            message: $("#new-message-form #new-message-container").val(),
        }));
        $("#new-message-form #new-message-phonenumber").prop("disabled", true);
        $("#new-message-form #new-message-container").prop("disabled", true);
        $("#new-message-form #btn-create-message").css("display", "none");
        setTimeout(function(){
            $("#new-message-form #new-message-phonenumber").val("");
            $("#new-message-form #new-message-container").val("");
            $("#new-message-form #btn-create-message").css("display", "block");
            $("#new-message-form #new-message-phonenumber").prop("disabled", false);
            $("#new-message-form #new-message-container").prop("disabled", false);
        }, 2000);
    })

    $("#new-message-form #btn-new-messages-contacts").click(function(){
        $.post('http://phone/open', JSON.stringify({
            type: "contacts",
        }));        
    })
    
    //Services
    
    //Police
    $("#services-police-form").submit(function(e){
        e.preventDefault();
        $.post('http://phone/service', JSON.stringify({
            type: "police",
            report: $("#services-police-form #services-police-textarea").val(),
        }));
        $("#services-police-form #services-police-textarea").prop("disabled", true);
        $("#services-police-form #btn-services-police-submit").css("display", "none");
        setTimeout(function(){
            $("#services-police-form #services-police-textarea").val("");
            $("#services-police-form #btn-services-police-submit").css("display", "block");
            $("#services-police-form #services-police-textarea").prop("disabled", false);
        }, 2000);       
    })
    $("#btn-services-police-cancel").click(function(){
        $.post('http://phone/cancel', JSON.stringify({
            type: "police",
        }));       
    })
    //Emergency
    $("#services-ems-form").submit(function(e){
        e.preventDefault();
        $.post('http://phone/service', JSON.stringify({
            type: "ems",
            report: $("#services-ems-form #services-ems-textarea").val(),
        }));
        $("#services-ems-form #services-ems-textarea").prop("disabled", true);
        $("#services-ems-form #btn-services-ems-submit").css("display", "none");
        setTimeout(function(){
            $("#services-ems-form #services-ems-textarea").val("");
            $("#services-ems-form #btn-services-ems-submit").css("display", "block");
            $("#services-ems-form #services-ems-textarea").prop("disabled", false);
        }, 2000);       
    })
    $("#btn-services-ems-cancel").click(function(){
        $.post('http://phone/cancel', JSON.stringify({
            type: "ems",
        }));       
    })
    //Taxi
    $("#services-taxi-form").submit(function(e){
        e.preventDefault();
        $.post('http://phone/service', JSON.stringify({
            type: "taxi",
            report: $("#services-taxi-form #services-taxi-select option:selected").val(),
        }));
        $("#services-taxi-form #services-taxi-select").prop("disabled", true);
        $("#services-taxi-form #btn-services-taxi-submit").css("display", "none");
        setTimeout(function(){
            $("#services-taxi-form #btn-services-taxi-submit").css("display", "block");
            $("#services-taxi-form #services-taxi-select").prop("disabled", false);
        }, 2000);       
    })
    $("#btn-services-taxi-cancel").click(function(){
        $.post('http://phone/cancel', JSON.stringify({
            type: "taxi",
            report: $("#services-taxi-form #services-taxi-select option:selected").val(),
        }));       
    })
    //Mechanic
    $("#services-mechanic-form").submit(function(e){
        e.preventDefault();
        $.post('http://phone/service', JSON.stringify({
            type: "mechanic",
            report: $("#services-mechanic-form #services-mechanic-select option:selected").val(),
        }));
        $("#services-mechanic-form #services-mechanic-select").prop("disabled", true);
        $("#services-mechanic-form #btn-services-mechanic-submit").css("display", "none");
        setTimeout(function(){
            $("#services-mechanic-form #btn-services-mechanic-submit").css("display", "block");
            $("#services-mechanic-form #services-mechanic-select").prop("disabled", false);
        }, 2000);       
    })
    $("#btn-services-mechanic-cancel").click(function(){
        $.post('http://phone/cancel', JSON.stringify({
            type: "mechanic",
        }));       
    })
    //Other Services
    //Helix Trading
    $("#other-services-helix-form").submit(function(e){
        e.preventDefault();
        $.post('http://phone/other_service', JSON.stringify({
            type: $("#other-services-helix-form #other-services-helix-select option:selected").val(),
        }));
        $("#other-services-helix-form #other-services-helix-select").prop("disabled", true);
        $("#other-services-helix-form #btn-other-services-helix-submit").css("display", "none");
        setTimeout(function(){
            $("#other-services-helix-form #btn-other-services-helix-submit").css("display", "block");
            $("#other-services-helix-form #other-services-helix-select").prop("disabled", false);
        }, 2000);       
    })
    $("#btn-other-services-helix-cancel").click(function(){
        $.post('http://phone/cancel', JSON.stringify({
            type: $("#other-services-helix-form #other-services-helix-select option:selected").val(),
        }));       
    })
    //Event listener
    window.addEventListener('message', function(event) {
        var item = event.data;
    
        if (item.open_phone === true) {
            $("#phone-number-display").text(formatPhoneNumber(item.phone_number))
            home_page();
        } else if (item.open_phone === false) {
            close_phone();
        }

        if (item.open_call === true) {
            contacts_sort_call(item.contacts);
            call_page();
        }
        
        if (item.open_dial === true) {
            if (item.start === true) {
                start = new Date;
                timer = setInterval(call_timer, 1000)
            } else if (item.start === false) {
                clearInterval(timer)
                $('#call-duration-heading').text("0:00:00");
                $('#call-duration-heading-answer').text("0:00:00");
            }
            $("#call-status-heading").text(item.message)
            dial_page();
        }
        
        if(item.update_call === true) {
            if (item.start === true) {
                start = new Date;
                timer = setInterval(call_timer, 1000)
            } else if (item.start === false) {
                clearInterval(timer)
                $('#call-duration-heading').text("0:00:00");
                $('#call-duration-heading-answer').text("0:00:00");
            }
            $("#call-status-heading").text(item.message);
        }
        
        if (item.open_dial_answer === true) {
            if (item.start === true) {
                start = new Date;
                timer = setInterval(call_timer, 1000)
            } else if (item.start === false) {
                clearInterval(timer)
                $('#call-duration-heading').text("0:00:00");
                $('#call-duration-heading-answer').text("0:00:00");
            }
            $("#caller-id-heading").text(item.caller_id);
            dial_answer_page();
        }
        if (item.open_contacts === true) {
            contacts_sort(item.contacts);
            contacts_page();
            if (item.add === true) {
                $("#add-contact-form #phone-number").val(selected_message_number);
            }
        } else if (item.open_contacts === false) {
            
        }
        
        if (item.open_messages === true) {
            add_messages_latest(item.latest_messages);
            messages_page();
        } else if (item.open_messages === false) {
            
        }

        if (item.open_sub_messages === true) {
            add_messages(item.messages);
            $("#sub-messages-heading").text(selected_message_name);
            submessages_page();
            var scrollBottom = $("#sub-messages-messages").height() + 1500000000000000000;
            $("#sub-messages-messages").scrollTop(scrollBottom);
        } else if (item.open_sub_messages === false) {
            
        }

        if (item.open_new_messages === true) {
            newmessage_page();
        } else if (item.open_new_messages === false) {
            
        }

        if (item.add_contact === true) {
            add_contact(item.contact);
        }

        if (item.alert === true) {
            alert(item.alert_message);   
        }
        
        if (item.services === true) {
            services_page();
        }
 
        if (item.service_police === true) {
            services_page_police();
        } else if (item.service_ems === true) {
            services_page_ems();
        } else if (item.service_taxi === true) {
            services_page_taxi();
        } else if (item.service_mechanic === true) {
            services_page_mechanic();
        }

        if (item.other_services === true) {
            other_services_page();
        }
        if (item.other_service_helix === true) {
            other_service_helix_page();
        }
        
        if (item.lifealert === true) {
            lifealert_page();
        }
        
        if (item.open_loader == true) {
            loader_page();
        }
    });

  
    //Home page buttons
    $("#btn_call").click(function(){
        $.post('http://phone/open', JSON.stringify({
            type: "call",
        }));        
    })
    $("#btn_open_contacts").click(function(){
        $.post('http://phone/open', JSON.stringify({
            type: "contacts",
        }));        
    })
    $("#btn_open_messages").click(function(){
        $.post('http://phone/open', JSON.stringify({
            type: "messages",
        }));         
    })
    $("#btn_open_new_message").click(function(){
         $.post('http://phone/open', JSON.stringify({
            type: "new_messages",
        }));
    })
    $("#btn_open_services").click(function(){
        $.post('http://phone/open', JSON.stringify({
            type: "services",
        }));
    })
    $("#btn_open_other_services").click(function(){
        $.post('http://phone/open', JSON.stringify({
            type: "other_services",
        }));
    })
    //Services buttons
    $("#btn_open_police").click(function(){
        $.post('http://phone/open', JSON.stringify({
            type: "service_police",
        }));
    })
    $("#btn_open_ems").click(function(){
        $.post('http://phone/open', JSON.stringify({
            type: "service_ems",
        }));
    })
    $("#btn_open_taxi").click(function(){
        $.post('http://phone/open', JSON.stringify({
            type: "service_taxi",
        }));
    })
    $("#btn_open_mechanic").click(function(){
        $.post('http://phone/open', JSON.stringify({
            type: "service_mechanic",
        }));
    })
    //Life alert
    $("#btn_ambulance").click(function(){
        $.post('http://phone/lifealert', JSON.stringify({
            type: "ambulance",
        }));
    })
    $("#btn_respawn").click(function(){
        $.post('http://phone/lifealert', JSON.stringify({
            type: "respawn",
        }));        
    })
    //Other Services buttons
    $("#btn_open_helix").click(function(){
        $.post('http://phone/open', JSON.stringify({
            type: "other_service_helix",
        }));
    })
    //Back/Close buttons/keys
    document.onkeyup = function (data) { //Close phone
        if (data.which == 27) { // Escape key
           $.post('http://phone/escape', JSON.stringify({}));
        }
    };
    $('.container').mousedown(function(event) {
        if (event.which == 3) {
            $.post('http://phone/back', JSON.stringify({}));
        }
    });
    $("#btn-back").click(function(){
        $.post('http://phone/back', JSON.stringify({}));        
    })
    $("#btn-close").click(function(){
        $.post('http://phone/escape', JSON.stringify({}));        
    })
});