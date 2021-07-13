-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1:3307
-- Время создания: Июл 09 2021 г., 15:28
-- Версия сервера: 10.3.13-MariaDB-log
-- Версия PHP: 7.2.22

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `eda`
--

-- --------------------------------------------------------

--
-- Структура таблицы `categories`
--

CREATE TABLE `categories` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `categories`
--

INSERT INTO `categories` (`id`, `name`, `url`, `date`) VALUES
(8, 'Салаты и закуски', 'salad', 1),
(9, 'Основные Блюда', 'surdish', 1),
(10, 'Супы и Выпечка', 'soups', 1),
(11, 'Соусы и Гарниры', 'sauces', 1),
(12, 'Десерты', 'desserts', 1),
(13, 'Винная Карта', 'wines', 1),
(14, 'Напитки и Коктейли', 'drinks', 1);

-- --------------------------------------------------------

--
-- Структура таблицы `comments`
--

CREATE TABLE `comments` (
  `id` int(10) UNSIGNED NOT NULL,
  `tovar_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `text` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `date` int(11) NOT NULL,
  `parent` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `comments`
--

INSERT INTO `comments` (`id`, `tovar_id`, `user_id`, `text`, `date`, `parent`) VALUES
(1, 1, 12, '<p>Хорошая новость</p>', 1564163134, NULL),
(2, 2, 56, '<p>Ну значит запишусь после каникул.</p>', 1651354654, NULL);

-- --------------------------------------------------------

--
-- Структура таблицы `groups`
--

CREATE TABLE `groups` (
  `id` int(11) UNSIGNED NOT NULL,
  `group_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `groups`
--

INSERT INTO `groups` (`id`, `group_name`) VALUES
(1, 'Администраторы'),
(2, 'Пользователи');

-- --------------------------------------------------------

--
-- Структура таблицы `news`
--

CREATE TABLE `news` (
  `id` int(11) UNSIGNED NOT NULL,
  `autor` int(11) UNSIGNED NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `short_news` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `full_news` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_edit` int(11) UNSIGNED NOT NULL,
  `date` int(11) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `news`
--

INSERT INTO `news` (`id`, `autor`, `title`, `short_news`, `full_news`, `date_edit`, `date`) VALUES
(1, 12, 'В нашей клинике появился лазерный хирургический аппарат', '<p style=\"text-align: justify;\">В нашей клинике появился лазерный хирургический аппарат. Предназначен он для лечения сосудистой патологии нижних конечностей (варикозная болезнь), заболеваний прямой кишки (геморрой) и патологии лор органов.</p>', '<p style=\"text-align: justify;\">В нашей клинике появился лазерный хирургический аппарат. Предназначен он для лечения сосудистой патологии нижних конечностей (варикозная болезнь), заболеваний прямой кишки (геморрой) и патологии лор органов. Принцип действия аппарата: вена обжигается лазерным излучением изнутри, после чего происходит полное её склеивание. Спустя определённого периода времени вена перестаёт существовать.</p>\r\n<p style=\"text-align: justify;\">Уникальность прибора в том, что длина волны лазера составляет 1940 нм. Это абсолютно новое течение в лазерной хирургии. Данные операции относятся к разряду малоинвазивных. Выполняются без разрезов под местным обезболивающим, имеют меньший болевой синдром и малую травматичность. После такой операции пациенты очень быстро восстанавливаются и возвращаются к привычной жизни.</p>', 1622126059, 1432874149),
(2, 12, 'Как будут работать больницы и поликлиники с 1 по 10 мая 2021 года', '<p style=\"text-align: justify;\">Так как Указом Президента РФ общая продолжительность майских праздников составит 10 дней (с 1 по 10 мая), больницы и поликлиники изменят график работы. Уже известно, что больницы и поликлиники не будут полноценно работать все майские праздники, в том числе с 4 по 7 мая. Но продолжат работу все пункты вакцинации, а в поликлиниках организуют дежурные группы специалистов.</p>', '<p style=\"text-align: justify;\">Так как Указом Президента РФ общая продолжительность майских праздников составит 10 дней (с 1 по 10 мая), больницы и поликлиники изменят график работы. Уже известно, что больницы и поликлиники не будут полноценно работать все майские праздники, в том числе с 4 по 7 мая. Но продолжат работу все пункты вакцинации, а в поликлиниках организуют дежурные группы специалистов.</p>\r\n<p style=\"text-align: justify;\">Минтруд выпустил рекомендации о нерабочих днях с 4 по 7 мая.</p>\r\n<p style=\"text-align: justify;\"><span style=\"font-size: 14pt;\"><strong>График работы больниц и поликлиник в майские праздники 2021 года</strong></span></p>\r\n<p style=\"text-align: justify;\">Несмотря на увеличенную продолжительность майских праздников, в сфере здравоохранения продолжат работу:</p>\r\n<ul style=\"text-align: justify;\">\r\n<li>дежурные группы медиков, которые будут принимать пациентов в экстренных ситуациях в поликлиниках;</li>\r\n<li>стационары больниц, где пациенты проходят лечение;</li>\r\n<li>сотрудники скорой и неотложной помощи;</li>\r\n<li>пункты вакцинации от коронавируса.</li>\r\n</ul>\r\n<p style=\"text-align: justify;\">Таким образом, попасть на плановый прием к медицинским специалистам будет нельзя с 1 по 10 мая. Но экстренную и неотложную помощь можно получить даже в праздники.</p>\r\n<p style=\"text-align: justify;\">В каждом регионе есть круглосуточные телефоны горячих линий, где можно получить информацию о графике работы медиков в определенных больницах и поликлиниках. Также отметим, что коммерческие медицинские центры и клиники могут работать даже в нерабочие, выходные и праздничные дни мая, так как это зависит от решения руководителя.</p>\r\n<p style=\"text-align: justify;\">Еще раз напомним текст Указа президента Путина о майских праздниках 2021 года:</p>\r\n<p style=\"text-align: justify;\">В целях сохранения тенденции сокращения распространения новой коронавирусной инфекции (COVID-19), укрепления здоровья граждан Российской Федерации и в соответствии со статьей 80 Конституции Российской Федерации постановляю:</p>\r\n<ol>\r\n<li style=\"text-align: justify;\">Установить с 4 по 7 мая 2021 г. включительно нерабочие дни с сохранением за работниками заработной платы.</li>\r\n<li style=\"text-align: justify;\">Органам публичной власти, иным органам и организациям определить количество служащих и работников, обеспечивающих с 1 по 10 мая 2021 г. включительно функционирование этих органов и организаций.</li>\r\n<li style=\"text-align: justify;\">Настоящий Указ вступает в силу со дня его официального опубликования.</li>\r\n</ol>', 1622126075, 1619670949),
(52, 12, 'Тест новости с редактором название', '<p>Тест новости с редактором короткое</p>', '<p>Тест новости с редактором полное</p>', 1622125021, 1622126377),
(54, 12, 'Тест2', '<p>Тест2</p>', '<p>Тест2</p>', 1624797724, 1624797724),
(55, 12, 'Тест3', '<p>Тест3</p>', '<p>Тест3</p>', 1624797733, 1624797733),
(56, 12, 'Тест4', '<p>Тест4</p>', '<p>Тест4</p>', 1624797746, 1624797746);

-- --------------------------------------------------------

--
-- Структура таблицы `static`
--

CREATE TABLE `static` (
  `id` int(11) NOT NULL,
  `url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `template` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_edit` int(10) UNSIGNED NOT NULL,
  `date` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `static`
--

INSERT INTO `static` (`id`, `url`, `title`, `template`, `date_edit`, `date`) VALUES
(1, 'donorstvo', 'Донорство', '<p><img src=\"/uploads/images/756c86a5e17b59e_621x300.jpg\" alt=\"\" /></p>\r\n<p style=\"text-align: justify;\"><strong>Донорство крови</strong> (от лат. donare &mdash; &laquo;дарить&raquo;) и (или) её компонентов &mdash; добровольная сдача крови и (или) её компонентов донорами, а также мероприятия, направленные на организацию и обеспечение безопасности заготовки крови и её компонентов. Клиническое использование связано с трансфузией (переливанием) реципиенту в лечебных целях. Также кровь, взятая от донора (донорская кровь), используется в научно-исследовательских и образовательных целях; в производстве компонентов крови лекарственных средств. &nbsp;Кровь как уникальное лечебное средство незаменима при переливании пострадавшим от ожогов и травм, при проведении сложных операций и при тяжелых родах. Кровь также жизненно необходима больным гемофилией, анемией и онкологическим больным при химиотерапии. &nbsp;Современная медицина не использует для лечения больных цельную кровь. Каждую дозу крови разделяют на компоненты. Для специализированного лечения применяются компоненты крови и препараты на основе донорской плазмы.&nbsp;</p>\r\n<p style=\"text-align: justify;\">Узнать можете ли вы быть донором</p>\r\n<p><img src=\"/uploads/images/2-3_protivopokazaniya_k_donorstvu.jpg\" alt=\"\" /></p>', 1621876964, 1621793638),
(2, 'information', 'Информация о больнице', '<p><img src=\"/uploads/images/08-09-33-i.jpg\" alt=\"\" /></p>\r\n<p style=\"text-align: justify;\"><strong>Морозовская взрослая городская клиническая больница</strong><br />Наша больница занимает 7 место по оборудованию и персоналу в России. У нас все необходимые аппараты и устройства для устранения самых сложных заболеваний. Мы не являемся государственной больницей. Квалифицированный персонал ждет вас на прием в нашей больнице.</p>\r\n<p style=\"text-align: justify;\">Наша больница находится по адресу: Город Москва, Улица Дмитрия Ульянова</p>\r\n<p><img src=\"/uploads/images/08-17-28-zb24.jpg\" alt=\"\" /></p>', 1621877114, 1621793638),
(3, 'price', 'Прайс-лист', '<table border=\"1\" cellspacing=\"0\" cellpadding=\"1\">\r\n<thead>\r\n<tr>\r\n<th>Травматолог и ортопед</th>\r\n<th>Цена в руб.</th>\r\n</tr>\r\n</thead>\r\n<tbody>\r\n<tr>\r\n<td>Травматолог и ортопед</td>\r\n<td>1000</td>\r\n</tr>\r\n<tr>\r\n<td>Невролог</td>\r\n<td>1000</td>\r\n</tr>\r\n<tr>\r\n<td>Окулист</td>\r\n<td>1000</td>\r\n</tr>\r\n<tr>\r\n<td>Педиатр</td>\r\n<td>1500</td>\r\n</tr>\r\n<tr>\r\n<td>Уролог</td>\r\n<td>1700</td>\r\n</tr>\r\n<tr>\r\n<td>Хирург</td>\r\n<td>500</td>\r\n</tr>\r\n<tr>\r\n<td>Хирургическая стоматология</td>\r\n<td>3000</td>\r\n</tr>\r\n<tr>\r\n<td>Лечебная стоматология</td>\r\n<td>2500</td>\r\n</tr>\r\n<tr>\r\n<td>Стоматология общей практики</td>\r\n<td>1500</td>\r\n</tr>\r\n</tbody>\r\n</table>', 1621873997, 1621793638),
(4, 'rating', 'Рейтинг врачей', '<table class=\"cwdtable\" border=\"1\" cellspacing=\"0\" cellpadding=\"1\">\r\n<thead>\r\n<tr>\r\n<th>Специалист</th>\r\n<th>Рейтинг</th>\r\n</tr>\r\n</thead>\r\n<tbody>\r\n<tr>\r\n<td>Травматолог и ортопед</td>\r\n<td>4,7</td>\r\n</tr>\r\n<tr>\r\n<td>Невролог</td>\r\n<td>4,2</td>\r\n</tr>\r\n<tr>\r\n<td>Окулист</td>\r\n<td>4,8</td>\r\n</tr>\r\n<tr>\r\n<td>Педиатр</td>\r\n<td>5,0</td>\r\n</tr>\r\n<tr>\r\n<td>Уролог</td>\r\n<td>4,9</td>\r\n</tr>\r\n<tr>\r\n<td>Хирург</td>\r\n<td>4,3</td>\r\n</tr>\r\n<tr>\r\n<td>Хирургическая стоматология</td>\r\n<td>4,8</td>\r\n</tr>\r\n<tr>\r\n<td>Лечебная стоматология</td>\r\n<td>4,8</td>\r\n</tr>\r\n<tr>\r\n<td>Стоматология общей практики</td>\r\n<td>4,6</td>\r\n</tr>\r\n</tbody>\r\n</table>', 1621874012, 1621793638),
(5, 'insurance', 'Страхование', '<p><img src=\"/uploads/images/medicinskoe-strahovanie.jpg\" alt=\"\" /></p>\r\n<p style=\"text-align: justify;\">Болезни вредят не только здоровью человека, но и приводят к материальным потерям: операции, медикаменты, различные медицинские исследования и лечебные процедуры иногда стоят дорого.</p>\r\n<p style=\"text-align: justify;\"><strong>Советуем оформить медицинский полис.</strong> Что дает полис добровольного медицинского страхования?</p>\r\n<ul>\r\n<li style=\"text-align: justify;\">Гарантия сохранности ваших средств, поскольку после приобретения полиса ДМС все затраты на медицинскую помощь в рамках программы страхования несет страховая компания,</li>\r\n<li style=\"text-align: justify;\">ваш выбор страховой программы с необходимым объемом медицинских услуг в оптимальных для вас лечебных учреждениях,</li>\r\n<li style=\"text-align: justify;\">гарантия того, что вы своевременно получите квалифицированную медицинскую помощь в рамках выбранной вами программы страхования,</li>\r\n<li style=\"text-align: justify;\">возможность круглосуточно получать бесплатные консультации у специалистов контакт-центра страховой компании по возникающим вопросам, в том числе по организации необходимой медицинской помощи в лечебном учреждении,</li>\r\n<li style=\"text-align: justify;\">постоянный контроль качества предоставляемых услуг и защита ваших интересов перед лечебным учреждением.</li>\r\n</ul>\r\n<p>Застраховаться <strong>8-800-999-65-78</strong></p>\r\n<p>Номер поддержки <strong>8-800-999-65-79</strong></p>', 1621877141, 1621793638);

-- --------------------------------------------------------

--
-- Структура таблицы `tovars`
--

CREATE TABLE `tovars` (
  `id` int(10) UNSIGNED NOT NULL,
  `category_id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` int(11) NOT NULL,
  `discount` int(11) NOT NULL DEFAULT 0,
  `poster` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `date` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `tovars`
--

INSERT INTO `tovars` (`id`, `category_id`, `name`, `description`, `price`, `discount`, `poster`, `date`) VALUES
(1, 8, 'Салат “Центральный”', 'из слабосоленой семги с красной икрой и йогуртовой заправкой (160 г)', 450, 0, 'uploads/tovars/1.jpg', 1625487696),
(2, 8, 'Салат “Греческий', ' огурец, помидоры, перец болгарский, маслины чёрные без косточек, лук, сыр фета, петрушка, травы, масло оливковое (200 г)', 320, 0, 'uploads/tovars/2.jpg', 1625487697),
(3, 8, 'Салат “Царский”', 'ростбиф, буженина с солеными огурцами, домашним майонезом, в корзинке из пармезана (185 г)', 340, 0, 'uploads/tovars/3.jpg', 1625487698),
(4, 8, 'Салат из языка “Восторг”', 'язык говяжий с огурцом, яйцом, картофелем, заправленный домашним майонезом (150 г)', 320, 0, 'uploads/tovars/4.jpg', 1625487699),
(5, 8, 'Теплый салат с куриной печенью', 'тушеная в сливках куриная печень с салатом, беконом, томатами и яйцом «пашот» (200 г)', 320, 0, 'uploads/tovars/5.jpg', 1625487700),
(6, 8, 'Мясной салат с жареными грибами', 'буженина, соленые огурцы, грибы, перепелиные яйца, заправлен домашним майонезом (185 г)', 320, 0, 'uploads/tovars/6.jpg', 1625487701),
(7, 8, 'Салат “Цезарь” с курицей', 'листья салата с соусом «Цезарь», с пшеничными гренками и жареной куриной грудкой (165 г)', 390, 0, 'uploads/tovars/7.jpg', 1625487702),
(8, 8, 'Салат “Амарант”', 'теплый салат из шпината с жареной говяжьей вырезкой под имбирным соусом (180/30 г)', 430, 0, 'uploads/tovars/8.jpg', 1625487703),
(9, 8, 'Салат “Морской”', 'салат из свежих томатов, листьев салата, помидоров черри, сладкого перца и жареных морепродуктов (200 г)', 540, 0, 'uploads/tovars/9.jpg', 1625487704),
(10, 8, 'Салат “Цезарь” с креветкой', 'листья салата с соусом «Цезарь», с пшеничными гренками и тигровыми креветками (165 г)', 520, 0, 'uploads/tovars/10.jpg', 1625487705),
(11, 8, 'Салат “Нисуаз” с лососем', 'листья салата с жареным лососем, каперсами, под соусом из оливкового масла, анчоусов, французской горчицы и бальзамического уксуса (190 г)', 420, 0, 'uploads/tovars/11.jpg', 1625487706),
(12, 8, 'Салат “Атлантик”', 'тунец опаленный дымом с киноа, брокколи и черри (200/30 г)', 490, 0, 'uploads/tovars/12.jpg', 1625487707),
(13, 8, 'Овощной салат', 'со сметаной или ароматным маслом на ваш выбор (180 г)', 250, 240, 'uploads/tovars/13.jpg', 1625487708),
(14, 9, 'Стейк лосося, запеченый в пергаменте', 'с соусом из сливок и шпината 260 гр.', 750, 0, 'uploads/tovars/14.jpg', 1625487709),
(15, 9, 'Стейк лосося жареный на гриле', 'с гарниром из жареного шпината и соусом из красного апельсина 120/80/30 гр.', 750, 0, 'uploads/tovars/15.jpg', 1625487710),
(16, 9, 'Котлета из трески и лосося', 'со свекольным булгуром и тимьяном 110/140/30 г', 480, 0, 'uploads/tovars/16.jpg', 1625487711),
(17, 9, 'Филе трески “Вайгач”', 'запеченное в ароматных травах с зеленым кус кусом 120/150/30 г.', 480, 0, 'uploads/tovars/17.jpg', 1625487712),
(18, 9, 'Бефстроганов из говяжьей вырезки', 'с грибами, картофельным пюре 150/150 г.', 530, 0, 'uploads/tovars/18.jpg', 1625487713),
(19, 9, 'Стейк из свинины', 'с картофелем фри и соусом «барбекю» 130/50 г.', 460, 0, 'uploads/tovars/19.jpg', 1625487714),
(20, 9, 'Куриная грудка с сыром', 'томатами черри, базиликом и крем бальзамиком 170 г.', 350, 0, 'uploads/tovars/20.jpg', 1625487715),
(21, 9, 'Котлета с яйцами Бенедикт под соусом “Голландез”', 'Нежная куриная котлета, запеченная в печи, сервируется жареным беконом, яйцом \"пашот\" и соусом \"голландез\" 120/105 г', 370, 0, 'uploads/tovars/21.jpg', 1625487716),
(22, 10, 'Борщ со сметаной', 'и чесночными пампушками 300/60 г.', 290, 0, 'uploads/tovars/22.jpg', 1625487717),
(23, 10, 'Уха с расстегаями', 'уха из лосося, трески и горбуши с рыбными расстегаями 300/80 г.', 350, 0, 'uploads/tovars/23.jpg', 1625487718),
(24, 10, 'Суп куриный с домашней лапшой', '300 г.', 240, 0, 'uploads/tovars/24.jpg', 1625487719),
(25, 10, 'Расстегай с семужкой', '40 г.', 75, 0, 'uploads/tovars/25.jpg', 1625487720),
(26, 10, 'Пампушки чесночные', '40 г.', 30, 0, 'uploads/tovars/26.jpg', 1625487721),
(27, 10, 'Хлебная корзина', 'булочки - пшеничная, мультизлаковая, с солодом и кориандром, фокачча 120/150 г', 210, 0, 'uploads/tovars/27.jpg', 1625487722),
(28, 10, 'Фокачча', 'Классическая/ С сыром', 180, 0, 'uploads/tovars/28.jpg', 1625487723),
(29, 10, 'Фокачча', 'С беконом', 200, 0, 'uploads/tovars/29.jpg', 1625487724),
(30, 11, 'Соусы в ассортименте', 'Сметанный, Барбекю, Блю Чиз, Тар Тар, Брусничный, Перечный, Медово-горчичный, Цезарь, Майонез, Сметана, Хрен столовый, Горчица 50 г.', 90, 0, 'uploads/tovars/30.jpg', 1625487725),
(31, 11, 'Гарниры в ассортименте', 'Картофель фри, Картофельное пюре, Запеченный картофель, Тушеная капуста, Рис отварной, Овощи на пару 150 г.', 150, 0, 'uploads/tovars/31.jpg', 1625487726),
(32, 11, 'Овощи гриль', '150 гр.', 190, 0, 'uploads/tovars/32.jpg', 1625487727),
(33, 12, 'Торт “Сливочный” с клубничным соусом', '170/80 г.', 290, 0, 'uploads/tovars/33.jpg', 1625487728),
(34, 12, 'Штрудель с яблоком и пломбиром', '200 г.', 295, 0, 'uploads/tovars/34.jpg', 1625487729),
(35, 12, 'Миндальный торт “Алмонди”', 'С белым, либо с молочным шоколадом, на Ваш выбор. Подается с шариком мороженого 100/50г', 320, 290, 'uploads/tovars/35.jpg', 1625487730),
(36, 13, 'Кюве Жан-Луи белое Брют', 'Cuvee Jean-Louis Blanc Brut', 1790, 0, 'uploads/tovars/36.jpg', 1625487731),
(37, 13, 'Кюве Жан-Луи Брют Розе', 'Cuvee Jean-Louis Brut Rose', 1790, 0, 'uploads/tovars/37.png', 1625487732),
(38, 13, 'Ламбруско Бьянко Аббация', 'Lambrusco Bianco Rosso, Abbazia', 850, 0, 'uploads/tovars/38.jpg', 1625487733),
(39, 13, 'Ламбруско Россо Аббация', 'Lambrusco Rosso, Abbazia', 850, 0, 'uploads/tovars/39.png', 1625487734),
(40, 14, 'Pepsi, 7up, Mirinda', '250 мл.', 120, 0, 'uploads/tovars/40.jpg', 1625487735),
(41, 14, 'Сок в ассортименте', '200 мл', 180, 0, 'uploads/tovars/41.jpg', 1625487736),
(42, 14, 'Морс ягодный', '250 мл', 110, 0, 'uploads/tovars/42.jpg', 1625487737),
(43, 14, 'Американо', '200 мл.', 100, 0, 'uploads/tovars/43.jpg', 1625487738),
(44, 14, 'Капучино', '200 мл.', 150, 0, 'uploads/tovars/44.jpg', 1625487739),
(45, 14, 'Латте', '230 мл.', 170, 0, 'uploads/tovars/45.jpg', 1625487740),
(46, 14, 'Глясе', '230 мл.', 190, 0, 'uploads/tovars/46.jpg', 1625487741);

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE `users` (
  `id` int(11) UNSIGNED NOT NULL,
  `group_id` int(11) UNSIGNED NOT NULL,
  `login` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `surname` varchar(120) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `gender` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `adress` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `phone` varchar(18) COLLATE utf8mb4_unicode_ci NOT NULL,
  `foto` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '',
  `date_reg` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `users`
--

INSERT INTO `users` (`id`, `group_id`, `login`, `password`, `email`, `name`, `surname`, `gender`, `adress`, `phone`, `foto`, `date_reg`) VALUES
(12, 1, 'Admin', '$2y$10$trgPL1fnnglSY3djNwS5wuI55DDOo5Sk.ZLU4Q/MxCiGVU2duyqwy', 'yafjasdlf@ya.ru', 'Админ', 'Админ', 'male', '', '+7 (777) 777-77-77', 'uploads/avatars/foto_12.png', 1575825604),
(13, 2, 'tyt', '$2y$10$OgfHEu39yMaikUhK0.vUd.gXGZZB6VgQsvX0w2NrCD6GSLAVTabGW', 'rgdf@f', '', '', '', '', '', '', 1575825604),
(14, 2, 'hypop', '$2y$10$CKfQJ7FZ4xpTJH4YXFVMeOuqVrv3Yj/KJf2cXgopZcWKeSnbFMBj6', 'hty@tr', '', '', '', '', '', '', 1575825604),
(15, 2, 'test2', '$2y$10$trgPL1fnnglSY3djNwS5wuI55DDOo5Sk.ZLU4Q/MxCiGVU2duyqwy', 'test@test.test', 'Тестовый', 'Тестов', '', '', '', '', 1575825604),
(19, 2, 'test3', '$2y$10$GV1Cwv1gMDQLZWVQSMdkN.YsOKecISXX3D8Bnxr0KjimPH05dklvK', 'fdsfsdfsd@fdsf', '', '', '', '', '', '', 1575825604),
(20, 2, 'test4', '$2y$10$lL.M9yafid52HKYQ5OYo/OH1mxjzHJg0QkUARprESvk/YLEVvJYZ6', 'ghg@hjkdf', 'dsfsf', '', '', '', '', '', 1575825604),
(21, 2, 'test5', '$2y$10$2BFbRYEDMku90LjfrS4Al.kyCexnvN5J6z9jHlEPsxiRgPtt/XP8a', 'fasdfjkfbds@gjhfs', 'dsfsfsdfs', '', '', '', '', '', 1575825604),
(23, 2, 'hgjgjgj', '$2y$10$pi0Hkd8VUAr3XNsYBICU/OyOM3VcF4Y5KC5CId8sYBMX4uEpuZbjG', 'dfgdfgf@gdfggd', 'dfgdgdg', '', '', '', '', '', 1575825604),
(25, 2, 'gfddshkjgfjk', '$2y$10$6l.hHmNFp3Y4xKlOWlNqoeRAIW4XcCQ7QhYX/MrygF9oHuP.euP/W', 'fdsfljsdfj@hkgjdf', 'sdfsdfsf', '', '', '', '', '', 1575825604),
(26, 2, 'test87', '$2y$10$W1UWHA1ybyF0eNlkNuSo0.dbvBj1bQfR4215e5tOc8QbHbT2Ylg7m', 'hgfhfgh@dggdg.ru', 'dgdgdg', '', '', '', '', '', 1575825604),
(27, 2, 'test88', '$2y$10$XRLbLXNq.EieUoZY8m1pxOQcqdzBO0yH0pO3.f43Od08iezs.Mbx2', 'hgfhfgh@dggdg5', 'dgdgdg', '', '', '', '', '', 1575825604),
(28, 2, 'fgdffdgfdg', '$2y$10$Vp8j.e5X.9jECPgMMuZ5auewavm34kx1/oYxsG6vm7ydeBik7mVs2', 'fdgdfg@fgdfgdg', '', '', '', '', '', '', 1575825604),
(29, 2, 'dfgdfgdfgdfg', '$2y$10$nWiDBkVduanxtKnVyJVUbuMQpOXBx/yVL5cYaXjJ1JheG1dftvf6y', 'rgdfg@dfgdgd', 'fghgfhf', '', '', '', '', '', 1575825604),
(30, 2, 'dfgdfgdfgdfgfdgdfg', '$2y$10$UrhtHUHy/1hcDCXdzNeh0.k52mc6XDNUFCU8g957W0qotsSbr9YGK', 'rgdfg@dfgdgddfgdfg', 'fghgfhfdfg', '', '', '', '', '', 1575825604),
(31, 2, 'dfgdfgdfgdfgfdgdfgfdgdfg', '$2y$10$Uc2ylGHBSftqXAMsz/AYbOsJywx4gbpNeEeX3G7R5Aqbu4IiFLGUC', 'rgdfg@dfgdgddfgdfgsdfgs', 'fghgfhfdfgsdf', '', '', '', '', '', 1575825604),
(32, 2, 'dfgdfgd', '$2y$10$1sYAaCUP6SlMuEJJ4KK8J.qw.Z0IlgYb3nRhKbUEnofdIbGc93vKu', 'rgdfg@d', 'fghgfhfdfgsdf', '', '', '', '', '', 1575825604),
(33, 2, 'dfgdfgddff', '$2y$10$Np3ccZSAhvsNmqLc4GmY5OJqAnAWuqDScxKVm/L5ppzYGeP6NQrpG', 'rgdfg@dsdf', 'fghgfhfdfgsdfsdf', '', '', '', '', '', 1575825604),
(34, 2, 'dfsujhsdfjlhsdf', '$2y$10$HhiaKhUm9XUJFcPknTfatewwQXIN/wYc6ZQK8l2uOxRSgMoDLTCNi', 'fdkjhbsdflkn@hjf', '', '', '', '', '', '', 1575830181),
(35, 2, 'sfkjhgsdfgk', '$2y$10$MOPRXxDi4tUwXy9I9GRCTujJ1bc23KHmCBqxsBr01d6k6R9wEr8RW', 's@d', 'sd', '', '', '', '', '', 1576773901),
(36, 2, 'sfk', '$2y$10$DZc53gNIGdL3EUmI04/3CepW4RHyH1A2suba/p1plrq7WmjAACLfK', 's@dh', 'sd', '', '', '', '', '', 1576774588),
(37, 2, 'fdsfsf', '$2y$10$nP49Z7JiAyxSIHWLTKF7cuu0DbyoZBeghcG/CR7eKf./0kBXeIWCS', 'sd@asf', 'sdd', '', '', '', '', '', 1576774705),
(40, 2, 'fdsfsffdg', '$2y$10$CQJVddGT3VDNYOZQcU9.EuhNjCLQyHkKEIJ3hjaiouKA8hHkZGkv.', 'sd@asf.ds', 'sdd', '', '', '', '', '', 1576774913),
(41, 2, 'fdsfsffdggfg', '$2y$10$jE2o5argpNKxiCjxnWEPheDCw5ooGCWG9tFE0Mfe4GSXMXu7OE4xO', 'sd@asf.ds.fg', 'sdd', '', '', '', '', '', 1576774960),
(44, 2, 'dasfsdf', '$2y$10$/i0ywU7S/Usd2XpGypEBKOB91xUbOw/OJd6ert95THscY0Fr2gS2.', 'fdsf@dff.er', 'sfsdfs', '', '', '', '', '', 1576775451),
(45, 2, 'antonina.kzrta', '$2y$10$jNKBywD0l9iVGhAgJFuYbuZX13QnF9gxcngQed.vOc58CGogS64X2', '79023988868@gsgsgsg.trt', 'gsdfgdfgdfg', '', '', '', '', '', 1594577359),
(46, 2, 'test89', '$2y$10$HirQXNVEHIS08oWB5a5NdeKMY1At/RZPL8QxE/Z4fkTrt27yHT.Dq', 'test89@ya.ru', 'test89', '', '', '', '', '', 1614424404),
(47, 2, 'GGWP', '$2y$10$P/l/EJEsIZa1l0nIHvZnzuIZVXg6Bg0e6o6ecqi8N6z5BA14B8y6q', 'fjsdl@fjdkls.ru', 'fjsdlkaf;j', 'jglsdf;j', '', '', '', '', 1614437083),
(55, 2, 'petrvas', '$2y$10$FEb1BMMUXzR0e4gRbBPPnuMzOHnT09yr.ECkqFagQHxooxSQ/BEIC', 'petr.vas@ya.ru', 'Пётр', 'Васильев', '', '', '', '', 1614446372),
(56, 2, 'Vasya', '$2y$10$7fzPe0uS7lAQ4qlqlxqSQukgBXx5nUOnHJhs.Hn76JatJZnYb5Hy2', 'vasya@ya.ru', 'Вася', 'Уткин', '', '', '', 'uploads/avatars/foto_56.jpg', 1620918189),
(60, 2, 'test24', '$2y$10$UAldOGvlY3JF7QOuY/khXOy9YdSB04GHgP6zhV5EQFU0qBTi0Gx92', 'dog35@dog.ru', 'Михаил', 'Васильев', 'male', 'г.Москва', '+7 (165) 135-13-46', '', 1625685583),
(61, 2, 'fjdks', '$2y$10$OF3.xbCyVQ9vTgE11QjQT.n97bkytuo0rfWLeikPwyjeucnrlvuma', 'cat@gfjkl.ru', 'test50', 'fsjkl', 'female', 'gsdfgsfg4546', '+7 (894) 684-61-87', '', 1625687172),
(62, 2, 'test64', '$2y$10$4j8gyvlvU9POTiWYy5YdZ.0onByZRh8QPe8LK23n.0noF5y1mur8u', 'fjdkl@gjk.ru', 'jlfksd', 'jfjdskl', 'female', 'fjdslkafj;sf;l', '+7 (955) 335-35-35', '', 1625687756),
(64, 2, 'testreg', '$2y$10$tSvflzFC5ic7e5ceqj.R0ePaVV/UdZ14ULeySuKlV2G.v4v1qwObq', 'testreg@gmail.com', 'Пётр', 'Русаков', 'male', 'г. Юхнов', '+7 (123) 135-41-31', '', 1625749555);

-- --------------------------------------------------------

--
-- Структура таблицы `user_tokens`
--

CREATE TABLE `user_tokens` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Дамп данных таблицы `user_tokens`
--

INSERT INTO `user_tokens` (`id`, `user_id`, `token`, `date`) VALUES
(56, 12, '$2y$10$KvMoAB0a1r4rNUOkq6Wyfut60fuy76Yu5wLndDZ9CmbJAAMCvzqp2', 1616334588),
(60, 12, '$2y$10$6NKRQ4qFgo4sLVR48GrZG.iOON/H2UN7hzBh5YgreDmje/tsnGvUO', 1618242806),
(62, 12, '$2y$10$8McdnRjcNYtz3NQUkWyeGOF2cK6ArNphYQu0uMr4Cd66nPwV3VSgu', 1618327460),
(66, 12, '$2y$10$ZGYcORe5F2UMDdmjG4NTkOnAIzBkDjGkrOzJc/84E0P39scMhvdU2', 1620829870),
(67, 12, '$2y$10$GSD538NK99U9IE1gS2n.J.g7jvuuJBWCLCjT1RBmCn5lCfq1Omvz2', 1620838847),
(69, 56, '$2y$10$ITIA68pZOs4ChDCJXzdbXe1NWbyGdDoxdsUWEd6zWd3QvkNKfUwaG', 1620918208),
(73, 12, '$2y$10$sTKegOBKGdYQd2AYsSaage5nEBnftMLf0HKsNWkovry/dlUuUedKO', 1621023072),
(76, 12, '$2y$10$0Jvae7vXM1qwlZia8IdF8OL8D0HMi4xdkRLyTtWUX8SAm8uE8Vrlm', 1621275008),
(77, 12, '$2y$10$CaJCkcCWNivO/eKfmrYRsOLjsc1cm8AAjqTzbrCHAk3Wks765yDwC', 1621353764),
(80, 12, '$2y$10$8rnFSw8p8U5QZvTA7No1UOe.5AMPwYHBUTzGMoWcQ/1uPZ31YZqFi', 1621428710),
(83, 12, '$2y$10$y2bxv.uiBvoltAeC6M6/d.olXgg8BY9cCugT8ibjEuHg78iFVuMtq', 1621438799),
(84, 12, '$2y$10$.I8WBbsUaAyjT87csdGsOO1Ti0lJhTiRjhj7xsnu4n.YM5ha8JlmO', 1621445054),
(85, 12, '$2y$10$oJ4kCTiMvnOR6YxZM5dNbOJXXncj30OtHARLy9UNJhZ0aq05DquJ6', 1621445255),
(86, 12, '$2y$10$Trz22ZDzOyFrXaWU7jdyS.DcbTRckP5Au2EpkmwYX2IusZAFhH1US', 1621445372),
(87, 12, '$2y$10$gZrMueroDa3dKutXoQAuDOedncbXN2aH2LSHLGUADS1qP9mMvYtK.', 1621446558),
(88, 12, '$2y$10$DPyAhQvTmV9fBydiEV1i..2dkjasq3YAg4Cg2ZR4Jzn9g5N5jQzZy', 1621453393),
(89, 12, '$2y$10$eoP.b/Kj4g2qpmjwbXwOPuFjGuYbfR5ibtWKf.9d5e4XXBmsCY9si', 1621453722),
(90, 12, '$2y$10$.l0kkxlqWASpQw8MGohhBOsjiTYpoSU9DhrLWVG2MnoW7HbEqa.lm', 1621454068),
(91, 56, '$2y$10$Q9qjFR.LauHs2bNNOHxw/.Ff9QbuOtXEZyrUbdgWXMuFdJIdlR2ue', 1621454098),
(92, 12, '$2y$10$7HyX7wcnWvZUPeftBy3st.u.p2twekXYW5WrTcFkzO2tSJAjQEwZ.', 1621455246),
(94, 12, '$2y$10$9.bh0CGsmJiWJQm8AY4AA.JqmMK/yDzsrJueejU6/s1WtZkns3d52', 1621455578),
(95, 12, '$2y$10$eSjw/5dKnJgGYRM3TWsVXO90NKSLStUBJm.ad9UL92JdUyVm/3Cr6', 1621455897),
(96, 12, '$2y$10$CdE3xD4W1nsI3xuNvXxyiucW1D.fXzQ4HB/oDiN4LW0u1MZ6sbOO6', 1621455926),
(98, 12, '$2y$10$/z9eLbtyiCL.WixGcR4QT.z23XLkeUbZJcFhduM0UNGDITQcYXIMu', 1621455951),
(100, 12, '$2y$10$PcKxGYPdoGI4XVMAiIsAJuI28G.cnU6ysvjwKOjxX2rYwf9xlN2Yu', 1621456546),
(101, 56, '$2y$10$lc45KRNk3bdioDZvtP5U5efqt5OCMkD5A2AE3M48IW5Rmx7215J1y', 1621456755),
(102, 56, '$2y$10$w9JWu4plryDUcH209/5mp.x29nAuYlNg2aUlCeKAlMpuyVvvn6VWO', 1621456916),
(103, 12, '$2y$10$R7l8G377djHgTDeU.A1qOunDe./7qID.rmaaLtLWn/QzRaHHH1ylm', 1621456936),
(104, 15, '$2y$10$e4X3lrSSpDoEiQ0DjCHReOUUKGJlgM2TbpNv.1T9jiEf.L00/S8xS', 1621457067),
(105, 12, '$2y$10$NTt6ILCmWwUnl8n3g6uMduaPXcMDYJ1.cvtjcgSTsOkhTqwyWBGvG', 1621457091),
(106, 56, '$2y$10$YqypzM0cUDfUtZE7V635SePRRh02U6pVVYyoQdk5mIWkIIsPkpOcW', 1621457289),
(107, 12, '$2y$10$xAGUqPn4traa7Y96jTGrZecyXBj37fb0Oubn8oV8z.OANqFQaboPG', 1621457309),
(108, 12, '$2y$10$WzpYz/cr/lbnEUL.IIcaNei.pkPsjllxW2s7ngQXBKi8aUh/DfCEW', 1621457394),
(109, 12, '$2y$10$L.xb0n8KoVNVGq89FfOLOOMbHcpkEtGTyuwAtzd2h.aGRvHJEy8na', 1621457416),
(110, 12, '$2y$10$vquMqquqW/nmXXuVaIgVc.S9Qjuto2l9YghrcFhFFrwFqlrEZTVv2', 1621514420),
(111, 12, '$2y$10$KlFmQ4vpxxxmM4BLNTrF2..kd/i.RpHB2Q7KZfC0gDON7p/b4r..q', 1621514699),
(112, 12, '$2y$10$XNJAWbXnKWT2GBQ9jud/duQOHolk0xveNOugXy7/pHlcERMfek/d.', 1621535227),
(113, 12, '$2y$10$0AUkFqW.yShbn0yuvJ4gAuORBgj.GGwoEr.E8qORWLwFLbq6ZzMMC', 1621535918),
(114, 12, '$2y$10$FnnA9bEDTtrvwHYSBr5F9.SMNcgAvX/I0B2gv5msEwJPoUfJPuN96', 1621598698),
(115, 12, '$2y$10$BP9D6f5oLTE2Ja0MiYA7LuHCdSU3aMtN5S/TtWXRbZj3fM5xaM36K', 1621634896),
(116, 12, '$2y$10$.c3flXblVnov051rs2.B2.S7BDSDnMBvGDUlTCY9QGMg59lUG/zqS', 1621782088),
(117, 12, '$2y$10$iR53w1XfUfS9OEde537yEeyKp0bLptcLEbhxW01SNBZ2IurfhDBD.', 1621792665),
(118, 12, '$2y$10$tzvObyL2Ex6UQGfyzvvSE.1ACmG90a6OffmNbhIfNuE0NMUeaCcpO', 1621792987),
(119, 12, '$2y$10$C/l.miRzU4AxDof3KRP1Du8pPnvmtC0YI9J2OUs0e6czxaSr04prO', 1621870694),
(120, 12, '$2y$10$Svy7T9veg4dXqrrAk4AQPetnanaKsbBKrMGxRFAK3Mt2KyZv33exm', 1621888262),
(121, 12, '$2y$10$Ulye9apC7W15IMS7b/U9S.a16.85vk4k3cKW1uVSKKt1.0mpdu9ou', 1621950471),
(124, 12, '$2y$10$cBtRYMOlukfwvbX2nrgl/u3a7wC7JWm.BE6Qyuh2hTjWXFz2lmaSC', 1622035076),
(125, 55, '$2y$10$hkGkZJSF68Bw0pFk3N38.uo8xHuHhESeaqYx.StvJMI6GXZIigh2C', 1622035286),
(126, 12, '$2y$10$hEtZrrC596kk45EleKqlk.Vuo8aoZ.w3CemRRxg/L.xLDa.N.mABG', 1622035842),
(128, 12, '$2y$10$55eqdA7M2EZA1fMLv4vRoeCJuqVTsodWwQFKVHpqG7bI9HAex5kpe', 1622151795),
(129, 12, '$2y$10$ZST3yz1bR/U4thxZJNWmsOMGuz.nYLbz1PtweZc3jbIXO8SZ8kik6', 1622203703),
(130, 12, '$2y$10$M2kqJed888k4YyjB1UM1zu5/qlMgeTlSb9eFBzR.bAR9gAxfFBJVi', 1622308173),
(132, 12, '$2y$10$RFtQbgBIPIM.jJt8AV9nDu5OSVIY3wprSAprbOv2GZ07RzwB.Q4ai', 1622312498),
(133, 12, '$2y$10$Sj6oTcwvn0emO.57irTToOqe3YPDldd5sXCDgVcGkAzkveueBjRui', 1622396712),
(134, 12, '$2y$10$qtiAcalUJwijqCTiJElLBuVP1tcBQiwkcMdRNM8KeYiaYd1oLX2.K', 1622567871),
(138, 12, '$2y$10$GsRYn4V7I9e4QP0S4KNMZODl0hEj96daR/BeMKTiXVl2bSY36Uq3y', 1622834521),
(141, 12, '$2y$10$.1.l7gDxKYUy5OKAJL72d.r.ABzA5kg4W0pwiMtaULdXNcM4rzArq', 1622988927),
(142, 47, '$2y$10$yfusvBP5Ta1TiKzySCKCMesSVc7NXqjjCysVHbs0hJGmgRuhyKM6a', 1622989472),
(143, 12, '$2y$10$YRIG0LmwK8IcRbs6jNS0WO0V88ymc3NuWXlEcuLtfK63gJZxDkefO', 1622989518),
(144, 12, '$2y$10$9LJPeJcVA4WB2bzV7a5RgOFJQcESk8u2842jngEElNvpXHMR7KhC.', 1623081384),
(145, 12, '$2y$10$0QhqpMUe.1CEBO7bZHvnCOI/QRSmU8b3H4hThDYL/FfkZxCtFlPOu', 1623091502),
(146, 12, '$2y$10$bWIC.79BoYauwuv14et/qOyMuJ7QoWt/2jmNrRP6Fy.RQTs78VRX2', 1623164864),
(147, 12, '$2y$10$0Kmm2AGCWceeAdQ61PcyuOxE6BWfpirtQLXbzbMQ9TcMpx5Fl0GK2', 1623167922),
(148, 12, '$2y$10$g0dESbKrigGy1e8qj2tPROOMMdw.8fns21.y8gn6Om/HPxNsEDf3q', 1623175229),
(149, 12, '$2y$10$J6kjh/k4g3xwCXZw/xBFLO18gCoetWequQOiz/LKTz0L/at.jyee6', 1623769633),
(150, 12, '$2y$10$9mk2tg5gWk8g/7AlRCqAV.iq5s8AUP7sbTFLryqWW9HxmnXD57Xxm', 1623856520),
(151, 12, '$2y$10$.PeHaU.dEuhJNijDZ/DLM.L3HF.w8MlFJ0DSuBQwGGhdACZ8BXGmC', 1623869276),
(152, 12, '$2y$10$UYrMLYOwqvLBoKr6pNnTteQn3p/zbMglZ9N.mnpGIF1danpZnoViy', 1623930117),
(153, 12, '$2y$10$wswn3TLDRss2CAe0DtWCb.vfldu0JrunTw2IampCyUcxkh/WSGFsK', 1623933217),
(154, 12, '$2y$10$463VR5LuDDG/7iyN7zaf7OWn/ht72DxZ3PIjo.c0TC3MpC7T3vnIO', 1624017024),
(158, 12, '$2y$10$Fx50AXoAllGyB3oCAT/hM.OvD9zpY1s50vrr.0RrFYN5drn4Z8AYm', 1625579133),
(165, 12, '$2y$10$uIGwFCf4JGz136cy9CA4lelSqaulrlXykhxLNApFhRwVhiecR7nve', 1625684880),
(168, 12, '$2y$10$RUzcbleyW6iDN3H5T1BqCOYv/EJJ1inrZhgzeV6NUNe1tL7NVTiGC', 1625763308),
(169, 12, '$2y$10$f6okkwZRZXqfCQUP/lls.eXPWcjjchx5EIMpnRDtQNE65Nh6dH5nC', 1625763561),
(170, 12, '$2y$10$rsA96IbXnENZfdqPrPfSzuyAcOnz8x0Xu5gqxBj1LsYs4UXnP3IGm', 1625833059);

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_users_comments` (`user_id`),
  ADD KEY `FK_tovars_comments` (`tovar_id`);

--
-- Индексы таблицы `groups`
--
ALTER TABLE `groups`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `news`
--
ALTER TABLE `news`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_users_news` (`autor`);

--
-- Индексы таблицы `static`
--
ALTER TABLE `static`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `url` (`url`);

--
-- Индексы таблицы `tovars`
--
ALTER TABLE `tovars`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_category_tovars` (`category_id`);

--
-- Индексы таблицы `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `login` (`login`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `fk_groups_users` (`group_id`);

--
-- Индексы таблицы `user_tokens`
--
ALTER TABLE `user_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `token` (`token`),
  ADD KEY `fk_user_tokens` (`user_id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT для таблицы `comments`
--
ALTER TABLE `comments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT для таблицы `groups`
--
ALTER TABLE `groups`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `news`
--
ALTER TABLE `news`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;

--
-- AUTO_INCREMENT для таблицы `static`
--
ALTER TABLE `static`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT для таблицы `tovars`
--
ALTER TABLE `tovars`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=47;

--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=65;

--
-- AUTO_INCREMENT для таблицы `user_tokens`
--
ALTER TABLE `user_tokens`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=171;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `FK_tovars_comments` FOREIGN KEY (`tovar_id`) REFERENCES `tovars` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_users_comments` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `news`
--
ALTER TABLE `news`
  ADD CONSTRAINT `FK_users_news` FOREIGN KEY (`autor`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `tovars`
--
ALTER TABLE `tovars`
  ADD CONSTRAINT `fk_category_tovars` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`);

--
-- Ограничения внешнего ключа таблицы `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `fk_groups_users` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ограничения внешнего ключа таблицы `user_tokens`
--
ALTER TABLE `user_tokens`
  ADD CONSTRAINT `fk_user_tokens` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
