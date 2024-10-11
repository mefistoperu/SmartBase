<?php
require_once("../config/config.php");
require_once("../helpers/helpers.php"); 
require_once("../libraries/conexion.php"); 

header("Access-Control-Allow-Origin: *");
// Permite la ejecucion de los metodos
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE");
date_default_timezone_set('America/Lima');
header("HTTP/1.1");
header("Content-Type: application/json; charset=UTF-8");


$jsondata = array();
$jsondata['estado'] = '0';
$jsondata['mensaje'] = 'ERROR';	

//$array = explode("/", $_SERVER['REQUEST_URI']);
$bodyRequest = file_get_contents("php://input");
$cab = json_decode($bodyRequest, true);

$ruc              = $cab['ruc'];
$tipo_cpe         = $cab['tipo_cpe'];
$serie_cpe        = $cab['serie_cpe'];
$num_cpe          = $cab['num_cpe'];
$fec_emision      = $cab['fec_emision'];
$fec_vencimiento  = $cab['fec_vencimiento'];
$hora_emision     = $cab['hora_emision'];
$tip_cambio       = $cab['tip_cambio'];
$condicion_vta    = $cab['condicion_vta'];
$num_cuotas       = $cab['num_cuotas'];
$orden_compra     = $cab['orden_compra'];
$moneda           = $cab['moneda'];
$op_gravadas      = $cab['op_gravadas'];
$op_exoneradas    = $cab['op_exoneradas'];
$op_inafectas     = $cab['op_inafectas'];
$igv              = $cab['igv'];
$total            = $cab['total'];
$tip_doc_cli      = $cab['tip_doc_cli'];
$ruc_cliente      = $cab['ruc_cliente'];
$nom_cliente      = $cab['nom_cliente'];
$ape_paterno      = $cab['ape_paterno'];
$ape_materno      = $cab['ape_materno'];
$nombres_cli      = $cab['nombres_cli'];
$dir_cliente      = $cab['dir_cliente'];
$mail_cliente     = $cab['mail_cliente'];
$pais_cliente     = $cab['pais_cliente'];
$dist_cliente     = $cab['dist_cliente'];
$prov_cliente     = $cab['prov_cliente'];
$depa_cliente     = $cab['depa_cliente'];
$observacion      = $cab['observacion'];
$por_detraccion   = $cab['por_detraccion'];
$cod_detraccion   = $cab['cod_detraccion'];
$imp_detraccion   = $cab['imp_detraccion'];
$num_detraccion   = $cab['num_detraccion'];
$tip_dod_ref      = $cab['tip_dod_ref'];
$ser_doc_ref      = $cab['ser_doc_ref'];
$num_doc_ref      = $cab['num_doc_ref'];
$fec_doc_ref      = $cab['fec_doc_ref'];
$mot_doc_ref      = $cab['mot_doc_ref'];
$sub_total        = $op_gravadas + $op_exoneradas + $op_inafectas;

$detalle = $cab['detalle'];


switch ($_GET["op"])
{
    case 'ventas' :
        
    /*validaciones*/
    if(empty($ruc))
    {
        $jsondata['mensaje'] ='ERROR: RUC NO PUEDE ESTAR VACIO';	
        $jsondata['estado'] ='0';
        echo json_encode($jsondata);
        break; 
    }
    if(empty($tipo_cpe))
    {
        $jsondata['mensaje'] ='ERROR: TIPO DE COMPROBANTE NO PUEDE ESTAR VACIO';	
        $jsondata['estado'] ='0';
        echo json_encode($jsondata);
        break; 
    }
    if($tipo_cpe=="01" && $tip_doc_cli =="1")
    {
        $jsondata['mensaje'] ='ERROR: TIPO DE COMPROBANTE NO PERMITIDO PARA TIPO DE DOCUMENTO';	
        $jsondata['estado'] ='0';
        echo json_encode($jsondata);
        break; 
    }
    $seriei = $serie_cpe;
    $si = $seriei[0];
    
     if($tipo_cpe=="01" &&  $si =="B")
    {
        $jsondata['mensaje'] ='ERROR: TIPO DE COMPROBANTE ES FACTURA Y SERIE ES DE BOLETA';	
        $jsondata['estado'] ='0';
        echo json_encode($jsondata);
        break; 
    }
     if($tipo_cpe=="03" &&  $si =="F")
    {
        $jsondata['mensaje'] ='ERROR: TIPO DE COMPROBANTE ES DE BOLETA Y SERIE ES DE FACTURA';	
        $jsondata['estado'] ='0';
        echo json_encode($jsondata);
        break; 
    }
    
    $basei = $op_gravadas + $op_exoneradas + $op_inafectas + $igv;
    
    if($basei <> $total)
    {
        $jsondata['mensaje'] ='ERROR: LA SUMATORIA DE LAS BASES Y EL IGV DIFIERE DEL TOTAL';	
        $jsondata['estado'] ='0';
        echo json_encode($jsondata);
        break; 
    }
    
    if($tip_cambio < 1 || $tip_cambio >=4.5)
    {
        $jsondata['mensaje'] ='ERROR: EL TIPO DE CAMBIO NO PUEDE SER MENOR A 1 O DEMASIADO GRANDE';	
        $jsondata['estado'] ='0';
        echo json_encode($jsondata);
        break; 
    }
    /************************SELECCIONAMOS EL ID DE EMPRESA POR EL RUC DEL EMISOR****************************/
    $query_data = "SELECT * FROM tbl_empresas WHERE ruc=$ruc";
    $resultado = $connect->prepare($query_data);
    $resultado->execute();
    $row_empresa = $resultado->fetch(PDO::FETCH_ASSOC);
    $idempresa   = $row_empresa['id_empresa'];
    
    /************************SELECCIONAMOS EL ID DE CLIENTE ****************************/
    $query_cli = "SELECT * FROM tbl_contribuyente WHERE num_doc=$ruc_cliente";
    $resultado_cli = $connect->prepare($query_cli);
    $resultado_cli->execute();
    $row_cli = $resultado_cli->fetch(PDO::FETCH_ASSOC);
    $num_reg_cli=$resultado_cli->rowCount();
    
    if($num_reg_cli >=1)
    {
      $id_ruc   = $row_cli['id_persona'];
    }
    else
    {
        $query=$connect->prepare("INSERT INTO tbl_contribuyente(nombre_persona,direccion_persona,distrito,provincia,departamento,tipo_doc,num_doc,correo,empresa) VALUES (?,?,?,?,?,?,?,?,?);");
		    $resultado=$query->execute([$nom_cliente,$dir_cliente,$dist_cliente,$prov_cliente,$depa_cliente,$tip_doc_cli,$ruc_cliente,$mail_cliente,$idempresa]);
		$id_ruc = $connect->lastInsertId();
    }
    
    
    /************************GUARDAMOS CABECERA DE VENTA**********************************/
   
    $vendedor ='1';
    $hora = date('h:i:s');
    $query=$connect->prepare("INSERT INTO tbl_venta_cab(idempresa,tipocomp,serie,correlativo,fecha_emision,fecha_vencimiento,condicion_venta,op_gravadas,op_exoneradas,op_inafectas,igv,total,codcliente,vendedor,obs,cuotas_credito,hora_emision,idcliente,por_det,cod_det,imp_det) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);");
    $resultado=$query->execute([$idempresa,$tipo_cpe ,$serie_cpe,$num_cpe,$fec_emision,$fec_vencimiento,$condicion_vta,$op_gravadas,$op_exoneradas,$op_inafectas,$igv,$total,$ruc_cliente, $vendedor,$_POST['obs'],$num_cuotas,$hora,$_POST['id_ruc'],$por_detraccion,$cod_detraccion,$imp_detraccion]);
    
    $lastInsertIdventa = $connect->lastInsertId();
       
   for ($i = 0; $i < count($detalle); $i++) 
   {
     $detalle[$i]['nombre_producto'].'<br />';
   }
   
$emisor    ='';
$cliente   ='';
$cabecera  ='';
$detalle   ='';

/*$jsondata['idventa'] = $idventanew;
$jsondata['pdf'] = RUTA.'/plugins/dompdf/?id='.$idventanew;
$jsondata['idcliente'] = $idproveedor;	
*/
$jsondata['idempresa'] =$idempresa;	
$jsondata['idcliente'] =$id_ruc;
$jsondata['idventa'] = $lastInsertIdventa;
$jsondata['mensaje'] ='GUARDADO CORRECTAMENTE';	
$jsondata['estado'] ='1';
$jsondata['documento'] = $serie_cpe.'-'.$num_cpe;
$jsondata['subtotal'] = number_format($sub_total,2,'.',',')  ;
$jsondata['igv'] = $igv;
$jsondata['total'] = $total;
$jsondata['moneda'] = $moneda;
$jsondata['hash'] = '';
$jsondata['rspta_sunat'] = '';

echo json_encode($jsondata);	

        
    break;
}
?>