<?php 
require_once("../../config/config.php");
require_once("../../helpers/helpers.php"); 
require_once("../../libraries/conexion.php"); 

$dni = $_POST['dni'];
$tip = $_POST['tip'];
$l = strlen($dni);

if($tip=='1' && $l == 8)
{
/*	$data = file_get_contents('https://dniruc.apisperu.com/api/v1/dni/'.$dni.'?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6IkptdmFsdmVyZGVjQGdtYWlsLmNvbSJ9.-XVl-oKrL-Jvu0H5ndUgqrIhDMlDwztn3qNPOA-usq0');
	$info = json_decode($data, true);

	if($data=='[]')
		{
			$datos = array(0 => 'nada');
			json_encode($datos);
		}

	else
		{
			$datos = array(
			0 => $info['dni'],
			1 => $tip,
			2 => $info['nombres'],
			3 => $info['apellidoPaterno'],
			4 => $info['apellidoMaterno']
		);
			echo json_encode($datos);
		}*/

$postData = array(
    "strApeMaterno" => "",
    "strApePaterno" => "",
    "strCorreo" => "",
    "strDocumento" => "".$dni,
    "strApeMaterno" => "",
    "strNombres" => "",
    "strTipoDocumento" => "DNI"
);

$curl = curl_init();

curl_setopt_array($curl, array(
  CURLOPT_URL => 'https://plataformamincu.cultura.gob.pe/post_cast/User/valDoc',
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_HEADER => false,
  CURLOPT_ENCODING => '',
  CURLOPT_MAXREDIRS => 10,
  CURLOPT_TIMEOUT => 0,
  CURLOPT_SSL_VERIFYHOST=>0,
  CURLOPT_FOLLOWLOCATION => true,
  CURLOPT_POSTFIELDS=>$postData,
  CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
  CURLOPT_CUSTOMREQUEST => 'POST',
));

$info= curl_exec($curl);

curl_close($curl);

//$info=json_decode($info);

$porciones = explode(",", $info);

$nombre1=$porciones[1];
$nombre2=$porciones[2];
$nombre3=$porciones[3];

$nombre1= explode(":", $nombre1);
$nombre2= explode(":", $nombre2);
$nombre3= explode(":", $nombre3);

$paterno=$nombre1[1];
$materno=$nombre2[1];
$nombres=$nombre3[1];
//$bodytag = str_replace("%body%", "black", "<body text='%body%'>");
$paterno=str_replace('"', "", $paterno);
$materno=str_replace('"', "", $materno);
$nombres=str_replace('"', "", $nombres);

/*
var_dump($info);
var_dump($nombre2[1]);
*/

$datos = array(
			0 => $dni,
			1 => $tip,
			2 =>$nombres,
			3 => $paterno,
			4 => $materno
		);

echo json_encode($datos);


/*
header('Content-Type: application/json; charset=utf-8');
echo $response;
*/

}
elseif($tip=='6' && $l == 11)
{
$data = file_get_contents("https://dniruc.apisperu.com/api/v1/ruc/".$dni."?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJlbWFpbCI6IkptdmFsdmVyZGVjQGdtYWlsLmNvbSJ9.-XVl-oKrL-Jvu0H5ndUgqrIhDMlDwztn3qNPOA-usq0");
	$info = json_decode($data, true);

	if($data==='[]' || $info['fechaInscripcion']==='--')
		{
			$datos = array(0 => 'nada');
			echo json_encode($datos);
		}
	else
		{
		$datos = array(
			0 => $info['ruc'], 
			1 => $tip,
			2 => $info['razonSocial'],
			3 => $info['estado'],
			4 => $info['tipo'],
			5 => $info['condicion'],
			6 => $info['direccion'],
			7 => $info['departamento'],
			8 => $info['provincia'],
			9 => $info['distrito']
		);
			echo json_encode($datos);
		}


}

/*echo $tip;	
copy("http://www2.sunat.gob.pe/padron_reducido_ruc.zip", "padron/padron_reducido_ruc.zip"); 

$zip = new ZipArchive;
// Declaramos el fichero a descomprimir, puede ser enviada desde un formulario
     $comprimido= $zip->open('padron/padron_reducido_ruc.zip');
     if ($comprimido=== TRUE) {
// Declaramos la carpeta que almacenara ficheros descomprimidos
         $zip->extractTo('padron/');
         $zip->close();
// Imprimimos si todo salio bien
         echo 'El fichero se descomprimio correctamente!';
		 unlink('padron/padron_reducido_ruc.zip');
     } else {
// Si algo salio mal, se imprime esta seccion
         echo 'Error descomprimiendo el archivo zip';
     }
		
		
		
		
if (isset($_SERVER['HTTP_ORIGIN'])) {  
		header('Content-type: application/json; charset=utf-8');
	    header("Access-Control-Allow-Origin: {$_SERVER['HTTP_ORIGIN']}");  
	    header('Access-Control-Allow-Credentials: true');  
	    header('Access-Control-Max-Age: 86400');   
	}  
	      
	if ($_SERVER['REQUEST_METHOD'] == 'OPTIONS') {       
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

    while (!feof($handle)) {
        $line = fgets($handle, 1024);
        if ($isFirst) {
            $isFirst = false;

            $lines++;
            continue;
        }
        
        if (substr( $line, 0, 11) === $ruc) {
            // position: $lines
            return utf8_encode($line);
        }

        $lines++;
    }
    fclose($handle);
    
    return 'NO ENCONTRADO';
}

// Este proceso toma unos cuantos segundos.

//$ruc = '20606397390';
$ruc = $dni;

//echo 'search: '.$ruc.PHP_EOL;
$resultado = queryRucPadron('padron/padron_reducido_ruc.txt', $ruc);
$pizza=$resultado.PHP_EOL;

$porciones = explode("|", $pizza);
// php query-ruc-padron.php 
// search: 20100070970
// 20100070970|SUPERMERCADOS PERUANOS SOCIEDAD ANONIMA 'O ' S.P.S.A.|ACTIVO|HABIDO|150130|CAL.|MORELLI|-|-|181|P-2|-|-|-

//var_dump($r);
if($porciones[10]=='-'){ $int=''; }else{ $int=' Inter. '.$porciones[10]; }
if($porciones[11]=='-'){ $lote=''; }else{ $lote=' Lote '.$porciones[11]; }
if($porciones[12]=='-'){ $dep=''; }else{ $dep=' Dep. '.$porciones[12]; }
if($porciones[13]=='-'){ $manzana=''; }else{ $dep=' Manzana '.$porciones[13]; }
if($porciones[14]=='-'){ $kilometro=''; }else{ $dep=' Kilómetro '.$porciones[12]; }

$direccion=$porciones[5].' '.$porciones[6].' '.$porciones[7].$porciones[8].' '.$porciones[9].$int.$lote.$dep.$manzana.$kilometro;

$direccion=str_replace(" - ", " ", $direccion);
$direccion=str_replace("-", "", $direccion);
$direccion=rtrim($direccion);

$sql=mysqli_query($mysqli, "SELECT *FROM u_distritos WHERE id='$porciones[4]' ");
$row=mysqli_fetch_array($sql);

$sql1=mysqli_query($mysqli, "SELECT *FROM u_provincias WHERE id='$row[id_lista]' ");
$row1=mysqli_fetch_array($sql1);

$sql2=mysqli_query($mysqli, "SELECT *FROM u_departamentos WHERE id='$row1[id_lista]' ");
$row2=mysqli_fetch_array($sql2);

$direccion=$direccion.', '.$row['nombre'].', '.$row1['nombre'].', '.$row2['nombre'];

$jsondata['ruc']=$porciones[0];
$jsondata['razonSocial']=$porciones[1];
$jsondata['nombreComercial']='-';
$jsondata['telefono']='';
$jsondata['estado']=$porciones[2];
$jsondata['condicion']=$porciones[3];
$jsondata['ubigeo']=$porciones[4];
$jsondata['direccion']=$direccion;
$jsondata['distrito']=$row['nombre'];
$jsondata['provincia']=$row1['nombre'];
$jsondata['departamento']=$row2['nombre'];


header("HTTP/1.1");
header("Content-Type: application/json; charset=UTF-8");
echo json_encode($jsondata);		
		
		
		
		
		
}



else
{
	$error='error';

	$datos = array(
	     0 => $error
	     
	 );

}*/
?>