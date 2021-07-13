<?php 
    $tpl->load('basket.html');    

    if(isset($_SESSION['basket'][0])){

        $tpl->set_repeat_block('/\[basket-item\](.*)\[\/basket-item\]/sU');        

        foreach($_SESSION['basket'] as $basket_item){

            $tpl->set('{poster}', "/".$basket_item['poster']);
            $tpl->set('{name}', $basket_item['name']);
            $tpl->set('{id}', $basket_item['id']);
            $tpl->set('{price}', $basket_item['price']);
            $tpl->set('{count}', $basket_item['count']);
            $tpl->set('{tovar_link}', '/tovars/'.$basket_item['id'].'/');

            if($basket_item['discount']){

                $tpl->set_block('not-discount','');
                $tpl->set('[discount]','');
                $tpl->set('[/discount]','');
                $tpl->set('{discount}', $basket_item['discount']);
                $tpl->set('{cost}',  $basket_item['discount'] * $basket_item['count']);
                
            } else {
                
                $tpl->set_block('discount','');
                $tpl->set('[not-discount]','');
                $tpl->set('[/not-discount]','');
                $tpl->set('{cost}',  $basket_item['price'] * $basket_item['count']);

            }
        
            $tpl->copy_repeat_block();
                
        }

        $tpl->save_repeat_block();

    } else {

    }

    $head['title'] = 'Корзина';
    $tpl->save('{content}');
?>