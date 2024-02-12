<?php 
class database {
  var $host = "localhost";
  var $username = "root";
  var $password = "";
  var $databaseName = "db_tes_rmt4";

  function __construct() {
    $koneksi = mysqli_connect($this->host, $this->username, $this->password, $this->databaseName);
   if($koneksi) {
    echo "Koneksi database MySQL dan PHP Berhasil";
   } else {
    echo "Koneksi database MySQL dan PHP Gagal";
   }
  }
}

$koneksi = new database();

?>