GUIAction = {
    closeGui () {
        $('#identity').css("display", "none");
        $('#register').css("display", "none");
        $("#cursor").css("display", "none");
    },
    openGuiIdentity (data) {
        data = data || {}
        let infoMissing = 'Fake ID'
        if (data.dateNaissance) {
            data.dateNaissance = data.dateNaissance.substr(0,11)
        }
        if (data.sexe !== undefined) {
            $('#identity').css('background-image', "url('carteV3_" + data.sexe +".png')")
            data.sexe = data.sexe === 'h' ? 'Male' : 'Female'
        }
        if (data.taille !== undefined){
            data.taille = data.taille + ' cm'
        }
        ['nom','prenom','jobs', 'dateNaissance', 'sexe', 'taille'].forEach(k => {
            $('#'+k).text(data[k] || infoMissing)
        })

        

        $('#identity').css("display", "block");
    },
    openGuiRegisterIdentity () {
        $("#cursor").css("display", "block");
        $('#register').css("display", "flex");
    },
    clickGui () {
        var element = $(document.elementFromPoint(cursorX, cursorY))
        element.focus().click()
    }
}

window.addEventListener('message', function (event){
    let method = event.data.method
    if (GUIAction[method] !== undefined) {
        GUIAction[method](event.data.data)
    }
})


$(document).ready(function () {
    $('#register').submit(function (event) {
        event.preventDefault()
        let form = event.target
        let data = {}
        let attrs = ['nom', 'prenom', 'dateNaissance', 'sexe', 'taille']
        attrs.forEach(e => {
            data[e] = form.elements[e].value
        })
        data.dateNaissance = data.dateNaissance.split('/').reverse().join('-')
        $.post('http://identity/' + 'register', JSON.stringify(data))
    })
})

//
// Gestion de la souris
//
$(document).ready(function(){
    var documentWidth = document.documentElement.clientWidth
    var documentHeight = document.documentElement.clientHeight
    var cursor = $('#cursor')
    cursorX = documentWidth / 2
    cursorY = documentHeight / 2
    cursor.css('left', cursorX)
    cursor.css('top', cursorY)
    $(document).mousemove( function (event) {
        cursorX = event.pageX
        cursorY = event.pageY
        cursor.css('left', cursorX + 1)
        cursor.css('top', cursorY + 1)
    })
})