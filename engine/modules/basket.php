<?php 
    $tpl->load('basket.html');

    $basket = json_decode($_COOKIE['basket']) or False;

    if(isset($basket[0])){

        $tpl->set_repeat_block('/\[basket-item\](.*)\[\/basket-item\]/sU');

        foreach($basket as $basket_item){

            $tpl->set('{poster}', $basket_item->poster);
            $tpl->set('{name}', $basket_item->name);
            $tpl->set('{id}', $basket_item->id);
            $tpl->set('{prace}', $basket_item->prace);
        
            $tpl->copy_repeat_block();
                
        }

        $tpl->save_repeat_block();

    } else {

    }

    $head['title'] = 'Корзина';
    $tpl->save('{content}');
?>
