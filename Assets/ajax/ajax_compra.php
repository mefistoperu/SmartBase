<?php 

require_once("../../config/config.php");
require_once("../../helpers/helpers.php"); 
require_once("../../libraries/conexion.php"); 
session_start();


if($_POST['action'] == 'add_dt')
{
    $insert_query_detalle =$connect->prepare("INSERT INTO tbl_compra_dt(idventa,num_det,fecha_det) VALUES(?,?,?)");
      $resultado_detalle = $insert_query_detalle->execute([$_POST['id_ven'],$_POST['num_det'],$_POST['fec_det']]);
}


if($_POST['action'] == 'buscar_dt')
{
  $doc=$_POST['id'];

$query_articulos = "SELECT * FROM tbl_compra_dt WHERE idventa ='$doc'";
$resultado = $connect->prepare($query_articulos);
$resultado->execute();
$row_articulo = $resultado->fetch(PDO::FETCH_ASSOC);

echo json_encode($row_articulo);
exit;
}







?>