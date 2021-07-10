var Basket = JSON.parse(Cookies.get('basket') || '[]');

function clearBasket() {
    Basket = [];
    Cookies.set('basket', '[]');
}

function addBasket(tovar) {
    for(let element of Basket){
        if(element.name == tovar.name){
            element.count += tovar.count;
            Cookies.set('basket', JSON.stringify(Basket));
            return;
        }
    }
    
    Basket.push(tovar); 
    Cookies.set('basket', JSON.stringify(Basket));
}

function buyTovar(id, name, poster){
    var count = $('.plus-minus').data('count');

    addBasket({
        id,
        name,
        count,
        poster
    })
    
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
