<?php
require_once("../config/config.php");
require_once("../helpers/helpers.php"); 
require_once("../libraries/conexion.php"); 
$ruc = $_GET['ruc'];

//echo json_encode($ruc);exit();
copy("http://www2.sunat.gob.pe/padron_reducido_ruc.zip", "padron/padron_reducido_ruc.zip"); 

$zip = new ZipArchive;
// Declaramos el fichero a descomprimir, puede ser enviada desde un formulario
$comprimido= $zip->open('padron/padron_reducido_ruc.zip');
if ($comprimido=== TRUE) 
{
// Declaramos la carpeta que almacenara ficheros descomprimidos
$zip->extractTo('padron/');
$zip->close();
// Imprimimos si todo salio bien
//echo 'El fichero se descomprimio correctamente!';
unlink('padron/padron_reducido_ruc.zip');
} 
else 
{
// Si algo salio mal, se imprime esta seccion
echo 'Error descomprimiendo el archivo zip';
}

if (isset($_SERVER['HTTP_ORIGIN'])) 
{  
header('Content-type: application/json; charset=utf-8');
header("Access-Control-Allow-Origin: {$_SERVER['HTTP_ORIGIN']}");  
header('Access-Control-Allow-Credentials: true');  
header('Access-Control-Max-Age: 86400');   
}  

if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') 
{       
if (isset($_SERVER['HTTP_ACCESS_CONTROL_REQUEST_METHOD']))  
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE, OPTIONS");        
if (isset($_SERVER['HTTP_ACCESS_CONTROL_REQUEST_HEADERS']))  
header("Access-Control-Allow-Headers: {$_SERVER['HTTP_ACCESS_CONTROL_REQUEST_HEADERS']}");  
}

header('Access-Control-Allow-Origin: *');

// Descargar padron reducido: http://www.sunat.gob.pe/descargaPRR/mrc137_padron_reducido.html
// Resultado al descomprimir: padron_reducido_ruc.txt 

set_time_limit(0);

function queryRucPadron($txtPath, $ruc)
{
    $handle = fopen($txtPath, "r") or die("No se puede abrir el txt");
    $lines = 0;
    $isFirst = true;

    while (!feof($handle))
    {
    $line = fgets($handle, 1024);
    if ($isFirst) {
    $isFirst = false;
    
    $lines++;
    continue;
    }

    if (substr( $line, 0, 11) === $ruc) 
    {
    // position: $lines
    return utf8_encode($line);
    }

    $lines++;
}
fclose($handle);

return 'NO ENCONTRADO';
}


// Este proceso toma unos cuantos segundos para poder insertar a la bd.


//$ruc = $dni;

//echo 'search: '.$ruc.PHP_EOL;
$resultado = queryRucPadron('padron/padron_reducido_ruc.txt', $ruc);
$pizza=$resultado.PHP_EOL;

$porciones = explode("|", $pizza);
// php query-ruc-padron.php 
// search: 20100070970
// 20100070970|SUPERMERCADOS PERUANOS SOCIEDAD ANONIMA 'O ' S.P.S.A.|ACTIVO|HABIDO|150130|CAL.|MORELLI|-|-|181|P-2|-|-|-

//var_dump($porciones);
if($porciones[10]=='-'){ $int=''; }else{ $int=' Inter. '.$porciones[10]; }
if($porciones[11]=='-'){ $lote=''; }else{ $lote=' Lote '.$porciones[11]; }
if($porciones[12]=='-'){ $dep=''; }else{ $dep=' Dep. '.$porciones[12]; }
if($porciones[13]=='-'){ $manzana=''; }else{ $dep=' Manzana '.$porciones[13]; }
if($porciones[14]=='-'){ $kilometro=''; }else{ $dep=' Kilómetro '.$porciones[12]; }

$direccion=$porciones[5].' '.$porciones[6].' '.$porciones[7].$porciones[8].' '.$porciones[9].$int.$lote.$dep.$manzana.$kilometro;

$direccion=str_replace(" - ", " ", $direccion);
$direccion=str_replace("-", "", $direccion);
$direccion=rtrim($direccion);

$ubigeo = $porciones[4];
//echo $ubigeo;
/*if($ubigeo<>"-")
{*/
$query_ubi = "SELECT * FROM tbl_ubigeo WHERE codigo='$ubigeo'";
//echo $query_ubi;
$resultado_ubi = $connect->prepare($query_ubi);
$resultado_ubi->execute();
$row_ubi = $resultado_ubi->fetch(PDO::FETCH_ASSOC);


$distrito       = strtoupper($row_ubi['distrito']);
$provincia      = strtoupper($row_ubi['provincia']);
$departamento   = strtoupper($row_ubi['departamento']);
/*}
$distrito       = '-';
$provincia      = '-';
$departamento   = '-';*/

$jsondata['ruc']=$porciones[0];
$jsondata['razonSocial']=$porciones[1];
$jsondata['nombreComercial']='-';
$jsondata['telefono']='';
$jsondata['estado']=$porciones[2];
$jsondata['condicion']=$porciones[3];
$jsondata['ubigeo']=$porciones[4];
$jsondata['direccion']=$direccion;
$jsondata['distrito']=$distrito ;
$jsondata['provincia']=$provincia ;
$jsondata['departamento']=$departamento;
header("HTTP/1.1");
header("Content-Type: application/json; charset=UTF-8");
echo json_encode($jsondata);	

?>