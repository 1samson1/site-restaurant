var Basket = JSON.parse(Cookies.get('basket') || '[]');

$(function () {
    updateBasket();
})

function clearBasket() {
    Basket = [];
    Cookies.set('basket', '[]');
}

function addBasket(tovar) {
    for(let element of Basket){
        if(element.name == tovar.name){
            element.count += tovar.count;
            element.summ += tovar.summ;
            return;
        }
    }
    
    Basket.push(tovar);
}

function updateBasket() {
    $('.basket__indicator').text(Basket.length);
    Cookies.set('basket', JSON.stringify(Basket));
}

function buyTovar(id, name, poster, prace){
    var count = $('.plus-minus').data('count');

    addBasket({
        id,
        name,
        count,
        poster,
        prace:Number(prace),
        summ: count*prace,
    })
    updateBasket();
    
    $('.added-tovar-description').text("Товар " + name + " добавлен в корзину.")

    $('.modal-window.add-tovar').fadeIn(500,function () {
        setTimeout(function () {
            $('.modal-window.add-tovar').fadeOut(500);
            $("body").css("overflow",""); 
        },7000)
    })
    $('body').css('overflow','hidden')


    $('.bg-modal-window, .close').on('click',function () {
        $('.modal-window.add-tovar').fadeOut(500);
        $("body").css("overflow",""); 
    })
}
