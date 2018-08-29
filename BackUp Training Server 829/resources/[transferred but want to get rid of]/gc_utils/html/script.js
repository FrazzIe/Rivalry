const nextTick = function(func, time) {
    setTimeout(func, time || 0)
}

const currentShow = -1
const idsTimer = []
const setTimeout = function(func, delay) {
    let id = window.setTimeout(func, delay)
    idsTimer.push(id)
    return id
}

const clearAllTimeout = function () {
    let copy = idsTimer.slice()
    idsTimer.length = 0 
    copy.forEach(clearTimeout)
}

const convertTextColor = function (text) {
  let re = /~([rbgypocmuswdf])~/g
  let m = text.match(re)
  if (m !== null) {
    text = text.replace(re, '<span class="text-$1">') + Array(1+m.length).join('</span>')
  }
  text = text.replace(/~n~/g, '<br>')
  return text
}

const showCursor = function () {
    let cursor = document.querySelector('#cursor')
    cursor.style.display = 'block'
}

const hideCursor = function () {
    let cursor = document.querySelector('#cursor')
    cursor.style.display = 'none'
}

const GUIAction = {
    click () {
        var element = $(document.elementFromPoint(cursorX, cursorY))
        element.focus().click()
    },
    keyUp () {
        $('*:focus').prev().focus()
    },
    keyDown () {
         $('*:focus').next().focus()
    },
    showProgressBar (data) {
        clearAllTimeout()
        let percent = data.percent || 0
        let text = data.text || ''
        let time = data.time || 2000
        let elemProgressBar = document.querySelector('#progressbar')
        let elemProgressBarLoading = document.querySelector('#progressbar_loading')
        let elemProgressBarText = document.querySelector('#progressbar_text')
        elemProgressBarLoading.style.transitionDuration = '120ms'
        elemProgressBarText.innerHTML = convertTextColor(text)
        elemProgressBar.style.display = 'block'
        elemProgressBarLoading.offsetHeight
        elemProgressBarLoading.style.width = (percent*100) + '%'
        setTimeout(GUIAction.hideProgressBar, time)
    },
    showProgressBarTime(data) {
        clearAllTimeout()
        let time = data.time || 8000
        let text = data.text || ''
        let text2 = data.text2 || text
        let elemProgressBar = document.querySelector('#progressbar')
        let elemProgressBarLoading = document.querySelector('#progressbar_loading')
        let elemProgressBarText = document.querySelector('#progressbar_text')
        elemProgressBar.style.display = 'none'
        elemProgressBarLoading.style.transitionDuration = time + 'ms'
        elemProgressBarLoading.style.width = '0%'
        elemProgressBarText.innerHTML = convertTextColor(text)
        elemProgressBarLoading.offsetHeight
        elemProgressBar.style.display = 'block'
        elemProgressBarLoading.offsetHeight
        elemProgressBarLoading.style.width = '100%'
        setTimeout(() => {
            elemProgressBarText.innerHTML = convertTextColor(text2)
            setTimeout(() => {
                GUIAction.hideProgressBar()
            }, 2000)
        }, time) 
    },
    hideProgressBar (data) {
        clearAllTimeout()
        let elemProgressBar = document.querySelector('#progressbar')
        elemProgressBar.style.display = 'none'
    },
    // ===========================
    showInpuText (data) {
        let elemTextInputWrapper = document.querySelector('#inputText_wrapper')
        let elemTextInputitle = document.querySelector('#inputText_title')
        let elemTextInput = document.querySelector('#inputText_value')

        elemTextInputitle.innerText = data.title || ''
        elemTextInput.value = data.defaultValue || ''
        elemTextInputWrapper.style.display = 'block'
        elemTextInput.focus()
        showCursor()
    },
    onValidInputText (value) {
        $.post('http://gc_utils/' + 'onValidInputText', JSON.stringify(value))
        let elemTextInputWrapper = document.querySelector('#inputText_wrapper')
        elemTextInputWrapper.style.display = 'none'
        hideCursor()
    },
    // ===========================
    showDialog (data) {
        let texte = data.texte || '...'
        let reponses = data.reponses || ['NC']
        let elemDialogWrapper = document.querySelector('#dialog_wrapper')
        let elemDialogTexte = document.querySelector('#dialog_texte')
        let elemDialogButtons = document.querySelector('#dialog_button')
        elemDialogButtons.innerHTML = ''
        for (let r of reponses) {
            let but = document.createElement('button')
            but.innerHTML = r
            elemDialogButtons.appendChild(but)
            but.addEventListener('click', GUIAction.onValidDialog)
        }
        elemDialogTexte.innerHTML = convertTextColor(texte)
        elemDialogWrapper.style.display = 'block'
        document.querySelectorAll('#dialog_button button')[0].focus()
        showCursor()
    },
    onValidDialog (event) {
        let elemDialogWrapper = document.querySelector('#dialog_wrapper')
        elemDialogWrapper.style.display = 'none'
        let value = event.target.innerText
        $.post('http://gc_utils/' + 'onValidDialog', JSON.stringify(value))
        hideCursor()
    }
}

window.addEventListener('message', function (event){
    let method = event.data.method
    if (GUIAction[method] !== undefined) {
        GUIAction[method](event.data)
    }
})

window.addEventListener('DOMContentLoaded', () => {
    let btnICancel = document.querySelector('#inputText_button_cancel')
    let btnIValid = document.querySelector('#inputText_button_valid')

    btnICancel.addEventListener('click', () => {
        GUIAction.onValidInputText(null)
    })

    btnIValid.addEventListener('click', () => {
        let elemTextInput = document.querySelector('#inputText_value')
        GUIAction.onValidInputText(elemTextInput.value)
    })

    window.addEventListener('keyup', (event) => {
        var key = event.keyCode ? event.keyCode : event.which
        if (key === 38) {
            GUIAction.keyUp()
        } else if ( key === 40) {
            GUIAction.keyDown()
        }
        
    })
})

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

// GUIAction.showProgressBar({percent: 0.2, text:'Chargement ...'})
// GUIAction.showProgressBarTime({time: 8000, text:'Chargement showProgressBarTime', text2: '+1 tomates'})
// GUIAction.hideProgressBar()
// GUIAction.showDialog({
//     texte: `Salut sa va ?~n~
//     On va devoir faire ~o~ le némage~n~
//     ~w~Je conte sur toi !`,
//     reponses: [
//         'Oui',
//         'Non',
//         'Degage'
//     ]
// })