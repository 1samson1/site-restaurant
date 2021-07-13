$(function () {
    $('.bg-modal-window, .close').on('click',function () {
        $('.modal-window.add-tovar').fadeOut(500);
        $("body").css("overflow",""); 
    })

    $('.tovar__buy').on('click', '.btn-add', function (event) {
        const count = $(event.delegateTarget).children('.plus-minus').data('count');
        const tovar_id = $(this).attr('data-tovar');

        send(`/api/basket/?action=add&id=${tovar_id}&count=${count}`)
            .then( response => {
                if(response == 'added'){
                    const indicator = $('.basket__indicator');
                    indicator.text(Number(indicator.text()) + 1 || 0);
                }

                $('.added-tovar-description').text("Товар добавлен в корзину.")

                $('.modal-window.add-tovar').fadeIn(500,function () {
                    setTimeout(function () {
                        $('.modal-window.add-tovar').fadeOut(500);
                        $("body").css("overflow",""); 
                    },7000)
                })
                $('body').css('overflow','hidden')
            })
        
    })
})

function send(url,body) {
    return fetch(url, {
        method:'GET',
        body
    })
    .then(response => response.json())
    .then(json => new Promise((resolve, reject) => {
        if(json.errors){
            return reject(json.errors[0])
        }
        return resolve(json.response)
    }))
    .catch( error => console.error(error))
}

function clearBasket() {
    send('/api/basket/?action=clear')
        .then(() => window.location.reload())
}

function removeBasket(id) {
    send(`/api/basket/?action=remove&id=${id}`)
        .then(() => window.location.reload())
}
