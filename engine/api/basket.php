<?php 

    if($_GET['action'] == "add"){

        if(isset($_SESSION['basket'][0])){
            foreach($_SESSION['basket'] as $index => $tovar){
                if($tovar['id'] == $_GET['id']){
                    $_SESSION['basket'][$index]['count'] +=  intval($_GET['count']);
                    $updated = true;
                    break;
                }
            }
            $response->set('updated');
        }

        if(!$updated){
            $db->get_tovar($_GET['id']);

            if($tovar = $db->get_row()){
                $tovar['count'] = intval($_GET['count']);
                $_SESSION['basket'][]= $tovar;
                $response->set('added');
            }
            else{
                $response->set_error('Ошибка', 'Неизвестная ошибка!', 520);
                http_response_code(520);
            }    
        }

            
    } elseif ($_GET['action'] == "remove"){
        if(isset($_SESSION['basket'][0])){
            foreach($_SESSION['basket'] as $index => $tovar){
                if($tovar['id'] == $_GET['id']){
                    unset($_SESSION['basket'][$index]);
                    $_SESSION['basket'] = array_values($_SESSION['basket']);
                    break;
                }
            }
        }
        $response->set('removed');
    } elseif ($_GET['action'] == "clear") {
        unset($_SESSION['basket']);
        $response->set('cleared');
    } else {
        $response->set($_SESSION['basket']);
    }

    

    $response->send();
?>
