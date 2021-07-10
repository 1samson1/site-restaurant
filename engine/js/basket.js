var Basket = JSON.parse(Cookies.get('basket') || '[]');

function clearBasket() {
    Basket = [];
    Cookies.set('basket', '[]');
}

function addBasket(tovar) {    
    Basket.forEach(element => {
        if(element.name == tovar.name){
            element.count += tovar.count;
            return;
        }
    });       
    
    Basket.push(tovar); 
    Cookies.set('basket', JSON.stringify(Basket));
}