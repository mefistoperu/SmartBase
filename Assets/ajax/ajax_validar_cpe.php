<?php
require_once("../../config/config.php");
require_once("../../helpers/helpers.php"); 
require_once("../../libraries/conexion.php"); 
session_start();

////////////llamar datos mediante un json para editar pelicula/////////////
if($_POST['action']=='validar_cpe_sunat')
{

$id=$_POST['id'];

$vtacab = "SELECT * FROM vw_tbl_venta_cab WHERE id=$id";
$resultado_cab  = $connect->prepare($vtacab);
$resultado_cab->execute();
$row_cab = $resultado_cab->fetch(PDO::FETCH_ASSOC);

$id_empresa = $row_cab['idempresa'];

$queryemp = "SELECT * FROM vw_tbl_empresas WHERE id_empresa=$id_empresa";
$resultado_emp  = $connect->prepare($queryemp);
$resultado_emp->execute();
$row_emp = $resultado_emp->fetch(PDO::FETCH_ASSOC);

$carpeta_xml='../../sunat/'.$row_emp['ruc'].'/xml/';
$carpeta_cdr='../../sunat/'.$row_emp['ruc'].'/cdr/';

$ruc         =$row_emp['ruc'];
$usuario_sol =$row_emp['usuario_sol'];
$pass_sol    =$row_emp['clave_sol'];

$tipo_comprobante=$row_cab['tipocomp'];
$serie=$row_cab['serie'];
$numero=$row_cab['correlativo'];

$mensajeu='ESTADO DEL COMPROBANTE: '.$serie.'-'.$numero.'';
if($row_emp['servidor_cpe']=='3'){//nubefact
    $ruta_ws = 'https://ose.nubefact.com/ol-ti-itcpe/billService?wsdl';
}else if($row_emp['servidor_cpe']=='4'){
    $ruta_ws = 'https://ose.bizlinks.com.pe/ol-ti-itcpe/billService?wsdl';
}else if($row_emp['servidor_cpe']=='1'){
    $ruta_ws='https://e-factura.sunat.gob.pe/ol-it-wsconscpegem/billConsultService';
//  $ruta_ws='https://www.sunat.gob.pe/ol-it-wsconscpegem/billConsultService';
} 
else{
   $ruta_ws='https://e-factura.sunat.gob.pe/ol-it-wsconscpegem/billConsultService'; 
}
try {

//===================ENVIO FACTURACION=====================
$soapUrl = $ruta_ws; 
$soapUser = "";  
$soapPassword = ""; 
    // xml post structure
    $xml_post_string = '<soapenv:Envelope xmlns:ser="http://service.sunat.gob.pe" 
xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
xmlns:wsse="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd">
    <soapenv:Header>
      <wsse:Security>
         <wsse:UsernameToken>
          <wsse:Username>'.$ruc.$usuario_sol.'</wsse:Username>
<wsse:Password Type="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-username-token-profile-1.0#PasswordText">' . $pass_sol . '</wsse:Password>
         </wsse:UsernameToken>
      </wsse:Security>
   </soapenv:Header>
   <soapenv:Body>
      <ser:getStatus>
         <rucComprobante>'.$ruc.'</rucComprobante>
         <tipoComprobante>'.$tipo_comprobante.'</tipoComprobante>
         <serieComprobante>'.$serie.'</serieComprobante>
         <numeroComprobante>'.$numero.'</numeroComprobante>
      </ser:getStatus>
   </soapenv:Body>
</soapenv:Envelope>';

    $headers = array(
        "Content-type: text/xml;charset=\"utf-8\"",
        "Accept: text/xml",
        "Cache-Control: no-cache",
        "Pragma: no-cache",
        "SOAPAction: ",
        "Content-length: " . strlen($xml_post_string),
    ); //SOAPAction: your op URL
//echo $xml_post_string;
    $url = $soapUrl;

    // PHP cURL  for https connection with auth
    $ch = curl_init();
    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 0);
    curl_setopt($ch, CURLOPT_URL, $url);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    //curl_setopt($ch, CURLOPT_USERPWD, $soapUser.":".$soapPassword); // username and password - declared at the top of the doc
    curl_setopt($ch, CURLOPT_HTTPAUTH, CURLAUTH_ANY);
    curl_setopt($ch, CURLOPT_TIMEOUT, 130);
    curl_setopt($ch, CURLOPT_POST, true);
    curl_setopt($ch, CURLOPT_POSTFIELDS, $xml_post_string); // the SOAP request
    curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);

    // converting
    $response = curl_exec($ch);
    $httpcode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    curl_close($ch);
  
		
file_put_contents($carpeta_cdr.'R-'.$ruc.'-'.$serie.'-'.$numero.'.XML', $response);

        $doc = new DOMDocument();
        $doc->loadXML($response);

        //===================VERIFICAMOS SI HA ENVIADO CORRECTAMENTE EL COMPROBANTE=====================
        if (isset($doc->getElementsByTagName('faultstring')->item(0)->nodeValue)) {
            $ticket = $doc->getElementsByTagName('faultstring')->item(0)->nodeValue;
			
			$mensaje['id_cpe'] = $id;
			$mensaje['doc_sunat'] = $mensajeu;
            $mensaje['cod_sunat'] = "0";
            $mensaje['msj_sunat'] = ''.$ticket.'';
			$mensaje['hash_cdr'] = "";
        
        } else {
            $mensaje['id_cpe'] = $id;
            $mensaje['doc_sunat'] = $mensajeu;
            $mensaje['cod_sunat'] = $doc->getElementsByTagName('statusCode')->item(0)->nodeValue;
            $mensaje['msj_sunat'] = ''.$doc->getElementsByTagName('statusMessage')->item(0)->nodeValue.'';
            $mensaje['hash_cdr'] = "";			
        }

    } catch (Exception $e) {
        $mensaje['id_cpe'] = $id;
        $mensaje['doc_sunat'] = $mensajeu;
        $mensaje['cod_sunat']="0199999";
        $mensaje['msj_sunat']="SUNAT ESTA FUERA SERVICIO: ".$e->getMessage().'';
        $mensaje['hash_cdr'] = "";
    }
    

        header("HTTP/1.1");
        header("Content-Type: application/json; charset=UTF-8");
        echo json_encode($mensaje, JSON_PRETTY_PRINT);
   
   

   //$data = json_encode($row_productos,true);
   //echo $data;

   exit();

}

if($_POST['action']=='actualizarEstado')
{
    //var_dump($_POST);
    if($_POST['estado'] == '1')
    {
        $mensaje = 'Aceptado por SUNAT';
    }
     else if($_POST['estado'] == '0')
    {
        $mensaje = '';
    }
    else  if($_POST['estado'] == '3')
    {
        $mensaje = 'Documento Anulado';
    }
   	$query=$connect->prepare("UPDATE tbl_venta_cab SET feestado=?,femensajesunat=? WHERE id = ?");
	$resultado = $query->execute([$_POST['estado'] ,$mensaje,$_POST['id_cpe']]);

	if($resultado)
	{
		$mensajex['respuesta']='Actualizado con exito';
	}
	else
	{
		$mensajex['respuesta']='Error al actualizar';
	}

	//echo $msg; 
    
    echo json_encode($mensajex);
    
    exit();
}
?>