<?php 

    $db->get_category_by_url($_GET['param1']);

    if($category = $db->get_row()){
        require_once ENGINE_DIR.'/modules/pagination.php';

        $pagination = new Pagination(
            function () use ($db, $category){
                $db->count_pages_for_tovars_by_category($category['id']);
            },
            '/category/'.$category['url'].'/',
            $config['count_tovars_on_page']
        );

        $tpl->load('shorttovar.html');
    
        $db->get_tovars_by_category($category['id'], $config['count_tovars_on_page'], $pagination->get_begin_item());
        while($tovar = $db->get_row()){
            $tpl->set('{poster}', '/'.$tovar['poster']);
            $tpl->set('{name}', $tovar['name']);
            $tpl->set('{description}', $tovar['description']);
            $tpl->set('{prace}', $tovar['prace']);

            $tpl->copy_tpl();
        }     
    
        $tpl->save_copy('{tovars}');

        $pagination->gen_tpl();
        

        $tpl->load('category.html');    
        $tpl->save('{content}');
    
        $tpl->set('{category-name}',$head['title'] = $category['name']);

    } else {
        $alerts->set_error('Oшибка', 'Такой категории не существует!', 404);
        $head['title'] = 'Категория не найдена!';
    }
    $tpl->load('shorttovar.html');



    
?>