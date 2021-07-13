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

    $('.basket-item__buy').each(function () {
        changeCost(
            $(this).find('.basket-item__summ .summ'),
            $(this).attr('data-cost'),
            $(this).find('.plus-minus').data('count')
        );
    })


    $('.basket-item__buy').on('count', '.plus-minus', function (event) {

        const tovar_id = $(event.delegateTarget).attr('data-tovar');
        const count = $(this).data('count');

        if($(this).data('timer'))
            clearTimeout($(this).data('timer'));
        
        $(this).data('timer', setTimeout(function () {
            send(`/api/basket/?action=update&id=${tovar_id}&count=${count}`)
                .then(() => {
                    changeCost(
                        $(event.delegateTarget).find('.basket-item__summ .summ'),
                        $(event.delegateTarget).attr('data-cost'),
                        count
                    );
                })
            
        }, 1000)); 
        
    })
})

function changeCost(element, cost, count) {
    element.text(Number(cost) * count)
}

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
