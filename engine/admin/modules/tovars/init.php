<?php

    $crumbs->add($head['title'] = 'Товары', MODULE_URL);

    require_once ENGINE_DIR.'/includes/functions.php';
    require_once ENGINE_DIR.'/includes/checkFeild.php';
    require_once ENGINE_DIR.'/includes/upload.php';
    
    if($_GET['action'] == 'delete'){

        if($db->remove_tovar($_GET['delete'])){
            showSuccess('Товар удален!','Выбранный товар успешно удален!', MODULE_URL);
        }
        else showError('Ошибка удаления!', 'Неизвестная ошибка!', MODULE_URL);

    }
    elseif(isset($_GET['delete'])){

        showConfirm('Удаление товара', 'Вы действительно хотите удалить выбранный товар?', addGetParam('action','delete'), MODULE_URL);
    
    }
    elseif(isset($_GET['id'])){

        $crumbs->add($head['title'] = 'Редактирование товара', '');

        $db->get_tovar_by_id($_GET['id']);

        if($tovar = $db->get_row()){

            if(isset($_POST['save'])){

                $alerts->set_error_if(!CheckField::empty($_POST['name']), 'Ошибка добавления!', 'Вы не ввели название товара!', 564);
            
                $alerts->set_error_if(!CheckField::empty($_POST['category']), 'Ошибка добавления!', 'Вы не выбрали категорию товара ', 565);
                
                $alerts->set_error_if(!CheckField::empty($_POST['price']), 'Ошибка добавления!', 'Вы не ввели цену товара', 566);

                $alerts->set_error_if(!CheckField::is_num($_POST['price']), 'Ошибка добавления!', 'Вы ввели некорректную цену товара', 568);
                
                $alerts->set_error_if(!CheckField::empty($_POST['discount']), 'Ошибка добавления!', 'Вы ввели скидку товара ', 567);
                
                $alerts->set_error_if(!CheckField::is_num($_POST['discount']), 'Ошибка добавления!', 'Вы ввели некорректную цену товара со скидкой', 569);

                $poster = new Upload_Image('poster', false, 'tovars');

                $alerts->alerts_array = array_merge($alerts->alerts_array, $poster->errors);
    
                if(!isset($alerts->alerts_array[0])){
                    if($db->edit_tovar($tovar['id'], $_POST['category'], $_POST['name'], $_POST['description'], $_POST['price'], $_POST['discount'], $poster->filepath)){

                        if($poster->filepath){
                            delete_file($tovar['poster']);
                            $poster->save();
                        }
                        
                        return showSuccess('Товар изменина!','Успешно изменен товар!', MODULE_URL);
                        
                    }
                    else $alerts->set_error('Ошибка изменения!', 'Неизвестная ошибка!', $db->error_num);
                }
            }

            $tpl->load('edit.html', MODULE_SKIN_DIR);

            $db->get_categories();
            while ($category = $db->get_row()) {
                $categories .= '<option value="'.$category['id'].'" '.($category['id'] == $tovar['category_id']?'selected':'').'>'.$category['name'].'</option>';
            }
            $tpl->set('{categories}', $categories);

            $tpl->set('{name}', $tovar['name']);
            $tpl->set('{description}', $tovar['description']);
            $tpl->set('{price}', $tovar['price']);
            $tpl->set('{discount}', $tovar['discount']);
            
            if($tovar['poster']) $poster = '/'.$tovar['poster'];
            else $poster = '{SKIN}/img/noimage.jpg';
            $tpl->set('{poster}', $poster);

            $tpl->save('{content}');
        }
        else $alerts->set_error('Oшибка', 'Такого товара не существует!', 404);

    }
    elseif($_GET['action'] == 'addnew'){

        $crumbs->add($head['title'] = 'Добавление товара', '');

        if(isset($_POST['add'])){

            $alerts->set_error_if(!CheckField::empty($_POST['name']), 'Ошибка добавления!', 'Вы не ввели название товара!', 564);
            
            $alerts->set_error_if(!CheckField::empty($_POST['category']), 'Ошибка добавления!', 'Вы не выбрали категорию товара ', 565);
            
            $alerts->set_error_if(!CheckField::empty($_POST['price']), 'Ошибка добавления!', 'Вы не ввели цену товара', 566);

            $alerts->set_error_if(!CheckField::is_num($_POST['price']), 'Ошибка добавления!', 'Вы ввели некорректную цену товара', 568);
            
            $alerts->set_error_if(!CheckField::empty($_POST['discount']), 'Ошибка добавления!', 'Вы ввели скидку товара ', 567);
            
            $alerts->set_error_if(!CheckField::is_num($_POST['discount']), 'Ошибка добавления!', 'Вы ввели некорректную цену товара со скидкой', 569);

            $poster = new Upload_Image('poster', false, 'tovars');

            $alerts->alerts_array = array_merge($alerts->alerts_array, $poster->errors);
            
            if(!isset($alerts->alerts_array[0])){
                if($db->add_tovar($_POST['category'], $_POST['name'], $_POST['description'], $_POST['price'], $_POST['discount'], time(), $poster->filepath)){  

                    if($poster->filepath){
                        $poster->save();
                    }

                    return showSuccess('Товар добавлен!','Успешно добавлен товар!', MODULE_URL);

                }
                else $alerts->set_error('Ошибка добавления!', 'Неизвестная ошибка!', $db->error_num);
            }
        }

        $tpl->load('addnew.html', MODULE_SKIN_DIR);

        $db->get_categories();
        while ($category = $db->get_row()) {
            $categories .= '<option value="'.$category['id'].'" >'.$category['name'].'</option>';
        }
        $tpl->set('{categories}', $categories);

        $tpl->save('{content}');

    }
    else{
        
        $tpl->load('main.html', MODULE_SKIN_DIR);
    
        $db->get_tovars();
        
        $tpl->set_repeat_block('tovars');
        
        while($tovar = $db->get_row()){
        
            $tpl->set('{name}', $tovar['name']);
            $tpl->set('{price}', $tovar['price']);
            $tpl->set('{url}', '/tovar/'.$tovar['id'].'/');
            $tpl->set('{discount}', $tovar['discount']);
            $tpl->set('{date}', date('Y.m.d H:i',$tovar['date']));
            $tpl->set('{edit-link}',  addGetParam('id', $tovar['id']));
            $tpl->set('{delete-link}', addGetParam('delete', $tovar['id']));
            
    
            $tpl->copy_repeat_block();
            
        }
    
        $tpl->save_repeat_block();
    
        $tpl->set('{add_tovar_link}', addGetParam('action','addnew'));
    
        $tpl->save('{content}');

    }

?>
