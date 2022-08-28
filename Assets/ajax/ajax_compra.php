<?php 

require_once("../../Config/Config.php");
require_once("../../Helpers/Helpers.php"); 
require_once("../../Libraries/Core/Conexion.php"); 
session_start();

if($_POST['action'] == 'searchCliente')
{
  $doc=$_POST['cliente'];

$query_articulos = "SELECT * FROM tbl_persona WHERE num_doc ='$doc'";
$resultado = $connect->prepare($query_articulos);
$resultado->execute();
$row_articulo = $resultado->fetch(PDO::FETCH_ASSOC);

echo json_encode($row_articulo);
exit;
}

if($_POST['action']=='addCompra')
{
	$cod_cliente      = $_POST['cod_cliente'];
	$fecha            = $_POST['fecha'];
     $f = explode("-",$fecha);
     $fecha_compra = $f[2].'-'.$f[1].'-'.$f[0];
	$tipo_cpe         = $_POST['categoria'];
	$serie_cpe        = $_POST['serie'];
	$numero           = $_POST['numero'];
	$sub_total        = $_POST['subt'];
	$igv              = $_POST['igv'];
	$total_compra     = $_POST['total_compra'];

	$query=$connect->prepare("INSERT INTO tbl_compras_cab(fecha_compra,persona,tipo_doc,serie_doc,numero_doc,op_gravadas,op_igv,total_compra) VALUES (?,?,?,?,?,?,?,?);");
	$resultado=$query->execute([$fecha_compra,$cod_cliente,$tipo_cpe,$serie_cpe,$numero,$sub_total,$igv,$total_compra]);
    $lastInsertId = $connect->lastInsertId();
//registro detalle compra

    for($i = 0; $i< count($_POST['idarticulo']); $i++)
    {
      $idarticulo = $_POST['idarticulo'][$i];
      $item   = $_POST['cont'][$i];
      $cantidad = $_POST['cantidad'][$i];
      $precio_compra = $_POST['precio_compra'][$i];
    

      $insert_query_detalle =$connect->prepare("INSERT INTO tbl_compras_det(id_compra,item,id_articulo,cantidad,precio_compra) VALUES(?,?,?,?,?)");
      $resultado_detalle = $insert_query_detalle->execute([$lastInsertId,$item,$idarticulo,$cantidad,$precio_compra]);



// inserta stock
$update_query_articulo = $connect->prepare("UPDATE tbl_articulo SET stock = stock + ? WHERE id_articulo = ?");
$resultado_stock   = $update_query_articulo->execute([$cantidad,$idarticulo]);
    }


    if($update_query_articulo)
    {
      $msg = 'ok';
    }
    else
    {
      $msg = 'error';
    }

    echo $msg;

    exit;


}


?>