<?php 

    $db->search($_POST['find'], $config['max_searched']);

    if($searched = $db->get_array()){
        $response->set($searched);
    }

    $response->send();
?>
