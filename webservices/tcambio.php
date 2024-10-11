<?php
require_once("../config/config.php");
require_once("../helpers/helpers.php"); 
require_once("../libraries/conexion.php"); 
$mes  = date('m');
$anio = date('Y');

//$mes = '7';
//$anio = '2024';
$url = "https://api.apis.net.pe/v1/tipo-cambio-sunat?month=".$mes."&year=".$anio;


$curl = curl_init();
curl_setopt($curl,CURLOPT_URL,$url);
curl_setopt($curl,CURLOPT_RETURNTRANSFER,true);
$resultado = curl_exec($curl);
//if(curl_errno($curl)) echo curl_error($curl);
//else $decoded = json_decode($resultado, true);

curl_close($curl);

$tc = json_decode($resultado,true);
//var_dump($tc);

foreach($tc as $row){
/*
$mensaje['dia'] = $row['fecha'];
$mensaje['vta'] = $row['venta'];
$mensaje['com'] = $row['compra'];*/
$fecha = $row['fecha'];
$query_data = "SELECT * FROM tbl_tipo_cambio WHERE fecha='$fecha'";
$resultado_data=$connect->prepare($query_data);
$resultado_data->execute();
$num_reg_data=$resultado_data->rowCount();
echo $num_reg_data;
if($num_reg_data==0)
{
 $query=$connect->prepare("INSERT INTO tbl_tipo_cambio(fecha,tcompra,tventa) VALUES (?,?,?);");
$resultado=$query->execute([$fecha,$row['compra'],$row['venta']]);   
}
if($resultado)
{
    $mensaje['respuesta'] = 'insertado con exito';
}
else
{
    $mensaje['respuesta'] = 'error al cargar el tipo de cambio';
}

/*
echo 'venta actual:'.number_format($row['venta'],3).'|';
echo 'compra:'.number_format($row['compra'],3).'|';
echo 'fecha :'.$row['fecha'].'<br >';
*/
}

echo json_encode($mensaje);

 ?>