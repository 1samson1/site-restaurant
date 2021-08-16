<?php 
    require_once ENGINE_DIR.'/includes/functions.php';

    function checkOrder(){
        global $db, $alerts, $order_number;

        
        if(isset($_SESSION['basket'][0])){
            $sum = 0;
            $time = time();
            $order_number = md5($time.randomStr());
            
            foreach($_SESSION['basket'] as $basket_item){
                if($basket_item['discount'])
                    $price = $basket_item['discount'];
                else
                    $price = $basket_item['price'];

                $sum += $basket_item['count'] * $price;

                $db->add_order_tovar(
                    $order_number,
                    $basket_item['id'],
                    $basket_item['count'],
                    $price
                );
            }

            $db->add_order(
                $_SESSION['user']['id'],
                $order_number,
                $_POST['adress'],
                $_POST['phone'],
                $time
            );

            $db->send_queries();

            if(!$db->error)
                return true;
            else 
                $alerts->set_error('Ошибка оформления заказа', 'Неизвестная ошибка', 520);


        } else $alerts->set_error('Ошибка оформления заказа', 'Ваша корзина пуста!', 404);

        return false;
    }

    if(isset($_POST['payment'])  && checkOrder()){

        $tpl->load('order.html');

        $tpl->set_repeat_block('basket-item');    
        
        $sum = 0;
        
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
                $sum += $basket_item['discount'] * $basket_item['count'];
                
            } else {
                
                $tpl->set_block('discount','');
                $tpl->set('[not-discount]','');
                $tpl->set('[/not-discount]','');
                $tpl->set('{cost}',  $basket_item['price'] * $basket_item['count']);
                $sum += $basket_item['price'] * $basket_item['count'];

            }
        
            $tpl->copy_repeat_block();
        }

        $tpl->save_repeat_block();

        $tpl->set('{itog}', $sum);
        $tpl->set('{order}', $order_number);

    }elseif(isset($_SESSION['basket'][0])){
        $tpl->load('basket.html');    
    
        $tpl->set_repeat_block('basket-item');
        
        $tpl->set('{adress}', $_SESSION['user']['adress']);
        $tpl->set('{phone}', $_SESSION['user']['phone']);

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
                $tpl->set('{cost}',  $basket_item['discount']);
                
            } else {
                
                $tpl->set_block('discount','');
                $tpl->set('[not-discount]','');
                $tpl->set('[/not-discount]','');
                $tpl->set('{cost}',  $basket_item['price']);

            }
        
            $tpl->copy_repeat_block();
                
        }

        $tpl->save_repeat_block();

    } else {
        $tpl->load('emptybasket.html');
    }

    $head['title'] = 'Корзина';
    $tpl->save('{content}');
?>
