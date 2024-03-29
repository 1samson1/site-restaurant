<?php
    class DataBase {
        
        public $error;
        public $error_num;
        public $connect;
        public $query;
        public $queries = null;

        public function __construct(){
            $this->connect = mysqli_connect(DB_HOST, DB_USER, DB_PASS, DB_NAME) or die("Нет подключения к БД");
			$this->set_charset();
        }  
        
        public function query($query){            
            $this->query = mysqli_query($this->connect,$query);
            $this->error = mysqli_error($this->connect);
			$this->error_num = mysqli_errno($this->connect);
            return $this->query;
        }
        
        public function multi_query($query) {
            if( mysqli_multi_query($this->connect, $query) ) {
                while( mysqli_more_results($this->connect) && mysqli_next_result($this->connect) ){
                    ;
                }
            }
            $this->error = mysqli_error($this->connect);
            $this->error_num = mysqli_errno($this->connect);
        }

        public function add_query($query) {
            $this->queries .= $query;
        }

        public function add_query_begin($query){
            $this->queries = $query.$this->queries;
        }
        
        public function send_queries() {
            $this->queries = 'START TRANSACTION;'.$this->queries;
            $this->queries .= 'COMMIT;';
            $this->multi_query($this->queries);
            $this->queries = null;
        }

        public function num_rows($query = '') {
            if ($query == '') $query = $this->query;
    
            return mysqli_num_rows($query);
        }

        public function get_row($query = '') {
            if ($query == '') $query = $this->query; 
            return mysqli_fetch_assoc($query);
        } 

        public function get_row_noassoc($query = '') {
            if ($query == '') $query = $this->query;    
            return mysqli_fetch_row($query);
        } 

        public function get_array($query = ''){
            if ($query == '') $query = $this->query;    

            while($row = $this->get_row()){
                $results[]= $row ;
            }
            return $results;
        }

        public function hash($value){
            return password_hash($value, PASSWORD_DEFAULT);
        }

        public function ecran($value){
            return mysqli_real_escape_string($this->connect, addslashes(stripslashes($value)));
        }

        public function ecran_html($value){
            return $this->ecran(htmlspecialchars($value));
        }

        public function bool_to_sql($bool){
            return $bool ? 1 : 0;
        }   

        public function str_to_sql($str){
            return $str ? $str : '';
        }   
		
		public function set_charset($charset="utf8"){
            return mysqli_set_charset($this->connect, $charset);    
        }  
		
		public function __destruct(){
            mysqli_close($this->connect);
        }
    }
?>
