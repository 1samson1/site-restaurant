<?php
    require_once ENGINE_DIR.'/includes/db.php'; // Подключаем файл базового класса базы данных

    class QueryDB extends DataBase{

        /*////////////////// Query for users tools  ////////////////////*/

        public function reg_user($group_id, $name, $surname, $login, $email, $phone, $gender, $adress, $pass){            
            return $this->query('
                INSERT INTO `users` (`group_id`,`name`,`surname`,`login`,`email`, `phone`, `gender`, `adress`, `password`,`date_reg`) 
                    VALUE (
                        "'.$group_id.'",
                        "'.$this->ecran_html($name).'",
                        "'.$this->ecran_html($surname).'",
                        "'.$this->ecran_html($login).'",
                        "'.$this->ecran_html($email).'",
                        "'.$this->ecran_html($phone).'",
                        "'.$this->ecran_html($gender).'",
                        "'.$this->ecran_html($adress).'",
                        "'.$this->hash($this->ecran_html($pass)).'",
                        "'.time().'"
                    )
            ;');
        }
        
        public function get_user($login){
            return $this->query('
                SELECT `users`.*, `groups`.`group_name`, `groups`.`id` AS `group_id` FROM `users`
                    INNER JOIN `groups` ON `users`.`group_id` = `groups`.`id` 
                    WHERE `login` = "'.$this->ecran_html($login).'"
            ;');
        }

        public function update_user($user_id, $name, $surname, $login, $email, $phone, $gender, $adress, $pass, $foto=false, $delete_foto=false){
            $pass = isset($pass[0])?', `users`.`password` = "'.$this->hash($this->ecran_html($pass)).'"' :'';
            if($delete_foto){
                $foto = ', `users`.`foto` = ""';
            }
            else if($foto){
                $foto = ', `users`.`foto` = "'.$foto.'"';
            }
            else{
                $foto = '';
            }
            return $this->query('
                UPDATE `users`
                    SET  
                        `users`.`name` = "'.$this->ecran_html($name).'",
                        `users`.`surname` = "'.$this->ecran_html($surname).'",
                        `users`.`login` = "'.$this->ecran_html($login).'",
                        `users`.`email` = "'.$this->ecran_html($email).'",
                        `users`.`phone` = "'.$this->ecran_html($phone).'",
                        `users`.`gender` = "'.$this->ecran_html($gender).'", 
                        `users`.`adress` = "'.$this->ecran_html($adress).'"
                        '.$pass.'
                        '.$foto.'
                    WHERE `users`.`id` = "'.$user_id.'"
            ;');
        }

        /*............... Query for work user's token ................*/

        public function add_token($user_id, $token){            
            return $this->query('
                INSERT INTO `user_tokens` (`user_id`, `token`, `date`) 
                    VALUES ('.$user_id.',"'.$token.'","'.time().'")
            ;');
        }  

        public function get_user_by_token($token){
            return $this->query('
                SELECT `users`.*, `groups`.`group_name`, `groups`.`id` AS `group_id` FROM `user_tokens` 
                    INNER JOIN `users` ON `user_tokens`.`user_id` = `users`.`id`
                    INNER JOIN `groups` ON `users`.`group_id` = `groups`.`id`
                    WHERE `token` = "'.$this->ecran_html( $token).'"
            ;');
        }

        public function remove_token($token){
            return $this->query('
                DELETE FROM `user_tokens`
                    WHERE `token` = "'.$this->ecran_html( $token).'"
            ;');
        }

        public function remove_token_all($user_id,$token){
            return $this->query('
                DELETE FROM `user_tokens`
                    WHERE `user_id` = "'.$this->ecran_html( $user_id).'" AND `token` != "'.$this->ecran_html($token).'"
            ;');
        }

        /*////////////////// Query for custom ////////////////////*/

        public function get_custom($limit, $category, $sort){

            if($category){

                $category = explode(',', $category);
    
                foreach ($category as $key => $value){
                    $category[$key] = '"'.trim($value).'"';
                }
    
                $category = "WHERE `categories`.`url` IN (".implode(',', $category).")";
            }


            return $this->query('
                SELECT `tovars`.* FROM `tovars` 
                    INNER JOIN `categories` ON `categories`.`id` = `tovars`.`category_id`
                    '.$category.'
                    ORDER BY `tovars`.`date` '.$sort.'
                    LIMIT '.$limit.'
            ;');
        }

        /*////////////////// Query for tovars ////////////////////*/

        public function get_category_by_url($url){
            return $this->query('
                SELECT 
                    `categories`.`id`,
                    `categories`.`name`,
                    `categories`.`url`,
                    `categories`.`date`
                FROM `categories`
                    WHERE `categories`.`url` = "'.$this->ecran_html($url).'"
            ;');
        }

        public function get_tovar($id){
            return $this->query('
                SELECT 
                    `tovars`.*
                FROM `tovars`
                    WHERE `tovars`.`id` = "'.$this->ecran_html($id).'"
            ;');
        }

        public function get_full_tovar($id){
            return $this->query('
                SELECT 
                    `tovars`.*,
                    (SELECT COUNT(*) FROM `comments` WHERE `comments`.`tovar_id` = `tovars`.`id`) AS `count_comments`
                FROM `tovars`
                    WHERE `tovars`.`id` = "'.$this->ecran_html($id).'"
            ;');
        }



        public function get_tovars_by_category($category_id, $count, $begin=0){
            return $this->query('
                SELECT 
                    `tovars`.*
                FROM `tovars`
                    WHERE `category_id` = '.$category_id.'
                    ORDER BY `tovars`.`date` DESC
                    LIMIT '.$begin.', '.$count.'
            ;');
        }

        /*////////////////// Query for search ////////////////////*/

        public function search($search, $count=10){
            return $this->query('
                SELECT 
                    `tovars`.* 
                FROM `tovars`
                    WHERE `tovars`.`name` LIKE("%'.$this->ecran_html($search).'%")
                    LIMIT '.$count.'
            ;');
        }

        /*////////////////// Query for orders ////////////////////*/

        public function add_order($user_id, $number, $adress, $phone, $time){
            return $this->add_query_begin('
                INSERT INTO `orders` (`user_id`, `number`, `adress`, `phone`, `time`) 
                    VALUES ("'.$user_id.'", "'.$number.'", "'.$this->ecran_html($adress).'","'.$this->ecran_html($phone).'","'.$time.'")
            ;');
        }

        public function add_order_tovar($order_number, $tovar_id, $count, $price){
            return $this->add_query('
                INSERT INTO `order_tovars` (`order_number`, `tovar_id`, `count`, `price`) 
                    VALUES ("'.$order_number.'", "'.$this->ecran_html($tovar_id).'","'.$this->ecran_html($count).'","'.$this->ecran_html($price).'")
            ;');
        }
        
        /*////////////////// Query for news ////////////////////*/

        public function get_short_news($count, $begin=0){
            return $this->query('
                SELECT 
                    `news`.`id`,
                    `users`.`login` AS `autor`, 
                    `news`.`title`,
                    `news`.`date`,
                    `news`.`short_news` AS `body`
                FROM `news`
                    INNER JOIN `users` ON `news`.`autor` = `users`.`id`
                    ORDER BY `news`.`date` DESC
                    LIMIT '.$begin.', '.$count.'
            ;');
        }

        public function get_full_news($id){
            return $this->query('
                SELECT 
                    `news`.`id`,
                    `users`.`login` AS `autor`, 
                    `news`.`title`,
                    `news`.`date`,
                    `news`.`full_news` AS `body`
                FROM `news`
                    INNER JOIN `users` ON `news`.`autor` = `users`.`id`
                    WHERE `news`.`id` = '.$this->ecran_html($id).'
            ;');
        }

        /*////////////////// Query for comments  ////////////////////*/

        public function add_comment($tovar_id, $user_id, $text, $date){
            return $this->query('
                INSERT INTO `comments` (`tovar_id`, `user_id`, `text`, `date`) 
                    VALUES ('.$this->ecran_html($tovar_id).', '.$this->ecran_html($user_id).', "'.$this->ecran($text).'", '.$date.')
            ;');
        }

        public function get_comments_by_tovar_id($id){
            return $this->query('
                SELECT 
                    `comments`.`id`,
                    `users`.`name`, 
                    `users`.`surname`, 
                    `users`.`foto`, 
                    `comments`.`text`,
                    `comments`.`date`
                FROM `comments` 
                    INNER JOIN `users` ON `comments`.`user_id` = `users`.`id`
                    WHERE `comments`.`tovar_id` = '.$this->ecran_html($id).'
                    ORDER BY `comments`.`date` DESC
            ;');
        }

        /*////////////////// Query for pagination  ////////////////////*/

        public function count_pages_for_news(){
            return $this->query('
                SELECT count(*) as `count` FROM `news`
            ;');
        }

        public function count_pages_for_tovars_by_category($category_id){
            return $this->query('
                SELECT count(*) as `count` FROM `tovars`
                    WHERE `category_id` = '.$category_id.'
            ;');
        }

        /*////////////////// Query for static page  ////////////////////*/

        public function get_static($url){
            return $this->query('
                SELECT * FROM `static` WHERE `static`.`url` = "'.$this->ecran_html($url).'"
            ;');
        }

        /*////////////////// Query for adminpanel ////////////////////*/

        public function get_groups(){
            return $this->query('
                SELECT * FROM `groups`
            ;');
        }

        /* Module static */

        public function get_statics(){
            return $this->query('
                SELECT `id`, `title`, `url`, `date_edit`, `date` FROM `static`
            ;');
        }

        public function get_static_by_id($id){
            return $this->query('
                SELECT `id`, `title`, `url`, `template` FROM `static` WHERE `id` = '.$this->ecran_html($id).'
            ;');
        }

        public function add_static($url, $title, $template, $date){
            return $this->query('
                INSERT INTO `static` (`url`, `title`, `template`, `date_edit`, `date`) 
                    VALUES ("'.$this->ecran_html($url).'", "'.$this->ecran_html($title).'", "'.$this->ecran($template).'", '.$this->ecran_html($date).', '.$this->ecran_html($date).')
            ;');
        }

        public function edit_static($id, $url, $title, $template, $date_edit){
            return $this->query('
                UPDATE `static` 
                    SET  
                        `url` = "'.$this->ecran_html($url).'",
                        `title` = "'.$this->ecran_html($title).'",
                        `template` = "'.$this->ecran($template).'",
                        `date_edit` = "'.$this->ecran_html($date_edit).'"
                    WHERE `id` = "'.$id.'"
            ;');
        }

        public function remove_static($id){
            return $this->query('
                DELETE FROM `static`
                    WHERE `id` = "'.$this->ecran_html( $id).'"
            ;');
        }

        /* Module users */

        public function get_users(){
            return $this->query('
                SELECT 
                    `users`.`id`,
                    `users`.`login`,
                    `groups`.`group_name`,
                    `groups`.`id` AS `group_id`,
                    `users`.`surname`,
                    `users`.`name`,
                    `users`.`date_reg`
                FROM `users`
                    INNER JOIN `groups` ON `users`.`group_id` = `groups`.`id` 
                    ORDER BY `group_id` ASC
            ;');
        }

        public function get_user_by_id($id){
            return $this->query('
                SELECT 
                    `users`.*,
                    `groups`.`group_name`,
                    `groups`.`id` AS `group_id`
                FROM `users`
                    INNER JOIN `groups` ON `users`.`group_id` = `groups`.`id`
                    WHERE `users`.`id` = "'.$this->ecran_html($id).'"
            ;');
        }       

        public function edit_user($user_id, $group_id, $name, $surname, $login, $email, $phone, $gender, $adress, $pass, $foto=false, $delete_foto=false){
            $pass = isset($pass[0])?', `users`.`password` = "'.$this->hash($this->ecran_html($pass)).'"' :'';
            if($delete_foto){
                $foto = ', `users`.`foto` = ""';
            }
            else if($foto){
                $foto = ', `users`.`foto` = "'.$foto.'"';
            }
            else{
                $foto = '';
            }

            return $this->query('
                UPDATE `users`
                    SET  
                        `users`.`name` = "'.$this->ecran_html($name).'",
                        `users`.`surname` = "'.$this->ecran_html($surname).'",
                        `users`.`login` = "'.$this->ecran_html($login).'",
                        `users`.`email` = "'.$this->ecran_html($email).'",
                        `users`.`phone` = "'.$this->ecran_html($phone).'",
                        `users`.`gender` = "'.$this->ecran_html($gender).'",
                        `users`.`adress` = "'.$this->ecran_html($adress).'",
                        `users`.`group_id` = "'.$this->ecran_html($group_id).'" 
                        '.$pass.'
                        '.$foto.'
                    WHERE `users`.`id` = "'.$this->ecran_html($user_id).'"
            ;');
        }

        public function remove_user($id){
            return $this->query('
                DELETE FROM `users`
                    WHERE `id` = "'.$this->ecran_html( $id).'"
            ;');
        }

        /* Module news */

        public function get_news(){
            return $this->query('
                SELECT 
                    `news`.`id`,
                    `news`.`title`,
                    `users`.`login` AS `autor`,
                    `news`.`date_edit`,
                    `news`.`date`
                FROM `news`
                    INNER JOIN `users` ON `news`.`autor` = `users`.`id`
                    ORDER BY `news`.`date` DESC
            ;');
        }

        public function get_news_by_id($id){
            return $this->query('
                SELECT `id`, `title`, `short_news`, `full_news` FROM `news` WHERE `id` = '.$this->ecran_html($id).'
            ;');
        }

        public function add_news($autor, $title, $short_news, $full_news, $date_edit, $date){
            return $this->query('
                INSERT INTO `news` (`autor`, `title`, `short_news`, `full_news`, `date_edit`, `date`) 
                    VALUES ("'.$this->ecran_html($autor).'", "'.$this->ecran_html($title).'", "'.$this->ecran($short_news).'", "'.$this->ecran($full_news).'", '.$this->ecran_html($date_edit).', '.$this->ecran_html($date).')
            ;');
        }

        public function edit_news($id, $title, $short_news, $full_news, $date_edit){
            return $this->query('
                UPDATE `news` 
                    SET                          
                        `title` = "'.$this->ecran_html($title).'",
                        `short_news` = "'.$this->ecran($short_news).'",
                        `full_news` = "'.$this->ecran($full_news).'",
                        `date_edit` = "'.$this->ecran_html($date_edit).'"
                    WHERE `id` = "'.$this->ecran_html($id).'"
            ;');
        }

        public function remove_news($id){
            return $this->query('
                DELETE FROM `news`
                    WHERE `id` = "'.$this->ecran_html( $id).'"
            ;');
        }

        /* Module comments */

        public function get_comments(){
            return $this->query('
                SELECT 
                    `comments`.`id`,
                    `users`.`login` AS `autor`,
                    `tovars`.`name` AS `item`,
                    `tovars`.`id` AS `item_id`,
                    `comments`.`text`,
                    `comments`.`date`
                FROM `comments`
                    INNER JOIN `tovars` ON `tovars`.`id` = `comments`.`tovar_id`
                    INNER JOIN `users` ON `users`.`id` = `comments`.`user_id`
                    ORDER BY `comments`.`date` DESC
            ;');
        }

        public function remove_comment($id){
            return $this->query('
                DELETE FROM `comments`
                    WHERE `id` = "'.$this->ecran_html( $id).'"
            ;');
        }

        /* Module categories */

        public function get_categories(){
            return $this->query('
                SELECT * FROM `categories`
            ;');
        }

        public function get_category_by_id($id){
            return $this->query('
                SELECT * FROM `categories` WHERE `id` = '.$this->ecran_html($id).'
            ;');
        }

        public function add_category($url, $name, $description, $date){
            return $this->query('
                INSERT INTO `categories` (`url`, `name`, `description`, `date_edit`, `date`) 
                    VALUES ("'.$this->ecran_html($url).'", "'.$this->ecran_html($name).'", "'.$this->ecran($description).'", '.$this->ecran_html($date).', '.$this->ecran_html($date).')
            ;');
        }

        public function edit_category($id, $url, $name, $description, $date_edit){
            return $this->query('
                UPDATE `categories` 
                    SET                          
                        `url` = "'.$this->ecran_html($url).'",
                        `name` = "'.$this->ecran_html($name).'",
                        `description` = "'.$this->ecran($description).'",
                        `date_edit` = "'.$this->ecran_html($date_edit).'"
                    WHERE `id` = "'.$this->ecran_html($id).'"
            ;');
        }

        public function remove_category($id){
            return $this->query('
                DELETE FROM `categories`
                    WHERE `id` = "'.$this->ecran_html( $id).'"
            ;');
        }

        /* Module tovars */

        public function get_tovars(){
            return $this->query('
                SELECT * FROM `tovars`
            ;');
        }

        public function get_tovar_by_id($id){
            return $this->query('
                SELECT 
                    `tovars`.*
                FROM `tovars`
                    WHERE `tovars`.`id` = "'.$this->ecran_html($id).'"
            ;');
        }

        public function add_tovar($category_id, $name, $description, $price, $discount, $date, $poster){
            return $this->query('
                INSERT INTO `tovars` (`category_id`, `name`, `description`, `price`, `discount`, `date`, `poster`) 
                    VALUES ('.$this->ecran_html($category_id).', "'.$this->ecran_html($name).'", "'.$this->ecran($description).'", '.$this->ecran_html($price).', '.$this->ecran_html($discount).', '.$this->ecran_html($date).', "'.$this->str_to_sql($poster).'")
            ;');
        }

        public function edit_tovar($id, $category_id, $name, $description, $price, $discount, $poster = false){
            if($poster){
                $poster = ', `tovars`.`poster` = "'.$poster.'"';
            }
            else{
                $poster = '';
            }
            return $this->query('
                UPDATE `tovars` 
                    SET                          
                        `category_id` = "'.$this->ecran_html($category_id).'",
                        `name` = "'.$this->ecran_html($name).'",
                        `description` = "'.$this->ecran($description).'",
                        `price` = "'.$this->ecran_html($price).'",
                        `discount` = "'.$this->ecran_html($discount).'"
                        '.$poster.'
                    WHERE `id` = "'.$this->ecran_html($id).'"
            ;');
        }

        public function remove_tovar($id){
            return $this->query('
                DELETE FROM `tovars`
                    WHERE `id` = "'.$this->ecran_html( $id).'"
            ;');
        }

    }
?>
