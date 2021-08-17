<?php

    $crumbs->add($head['title'] = 'Категории товаров', MODULE_URL);

    require_once ENGINE_DIR.'/includes/functions.php';
    require_once ENGINE_DIR.'/includes/checkFeild.php';
    
    if($_GET['action'] == 'delete'){

        if($db->remove_category($_GET['delete'])){
            showSuccess('Категория удалена!','Выбраная категория успешно удалена!', MODULE_URL);
        }
        else showError('Ошибка удаления!', 'Неизвестная ошибка!', MODULE_URL);

    }
    elseif(isset($_GET['delete'])){

        showConfirm('Удаление категории', 'Вы действительно хотите удалить выбранную категорию?', addGetParam('action','delete'), MODULE_URL);
    
    }
    elseif(isset($_GET['id'])){

        $crumbs->add($head['title'] = 'Редактирование категории', '');

        $db->get_category_by_id($_GET['id']);

        if($category = $db->get_row()){

            if(isset($_POST['save'])){

                $alerts->set_error_if(!CheckField::empty($_POST['name']), 'Ошибка изменения!', 'Вы не ввели название категории!', 564);
            
                $alerts->set_error_if(!CheckField::empty($_POST['url']), 'Ошибка изменения!', 'Вы не ввели адрес категории!', 565);
                
                if(!isset($alerts->alerts_array[0])){
                    if($db->edit_category($_GET['id'], $_POST['url'], $_POST['name'], $_POST['description'], time())){

                        return showSuccess('Товар изменин!','Успешно изменен товар!', MODULE_URL);

                    }
                    else $alerts->set_error('Ошибка изменения!', 'Неизвестная ошибка!', $db->error_num);
                }
            }

            $tpl->load('edit.html', MODULE_SKIN_DIR);

            $tpl->set('{name}', $category['name']);
            $tpl->set('{url}', $category['url']);
            $tpl->set('{description}', $category['description']);

            $tpl->save('{content}');
        }
        else $alerts->set_error('Oшибка', 'Такого товара не существует!', 404);

    }
    elseif($_GET['action'] == 'addnew'){

        $crumbs->add($head['title'] = 'Добавление категории', '');

        if(isset($_POST['add'])){
            $alerts->set_error_if(!CheckField::empty($_POST['name']), 'Ошибка добавления!', 'Вы не ввели название категории!', 564);
            
            $alerts->set_error_if(!CheckField::empty($_POST['url']), 'Ошибка добавления!', 'Вы не ввели адрес категории!', 565);
            
            if(!isset($alerts->alerts_array[0])){
                if($db->add_category($_POST['url'], $_POST['name'], $_POST['description'], time())){  

                    return showSuccess('Товар добавлен!','Успешно добавлен товар!', MODULE_URL);

                }
                else $alerts->set_error('Ошибка добавления!', 'Неизвестная ошибка!', $db->error_num);
            }
        }
        
        $tpl->load('addnew.html', MODULE_SKIN_DIR);

        $tpl->save('{content}');

    }
    else{
        
        $tpl->load('main.html', MODULE_SKIN_DIR);
    
        $db->get_categories();
        
        $tpl->set_repeat_block('categories');
        
        while($category = $db->get_row()){
        
            $tpl->set('{name}', $category['name']);
            $tpl->set('{url}', $category['url']);
            $tpl->set('{url-link}', '/category/'.$category['url'].'/');
            $tpl->set('{date_edit}', date('Y.m.d H:i',$category['date_edit']));
            $tpl->set('{date}', date('Y.m.d H:i',$category['date']));
            $tpl->set('{edit-link}',  addGetParam('id', $category['id']));
            $tpl->set('{delete-link}', addGetParam('delete', $category['id']));
            
    
            $tpl->copy_repeat_block();
            
        }
    
        $tpl->save_repeat_block();
    
        $tpl->set('{add_category_link}', addGetParam('action','addnew'));
    
        $tpl->save('{content}');

    }

?>
