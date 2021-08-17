<?php 
    function addGetParam($name, $param){
        if(strpos($_SERVER['REQUEST_URI'], '?') === false){
            return $_SERVER['REQUEST_URI'].'?'.$name.'='.$param;
        }
        return $_SERVER['REQUEST_URI'].'&'.$name.'='.$param;     
    }   

    function randomStr($size = 10){
        $permitted_chars = '0123456789abcdefghijklmnopqrstuvwxyz';
        return substr(str_shuffle($permitted_chars), 0, $size);
    }

    function custom ($matches){
        global $config, $db, $tpl;

        $params = $matches[1];

        if( preg_match( "/category=['\"](.+?)['\"]/i", $params, $match ) ) {
            $custom_category = trim($match[1]);
        } else $custom_category = "";

        if( preg_match( "/template=['\"](.+?)['\"]/i", $params, $match ) ) {
            $custom_template = trim($match[1]);
        } else $custom_template = "shortnews.html";

        if( preg_match( "/limit=['\"](.+?)['\"]/i", $params, $match ) ) {
            $custom_limit = intval($match[1]);
        } else $custom_limit = $config['count_tovars_on_page'];

        if( preg_match( "/sort=['\"](.+?)['\"]/i", $params, $match ) ) {
            $custom_sort = trim($match[1]);
        } else $custom_sort = "ASC";

        $db->get_custom($custom_limit, $custom_category, $custom_sort);

        $tpl->load($custom_template);

        while($tovar = $db->get_row()){
            $tpl->set('{poster}', '/'.$tovar['poster']);
            $tpl->set('{name}', $tovar['name']);
            $tpl->set('{description}', $tovar['description']);
            $tpl->set('{price}', $tovar['price']);
            $tpl->set('{tovar-link}', '/tovar/'.$tovar['id'].'/');

            if($tovar['discount']){

                $tpl->set_block('not-discount','');
                $tpl->set('[discount]','');
                $tpl->set('[/discount]','');
                $tpl->set('{discount}', $tovar['discount']);

            } else {

                $tpl->set_block('discount','');
                $tpl->set('[not-discount]','');
                $tpl->set('[/not-discount]','');

            }

            $tpl->copy_tpl();
        }                    

        $temp = $tpl->copy_template;

        $tpl->copy_template = null;

        return $temp;

    }
?>