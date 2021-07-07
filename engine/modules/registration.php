<?php

	require_once ENGINE_DIR.'/includes/checkFeild.php';	
	require_once ENGINE_DIR.'/includes/errors.php';	

	if(!$_COOKIE['user_token'] && $config['registration_on']){

		if(isset($_POST['do_reg'])){

			$alerts->set_error_if(!CheckField::login($_POST['login']), 'Ошибка регистрации', 'Некорректный логин', 201);

			$alerts->set_error_if(!CheckField::email($_POST['email']), 'Ошибка регистрации', 'Некорректный email', 202);

			$alerts->set_error_if(!CheckField::empty($_POST['password']), 'Ошибка регистрации', 'Вы не ввели пароль', 203);

			$alerts->set_error_if(!CheckField::empty($_POST['phone']), 'Ошибка регистрации', 'Вы не ввели моб. номер', 203);

			$alerts->set_error_if(!CheckField::confirm_pass($_POST['password'],$_POST['repassword']), 'Ошибка регистрации', 'Пароль не совпадает с формой подтверждения', 204);

			if(!isset($alerts->alerts_array[0])){

				if($db->reg_user(
					$config['reg_user_group'],
					$_POST['name'],
					$_POST['surname'],
					$_POST['login'],
					$_POST['email'],
					$_POST['phone'],
					$_POST['gender'],
					$_POST['adress'],
					$_POST['password']
				)){
					$alerts->set_success('Регистрация прошла успешно', 'Вы успешно зарегистрированы.');
				}
				else $alerts->set_error('Ошибка регистрации', Error_info::reg_user($db->error_num), $db->error_num);
			}
		}
		
		foreach($genders as $key => $value){
			$genders_tpl .= '<option value="'.$key.'" '.($key == $user['gender']?'selected':'').'>'.$value.'</option>';
		}
		$tpl->set('{genders}', $genders_tpl);
		
		$head['title'] = 'Регистрация';
		$tpl->load('registration.html');    
		$tpl->save('{content}');
	}
	else $alerts->set_error('Ошибка', 'Регистрация не доступна', 233);

?>
