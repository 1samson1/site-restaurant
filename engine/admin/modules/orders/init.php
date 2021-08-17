<?php

    $crumbs->add($head['title'] = 'Заказы', MODULE_URL);

    require_once ENGINE_DIR.'/includes/functions.php';
    require_once ENGINE_DIR.'/includes/checkFeild.php';
    
    if($_GET['action'] == 'delete'){

        if($db->remove_order($_GET['delete'])){
            showSuccess('Заказ удалён!','Выбраный заказ успешно удалён!', MODULE_URL);
        }
        else showError('Ошибка удаления!', 'Неизвестная ошибка!', MODULE_URL);

    }
    elseif(isset($_GET['delete'])){

        showConfirm('Удаление заказа', 'Вы действительно хотите удалить выбранный заказ?', addGetParam('action','delete'), MODULE_URL);
    
    }
    elseif(isset($_GET['id'])){

        $crumbs->add($head['title'] = 'Просмотр заказа', '');

        $db->get_order_by_id($_GET['id']);

        if($order = $db->get_row()){

            $tpl->load('show.html', MODULE_SKIN_DIR);

            $tpl->set('{number}', $order['number']);
            $tpl->set('{adress}', $order['adress']);
            $tpl->set('{phone}', $order['phone']);
            $tpl->set('{user_name}', $order['user_name']);
            $tpl->set('{user_surname}', $order['user_surname']);
            $tpl->set('{url-user}', '/profile/'.$order['user_login'].'/');
            $tpl->set('{time}', date('Y.m.d H:i',$order['time']));

            $tpl->set_repeat_block('tovars');

            $db->get_order_tovars_by_number($order['number']);

            $summ = 0;
        
            while($order_tovar = $db->get_row()){

                $summ +=  $order_tovar['price'] * $order_tovar['count'];
            
                $tpl->set('{name}', $order_tovar['name']);
                $tpl->set('{price}', $order_tovar['price']);
                $tpl->set('{count}', $order_tovar['count']);
                $tpl->set('{url-tovar}', '/tovar/'.$order_tovar['tovar_id'].'/');
                
                if($order_tovar['poster']) $poster = '/'.$order_tovar['poster'];
                else $poster = '{SKIN}/img/noimage.jpg';
                $tpl->set('{poster}', $poster);
                
        
                $tpl->copy_repeat_block();
                
            }
        
            $tpl->save_repeat_block();

            $tpl->set('{summ}', $summ);

            $tpl->save('{content}');
        }
        else $alerts->set_error('Oшибка', 'Такого товара не существует!', 404);

    } 
    else{
        
        $tpl->load('main.html', MODULE_SKIN_DIR);
    
        $db->get_orders();
        
        $tpl->set_repeat_block('orders');
        
        while($order = $db->get_row()){
        
            $tpl->set('{number}', $order['number']);
            $tpl->set('{adress}', $order['adress']);
            $tpl->set('{phone}', $order['phone']);
            $tpl->set('{time}', date('Y.m.d H:i',$order['time']));
            $tpl->set('{show-link}',  addGetParam('id', $order['id']));
            $tpl->set('{delete-link}', addGetParam('delete', $order['id']));            
    
            $tpl->copy_repeat_block();
        }
    
        $tpl->save_repeat_block();
    
        $tpl->save('{content}');

    }

?>
