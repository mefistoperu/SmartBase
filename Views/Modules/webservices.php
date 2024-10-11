<?php 
if (isset($_SERVER['HTTP_ORIGIN'])) 
{  
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

$migra_ventas       = 1;
$migra_cobros       = 1;
$migra_compras      = 1;
$migra_pagos        = 1;
$migra_importacion  = 1;

$ruce  = $_GET['ruc'];
//echo $ruce;exit();
/*para pentarama inversiones turiticas */
if($ruce  == '20494191637')
{
  require_once "../../../lovetriangle/config/global.php";
 require_once "../../../lovetriangle/config/Conexion.php";
   		
if(isset($_GET['fechai'])){  $fecha_inicio=$_REQUEST["fechai"]; }else{ $fecha_inicio=''; }
if(isset($_GET['fechaf'])){  $fecha_fin=$_REQUEST["fechaf"]; }else{ $fecha_fin=''; }
$ruc=$_REQUEST["ruc"];
	
//echo $ruc;

$cc = '1009';	
		
$sql="SELECT *FROM config WHERE ruc='$ruc'";
$row=ejecutarConsultaSimpleFila($sql);

$sqls="SELECT *FROM config_contabilidad WHERE idempresa='$row[id]' ";
$cons= ejecutarConsultaSimpleFila($sqls);

$origenventa=$cons['venta'];
$ctaingreso='7011111';
$ctaigv=$cons['cps'];
$ccostos=$cons['cpd'];

$cuentasoles=$cons['cpd'];
$cuendolar=$cons['igv'];

$origencompra=$cons['pago'];

$percepcioncompra40=$cons['percepcioncompra40'];

$cuentacompraoles=$cons['ccomprassoles'];
$cuentacompradolar=$cons['ccomprasdolares'];
$cuentadetraccion=$cons['ctadetraccion'];
$cuentaretencion=$cons['ctaretencion'];

$ctaperceipcion12=$cons['percepcion12'];
$ctaperceipcion40=$cons['percepcion40'];

$origencobrarf=$cons['origencobros'];
$detraccioncompras=$cons['detraccioncompras'];

$idv2=0;

$n=0;
$data= Array();
/*VENTAS*/

$datos = "SELECT  v.txtID_MONEDA, v.txtNUMERO,  v.txtSERIE, v.txtID_CLIENTE, v.txtFECHA_DOCUMENTO, d.idproducto, a.cta_ventas, v.tipocambio, v.txtID_TIPO_DOCUMENTO, v.txtTOTAL, v.txtIGV, v.txtSUB_TOTAL, d.subtotal, d.nombreproducto, v.idventa, v.fecha_vto, v.estado, v.docmodifica, v.docmodifica_tipo, v.exonerado, v.inafecta, v.tipo_pago, d.inafectad FROM detalle_venta d INNER JOIN venta v ON d.idventa=v.idventa LEFT JOIN articulo a ON d.idproducto=a.id WHERE DATE(v.txtFECHA_DOCUMENTO)>='$fecha_inicio' AND DATE(v.txtFECHA_DOCUMENTO)<='$fecha_fin'  AND v.idempresa='$row[id]'  AND (v.txtID_TIPO_DOCUMENTO='03' OR v.txtID_TIPO_DOCUMENTO='01' OR v.txtID_TIPO_DOCUMENTO='07' OR v.txtID_TIPO_DOCUMENTO='08' ) ORDER BY d.iddetalle_venta";

//echo $datos;

/*
$datos = "SELECT  v.txtID_MONEDA, v.txtNUMERO,  v.txtSERIE, v.txtID_CLIENTE, v.txtFECHA_DOCUMENTO, d.idproducto, a.cta_ventas, v.tipocambio, v.txtID_TIPO_DOCUMENTO, v.txtTOTAL, v.txtIGV, v.txtSUB_TOTAL, d.subtotal, d.nombreproducto, v.idventa, v.fecha_vto, v.estado, v.docmodifica, v.docmodifica_tipo, v.exonerado, v.inafecta, v.tipo_pago, d.inafectad FROM detalle_venta d INNER JOIN venta v ON d.idventa=v.idventa LEFT JOIN articulo a ON d.idproducto=a.id WHERE v.idempresa='$row[id]' ORDER BY d.iddetalle_venta ";
*/

$rspta=ejecutarConsulta($datos);	
while ($reg=$rspta->fetch_object()){
	
$sql2="SELECT *FROM persona WHERE idpersona='$reg->txtID_CLIENTE' ";
$cliente= ejecutarConsultaSimpleFila($sql2);	

$tipocambiomon=$reg->tipocambio;
if($reg->tipocambio=='0.000'){
$tipocambiomon='1.000';	
}

$controlpresupuestal='';
$accostos='';


$serienum=$reg->txtSERIE.'-'.$reg->txtNUMERO;

$tdoccli='0';

if($cliente['tipo_documento']=='DNI'){ $tdoccli='1'; }else if($cliente['tipo_documento']=='RUC'){ $tdoccli='6'; }

$fechap = date("Y-m-d", strtotime($reg->txtFECHA_DOCUMENTO));
$fecha= explode('-', $fechap);
$anio= $fecha[2].'/'.$fecha[1].'/'.$fecha[0];
	
$fechaf =explode('-', $reg->fecha_vto);
$fechaf =$fechaf[2].'/'.$fechaf[1].'/'.$fechaf[0];
	
$moneda="S";
$cuenta=$cuentasoles;	
if($reg->txtID_MONEDA=='USD'){ 
$moneda="D";
$cuenta=$cuendolar;
}

$glosa='ASIENTO DE VENTA';

$texto = str_replace($no_permitidas, $permitidas, $cliente['nombre']);
	
$ruccliente=$cliente['txtID_CLIENTE'];
if($cliente['txtID_CLIENTE']=='00000000'){
$ruccliente='99999999'; 
$tdoccli='0';
}
	
$debe=$reg->txtTOTAL;

//if($reg->detraccion>0){ $debe=round($reg->txtTOTAL-$reg->detraccion, 2); }


$haber='0.00';
	
$debe1='0.00';
$haber1=$reg->txtIGV;
$subtotal=$reg->txtSUB_TOTAL;
$debedetalle='0.00';
$haberdetalle=$reg->subtotal;
$exonerado=$reg->exonerado;
$inafecta=$reg->inafecta;
$inafectadetalle=$reg->inafectad;
//echo $reg->inafectad;
$relserie='';
$reltipodoc='';
$relfecha='';
	
if($reg->estado>'2'){
$texto='ANULADA';
$ruccliente='00000000000';
$glosa='ANULADA';
$debe='0.00';
$haber='0.00';
$debe1='0.00';
$haber1='0.00';
$subtotal='0.00';
$haberdetalle='0.00';
$debedetalle='0.00';
$exonerado='0.00';
$inafecta='0.00';
$inafectadetalle='0.00';

}
else if($reg->txtID_TIPO_DOCUMENTO=='07'){
    
$debe='0.00';
$haber=$reg->txtTOTAL;	
$debe1='0.00';
$haber1=$reg->txtIGV;
$debedetalle=$reg->subtotal;
$haberdetalle='0.00';
$inafectadetalle='0.00';
$inafecta='0.00';

$dorel= explode('-', $reg->docmodifica);	
$sqlre="SELECT *FROM venta WHERE txtSERIE='$dorel[0]' AND txtNUMERO='$dorel[1]' AND txtID_TIPO_DOCUMENTO='$reg->docmodifica_tipo' AND idempresa='$row[id]' ";
$relaciona=ejecutarConsultaSimpleFila($sqlre);
	
$relserie=$reg->docmodifica;
$reltipodoc=$reg->docmodifica_tipo;
$relfecha=date("d/m/Y", strtotime($relaciona['txtFECHA_DOCUMENTO']));

}
else if($reg->txtID_TIPO_DOCUMENTO=='08'){

$dorel= explode('-', $reg->docmodifica);	
$sqlre="SELECT *FROM venta WHERE txtSERIE='$dorel[0]' AND txtNUMERO='$dorel[1]' AND txtID_TIPO_DOCUMENTO='$reg->docmodifica_tipo' AND idempresa='$row[id]' ";
$relaciona=ejecutarConsultaSimpleFila($sqlre);
	
$relserie=$reg->docmodifica;
$reltipodoc=$reg->docmodifica_tipo;
$relfecha=date("d/m/Y", strtotime($relaciona['txtFECHA_DOCUMENTO']));

}
	
	
	
		
if($reg->idventa!=$idv2){

$n=$n+1;

$totaldebe=$debe;

/*
DETRACCIONES
*/

$data[]=array(
'origen'=>$origenventa,
'vou'=>''.$n,
'fecha'=>$anio,
'cuenta'=>$cuenta,
'debe'=>''.$totaldebe,
'haber'=>''.$haber,
'moneda'=>$moneda,
'tc'=>$tipocambiomon,
'doc'=>$reg->txtID_TIPO_DOCUMENTO,
'numero'=>$serienum,
'fechad'=>$anio,
'fechav'=>$fechaf,
'codigo'=>$ruccliente,
'cc'=>''.$cc,
'pre'=>'',
'fe'=>'',
'glosa'=>$glosa,
'tl'=>'',
'neto1'=>'',
'neto2'=>'',
'neto3'=>'',
'neto4'=>'',
'neto5'=>'',
'neto6'=>'',
'neto7'=>'',
'neto8'=>'',
'neto9'=>'',
'igv'=>'',
'rdoc'=>$reltipodoc,
'rnum'=>$relserie,
'rfec'=>$relfecha,
'snum'=>'',	
'sfec'=>'',
'ruc'=>$ruccliente,
'rs'=>$texto,
'tipo'=>'2',
'tdoci'=>$tdoccli,
'mpago'=>'',
'ape1'=>'',
'ape2'=>'',
'nombre'=>'',
'tbien'=>'',
'refmonto'=>'0.00'
);
/*UBSTOTA*/	
/*
'neto5'=>''.$exoneradotot,
'neto6'=>''.$inafectatot,
*/

if($inafecta>0){
$subtotal='0.00';
}

$data[]=array(
'origen'=>$origenventa,
'vou'=>''.$n,
'fecha'=>$anio,
'cuenta'=>$ctaigv,
'debe'=>''.$debe1,
'haber'=>''.$haber1,
'moneda'=>$moneda,
'tc'=>$tipocambiomon,
'doc'=>$reg->txtID_TIPO_DOCUMENTO,
'numero'=>$serienum,
'fechad'=>$anio,
'fechav'=>$fechaf,
'codigo'=>$ruccliente,
'cc'=>''.$cc,
'pre'=>'',
'fe'=>'',
'glosa'=>$glosa,
'tl'=>'V',
'neto1'=>'',/*.$subtotal,*/
'neto2'=>'',
'neto3'=>'',
'neto4'=>'',
'neto5'=>''.$exonerado,
'neto6'=>''.$inafecta,
'neto7'=>'',
'neto8'=>'',
'neto9'=>'',
'igv'=>''.$haber1,
'rdoc'=>$reltipodoc,
'rnum'=>$relserie,
'rfec'=>$relfecha,
'snum'=>'',	
'sfec'=>'',
'ruc'=>$ruccliente,
'rs'=>$texto,
'tipo'=>'2',
'tdoci'=>$tdoccli,
'mpago'=>'',
'ape1'=>'',
'ape2'=>'',
'nombre'=>'',
'tbien'=>'',
'refmonto'=>'0.00'
);

$idv2=$reg->idventa;
}


$cuentaprod=$reg->cta_ventas;
if($cuentaprod==''){ $cuentaprod='7011111'; }
$glosadescp= str_replace($no_permitidas, $permitidas, $reg->nombreproducto);

$data[]=array(
'origen'=>$origenventa,
'vou'=>''.$n,
'fecha'=>$anio,
'cuenta'=>$cuentaprod,
'debe'=>''.$debedetalle,
'haber'=>''.$haberdetalle,
'moneda'=>$moneda,
'tc'=>$tipocambiomon,
'doc'=>$reg->txtID_TIPO_DOCUMENTO,
'numero'=>$serienum,
'fechad'=>$anio,
'fechav'=>$fechaf,
'codigo'=>$ruccliente,
'cc'=>''.$cc,
'pre'=>''.$controlpresupuestal,
'fe'=>'',
'glosa'=>$glosadescp,
'tl'=>'',
'neto1'=>'',
'neto2'=>'',
'neto3'=>'',
'neto4'=>'',
'neto5'=>'',
'neto6'=>''.$inafectadetalle,
'neto7'=>'',
'neto8'=>'',
'neto9'=>'',
'igv'=> '',
'rdoc'=>$reltipodoc,
'rnum'=>$relserie,
'rfec'=>$relfecha,
'snum'=>'',	
'sfec'=>'',
'ruc'=>$ruccliente,
'rs'=>$texto,
'tipo'=>'2',
'tdoci'=>$tdoccli,
'mpago'=>'',
'ape1'=>'',
'ape2'=>'',
'nombre'=>'',
'tbien'=>'',
'refmonto'=>'0.00'
);

 }
//$idv2='0';/**que es eso? eso es para no repetir una columna */
$idv2='0';
$n=0;
/*CUENTAS POR COBRAR*/

/*
$datos3 = "SELECT v.txtID_CLIENTE, v.txtSERIE, v.txtNUMERO, c.fecha, c.fechaoperacion, v.txtFECHA_DOCUMENTO, v.txtID_MONEDA, c.idtipo, c.moneda, c.montosoles, c.montodolares, c.tipocambio, v.txtID_TIPO_DOCUMENTO, c.operacion, v.txtTOTAL, v.fecha_vto, c.otrospagos, v.detraccion, v.retencion, v.idventa AS idventa2, c.id, v.detraccion FROM caja_ventapago c LEFT JOIN venta v ON c.idventa=v.idventa WHERE DATE(c.fecha_pago)>='$fecha_inicio' AND DATE(c.fecha_pago)<='$fecha_fin' AND (v.estado='0' OR v.estado='1' OR v.estado='2' ) AND (v.txtID_TIPO_DOCUMENTO='03' OR v.txtID_TIPO_DOCUMENTO='01') AND c.idempresa='$row[id]' AND c.estado='1' AND c.nivel='0' ORDER BY c.fecha ASC ";
$datos = ejecutarConsulta($datos3);

//echo $datos3;


while($dato=mysqli_fetch_array($datos)) {
	
$sql2="SELECT *FROM persona WHERE idpersona='$dato[txtID_CLIENTE]' ";
$cliente= ejecutarConsultaSimpleFila($sql2);

$serienum=$dato['txtSERIE'].'-'.$dato['txtNUMERO'];

if($cliente['tipo_documento']=='DNI'){ $tdoccli='1'; }else{ $tdoccli='6'; }
			
$fechat= date("Y-m-d", strtotime($dato['fecha']));
$vantatit='COBRANZA';

$anio= date("d/m/Y", strtotime($dato['fecha_pago']));
	
$fechadocini= date("Y-m-d", strtotime($dato['fecha_pago']));	

$sqlca="SELECT *FROM tipo_cambio WHERE fecha='$fechadocini' ";
$conca= ejecutarConsultaSimpleFila($sqlca);

if($dato['txtID_MONEDA']=='PEN'){ $moneda="S"; $monedag=$cons['venta']; }else{ $moneda="D"; $monedag=$cons['igv']; }

$asientov='ASIENTO DE VENTA';
	
$texto = str_replace($no_permitidas, $permitidas, $cliente['nombre']);
	
$sqlcat="SELECT *FROM caja_tipopago WHERE id='$dato[idtipo]' ";
$cajatipo= ejecutarConsultaSimpleFila($sqlcat);	
	
if($dato['moneda']=='PEN'){
$totalmonto=$dato['montosoles'];
$monedad="S";
$cuenta=$cajatipo['cuentasoles'];
}else{ 
$totalmonto=$dato['montodolares']; 
$monedad="D";
$cuenta=$cajatipo['cuentadolares'];
}


//if($dato['otrospagos']=='1'){
//$cuenta=$cons['ctadetraccion']; 
//}else if($dato['otrospagos']=='2'){ 
//$cuenta=$cons['ctaretencion']; 
//}


if($conca['venta']){ $tc=$conca['venta']; }else{ $tc=$dato['tipocambio']; }

$totalpago=$dato['txtTOTAL']; 

if($dato['idventa2']!=$idv2){

$n=$n+1;

//DETRACCION
if($dato['detraccion']>0&&$dato['otrospagos']=='1'){
    
$data[]=array(
'origen'=>$origencobrarf,
'vou'=>''.$n,
'fecha'=>date("d/m/Y", strtotime($dato['fechaoperacion'])),
'cuenta'=>$cuentadetraccion,
'debe'=>''.'0.00',
'haber'=>''.$dato['detraccion'],
'moneda'=>$moneda,
'tc'=>$dato['tipocambio'],
'doc'=>$dato['txtID_TIPO_DOCUMENTO'],
'numero'=>$serienum,
'fechad'=>date("d/m/Y", strtotime($dato['txtFECHA_DOCUMENTO'])),
'fechav'=>date("d/m/Y", strtotime($dato['fecha_vto'])),
'codigo'=>$cliente['txtID_CLIENTE'],
'cc'=>'',
'pre'=>'',
'fe'=>'',
'glosa'=>'DETRACCION',
'tl'=>'',
'neto1'=>'',
'neto2'=>'',
'neto3'=>'',
'neto4'=>'',
'neto5'=>'',
'neto6'=>'',
'neto7'=>'',
'neto8'=>'',
'neto9'=>'',
'igv'=>'',
'rdoc'=>'',
'rnum'=>'',
'rfec'=>'',
'snum'=>'',	
'sfec'=>'',
'ruc'=>$cliente['txtID_CLIENTE'],
'rs'=>$texto,
'tipo'=>'2',
'tdoci'=>$cajatipo['tiposunat'],
'mpago'=>'',
'ape1'=>'',
'ape2'=>'',
'nombre'=>'',
'tbien'=>'',
'refmonto'=>'0.00'
);

}else{
 

$data[]=array(
'origen'=>$origencobrarf,
'vou'=>''.$n,
'fecha'=>date("d/m/Y", strtotime($dato['fechaoperacion'])),
'cuenta'=>$ccostos,
'debe'=>'0.00',
'haber'=>''.round($totalpago, 2),
'moneda'=>$moneda,
'tc'=>$dato['tipocambio'],
'doc'=>$dato['txtID_TIPO_DOCUMENTO'],
'numero'=>$serienum,
'fechad'=>date("d/m/Y", strtotime($dato['txtFECHA_DOCUMENTO'])),
'fechav'=>date("d/m/Y", strtotime($dato['fecha_vto'])),
'codigo'=>$cliente['txtID_CLIENTE'],
'cc'=>'',
'pre'=>'',
'fe'=>'',
'glosa'=>$vantatit,
'tl'=>'',
'neto1'=>'',
'neto2'=>'',
'neto3'=>'',
'neto4'=>'',
'neto5'=>'',
'neto6'=>'',
'neto7'=>'',
'neto8'=>'',
'neto9'=>'',
'igv'=>'',
'rdoc'=>'',
'rnum'=>'',
'rfec'=>'',
'snum'=>'',
'sfec'=>'',
'ruc'=>$cliente['txtID_CLIENTE'],
'rs'=>$texto,
'tipo'=>'2',
'tdoci'=>$tdoccli,
'mpago'=>$cajatipo['tiposunat'],
'ape1'=>'',
'ape2'=>'',
'nombre'=>'',
'tbien'=>'',
'refmonto'=>'0.00'
);

 
    
}


$idv2=$dato['idventa2'];
}

$data[]=array(
'origen'=>$origencobrarf,
'vou'=>''.$n,
'fecha'=>date("d/m/Y", strtotime($dato['fechaoperacion'])),
'cuenta'=>$cuenta,
'debe'=>''.$totalmonto,
'haber'=>'0.00',
'moneda'=>$moneda,
'tc'=>$dato['tipocambio'],
'doc'=>'00',
'numero'=>$dato['operacion'],
'fechad'=>date("d/m/Y", strtotime($dato['txtFECHA_DOCUMENTO'])),
'fechav'=>date("d/m/Y", strtotime($dato['fechaoperacion'])),
'codigo'=>$cliente['txtID_CLIENTE'],
'cc'=>'',
'pre'=>'',
'fe'=>'O101',
'glosa'=>$vantatit,
'tl'=>'',
'neto1'=>'',
'neto2'=>'',
'neto3'=>'',
'neto4'=>'',
'neto5'=>'',
'neto6'=>'',
'neto7'=>'',
'neto8'=>'',
'neto9'=>'',
'igv'=>'',
'rdoc'=>$cajatipo['tipo'],
'rnum'=>$dato['operacion'],
'rfec'=>date("d/m/Y", strtotime($dato['fecha'])),
'snum'=>'',
'sfec'=>date("d/m/Y", strtotime($dato['fecha'])),
'ruc'=>$cliente['txtID_CLIENTE'],
'rs'=>$texto,
'tipo'=>'2',
'tdoci'=>$tdoccli,
'mpago'=>$cajatipo['tiposunat'],
'ape1'=>'',
'ape2'=>'',
'nombre'=>'',
'tbien'=>'',
'refmonto'=>'0.00'
);




}
*/

/*LAS COMPRAS*/
$n=0;


  
$datos = "SELECT  i.idproveedor, i.fecha_hora, i.num_comprobante, i.serie_comprobante, i.fechaven, i.igv, i.total_compra, i.subtotal, d.descripcion, i.idingreso, i.tipo_comprobante, d.igv AS igvdetalle, d.subtotal AS subtotaldetalle, i.moneda, i.idingreso AS idingresfinal, i.exonerado, d.cuentacompra, d.txtCOD_ARTICULO FROM detalle_ingreso d INNER JOIN ingreso i ON d.idingreso=i.idingreso LEFT JOIN articulo a ON d.txtCOD_ARTICULO=a.id WHERE DATE(i.fechaven)>='$fecha_inicio'  AND DATE(i.fechaven)<='$fecha_fin' AND i.estado='0' 
AND i.tipo_comprobante!='17' AND i.tipo_comprobante!='99' AND i.tipo_comprobante!='16' AND i.idempresa='$row[id]' AND d.idempresa='$row[id]' AND (i.nivel='0' OR i.nivel='1')
GROUP BY iddetalle_ingreso ORDER BY fecha_hora ASC ";
    


//echo $datos;


$rspta2=ejecutarConsulta($datos);

while ($reg=$rspta2->fetch_object()){

$sql2="SELECT *FROM persona WHERE idpersona='$reg->idproveedor' ";
$cliente= ejecutarConsultaSimpleFila($sql2);	

$serienum=$reg->serie_comprobante.'-'.$reg->num_comprobante;

$tdoccli='0';

if($cliente['tipo_documento']=='DNI'){ $tdoccli='1'; }else if($cliente['tipo_documento']=='RUC'){ $tdoccli='6'; }

$fechap = date("Y-m-d", strtotime($reg->fecha_hora));
$fecha= explode('-', $fechap);
$anio= $fecha[2].'/'.$fecha[1].'/'.$fecha[0];
	
$fechaf =explode('-', $reg->fechaven);
$fechaf =$fechaf[2].'/'.$fechaf[1].'/'.$fechaf[0];

$sqlca="SELECT *FROM tipo_cambio WHERE fecha='$fechap' ";
$conca= ejecutarConsultaSimpleFila($sqlca);
$tc=$conca['venta'];

$moneda="S";
$cuenta=$cuentacompraoles;	
if($reg->moneda=='USD'){ 
$moneda="D";
$cuenta=$cuentacompradolar;
}

if(!$conca){
$tc='1.000';
}


$ccostos='';
$controlpresupuestal='';

$glosa='ASIENTO DE COMPRA';
$texto = str_replace($no_permitidas, $permitidas, $cliente['nombre']);

$ruccliente=$cliente['txtID_CLIENTE'];
if($cliente['txtID_CLIENTE']=='00000000'){
$ruccliente='999999999999'; 
$tdoccli='0';
}

if($reg->idingresfinal!=$idv2){

$n=$n+1;

$totalcompra=$reg->total_compra;

if($reg->detracciones>0){
$totalcompra=round($reg->total_compra-$reg->detracciones, 2);
}

$data[]=array(
'origen'=>$origencompra,
'vou'=>''.$n,
'fecha'=>$fechaf,
'cuenta'=>$cuenta,
'debe'=>'0.00',
'haber'=>''.$totalcompra,
'moneda'=>$moneda,
'tc'=>$tc,
'doc'=>''.$reg->tipo_comprobante,
'numero'=>$serienum,
'fechad'=>$anio,
'fechav'=>$anio,
'codigo'=>$ruccliente,
'cc'=>''.$cc,
'pre'=>'',
'fe'=>'',
'glosa'=>$glosa,
'tl'=>'',
'neto1'=>'',
'neto2'=>'',
'neto3'=>'',
'neto4'=>'',
'neto5'=>'',
'neto6'=>'',
'neto7'=>'',
'neto8'=>'',
'neto9'=>'',
'igv'=>'',
'rdoc'=>'',
'rnum'=>'',
'rfec'=>'',
'snum'=>'',	
'sfec'=>'',
'ruc'=>$ruccliente,
'rs'=>$texto,
'tipo'=>'1',
'tdoci'=>$tdoccli,
'mpago'=>'',
'ape1'=>'',
'ape2'=>'',
'nombre'=>'',
'tbien'=>'',
'refmonto'=>'0.00'
);
//CUENTA IGV CUENTA 40	
$data[]=array(
'origen'=>$origencompra,
'vou'=>''.$n,
'fecha'=>$fechaf,
'cuenta'=>$ctaigv,
'debe'=>''.$reg->igv,
'haber'=>'0.00',
'moneda'=>$moneda,
'tc'=>$tc,
'doc'=>''.$reg->tipo_comprobante,
'numero'=>$serienum,
'fechad'=>$anio,
'fechav'=>$anio,
'codigo'=>$ruccliente,
'cc'=>'',
'pre'=>'',
'fe'=>'',
'glosa'=>$glosa,
'tl'=>'C',
'neto1'=>''.$reg->subtotal,
'neto2'=>'',
'neto3'=>'',
'neto4'=>'',
'neto5'=>'',
'neto6'=>''.$reg->exonerado,
'neto7'=>'',
'neto8'=>'',
'neto9'=>'',
'igv'=>''.$reg->igv,
'rdoc'=>'',
'rnum'=>'',
'rfec'=>'',
'snum'=>'',	
'sfec'=>'',
'ruc'=>$ruccliente,
'rs'=>$texto,
'tipo'=>'1',
'tdoci'=>$tdoccli,
'mpago'=>'',
'ape1'=>'',
'ape2'=>'',
'nombre'=>'',
'tbien'=>'',
'refmonto'=>'0.00'
);

//CUENTA PERCEPCIONES CUENTA 40	
if($reg->percepcion!='0.00'){
$data[]=array(
'origen'=>$origencompra,
'vou'=>''.$n,
'fecha'=>$fechaf,
'cuenta'=>$percepcioncompra40,
'debe'=>''.$reg->igv,
'haber'=>'0.00',
'moneda'=>$moneda,
'tc'=>$tc,
'doc'=>''.$reg->tipo_comprobante,
'numero'=>$serienum,
'fechad'=>$anio,
'fechav'=>$anio,
'codigo'=>$ruccliente,
'cc'=>'',
'pre'=>'',
'fe'=>'',
'glosa'=>$glosa,
'tl'=>'C',
'neto1'=>''.$reg->subtotal,
'neto2'=>'',
'neto3'=>'',
'neto4'=>'',
'neto5'=>'',
'neto6'=>''.$reg->exonerado,
'neto7'=>'',
'neto8'=>'',
'neto9'=>'',
'igv'=>''.$reg->igv,
'rdoc'=>'',
'rnum'=>'',
'rfec'=>'',
'snum'=>'',	
'sfec'=>'',
'ruc'=>$ruccliente,
'rs'=>$texto,
'tipo'=>'1',
'tdoci'=>$tdoccli,
'mpago'=>'',
'ape1'=>'',
'ape2'=>'',
'nombre'=>'',
'tbien'=>'',
'refmonto'=>'0.00'
);
}


if($reg->detracciones>0){

 $data[]=array(
'origen'=>$origencompra,
'vou'=>''.$n,
'fecha'=>$fechaf,
'cuenta'=>$cons['detraccioncompras'],
'debe'=>'0.00',
'haber'=>''.$reg->detracciones,
'moneda'=>$moneda,
'tc'=>$tc,
'doc'=>''.$reg->tipo_comprobante,
'numero'=>$serienum,
'fechad'=>$anio,
'fechav'=>$anio,
'codigo'=>$ruccliente,
'cc'=>$ccostos.'',
'pre'=>''.$controlpresupuestal,
'fe'=>'',
'glosa'=>'DETRACCION',
'tl'=>'',
'neto1'=>'',
'neto2'=>'',
'neto3'=>'',
'neto4'=>'',
'neto5'=>'',
'neto6'=>'',
'neto7'=>'',
'neto8'=>'',
'neto9'=>'',
'igv'=> '',
'rdoc'=>'',
'rnum'=>'',
'rfec'=>'',
'snum'=>'',	
'sfec'=>'',
'ruc'=>$ruccliente,
'rs'=>$texto,
'tipo'=>'1',
'tdoci'=>$tdoccli,
'mpago'=>'',
'ape1'=>'',
'ape2'=>'',
'nombre'=>'',
'tbien'=>'',
'refmonto'=>'0.00'
);  
}


$idv2=$reg->idingresfinal;
}

$cuentaprod=$reg->cuentacompra;
if($cuentaprod==''){ 
    
$sqlart="SELECT *FROM articulo WHERE txtCOD_ARTICULO='$reg->txtCOD_ARTICULO' ";
$art= ejecutarConsultaSimpleFila($sqlart);

if($art['ctacompras']==''){ 
$cuentaprod='60112'; 
}else{
$cuentaprod=$art['ctacompras'];
}

}
$glosadescp= str_replace($no_permitidas, $permitidas, $reg->descripcion);

$data[]=array(
'origen'=>$origencompra,
'vou'=>''.$n,
'fecha'=>$fechaf,
'cuenta'=>$cuentaprod,
'debe'=>''.$reg->subtotaldetalle,
'haber'=>'0.00',
'moneda'=>$moneda,
'tc'=>$tc,
'doc'=>''.$reg->tipo_comprobante,
'numero'=>$serienum,
'fechad'=>$anio,
'fechav'=>$anio,
'codigo'=>$ruccliente,
'cc'=>$ccostos.'',
'pre'=>''.$controlpresupuestal,
'fe'=>'',
'glosa'=>$glosadescp,
'tl'=>'',
'neto1'=>'',
'neto2'=>'',
'neto3'=>'',
'neto4'=>'',
'neto5'=>'',
'neto6'=>'',
'neto7'=>'',
'neto8'=>'',
'neto9'=>'',
'igv'=> '',
'rdoc'=>'',
'rnum'=>'',
'rfec'=>'',
'snum'=>'',	
'sfec'=>'',
'ruc'=>$ruccliente,
'rs'=>$texto,
'tipo'=>'1',
'tdoci'=>$tdoccli,
'mpago'=>'',
'ape1'=>'',
'ape2'=>'',
'nombre'=>'',
'tbien'=>'',
'refmonto'=>'0.00'
);





}

function fechaCastellano ($fecha) {
  $fecha = substr($fecha, 0, 10);
  $numeroDia = date('d', strtotime($fecha));
  $dia = date('l', strtotime($fecha));
  $mes = date('F', strtotime($fecha));
  $anio = date('Y', strtotime($fecha));
  $dias_ES = array("Lunes", "Martes", "Miércoles", "Jueves", "Viernes", "Sábado", "Domingo");
  $dias_EN = array("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday");
  $nombredia = str_replace($dias_EN, $dias_ES, $dia);
$meses_ES = array("ENERO", "FEBRERO", "MARZO", "ABRIL", "MAYO", "JUNIO", "JULIO", "AGOSTO", "SEPTIEMBRE", "OCTUBRE", "NOVIEMBRE", "Diciembre");
  $meses_EN = array("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December");
  $nombreMes = str_replace($meses_EN, $meses_ES, $mes);
  return " ".$nombreMes." ".$anio;
}

$origencompraactivo='90';
$origen='05';
$vantatit='DEPRECIACION DEL MES';
$compratit='COMPRA ACTIVO DEL MES';
/*ACTIVOS DEPRECIACION */

$fechainiact=date("Y-m", strtotime($fecha_inicio));
$fechafinact=date("Y-m", strtotime($fecha_fin));



	
/*
AQUI TERMINA PLKANILLAS
*/	


/*PLANILLAS VACAICONES*/
/*
$nnnn='0';
$vantatit='PLANILLAS VACACIONES DE '.$periodonombre;
$porciones = explode("-", $fecha_fin);

$results=ejecutarConsulta("SELECT *FROM planilla_mensual WHERE periodo>='$finicio' AND periodo<='$ffin' AND idempresa='$row[id]' AND estado='0' AND nivel='1' ");

while ($reg=$results->fetch_object()){
 
 
$sqlem="SELECT *FROM planilla_empleados WHERE id='$reg->idempleado' AND YEAR(fechavac)='$porciones[0]' AND MONTH(fechavac)='$porciones[1]' AND estado='1' ";
$empl= ejecutarConsultaSimpleFila($sqlem);
 
 if($empl){

$nnnn=$nnnn+1;
	
$sqlem="SELECT *FROM planilla_empleados WHERE id='$reg->idempleado' AND estado='1' ";
$persac= ejecutarConsultaSimpleFila($sqlem);
$texto = str_replace($no_permitidas, $permitidas, $persac['paterno'].' '.$persac['materno'].' '.$persac['nombres']);

$data[]=array(
'origen'=>$origen,
'vou'=>''.$nnn,
'fecha'=>$fechames,
'cuenta'=>$ctadebe,
'debe'=>''.$reg->remuneracion,
'haber'=>'0.00',
'moneda'=>$moneda,
'tc'=>$tcambio,
'doc'=>'',
'numero'=>'',
'fechad'=>$fechames,
'fechav'=>$fechames,
'codigo'=>$persac['txtID_CLIENTE'],
'cc'=>'',
'pre'=>'',
'fe'=>'O101',
'glosa'=>$vantatit,
'tl'=>'',
'neto1'=>'',
'neto2'=>'',
'neto3'=>'',
'neto4'=>'',
'neto5'=>'',
'neto6'=>'',
'neto7'=>'',
'neto8'=>'',
'neto9'=>'',
'igv'=>'',
'rdoc'=>'',
'rnum'=>'',
'rfec'=>'',
'snum'=>'',
'sfec'=>'',
'ruc'=>$persac['numero'],
'rs'=>$texto,
'tipo'=>'',
'tdoci'=>$tipodoccli,
'mpago'=>'',
'ape1'=>'',
'ape2'=>'',
'nombre'=>'',
'tbien'=>''
);

$data[]=array(
'origen'=>$origen,
'vou'=>''.$nnn,
'fecha'=>$fechames,
'cuenta'=>$ctahaber,
'debe'=>'0.00',
'haber'=>''.$reg->remuneracion,
'moneda'=>$moneda,
'tc'=>$tcambio,
'doc'=>'',
'numero'=>'',
'fechad'=>$fechames,
'fechav'=>$fechames,
'codigo'=>$persac['txtID_CLIENTE'],
'cc'=>'',
'pre'=>'',
'fe'=>'O101',
'glosa'=>$vantatit,
'tl'=>'',
'neto1'=>'',
'neto2'=>'',
'neto3'=>'',
'neto4'=>'',
'neto5'=>'',
'neto6'=>'',
'neto7'=>'',
'neto8'=>'',
'neto9'=>'',
'igv'=>'',
'rdoc'=>'',
'rnum'=>'',
'rfec'=>'',
'snum'=>'',
'sfec'=>'',
'ruc'=>$persac['numero'],
'rs'=>$texto,
'tipo'=>'',
'tdoci'=>$tipodoccli,
'mpago'=>'',
'ape1'=>'',
'ape2'=>'',
'nombre'=>'',
'tbien'=>''
);
$nnnn=$nnnn+1;


}
   
}
*/ 		
header('Content-Type: application/json');	
echo json_encode($data);

exit();
    
}
/*PARA GRAND PRIX*/
if($ruce  == '20393579413' || $ruce =='20604312052' || $ruce == '20605279628' || $ruce =='20605704761' || $ruce == '20101063110' || $ruce == '20477863478' || $ruce == '20602020399' || $ruce == '10415898890')
{
//Ip de la pc servidor de base de datos
define("DB_HOST","52.144.46.42"); // HOST DEL MYSQL
//Nombre de la base de datos
define("DB_NAME", "siscont_erp"); // NOMBRE DE LA BASE DE DATOS siscont_erp
//Usuario de la base de datos
define("DB_USERNAME", "siscont_erp"); //USUARIO DE BASE DE DATOS siscont_erp
//Contraseña del usuario de la base de datos
define("DB_PASSWORD", "ZNnEcrjWzeEGfJ8D"); //CONTRASEÑA DE LA BASE DE DATOS
//definimos la codificación de los caracteres
define("DB_ENCODE","utf8");//Definimos una constante como nombre del proyecto

$conexion = new mysqli(DB_HOST,DB_USERNAME,DB_PASSWORD,DB_NAME);

mysqli_query( $conexion, 'SET NAMES "'.DB_ENCODE.'"');

//Si tenemos un posible error en la conexión lo mostramos
if (mysqli_connect_errno())
{
    printf("Falló conexión a la base de datos: %s\n",mysqli_connect_error());
    exit();
}

if (!function_exists('ejecutarConsulta'))
{
    function ejecutarConsulta($sql)
    {
        global $conexion;
        $query = $conexion->query($sql);
        return $query;
    }

    function ejecutarConsultaSimpleFila($sql){
        global $conexion;
        $query = $conexion->query($sql);
        $row = $query->fetch_assoc();
        return $row;
    }

    function ejecutarConsulta_retornarID($sql)
    {
        global $conexion;
        $query = $conexion->query($sql);
        return $conexion->insert_id;
    }

    function limpiarCadena($str)
    {
        global $conexion;
        $str = mysqli_real_escape_string($conexion,trim($str));
        //para cambiar & comillas apostrofes
        //return htmlspecialchars($str, ENT_COMPAT);
        return $str;
    }
}
  
$no_permitidas= array ("á","é","í","ó","ú","Á","É","Í","Ó","Ú","À","Ã","Ì","Ò","Ù","Ã™","Ã ","Ã¨","Ã¬","Ã²","Ã¹","ç","Ç","Ã¢","ê","Ã®","Ã´","Ã»","Ã", "ÃŠ", "ÃŽ", "Ã", "Ã›", "ü","Ã¶", "Ã–","Ã¯","Ã¤","«","Ò","Ã","Ã","Ã‹","*","%", "'", '"', '<b>', '</b>', '&amp;');
$permitidas= array ("a","e","i","o","u","A","E","I","O","U","N","A","E","I","O","U","a","e","i","o","u","c","C","a","e","i","o","u","A","E","I","O","U","u","o","O","i", "a", "e", "U", "I", "A", "E", ".", ".", "", "", '', '', 'Y');
    		
if(isset($_GET['fechai'])){  $fecha_inicio=$_REQUEST["fechai"]; }else{ $fecha_inicio=''; }
if(isset($_GET['fechaf'])){  $fecha_fin=$_REQUEST["fechaf"]; }else{ $fecha_fin=''; }
$ruc=$_REQUEST["ruc"];
	
//echo $ruc;
	
	
$myArray= explode('-', $fecha_fin);
$fechatot=$myArray[0].'-'.$myArray[1];
		
$sql="SELECT *FROM config WHERE ruc='$ruc'";
$row=ejecutarConsultaSimpleFila($sql);

$sqls="SELECT *FROM config_contabilidad WHERE idempresa='$row[id]' ";
$cons= ejecutarConsultaSimpleFila($sqls);
		
$origenventa=$cons['venta'];
$ctaingreso='70111';
$ctaigv=$cons['cps'];
$ccostos=$cons['cpd'];

$cuentasoles=$cons['cpd'];
$cuendolar=$cons['igv'];

$origencompra=$cons['pago'];

$percepcioncompra40='';

$cuentacompraoles=$cons['ccomprassoles'];
$cuentacompradolar=$cons['ccomprasdolares'];
$cuentadetraccion=$cons['ctadetraccion'];
$cuentaretencion=$cons['ctaretencion'];

$ctaperceipcion12='';
$ctaperceipcion40='';

$origencobrarf='';
$detraccioncompras=$cons['detraccioncompras'];

$n=0;


$f = explode('-',$fecha_inicio);
$mesvou = $f[1];
$aniovou = $f[0];

$sqlvou="SELECT *FROM tbl_vou WHERE idempresa= '$row[id]' AND origen ='$origenventa' AND mes='$mesvou' AND anio = '$aniovou'";

//echo $sqlvou;
$vouorigen= ejecutarConsultaSimpleFila($sqlvou);

if($vouorigen['vou']!='')
{
  $n = $vouorigen['vou'] +  1;

}
else
{

$sqlemp="SELECT *FROM config WHERE ruc= '$ruce'";
$empr= ejecutarConsultaSimpleFila($sqlemp);
$idempr = $empr['id'];
$sql="INSERT INTO  tbl_vou  VALUES (NULL, '$idempr', '$origenventa','$n','$mesvou','$aniovou')";
$rspta=ejecutarConsulta($sql);
}


$data= Array();
/*VENTAS*/
$datos = "SELECT  v.txtID_MONEDA, v.txtNUMERO, v.detraccion, v.retencion, v.percepcion, v.txtSERIE, v.txtID_CLIENTE, v.txtFECHA_DOCUMENTO, d.idproducto, a.ctaventas, v.tipocambio, v.txtID_TIPO_DOCUMENTO, v.txtTOTAL, v.txtIGV, v.txtSUB_TOTAL, d.subtotal, d.nombreproducto, v.idventa, v.fecha_vto, v.estado, v.docmodifica, v.docmodifica_tipo, v.sector, v.controlpresupuestal, v.exonerado, v.inafecta, v.tipo_pago, v.detraccion, d.inafectad,v.txtOBSERVACION as glosa
    FROM detalle_venta d 
    INNER JOIN venta v ON d.idventa=v.idventa LEFT JOIN articulo a ON d.idproducto=a.txtCOD_ARTICULO WHERE DATE(v.txtFECHA_DOCUMENTO)>='$fecha_inicio' AND DATE(v.txtFECHA_DOCUMENTO)<='$fecha_fin'  AND v.idempresa='$row[id]'  AND (v.txtID_TIPO_DOCUMENTO='03' OR v.txtID_TIPO_DOCUMENTO='01' OR v.txtID_TIPO_DOCUMENTO='07' OR v.txtID_TIPO_DOCUMENTO='08' ) ORDER BY d.iddetalle_venta ";
    
//echo $datos;exit();
$rspta=ejecutarConsulta($datos);	
while ($reg=$rspta->fetch_object())
{
	
$sql2="SELECT *FROM persona WHERE idpersona='$reg->txtID_CLIENTE' ";
$cliente= ejecutarConsultaSimpleFila($sql2);	

$tipocambiomon=$reg->tipocambio;
if($reg->tipocambio=='0.000'){
$tipocambiomon='1.000';	
}

$controlpresupuestal='';
$accostos='';


$serienum=$reg->txtSERIE.'-'.$reg->txtNUMERO;

$tdoccli='0';

if($cliente['tipo_documento']=='DNI'){ $tdoccli='1'; }
else if($cliente['tipo_documento']=='RUC'){ $tdoccli='6'; }

$fechap = date("Y-m-d", strtotime($reg->txtFECHA_DOCUMENTO));
$fecha= explode('-', $fechap);
$anio= $fecha[2].'/'.$fecha[1].'/'.$fecha[0];
	
$fechaf =explode('-', $reg->fecha_vto);
$fechaf =$fechaf[2].'/'.$fechaf[1].'/'.$fechaf[0];
	
$moneda="S";
$cuenta=$cuentasoles;	
if($reg->txtID_MONEDA=='USD'){ 
$moneda="D";
$cuenta=$cuendolar;
}
/*CENTRO DE COSTOS*/
if($reg->sector!='0'){
$sqlcac="SELECT *FROM categoria WHERE idcategoria='$reg->sector' ";
$cacostos= ejecutarConsultaSimpleFila($sqlcac);
$accostos=$cacostos['ctaventas'];
}

/*CONTROL PRESUPUESTAL*/
if($reg->controlpresupuestal!='0'){
$sqlcontrol="SELECT *FROM categoria WHERE idcategoria='$reg->controlpresupuestal' ";
$controlpres= ejecutarConsultaSimpleFila($sqlcontrol);
$controlpresupuestal=$controlpres['ctaventas'];
}

if($ruc == '20602020399')
{
$glosa=$reg->glosa;
$glosa = substr($glosa,0,60);
if($controlpresupuestal == '01G00001')
{
$accostos='0100';
}
else if($controlpresupuestal == '02G00001')
{
$accostos='0200';
}
else if($controlpresupuestal == '03G00001')
{
$accostos='0300';
}
else if($controlpresupuestal == '04G00001')
{
$accostos='0400';
}
else if($controlpresupuestal == '05G00001')
{
$accostos='0500';
}
else if($controlpresupuestal == '06G00001')
{
$accostos='0600';
}


}
else
{
  $glosa=$reg->nombreproducto;  
}

//echo $glosa;exit();


$texto = str_replace($no_permitidas, $permitidas, $cliente['nombre']);
	
$ruccliente=$cliente['txtID_CLIENTE'];
if($cliente['txtID_CLIENTE']=='00000000'){
$ruccliente='99999999'; 
$tdoccli='0';
}
	
$debe=$reg->txtTOTAL;

//if($reg->detraccion>0){ $debe=round($reg->txtTOTAL-$reg->detraccion, 2); }


$haber='0.00';
	
$debe1='0.00';
$haber1=$reg->txtIGV;
$subtotal=$reg->txtSUB_TOTAL;
$debedetalle='0.00';
$haberdetalle=$reg->subtotal;
$exonerado=$reg->exonerado;
$inafecta=$reg->inafecta;
$inafectadetalle=$reg->inafectad;
//echo $reg->inafectad;
$relserie='';
$reltipodoc='';
$relfecha='';

$fechatc = substr($reg->txtFECHA_DOCUMENTO,0,10);
$sqltc = "SELECT * FROM tipo_cambio where fecha ='$fechatc'";
$dattc = ejecutarConsultaSimpleFila($sqltc);
$tipocambiomon = $dattc['venta'];


if($reg->estado>'2')
{
$texto='ANULADA';
$ruccliente='00000000000';
$glosa='ANULADA';
$debe='0.00';
$haber='0.00';
$debe1='0.00';
$haber1='0.00';
$subtotal='0.00';
$haberdetalle='0.00';
$debedetalle='0.00';
$exonerado='0.00';
$inafecta='0.00';
$inafectadetalle='0.00';

}
else if($reg->txtID_TIPO_DOCUMENTO=='07'){
    
$debe='0.00';
$haber=$reg->txtTOTAL;	
$haber1='0.00';
$debe1=$reg->txtIGV;
$debedetalle=$reg->subtotal;
$haberdetalle='0.00';
$inafectadetalle='0.00';
$inafecta='0.00';

$dorel= explode('-', $reg->docmodifica);	
$sqlre="SELECT *FROM venta WHERE txtSERIE='$dorel[0]' AND txtNUMERO='$dorel[1]' AND txtID_TIPO_DOCUMENTO='$reg->docmodifica_tipo' AND idempresa='$row[id]' ";
$relaciona=ejecutarConsultaSimpleFila($sqlre);
	
$relserie=$reg->docmodifica;
$reltipodoc=$reg->docmodifica_tipo;
$relfecha=date("d/m/Y", strtotime($relaciona['txtFECHA_DOCUMENTO']));

}
else if($reg->txtID_TIPO_DOCUMENTO=='08'){

$dorel= explode('-', $reg->docmodifica);	
$sqlre="SELECT *FROM venta WHERE txtSERIE='$dorel[0]' AND txtNUMERO='$dorel[1]' AND txtID_TIPO_DOCUMENTO='$reg->docmodifica_tipo' AND idempresa='$row[id]' ";
$relaciona=ejecutarConsultaSimpleFila($sqlre);
	
$relserie=$reg->docmodifica;
$reltipodoc=$reg->docmodifica_tipo;
$relfecha=date("d/m/Y", strtotime($relaciona['txtFECHA_DOCUMENTO']));

}
		
if($reg->idventa!=$idv2){

$n = $n+1;

$totaldebe=$debe;

/*
DETRACCIONES
*/

    if($row['id']!='51')
    {
    if($reg->detraccion>0)
    {
    $totaldebe=round($debe-$reg->detraccion, 2);
    }
    }
if($row['id'] == '179')
{
    if($moneda == 'S')
    {
        $cuentadet = '12121';
    }
    else if($moneda == 'D')
    {
        $cuentadet = '12122';
    }
}
else
{
    $cuentadet = $cons['detraccionventas'];
}



$data[]=array(
'origen'=>$origenventa,
'vou'=>''.$n,
'fecha'=>$anio,
'cuenta'=>$cuenta,
'debe'=>''.$totaldebe,
'haber'=>''.$haber,
'moneda'=>$moneda,
'tc'=>$tipocambiomon,
'doc'=>$reg->txtID_TIPO_DOCUMENTO,
'numero'=>$serienum,
'fechad'=>$anio,
'fechav'=>$fechaf,
'codigo'=>$ruccliente,
'cc'=>'',
'pre'=>'',
'fe'=>'',
'glosa'=>$glosa,
'tl'=>'',
'neto1'=>'',
'neto2'=>'',
'neto3'=>'',
'neto4'=>'',
'neto5'=>'',
'neto6'=>'',
'neto7'=>'',
'neto8'=>'',
'neto9'=>'',
'igv'=>'',
'rdoc'=>$reltipodoc,
'rnum'=>$relserie,
'rfec'=>$relfecha,
'snum'=>'',	
'sfec'=>'',
'ruc'=>$ruccliente,
'rs'=>$texto,
'tipo'=>'2',
'tdoci'=>$tdoccli,
'mpago'=>'',
'ape1'=>'',
'ape2'=>'',
'nombre'=>'',
'tbien'=>'',
'refmonto'=>'0.00'
);
/*UBSTOTA*/	
/*
'neto5'=>''.$exoneradotot,
'neto6'=>''.$inafectatot,
*/

if($inafecta>0){
$subtotal='0.00';
}

$data[]=array(
'origen'=>$origenventa,
'vou'=>''.$n,
'fecha'=>$anio,
'cuenta'=>$ctaigv,
'debe'=>''.$debe1,
'haber'=>''.$haber1,
'moneda'=>$moneda,
'tc'=>$tipocambiomon,
'doc'=>$reg->txtID_TIPO_DOCUMENTO,
'numero'=>$serienum,
'fechad'=>$anio,
'fechav'=>$fechaf,
'codigo'=>$ruccliente,
'cc'=>'',
'pre'=>'',
'fe'=>'',
'glosa'=>$glosa,
'tl'=>'V',
'neto1'=>''.$subtotal,
'neto2'=>'',
'neto3'=>'',
'neto4'=>'',
'neto5'=>''.$exonerado,
'neto6'=>''.$inafecta,
'neto7'=>'',
'neto8'=>'',
'neto9'=>'',
'igv'=>''.($haber1 + $debe1),
'rdoc'=>$reltipodoc,
'rnum'=>$relserie,
'rfec'=>$relfecha,
'snum'=>'',	
'sfec'=>'',
'ruc'=>$ruccliente,
'rs'=>$texto,
'tipo'=>'2',
'tdoci'=>$tdoccli,
'mpago'=>'',
'ape1'=>'',
'ape2'=>'',
'nombre'=>'',
'tbien'=>'',
'refmonto'=>'0.00'
);


if($reg->percepcion>0){
    
/*POR SI HAY PERCEPCIONES 40*/
$data[]=array(
'origen'=>$origenventa,
'vou'=>''.$n,
'fecha'=>$anio,
'cuenta'=>$ctaperceipcion40,
'debe'=>''.'0.00',
'haber'=>''.$reg->percepcion,
'moneda'=>$moneda,
'tc'=>$tipocambiomon,
'doc'=>$reg->txtID_TIPO_DOCUMENTO,
'numero'=>$serienum,
'fechad'=>$anio,
'fechav'=>$fechaf,
'codigo'=>$ruccliente,
'cc'=>'',
'pre'=>'',
'fe'=>'',
'glosa'=>'PERCEPCION',
'tl'=>'',
'neto1'=>'',
'neto2'=>'',
'neto3'=>'',
'neto4'=>'',
'neto5'=>'',
'neto6'=>'',
'neto7'=>'',
'neto8'=>'',
'neto9'=>'',
'igv'=>'',
'rdoc'=>'',
'rnum'=>'',
'rfec'=>'',
'snum'=>'',	
'sfec'=>'',
'ruc'=>$ruccliente,
'rs'=>$texto,
'tipo'=>'2',
'tdoci'=>$tdoccli,
'mpago'=>'',
'ape1'=>'',
'ape2'=>'',
'nombre'=>'',
'tbien'=>'',
'refmonto'=>'0.00'
);
/*POR SI HAY PERCEPCIONES 12*/
$data[]=array(
'origen'=>$origenventa,
'vou'=>''.$n,
'fecha'=>$anio,
'cuenta'=>$ctaperceipcion12,
'debe'=>''.$reg->percepcion,
'haber'=>''.'0.00',
'moneda'=>$moneda,
'tc'=>$tipocambiomon,
'doc'=>$reg->txtID_TIPO_DOCUMENTO,
'numero'=>$serienum,
'fechad'=>$anio,
'fechav'=>$fechaf,
'codigo'=>$ruccliente,
'cc'=>'',
'pre'=>'',
'fe'=>'',
'glosa'=>'PERCEPCION',
'tl'=>'',
'neto1'=>'',
'neto2'=>'',
'neto3'=>'',
'neto4'=>'',
'neto5'=>'',
'neto6'=>'',
'neto7'=>'',
'neto8'=>'',
'neto9'=>'',
'igv'=>'',
'rdoc'=>'',
'rnum'=>'',
'rfec'=>'',
'snum'=>'',	
'sfec'=>'',
'ruc'=>$ruccliente,
'rs'=>$texto,
'tipo'=>'2',
'tdoci'=>$tdoccli,
'mpago'=>'',
'ape1'=>'',
'ape2'=>'',
'nombre'=>'',
'tbien'=>'',
'refmonto'=>'0.00'
);

}

/*DETRACCIONES*/
if($row['id']!='51'){

if($reg->detraccion>0){

$data[]=array(
'origen'=>$origenventa,
'vou'=>''.$n,
'fecha'=>$anio,
'cuenta'=>$cuentadet,
'debe'=>''.$reg->detraccion,
'haber'=>''.'0.00',
'moneda'=>$moneda,
'tc'=>$tipocambiomon,
'doc'=>$reg->txtID_TIPO_DOCUMENTO,
'numero'=>$serienum,
'fechad'=>$anio,
'fechav'=>$fechaf,
'codigo'=>$ruccliente,
'cc'=>'',
'pre'=>'',
'fe'=>'',
'glosa'=>'DETRACCIONES',
'tl'=>'',
'neto1'=>'',
'neto2'=>'',
'neto3'=>'',
'neto4'=>'',
'neto5'=>'',
'neto6'=>'',
'neto7'=>'',
'neto8'=>'',
'neto9'=>'',
'igv'=>'',
'rdoc'=>'',
'rnum'=>'',
'rfec'=>'',
'snum'=>'',	
'sfec'=>'',
'ruc'=>$ruccliente,
'rs'=>$texto,
'tipo'=>'2',
'tdoci'=>$tdoccli,
'mpago'=>'',
'ape1'=>'',
'ape2'=>'',
'nombre'=>'',
'tbien'=>'',
'refmonto'=>'0.00'
);

}
}

$idv2=$reg->idventa;
}


$cuentaprod=$reg->ctaventas;
if($cuentaprod==''){ $cuentaprod='70001'; }
$glosadescp= str_replace($no_permitidas, $permitidas, $reg->nombreproducto);

$data[]=array(
'origen'=>$origenventa,
'vou'=>''.$n,
'fecha'=>$anio,
'cuenta'=>$cuentaprod,
'debe'=>''.$debedetalle,
'haber'=>''.$haberdetalle,
'moneda'=>$moneda,
'tc'=>$tipocambiomon,
'doc'=>$reg->txtID_TIPO_DOCUMENTO,
'numero'=>$serienum,
'fechad'=>$anio,
'fechav'=>$fechaf,
'codigo'=>$ruccliente,
'cc'=>''.$accostos,
'pre'=>''.$controlpresupuestal,
'fe'=>'',
'glosa'=>$glosa,
'tl'=>'',
'neto1'=>'',
'neto2'=>'',
'neto3'=>'',
'neto4'=>'',
'neto5'=>'',
'neto6'=>''.$inafectadetalle,
'neto7'=>'',
'neto8'=>'',
'neto9'=>'',
'igv'=> '',
'rdoc'=>$reltipodoc,
'rnum'=>$relserie,
'rfec'=>$relfecha,
'snum'=>'',	
'sfec'=>'',
'ruc'=>$ruccliente,
'rs'=>$texto,
'tipo'=>'2',
'tdoci'=>$tdoccli,
'mpago'=>'',
'ape1'=>'',
'ape2'=>'',
'nombre'=>'',
'tbien'=>'',
'refmonto'=>'0.00'
);
//$n = $n+1;
 }
 
/**************************update vou*/

$sql="UPDATE tbl_vou SET vou='$n'  WHERE origen='$origenventa'  AND idempresa='$row[id]' AND mes='$mesvou' AND anio = '$aniovou'";
$rspta=ejecutarConsulta($sql);

//echo $sql;

//$idv2='0';/**que es eso? eso es para no repetir una columna */
$idv2='0';
/*****************cuentas por cobrar***************************/
$n=0;
/*CUENTAS POR COBRAR*/
$datos3 = "SELECT v.txtID_CLIENTE, v.txtSERIE, v.txtNUMERO, c.fecha, c.fechaoperacion, v.txtFECHA_DOCUMENTO, v.txtID_MONEDA, c.idtipo, c.moneda, c.montosoles, c.montodolares, c.tipocambio, v.txtID_TIPO_DOCUMENTO, c.operacion, v.txtTOTAL, v.fecha_vto, c.otrospagos, v.detraccion, v.retencion, v.idventa AS idventa2, c.id, v.detraccion FROM caja_ventapago c LEFT JOIN venta v ON c.idventa=v.idventa WHERE DATE(c.fecha_pago)>='$fecha_inicio' AND DATE(c.fecha_pago)<='$fecha_fin' AND (v.estado='0' OR v.estado='1' OR v.estado='2' ) AND (v.txtID_TIPO_DOCUMENTO='03' OR v.txtID_TIPO_DOCUMENTO='01') AND c.idempresa='$row[id]' AND c.estado='1' AND c.nivel='0' ORDER BY c.fecha ASC ";
$datos = ejecutarConsulta($datos3);

//echo $datos3;


while($dato=mysqli_fetch_array($datos)) {
	
$sql2="SELECT *FROM persona WHERE idpersona='$dato[txtID_CLIENTE]' ";
$cliente= ejecutarConsultaSimpleFila($sql2);

$serienum=$dato['txtSERIE'].'-'.$dato['txtNUMERO'];

if($cliente['tipo_documento']=='DNI'){ $tdoccli='1'; }else{ $tdoccli='6'; }
			
$fechat= date("Y-m-d", strtotime($dato['fecha']));
$vantatit='COBRANZA';

$anio= date("d/m/Y", strtotime($dato['fecha_pago']));
	
$fechadocini= date("Y-m-d", strtotime($dato['fecha_pago']));	

$sqlca="SELECT *FROM tipo_cambio WHERE fecha='$fechadocini' ";
$conca= ejecutarConsultaSimpleFila($sqlca);

if($dato['txtID_MONEDA']=='PEN'){ $moneda="S"; $monedag=$cons['venta']; }else{ $moneda="D"; $monedag=$cons['igv']; }

$asientov='ASIENTO DE VENTA';
	
$texto = str_replace($no_permitidas, $permitidas, $cliente['nombre']);
	
$sqlcat="SELECT *FROM caja_tipopago WHERE id='$dato[idtipo]' ";
$cajatipo= ejecutarConsultaSimpleFila($sqlcat);	
	
if($dato['moneda']=='PEN'){
$totalmonto=$dato['montosoles'];
$monedad="S";
$cuenta=$cajatipo['cuentasoles'];
}else{ 
$totalmonto=$dato['montodolares']; 
$monedad="D";
$cuenta=$cajatipo['cuentadolares'];
}

/*
if($dato['otrospagos']=='1'){
$cuenta=$cons['ctadetraccion']; 
}else if($dato['otrospagos']=='2'){ 
$cuenta=$cons['ctaretencion']; 
}
*/

if($conca['venta']){ $tc=$conca['venta']; }else{ $tc=$dato['tipocambio']; }

$totalpago=$dato['txtTOTAL']; 

if($dato['idventa2']!=$idv2){

$n=$n+1;

/*DETRACCION*/
if($dato['detraccion']>0&&$dato['otrospagos']=='1'){
    
$data[]=array(
'origen'=>$origencobrarf,
'vou'=>''.$n,
'fecha'=>date("d/m/Y", strtotime($dato['fechaoperacion'])),
'cuenta'=>$cuentadetraccion,
'debe'=>''.'0.00',
'haber'=>''.$dato['detraccion'],
'moneda'=>$moneda,
'tc'=>$dato['tipocambio'],
'doc'=>$dato['txtID_TIPO_DOCUMENTO'],
'numero'=>$serienum,
'fechad'=>date("d/m/Y", strtotime($dato['txtFECHA_DOCUMENTO'])),
'fechav'=>date("d/m/Y", strtotime($dato['fecha_vto'])),
'codigo'=>$cliente['txtID_CLIENTE'],
'cc'=>'',
'pre'=>'',
'fe'=>'',
'glosa'=>'DETRACCION',
'tl'=>'',
'neto1'=>'',
'neto2'=>'',
'neto3'=>'',
'neto4'=>'',
'neto5'=>'',
'neto6'=>'',
'neto7'=>'',
'neto8'=>'',
'neto9'=>'',
'igv'=>'',
'rdoc'=>'',
'rnum'=>'',
'rfec'=>'',
'snum'=>'',	
'sfec'=>'',
'ruc'=>$cliente['txtID_CLIENTE'],
'rs'=>$texto,
'tipo'=>'2',
'tdoci'=>$cajatipo['tiposunat'],
'mpago'=>'',
'ape1'=>'',
'ape2'=>'',
'nombre'=>'',
'tbien'=>'',
'refmonto'=>'0.00'
);

}else{
 

$data[]=array(
'origen'=>$origencobrarf,
'vou'=>''.$n,
'fecha'=>date("d/m/Y", strtotime($dato['fechaoperacion'])),
'cuenta'=>$ccostos,
'debe'=>'0.00',
'haber'=>''.round($totalpago, 2),
'moneda'=>$moneda,
'tc'=>$dato['tipocambio'],
'doc'=>$dato['txtID_TIPO_DOCUMENTO'],
'numero'=>$serienum,
'fechad'=>date("d/m/Y", strtotime($dato['txtFECHA_DOCUMENTO'])),
'fechav'=>date("d/m/Y", strtotime($dato['fecha_vto'])),
'codigo'=>$cliente['txtID_CLIENTE'],
'cc'=>'',
'pre'=>'',
'fe'=>'',
'glosa'=>$glosa,
'tl'=>'',
'neto1'=>'',
'neto2'=>'',
'neto3'=>'',
'neto4'=>'',
'neto5'=>'',
'neto6'=>'',
'neto7'=>'',
'neto8'=>'',
'neto9'=>'',
'igv'=>'',
'rdoc'=>'',
'rnum'=>'',
'rfec'=>'',
'snum'=>'',
'sfec'=>'',
'ruc'=>$cliente['txtID_CLIENTE'],
'rs'=>$texto,
'tipo'=>'2',
'tdoci'=>$tdoccli,
'mpago'=>$cajatipo['tiposunat'],
'ape1'=>'',
'ape2'=>'',
'nombre'=>'',
'tbien'=>'',
'refmonto'=>'0.00'
);

 
    
}


$idv2=$dato['idventa2'];
}

$data[]=array(
'origen'=>$origencobrarf,
'vou'=>''.$n,
'fecha'=>date("d/m/Y", strtotime($dato['fechaoperacion'])),
'cuenta'=>$cuenta,
'debe'=>''.$totalmonto,
'haber'=>'0.00',
'moneda'=>$moneda,
'tc'=>$dato['tipocambio'],
'doc'=>'00',
'numero'=>$dato['operacion'],
'fechad'=>date("d/m/Y", strtotime($dato['txtFECHA_DOCUMENTO'])),
'fechav'=>date("d/m/Y", strtotime($dato['fechaoperacion'])),
'codigo'=>$cliente['txtID_CLIENTE'],
'cc'=>'',
'pre'=>'',
'fe'=>'O101',
'glosa'=>$glosa,
'tl'=>'',
'neto1'=>'',
'neto2'=>'',
'neto3'=>'',
'neto4'=>'',
'neto5'=>'',
'neto6'=>'',
'neto7'=>'',
'neto8'=>'',
'neto9'=>'',
'igv'=>'',
'rdoc'=>$cajatipo['tipo'],
'rnum'=>$dato['operacion'],
'rfec'=>date("d/m/Y", strtotime($dato['fecha'])),
'snum'=>'',
'sfec'=>date("d/m/Y", strtotime($dato['fecha'])),
'ruc'=>$cliente['txtID_CLIENTE'],
'rs'=>$texto,
'tipo'=>'2',
'tdoci'=>$tdoccli,
'mpago'=>$cajatipo['tiposunat'],
'ape1'=>'',
'ape2'=>'',
'nombre'=>'',
'tbien'=>'',
'refmonto'=>'0.00'
);




}


/*LAS COMPRAS*/
$n=0;

if($row['id']=='1'){

$datos = "SELECT  i.idproveedor, i.fecha_hora, i.num_comprobante, i.serie_comprobante, i.fechaven, i.igv, i.total_compra, i.subtotal, d.descripcion, a.ctacompras, i.idingreso, i.ccostos, i.tipo_comprobante, d.igv AS igvdetalle, d.subtotal AS subtotaldetalle, i.moneda, i.idingreso AS idingresfinal, i.exonerado, i.percepcion, i.controlpresupuestal, i.detracciones FROM detalle_ingreso d INNER JOIN ingreso i ON d.idingreso=i.idingreso LEFT JOIN articulo a ON d.txtCOD_ARTICULO=a.txtCOD_ARTICULO WHERE DATE(i.fechaven)>='$fecha_inicio'  AND DATE(i.fechaven)<='$fecha_fin' AND i.estado='0' 
AND i.tipo_comprobante!='17' AND i.tipo_comprobante!='99' AND i.tipo_comprobante!='16' AND i.idempresa='$row[id]' AND d.idempresa='$row[id]' AND (i.nivel='0' OR i.nivel='1')
GROUP BY iddetalle_ingreso ORDER BY fecha_hora ASC ";

}else{
  
$datos = "SELECT  i.idproveedor, i.fecha_hora, i.num_comprobante, i.serie_comprobante, i.fechaven, i.igv, i.total_compra, i.subtotal, d.descripcion, i.idingreso, i.ccostos, i.tipo_comprobante, d.igv AS igvdetalle, d.subtotal AS subtotaldetalle, i.moneda, i.idingreso AS idingresfinal, i.exonerado, i.percepcion, i.controlpresupuestal, i.detracciones, d.cuentacompra, i.obs, d.txtCOD_ARTICULO FROM detalle_ingreso d INNER JOIN ingreso i ON d.idingreso=i.idingreso LEFT JOIN articulo a ON d.txtCOD_ARTICULO=a.txtCOD_ARTICULO WHERE DATE(i.fechaven)>='$fecha_inicio'  AND DATE(i.fechaven)<='$fecha_fin' AND i.estado='0' 
AND i.tipo_comprobante!='17' AND i.tipo_comprobante!='99' AND i.tipo_comprobante!='16' AND i.idempresa='$row[id]' AND d.idempresa='$row[id]' AND (i.nivel='0' OR i.nivel='1')
GROUP BY iddetalle_ingreso ORDER BY fecha_hora ASC ";
    
}

//echo $datos;


$rspta2=ejecutarConsulta($datos);

while ($reg=$rspta2->fetch_object()){

$sql2="SELECT *FROM persona WHERE idpersona='$reg->idproveedor' ";
$cliente= ejecutarConsultaSimpleFila($sql2);	

$serienum=$reg->serie_comprobante.'-'.$reg->num_comprobante;

$tdoccli='0';

if($cliente['tipo_documento']=='DNI'){ $tdoccli='1'; }else if($cliente['tipo_documento']=='RUC'){ $tdoccli='6'; }

$fechap = date("Y-m-d", strtotime($reg->fecha_hora));
$fecha= explode('-', $fechap);
$anio= $fecha[2].'/'.$fecha[1].'/'.$fecha[0];
	
$fechaf =explode('-', $reg->fechaven);
$fechaf =$fechaf[2].'/'.$fechaf[1].'/'.$fechaf[0];

$sqlca="SELECT *FROM tipo_cambio WHERE fecha='$fechap' ";
$conca= ejecutarConsultaSimpleFila($sqlca);
$tc=$conca['venta'];

$moneda="S";
$cuenta=$cuentacompraoles;	
if($reg->moneda=='USD'){ 
$moneda="D";
$cuenta=$cuentacompradolar;
}

if(!$conca){
$tc='1.000';
}


$ccostos='';
$controlpresupuestal='';

if($reg->ccostos!='0'){
$sqlcac="SELECT *FROM categoria WHERE idcategoria='$reg->ccostos' ";
$cacostos= ejecutarConsultaSimpleFila($sqlcac);
$ccostos=$cacostos['ctaventas'];

}

/*CONTROL PRESUPUESTAL*/
if($reg->controlpresupuestal!='0'){
$sqlcontrol="SELECT *FROM categoria WHERE idcategoria='$reg->controlpresupuestal' ";
$controlpres= ejecutarConsultaSimpleFila($sqlcontrol);
$controlpresupuestal=$controlpres['ctaventas'];
}

$glosa='ASIENTO DE COMPRA';

if($reg->obs!=''&&$row['id']=='166'){
$glosa=$reg->obs;
}


$texto = str_replace($no_permitidas, $permitidas, $cliente['nombre']);

$ruccliente=$cliente['txtID_CLIENTE'];
if($cliente['txtID_CLIENTE']=='00000000'){
$ruccliente='999999999999'; 
$tdoccli='0';
}

if($reg->idingresfinal!=$idv2){

$n=$n+1;

$totalcompra=$reg->total_compra;

if($reg->detracciones>0){
$totalcompra=round($reg->total_compra-$reg->detracciones, 2);
}

$data[]=array(
'origen'=>$origencompra,
'vou'=>''.$n,
'fecha'=>$fechaf,
'cuenta'=>$cuenta,
'debe'=>'0.00',
'haber'=>''.$totalcompra,
'moneda'=>$moneda,
'tc'=>$tc,
'doc'=>''.$reg->tipo_comprobante,
'numero'=>$serienum,
'fechad'=>$anio,
'fechav'=>$anio,
'codigo'=>$ruccliente,
'cc'=>'',
'pre'=>'',
'fe'=>'',
'glosa'=>$glosa,
'tl'=>'',
'neto1'=>'',
'neto2'=>'',
'neto3'=>'',
'neto4'=>'',
'neto5'=>'',
'neto6'=>'',
'neto7'=>'',
'neto8'=>'',
'neto9'=>'',
'igv'=>'',
'rdoc'=>'',
'rnum'=>'',
'rfec'=>'',
'snum'=>'',	
'sfec'=>'',
'ruc'=>$ruccliente,
'rs'=>$texto,
'tipo'=>'1',
'tdoci'=>$tdoccli,
'mpago'=>'',
'ape1'=>'',
'ape2'=>'',
'nombre'=>'',
'tbien'=>'',
'refmonto'=>'0.00'
);
//CUENTA IGV CUENTA 40	
$data[]=array(
'origen'=>$origencompra,
'vou'=>''.$n,
'fecha'=>$fechaf,
'cuenta'=>$ctaigv,
'debe'=>''.$reg->igv,
'haber'=>'0.00',
'moneda'=>$moneda,
'tc'=>$tc,
'doc'=>''.$reg->tipo_comprobante,
'numero'=>$serienum,
'fechad'=>$anio,
'fechav'=>$anio,
'codigo'=>$ruccliente,
'cc'=>'',
'pre'=>'',
'fe'=>'',
'glosa'=>$glosa,
'tl'=>'C',
'neto1'=>''.$reg->subtotal,
'neto2'=>'',
'neto3'=>'',
'neto4'=>'',
'neto5'=>'',
'neto6'=>''.$reg->exonerado,
'neto7'=>'',
'neto8'=>'',
'neto9'=>'',
'igv'=>''.$reg->igv,
'rdoc'=>'',
'rnum'=>'',
'rfec'=>'',
'snum'=>'',	
'sfec'=>'',
'ruc'=>$ruccliente,
'rs'=>$texto,
'tipo'=>'1',
'tdoci'=>$tdoccli,
'mpago'=>'',
'ape1'=>'',
'ape2'=>'',
'nombre'=>'',
'tbien'=>'',
'refmonto'=>'0.00'
);

//CUENTA PERCEPCIONES CUENTA 40	
if($reg->percepcion!='0.00'){
$data[]=array(
'origen'=>$origencompra,
'vou'=>''.$n,
'fecha'=>$fechaf,
'cuenta'=>$percepcioncompra40,
'debe'=>''.$reg->igv,
'haber'=>'0.00',
'moneda'=>$moneda,
'tc'=>$tc,
'doc'=>''.$reg->tipo_comprobante,
'numero'=>$serienum,
'fechad'=>$anio,
'fechav'=>$anio,
'codigo'=>$ruccliente,
'cc'=>'',
'pre'=>'',
'fe'=>'',
'glosa'=>$glosa,
'tl'=>'C',
'neto1'=>''.$reg->subtotal,
'neto2'=>'',
'neto3'=>'',
'neto4'=>'',
'neto5'=>'',
'neto6'=>''.$reg->exonerado,
'neto7'=>'',
'neto8'=>'',
'neto9'=>'',
'igv'=>''.$reg->igv,
'rdoc'=>'',
'rnum'=>'',
'rfec'=>'',
'snum'=>'',	
'sfec'=>'',
'ruc'=>$ruccliente,
'rs'=>$texto,
'tipo'=>'1',
'tdoci'=>$tdoccli,
'mpago'=>'',
'ape1'=>'',
'ape2'=>'',
'nombre'=>'',
'tbien'=>'',
'refmonto'=>'0.00'
);
}


if($reg->detracciones>0){

 $data[]=array(
'origen'=>$origencompra,
'vou'=>''.$n,
'fecha'=>$fechaf,
'cuenta'=>$cons['detraccioncompras'],
'debe'=>'0.00',
'haber'=>''.$reg->detracciones,
'moneda'=>$moneda,
'tc'=>$tc,
'doc'=>''.$reg->tipo_comprobante,
'numero'=>$serienum,
'fechad'=>$anio,
'fechav'=>$anio,
'codigo'=>$ruccliente,
'cc'=>$ccostos.'',
'pre'=>''.$controlpresupuestal,
'fe'=>'',
'glosa'=>'DETRACCION',
'tl'=>'',
'neto1'=>'',
'neto2'=>'',
'neto3'=>'',
'neto4'=>'',
'neto5'=>'',
'neto6'=>'',
'neto7'=>'',
'neto8'=>'',
'neto9'=>'',
'igv'=> '',
'rdoc'=>'',
'rnum'=>'',
'rfec'=>'',
'snum'=>'',	
'sfec'=>'',
'ruc'=>$ruccliente,
'rs'=>$texto,
'tipo'=>'1',
'tdoci'=>$tdoccli,
'mpago'=>'',
'ape1'=>'',
'ape2'=>'',
'nombre'=>'',
'tbien'=>'',
'refmonto'=>'0.00'
);  
}


$idv2=$reg->idingresfinal;
}

$cuentaprod=$reg->cuentacompra;
if($cuentaprod==''){ 
    
$sqlart="SELECT *FROM articulo WHERE txtCOD_ARTICULO='$reg->txtCOD_ARTICULO' ";
$art= ejecutarConsultaSimpleFila($sqlart);

if($art['ctacompras']==''){ 
$cuentaprod='60111'; 
}else{
$cuentaprod=$art['ctacompras'];
}

}
$glosadescp= str_replace($no_permitidas, $permitidas, $reg->descripcion);

$data[]=array(
'origen'=>$origencompra,
'vou'=>''.$n,
'fecha'=>$fechaf,
'cuenta'=>$cuentaprod,
'debe'=>''.$reg->subtotaldetalle,
'haber'=>'0.00',
'moneda'=>$moneda,
'tc'=>$tc,
'doc'=>''.$reg->tipo_comprobante,
'numero'=>$serienum,
'fechad'=>$anio,
'fechav'=>$anio,
'codigo'=>$ruccliente,
'cc'=>$ccostos.'',
'pre'=>''.$controlpresupuestal,
'fe'=>'',
'glosa'=>$glosadescp,
'tl'=>'',
'neto1'=>'',
'neto2'=>'',
'neto3'=>'',
'neto4'=>'',
'neto5'=>'',
'neto6'=>'',
'neto7'=>'',
'neto8'=>'',
'neto9'=>'',
'igv'=> '',
'rdoc'=>'',
'rnum'=>'',
'rfec'=>'',
'snum'=>'',	
'sfec'=>'',
'ruc'=>$ruccliente,
'rs'=>$texto,
'tipo'=>'1',
'tdoci'=>$tdoccli,
'mpago'=>'',
'ape1'=>'',
'ape2'=>'',
'nombre'=>'',
'tbien'=>'',
'refmonto'=>'0.00'
);





}


/*OTROS GASTOS IMPORTACION*/

/*inicio importacion*/
$datos = "SELECT  * FROM ingreso_importacion WHERE fecha>='$fecha_inicio'  AND fecha<='$fecha_fin' ORDER BY fecha ASC ";
    
$rspta2=ejecutarConsulta($datos);

while ($reg=$rspta2->fetch_object()){

$sql2="SELECT *FROM persona WHERE idpersona='$reg->proveedor' ";
$cliente= ejecutarConsultaSimpleFila($sql2);	

$sqlingre="SELECT *FROM ingreso WHERE idingreso='$reg->idingreso' ";
$ingre= ejecutarConsultaSimpleFila($sqlingre);	


$serienum=$reg->serie_numero;

if($cliente['tipo_documento']=='DNI'){ $tdoccli='1'; }else{ $tdoccli='6'; }

$anio= date("d/m/Y", strtotime($reg->fecha));

$sqlca="SELECT *FROM tipo_cambio WHERE fecha<='$reg->fecha' ";
$conca= ejecutarConsultaSimpleFila($sqlca);
$tc=$conca['venta'];

$moneda="S";
$cuenta=$cuentacompraoles;	
if($reg->moneda=='USD'){ 
$moneda="D";
$cuenta=$cuentacompradolar;
}

if(!$conca){
$tc='1.000';
}

$ccostos='';
$controlpresupuestal='';

if($ingre['ccostos']!='0'){
$sqlcac="SELECT *FROM categoria WHERE idcategoria='$reg->ccostos' ";
$cacostos= ejecutarConsultaSimpleFila($sqlcac);
$ccostos=$cacostos['ctaventas'];
}

//CONTROL PRESUPUESTAL

if($ingre['controlpresupuestal']!='0'){
$sqlcontrol="SELECT *FROM categoria WHERE idcategoria='$reg->controlpresupuestal' ";
$controlpres= ejecutarConsultaSimpleFila($sqlcontrol);
$controlpresupuestal=$controlpres['ctaventas'];
}

$glosa='GASTOS IMPORTACION';

$texto = str_replace($no_permitidas, $permitidas, $cliente['nombre']);

$ruccliente=$cliente['txtID_CLIENTE'];
if($cliente['txtID_CLIENTE']=='00000000'){
$ruccliente='999999999999'; 
$tdoccli='0';
}

$n=$n+1;

$data[]=array(
'origen'=>$origencompra,
'vou'=>''.$n,
'fecha'=>$anio,
'cuenta'=>$cuenta,
'debe'=>'0.00',
'haber'=>''.$reg->monto,
'moneda'=>$moneda,
'tc'=>$tc,
'doc'=>''.$reg->tipodocumento,
'numero'=>$serienum,
'fechad'=>$anio,
'fechav'=>$anio,
'codigo'=>$ruccliente,
'cc'=>'',
'pre'=>'',
'fe'=>'',
'glosa'=>$glosa,
'tl'=>'',
'neto1'=>'',
'neto2'=>'',
'neto3'=>'',
'neto4'=>'',
'neto5'=>'',
'neto6'=>'',
'neto7'=>'',
'neto8'=>'',
'neto9'=>'',
'igv'=>'',
'rdoc'=>'',
'rnum'=>'',
'rfec'=>'',
'snum'=>'',	
'sfec'=>'',
'ruc'=>$ruccliente,
'rs'=>$texto,
'tipo'=>'2',
'tdoci'=>$tdoccli,
'mpago'=>'',
'ape1'=>'',
'ape2'=>'',
'nombre'=>'',
'tbien'=>'',
'refmonto'=>'0.00'
);
//CUENTA IGV CUENTA 40	
$neto1=0;
$neto6=0;
if($reg->igv == 0)
{
    $neto6 = $reg->subtotal;
}
else
{
 $neto1 =     $reg->subtotal;
}
$data[]=array(
'origen'=>$origencompra,
'vou'=>''.$n,
'fecha'=>$anio,
'cuenta'=>$ctaigv,
'debe'=>''.$reg->igv,
'haber'=>'0.00',
'moneda'=>$moneda,
'tc'=>$tc,
'doc'=>''.$reg->tipodocumento,
'numero'=>$serienum,
'fechad'=>$anio,
'fechav'=>$anio,
'codigo'=>$ruccliente,
'cc'=>'',
'pre'=>'',
'fe'=>'',
'glosa'=>$glosa,
'tl'=>'C',
'neto1'=>''.$neto1,
'neto2'=>'',
'neto3'=>'',
'neto4'=>'',
'neto5'=>'',
'neto6'=>''.$neto6,
'neto7'=>'',
'neto8'=>'',
'neto9'=>'',
'igv'=>''.$reg->igv,
'rdoc'=>'',
'rnum'=>'',
'rfec'=>'',
'snum'=>'',	
'sfec'=>'',
'ruc'=>$ruccliente,
'rs'=>$texto,
'tipo'=>'2',
'tdoci'=>$tdoccli,
'mpago'=>'',
'ape1'=>'',
'ape2'=>'',
'nombre'=>'',
'tbien'=>'',
'refmonto'=>'0.00'
);


$cuentaprod=$reg->ctacompras;
if($cuentaprod==''){ $cuentaprod='60111'; }
$glosadescp= str_replace($no_permitidas, $permitidas, $reg->motivo);

$data[]=array(
'origen'=>$origencompra,
'vou'=>''.$n,
'fecha'=>$anio,
'cuenta'=>$reg->codcontable,
'debe'=>''.$reg->subtotal,
'haber'=>'0.00',
'moneda'=>$moneda,
'tc'=>$tc,
'doc'=>''.$reg->tipodocumento,
'numero'=>$serienum,
'fechad'=>$anio,
'fechav'=>$anio,
'codigo'=>$ruccliente,
'cc'=>$ccostos.'',
'pre'=>''.$controlpresupuestal,
'fe'=>'',
'glosa'=>$glosadescp,
'tl'=>'',
'neto1'=>'',
'neto2'=>'',
'neto3'=>'',
'neto4'=>'',
'neto5'=>'',
'neto6'=>'',
'neto7'=>'',
'neto8'=>'',
'neto9'=>'',
'igv'=> '',
'rdoc'=>'',
'rnum'=>'',
'rfec'=>'',
'snum'=>'',	
'sfec'=>'',
'ruc'=>$ruccliente,
'rs'=>$texto,
'tipo'=>'2',
'tdoci'=>$tdoccli,
'mpago'=>'',
'ape1'=>'',
'ape2'=>'',
'nombre'=>'',
'tbien'=>'',
'refmonto'=>'0.00'
);

}
/*fin de importacion*/


function fechaCastellano ($fecha) {
  $fecha = substr($fecha, 0, 10);
  $numeroDia = date('d', strtotime($fecha));
  $dia = date('l', strtotime($fecha));
  $mes = date('F', strtotime($fecha));
  $anio = date('Y', strtotime($fecha));
  $dias_ES = array("Lunes", "Martes", "Miércoles", "Jueves", "Viernes", "Sábado", "Domingo");
  $dias_EN = array("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday");
  $nombredia = str_replace($dias_EN, $dias_ES, $dia);
$meses_ES = array("ENERO", "FEBRERO", "MARZO", "ABRIL", "MAYO", "JUNIO", "JULIO", "AGOSTO", "SEPTIEMBRE", "OCTUBRE", "NOVIEMBRE", "Diciembre");
  $meses_EN = array("January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December");
  $nombreMes = str_replace($meses_EN, $meses_ES, $mes);
  return " ".$nombreMes." ".$anio;
}

$origencompraactivo='90';
$origen='05';
$vantatit='DEPRECIACION DEL MES';
$compratit='COMPRA ACTIVO DEL MES';
/*ACTIVOS DEPRECIACION */

$fechainiact=date("Y-m", strtotime($fecha_inicio));
$fechafinact=date("Y-m", strtotime($fecha_fin));

$n=1;
$sql="SELECT * FROM activos_depreciacion WHERE idempresa='$row[id]' AND periodo>='$fechainiact' AND periodo<='$fechafinact' ";
$rspta=ejecutarConsulta($sql);

while ($reg=$rspta->fetch_object()){

$sqlact="SELECT *FROM activos_ingresos WHERE id='$reg->idactivo' ";
$activo= ejecutarConsultaSimpleFila($sqlact);

$fech=date("d", strtotime($activo['fechauso']));
$anio=$fechat= date("d/m/Y", strtotime($fechatot.'-'.$fech));	
$fechap=$anio=$fechat= date("d/m/Y", strtotime($fechatot.'-'.$fech));

$sqlca="SELECT *FROM tipo_cambio WHERE fecha='$fechap'  ";
$conca= ejecutarConsultaSimpleFila($sqlca);

if($activo['moneda']=='PEN'){
$moneda="S"; 
$cuentacomprasd=$cons['ccomprassoles'];
}else{
$moneda="D";
$cuentacomprasd=$cons['ccomprasdolares'];
}

$data[]=array(
'origen'=>$origen,
'vou'=>''.$n,
'fecha'=>$anio,
'cuenta'=>$activo['ctagastos'],
'debe'=>''.round($reg->dep_ejercicio, 2),
'haber'=>'0.00',
'moneda'=>$moneda,
'tc'=>'1.00',
'doc'=>'',
'numero'=>'',
'fechad'=>$anio,
'fechav'=>$anio,
'codigo'=>'',
'cc'=>'',
'pre'=>'',
'fe'=>'',
'glosa'=>$vantatit,
'tl'=>'',
'neto1'=>'',
'neto2'=>'',
'neto3'=>'',
'neto4'=>'',
'neto5'=>'',
'neto6'=>'',
'neto7'=>'',
'neto8'=>'',
'neto9'=>'',
'igv'=> '',
'rdoc'=>'',
'rnum'=>'',
'rfec'=>'',
'snum'=>'',	
'sfec'=>'',
'ruc'=>'',
'rs'=>'',
'tipo'=>'',
'tdoci'=>'',
'mpago'=>'',
'ape1'=>'',
'ape2'=>'',
'nombre'=>'',
'tbien'=>'',
'refmonto'=>''
);

$data[]=array(
'origen'=>$origen,
'vou'=>''.$n,
'fecha'=>$anio,
'cuenta'=>$activo['ctadepreciacion'],
'debe'=>'0.00',
'haber'=>''.round($reg->dep_ejercicio, 2),
'moneda'=>$moneda,
'tc'=>'1.00',
'doc'=>'',
'numero'=>'',
'fechad'=>$anio,
'fechav'=>$anio,
'codigo'=>'',
'cc'=>'',
'pre'=>'',
'fe'=>'',
'glosa'=>$vantatit,
'tl'=>'',
'neto1'=>'',
'neto2'=>'',
'neto3'=>'',
'neto4'=>'',
'neto5'=>'',
'neto6'=>'',
'neto7'=>'',
'neto8'=>'',
'neto9'=>'',
'igv'=> '',
'rdoc'=>'',
'rnum'=>'',
'rfec'=>'',
'snum'=>'',	
'sfec'=>'',
'ruc'=>'',
'rs'=>'',
'tipo'=>'',
'tdoci'=>'',
'mpago'=>'',
'ape1'=>'',
'ape2'=>'',
'nombre'=>'',
'tbien'=>'',
'refmonto'=>''
);


   $data[]=array(
'origen'=>$origencompraactivo,
'vou'=>''.$n,
'fecha'=>$anio,
'cuenta'=>$activo['ctaactivo'],
'debe'=>''.round($activo['costo'], 2),
'haber'=>'0.00',
'moneda'=>$moneda,
'tc'=>'1.00',
'doc'=>'',
'numero'=>'',
'fechad'=>$fecha_inicio,
'fechav'=>$fecha_fin,
'codigo'=>'',
'cc'=>'',
'pre'=>'',
'fe'=>'',
'glosa'=>$compratit,
'tl'=>'',
'neto1'=>'',
'neto2'=>'',
'neto3'=>'',
'neto4'=>'',
'neto5'=>'',
'neto6'=>'',
'neto7'=>'',
'neto8'=>'',
'neto9'=>'',
'igv'=> '',
'rdoc'=>'',
'rnum'=>'',
'rfec'=>'',
'snum'=>'',	
'sfec'=>'',
'ruc'=>'',
'rs'=>'',
'tipo'=>'',
'tdoci'=>'',
'mpago'=>'',
'ape1'=>'',
'ape2'=>'',
'nombre'=>'',
'tbien'=>'',
'refmonto'=>''
); 

$igv=$activo['costo']*0.18;

/*CUENTA COMPRA*/
$data[]=array(
'origen'=>$origencompraactivo,
'vou'=>''.$n,
'fecha'=>$anio,
'cuenta'=>$ctaigv,
'debe'=>''.round($igv, 2),
'haber'=>'0.00',
'moneda'=>$moneda,
'tc'=>'1.00',
'doc'=>$activo['tipodoc'],
'numero'=>$activo['serie'].'-'.$activo['numero'],
'fechad'=>$fecha_inicio,
'fechav'=>$fecha_fin,
'codigo'=>'',
'cc'=>'',
'pre'=>'',
'fe'=>'',
'glosa'=>$compratit,
'tl'=>'C',
'neto1'=>'',
'neto2'=>'',
'neto3'=>'',
'neto4'=>'',
'neto5'=>'',
'neto6'=>'',
'neto7'=>'',
'neto8'=>'',
'neto9'=>'',
'igv'=> '',
'rdoc'=>'',
'rnum'=>'',
'rfec'=>'',
'snum'=>'',	
'sfec'=>'',
'ruc'=>'',
'rs'=>'',
'tipo'=>'',
'tdoci'=>'',
'mpago'=>'',
'ape1'=>'',
'ape2'=>'',
'nombre'=>'',
'tbien'=>'',
'refmonto'=>''
);

$sumatodo=$activo['costo']+$igv;

$data[]=array(
'origen'=>$origencompraactivo,
'vou'=>''.$n,
'fecha'=>$anio,
'cuenta'=>$cuentacomprasd,
'debe'=>'0.00',
'haber'=>''.round($sumatodo, 2),
'moneda'=>$moneda,
'tc'=>'1.00',
'doc'=>$activo['tipodoc'],
'numero'=>$activo['serie'].'-'.$activo['numero'],
'fechad'=>$fecha_inicio,
'fechav'=>$fecha_fin,
'codigo'=>'',
'cc'=>'',
'pre'=>'',
'fe'=>'',
'glosa'=>$compratit,
'tl'=>'',
'neto1'=>'',
'neto2'=>'',
'neto3'=>'',
'neto4'=>'',
'neto5'=>'',
'neto6'=>'',
'neto7'=>'',
'neto8'=>'',
'neto9'=>'',
'igv'=> '',
'rdoc'=>'',
'rnum'=>'',
'rfec'=>'',
'snum'=>'',	
'sfec'=>'',
'ruc'=>'',
'rs'=>'',
'tipo'=>'',
'tdoci'=>'',
'mpago'=>'',
'ape1'=>'',
'ape2'=>'',
'nombre'=>'',
'tbien'=>'',
'refmonto'=>''
);




}


//$idv2='0';/**que es eso? eso es para no repetir una columna */
$idv2='0';
$n=0;

/*
CUENTAS POR PAGAR
*/
$datos = "SELECT v.idproveedor, v.serie_comprobante, v.num_comprobante, c.fecha, c.fechaoperacion, v.fecha_hora, v.moneda, c.idtipo, c.moneda AS monedapago, c.montosoles, c.montodolares, c.tipocambio, v.tipo_comprobante, c.operacion, v.total_compra, v.fechaven, c.otrospagos, v.detracciones, v.retenciones, c.id AS idventa2, c.id, v.detracciones FROM caja_ventapago c LEFT JOIN ingreso v ON c.idventa=v.idingreso WHERE DATE(c.fecha_pago)>='$fecha_inicio' AND DATE(c.fecha_pago)<='$fecha_fin' AND v.estado='0' AND (v.tipo_comprobante='03' OR v.tipo_comprobante='01') AND c.idempresa='$row[id]' AND c.estado='1' AND c.nivel='1' ORDER BY c.fecha ASC ";

//echo $datos;

$datos = ejecutarConsulta($datos);
while($dato=mysqli_fetch_array($datos)) {
	
$sql2="SELECT *FROM persona WHERE idpersona='$dato[idproveedor]' ";
$cliente= ejecutarConsultaSimpleFila($sql2);

$serienum=$dato['serie_comprobante'].'-'.$dato['num_comprobante'];

if($cliente['tipo_documento']=='DNI'){ $tdoccli='1'; }else{ $tdoccli='6'; }
			
$fechat= date("Y-m-d", strtotime($dato['fecha']));
$vantatit='PAGOS';

$anio= date("d/m/Y", strtotime($dato['fecha_pago']));
	
$fechadocini= date("Y-m-d", strtotime($dato['fecha_pago']));	

$sqlca="SELECT *FROM tipo_cambio WHERE fecha='$fechadocini' ";
$conca= ejecutarConsultaSimpleFila($sqlca);

if($dato['moneda']=='PEN'){ $moneda="S"; $monedag=$cons['venta']; }else{ $moneda="D"; $monedag=$cons['igv']; }

$asientov='ASIENTO DE COMPRA';
	
$texto = str_replace($no_permitidas, $permitidas, $cliente['nombre']);
	
$sqlcat="SELECT *FROM caja_tipopago WHERE id='$dato[idtipo]' ";
$cajatipo= ejecutarConsultaSimpleFila($sqlcat);	


	
if($dato['monedapago']=='PEN'){
$totalmonto=$dato['montosoles'];
$monedad="S";
$cuenta=$cajatipo['cuentasoles'];
$cuentacompra=$cuentacompraoles;
}else{ 
$totalmonto=$dato['montodolares']; 
$monedad="D";
$cuenta=$cajatipo['cuentadolares'];
$cuentacompra=$cuentacompradolar;
}

if($conca['venta']){ $tc=$conca['venta']; }else{ $tc=$dato['tipocambio']; }

$totalpago=$dato['total_compra']; 

if($dato['idventa2']!=$idv2){

$n=$n+1;

/*DETRACCION*/
if($dato['detracciones']>0&&$dato['otrospagos']=='1'){
    
$data[]=array(
'origen'=>$cons['origenpagos'],
'vou'=>''.$n,
'fecha'=>date("d/m/Y", strtotime($dato['fechaoperacion'])),
'cuenta'=>$cuenta,
'debe'=>''.$dato['detracciones'],
'haber'=>''.'0.00',
'moneda'=>$moneda,
'tc'=>$dato['tipocambio'],
'doc'=>$dato['tipo_comprobante'],
'numero'=>$serienum,
'fechad'=>date("d/m/Y", strtotime($dato['fecha_hora'])),
'fechav'=>date("d/m/Y", strtotime($dato['fechaven'])),
'codigo'=>$cliente['txtID_CLIENTE'],
'cc'=>'',
'pre'=>'',
'fe'=>'',
'glosa'=>'DETRACCION',
'tl'=>'',
'neto1'=>'',
'neto2'=>'',
'neto3'=>'',
'neto4'=>'',
'neto5'=>'',
'neto6'=>'',
'neto7'=>'',
'neto8'=>'',
'neto9'=>'',
'igv'=>'',
'rdoc'=>'',
'rnum'=>'',
'rfec'=>'',
'snum'=>'',	
'sfec'=>'',
'ruc'=>$cliente['txtID_CLIENTE'],
'rs'=>$texto,
'tipo'=>'2',
'tdoci'=>$cajatipo['tiposunat'],
'mpago'=>'',
'ape1'=>'',
'ape2'=>'',
'nombre'=>'',
'tbien'=>'',
'refmonto'=>'0.00'
);

}else{
 

$data[]=array(
'origen'=>$cons['origenpagos'],
'vou'=>''.$n,
'fecha'=>date("d/m/Y", strtotime($dato['fechaoperacion'])),
'cuenta'=>$cuenta,
'debe'=>''.round($totalpago, 2),
'haber'=>'0.00',
'moneda'=>$moneda,
'tc'=>$dato['tipocambio'],
'doc'=>$dato['tipo_comprobante'],
'numero'=>$serienum,
'fechad'=>date("d/m/Y", strtotime($dato['fecha_hora'])),
'fechav'=>date("d/m/Y", strtotime($dato['fechaven'])),
'codigo'=>$cliente['txtID_CLIENTE'],
'cc'=>'',
'pre'=>'',
'fe'=>'',
'glosa'=>$vantatit,
'tl'=>'',
'neto1'=>'',
'neto2'=>'',
'neto3'=>'',
'neto4'=>'',
'neto5'=>'',
'neto6'=>'',
'neto7'=>'',
'neto8'=>'',
'neto9'=>'',
'igv'=>'',
'rdoc'=>'',
'rnum'=>'',
'rfec'=>'',
'snum'=>'',
'sfec'=>'',
'ruc'=>$cliente['txtID_CLIENTE'],
'rs'=>$texto,
'tipo'=>'2',
'tdoci'=>$tdoccli,
'mpago'=>$cajatipo['tiposunat'],
'ape1'=>'',
'ape2'=>'',
'nombre'=>'',
'tbien'=>'',
'refmonto'=>'0.00'
);

 
    
}


$idv2=$dato['idventa2'];
}

$data[]=array(
'origen'=>$cons['origenpagos'],
'vou'=>''.$n,
'fecha'=>date("d/m/Y", strtotime($dato['fechaoperacion'])),
'cuenta'=>$cuentacompra,
'debe'=>'0.00',
'haber'=>''.$totalmonto,
'moneda'=>$moneda,
'tc'=>$dato['tipocambio'],
'doc'=>'00',
'numero'=>$dato['operacion'],
'fechad'=>date("d/m/Y", strtotime($dato['fecha_hora'])),
'fechav'=>date("d/m/Y", strtotime($dato['fechaoperacion'])),
'codigo'=>$cliente['txtID_CLIENTE'],
'cc'=>'',
'pre'=>'',
'fe'=>'O101',
'glosa'=>$vantatit,
'tl'=>'',
'neto1'=>'',
'neto2'=>'',
'neto3'=>'',
'neto4'=>'',
'neto5'=>'',
'neto6'=>'',
'neto7'=>'',
'neto8'=>'',
'neto9'=>'',
'igv'=>'',
'rdoc'=>$cajatipo['tipo'],
'rnum'=>$dato['operacion'],
'rfec'=>date("d/m/Y", strtotime($dato['fecha'])),
'snum'=>'',
'sfec'=>date("d/m/Y", strtotime($dato['fecha'])),
'ruc'=>$cliente['txtID_CLIENTE'],
'rs'=>$texto,
'tipo'=>'2',
'tdoci'=>$tdoccli,
'mpago'=>$cajatipo['tiposunat'],
'ape1'=>'',
'ape2'=>'',
'nombre'=>'',
'tbien'=>'',
'refmonto'=>'0.00'
);

}


	
//PAGOS	
/*
$n=0;
	
$datos = "SELECT v.idempresa, v.serie_comprobante, v.num_comprobante, c.fecha, v.fecha_hora, v.moneda, c.idtipo, c.moneda, c.montosoles, c.montodolares, c.tipocambio, v.tipo_comprobante, c.operacion, v.total_compra, v.fechaven, v.idproveedor, c.fechaoperacion FROM caja_ventapago c LEFT JOIN ingreso v ON c.idventa=v.idingreso WHERE DATE(c.fechaoperacion)>='$fecha_inicio' AND DATE(c.fechaoperacion)<='$fecha_fin' AND (v.estado='0' OR v.estado='1' OR v.estado='2' ) AND (v.tipo_comprobante='03' OR v.tipo_comprobante='01') AND c.idempresa='$row[id]' AND c.estado='1' AND c.nivel='1' ORDER BY c.fecha ASC ";
$datos = ejecutarConsulta($datos);
while($dato=mysqli_fetch_array($datos)) {
	
$n=$n+1;
	
$sql2="SELECT *FROM persona WHERE idpersona='$dato[idproveedor]' ";
$cliente= ejecutarConsultaSimpleFila($sql2);

$serienum=$dato['serie_comprobante'].'-'.$dato['num_comprobante'];

if($cliente['tipo_documento']=='DNI'){ $tdoccli='1'; }else{ $tdoccli='6'; }
			
$fechat= date("Y-m-d", strtotime($dato['fecha']));
$vantatit='PAGOS';

$anio= date("d/m/Y", strtotime($dato['fecha']));
	
$fechadocini= date("Y-m-d", strtotime($dato['fecha']));	

$sqlca="SELECT *FROM tipo_cambio WHERE fecha='$fechadocini' ";
$conca= ejecutarConsultaSimpleFila($sqlca);

if($dato['txtID_MONEDA']=='PEN'){ $moneda="S"; $monedag=$cons['venta']; }else{ $moneda="D"; $monedag=$cons['igv']; }

$asientov='ASIENTO DE VENTA';
	
$texto = str_replace($no_permitidas, $permitidas, $cliente['nombre']);
	
$sqlcat="SELECT *FROM caja_tipopago WHERE id='$dato[idtipo]' ";
$cajatipo= ejecutarConsultaSimpleFila($sqlcat);	
	
if($dato['moneda']=='PEN'){
$totalmonto=$dato['montosoles'];
$monedad="S";
$cuenta=$cajatipo['cuentasoles'];
$cuentacompra=$cuentacompraoles;
}else{ 
$totalmonto=$dato['montodolares']; 
$monedad="D";
$cuenta=$cajatipo['cuentadolares'];
$cuentacompra=$cuentacompradolar;
}


$data[]=array(
'origen'=>$cons['origenpagos'],
'vou'=>''.$n,
'fecha'=>$anio,
'cuenta'=>$cuenta,
'debe'=>'0.00',
'haber'=>''.$totalmonto,
'moneda'=>$monedad,
'tc'=>$dato['tipocambio'],
'doc'=>$dato['tipo_comprobante'],
'numero'=>$serienum,
'fechad'=>date("d/m/Y", strtotime($dato['fechaoperacion'])),
'fechav'=>date("d/m/Y", strtotime($dato['fechaoperacion'])),
'codigo'=>$cliente['txtID_CLIENTE'],
'cc'=>'',
'pre'=>'',
'fe'=>'O101',
'glosa'=>$vantatit,
'tl'=>'',
'neto1'=>'',
'neto2'=>'',
'neto3'=>'',
'neto4'=>'',
'neto5'=>'',
'neto6'=>'',
'neto7'=>'',
'neto8'=>'',
'neto9'=>'',
'igv'=>'',
'rdoc'=>$dato['tipo_comprobante'],
'rnum'=>$dato['operacion'],
'rfec'=>date("d/m/Y", strtotime($dato['fecha'])),
'snum'=>'',
'sfec'=>date("d/m/Y", strtotime($dato['fecha'])),
'ruc'=>$cliente['txtID_CLIENTE'],
'rs'=>$texto,
'tipo'=>'2',
'tdoci'=>$tdoccli,
'mpago'=>$cajatipo['tiposunat'],
'ape1'=>'',
'ape2'=>'',
'nombre'=>'',
'tbien'=>''
);

if($conca['venta']){ $tc=$conca['venta']; }else{ $tc=$dato['tipocambio']; }
	
$data[]=array(
'origen'=>$cons['origenpagos'],
'vou'=>''.$n,
'fecha'=>$anio,
'cuenta'=>$cuentacompra,
'debe'=>''.$dato['total_compra'],
'haber'=>'0.00',
'moneda'=>$monedad,
'tc'=>$tc,
'doc'=>$dato['tipo_comprobante'],
'numero'=>$serienum,
'fechad'=>date("d/m/Y", strtotime($dato['fecha_hora'])),
'fechav'=>date("d/m/Y", strtotime($dato['fecha_hora'])),
'codigo'=>$cliente['txtID_CLIENTE'],
'cc'=>'',
'pre'=>'',
'fe'=>'',
'glosa'=>$vantatit,
'tl'=>'',
'neto1'=>'',
'neto2'=>'',
'neto3'=>'',
'neto4'=>'',
'neto5'=>'',
'neto6'=>'',
'neto7'=>'',
'neto8'=>'',
'neto9'=>'',
'igv'=>'',
'rdoc'=>'',
'rnum'=>'',
'rfec'=>'',
'snum'=>'',
'sfec'=>'',
'ruc'=>$cliente['txtID_CLIENTE'],
'rs'=>$texto,
'tipo'=>'2',
'tdoci'=>$tdoccli,
'mpago'=>$cajatipo['tiposunat'],
'ape1'=>'',
'ape2'=>'',
'nombre'=>'',
'tbien'=>''
);

}
*/


/*ACTIVOS FIJOS DEL MES
$vantatit='COMPRA DE ACTIVO DEL MES';
$origenpago=$cons['pago'];	
$ccompras=$cons['ccomprassoles'];
$nn='0';	
		
$sql="SELECT *FROM activos_ingresos WHERE fecha>='$fecha_inicio' AND fecha<='$fecha_fin' AND idempresa='$row[id]'  ORDER by fecha asc ";
$rspta=ejecutarConsulta($sql);
		
while ($reg=$rspta->fetch_object()){
		
$nn=$nn+1;
	
$sqlpac="SELECT *FROM persona WHERE idpersona='$reg->idproveedor' ";
$persac= ejecutarConsultaSimpleFila($sqlpac);
	
$texto = str_replace($no_permitidas, $permitidas, $persac['nombre']);

$anio=$fechat= date("d/m/Y", strtotime($reg->fecha));	

$sqlca="SELECT *FROM tipo_cambio WHERE fecha='$reg->fecha' AND idempresa='0' ";
$conca= ejecutarConsultaSimpleFila($sqlca);

$tipopersona='1';
$tipodoccli='6';

if($persac['tipo_documento']=='DNI'){ 
$tipopersona='2';
$tipodoccli='1';
}
if($reg->moneda=='PEN'){ $moneda="S"; }else{ 
$moneda="D";  
$ccompras=$cons['ccomprasdolares'];
}
	
$subtotal=round(($reg->costo/1.18), 5);
$igv=$reg->costo-$subtotal;
	
$sqlcat="SELECT *FROM categoria WHERE idcategoria='$reg->ccostos'  ";
$cat= ejecutarConsultaSimpleFila($sqlcat);
		
$data[]=array(
'origen'=>$origenpago,
'vou'=>''.$nn,
'fecha'=>$anio,
'cuenta'=>$ctaigv,
'debe'=>''.round($igv, 2),
'haber'=>'0.00',
'moneda'=>$moneda,
'tc'=>$reg->tcambio,
'doc'=>$reg->tipodoc,
'numero'=>$reg->serie.'-'.$reg->numero,
'fechad'=>date("d/m/Y", strtotime($dato['fecha'])),
'fechav'=>date("d/m/Y", strtotime($dato['fecha'])),
'codigo'=>$persac['txtID_CLIENTE'],
'cc'=>$cat['descripcion'],
'pre'=>'',
'fe'=>'O101',
'glosa'=>$vantatit,
'tl'=>'',
'neto1'=>'',
'neto2'=>'',
'neto3'=>'',
'neto4'=>'',
'neto5'=>'',
'neto6'=>'',
'neto7'=>'',
'neto8'=>'',
'neto9'=>'',
'igv'=>'',
'rdoc'=>'',
'rnum'=>'',
'rfec'=>'',
'snum'=>'',
'sfec'=>'',
'ruc'=>$persac['txtID_CLIENTE'],
'rs'=>$texto,
'tipo'=>$tipopersona,
'tdoci'=>$tipodoccli,
'mpago'=>'',
'ape1'=>'',
'ape2'=>'',
'nombre'=>'',
'tbien'=>''
);
*/
/*
$subtotal=round($reg->costo-$igv, 2);
debe
$data[]=array(
'origen'=>$origenpago,
'vou'=>''.$nn,
'fecha'=>$anio,
'cuenta'=>$reg->ctaactivo,
'debe'=>''.$subtotal,
'haber'=>'0.00',
'moneda'=>$moneda,
'tc'=>$reg->tcambio,
'doc'=>$reg->tipodoc,
'numero'=>$reg->serie.'-'.$reg->numero,
'fechad'=>date("d/m/Y", strtotime($dato['fecha'])),
'fechav'=>date("d/m/Y", strtotime($dato['fecha'])),
'codigo'=>$persac['txtID_CLIENTE'],
'cc'=>$cat['descripcion'],
'pre'=>'',
'fe'=>'O101',
'glosa'=>$vantatit,
'tl'=>'',
'neto1'=>'',
'neto2'=>'',
'neto3'=>'',
'neto4'=>'',
'neto5'=>'',
'neto6'=>'',
'neto7'=>'',
'neto8'=>'',
'neto9'=>'',
'igv'=>'',
'rdoc'=>'',
'rnum'=>'',
'rfec'=>'',
'snum'=>'',
'sfec'=>'',
'ruc'=>$persac['txtID_CLIENTE'],
'rs'=>$texto,
'tipo'=>$tipopersona,
'tdoci'=>$tipodoccli,
'mpago'=>'',
'ape1'=>'',
'ape2'=>'',
'nombre'=>'',
'tbien'=>''
);
*/
/*HABER
$data[]=array(
'origen'=>$origenpago,
'vou'=>''.$nn,
'fecha'=>$anio,
'cuenta'=>$ccompras,
'debe'=>'0.00',
'haber'=>''.$reg->costo,
'moneda'=>$moneda,
'tc'=>$reg->tcambio,
'doc'=>$reg->tipodoc,
'numero'=>$reg->serie.'-'.$reg->numero,
'fechad'=>date("d/m/Y", strtotime($dato['fecha'])),
'fechav'=>date("d/m/Y", strtotime($dato['fecha'])),
'codigo'=>$persac['txtID_CLIENTE'],
'cc'=>$cat['descripcion'],
'pre'=>'',
'fe'=>'O101',
'glosa'=>$vantatit,
'tl'=>'',
'neto1'=>'',
'neto2'=>'',
'neto3'=>'',
'neto4'=>'',
'neto5'=>'',
'neto6'=>'',
'neto7'=>'',
'neto8'=>'',
'neto9'=>'',
'igv'=>'',
'rdoc'=>'',
'rnum'=>'',
'rfec'=>'',
'snum'=>'',
'sfec'=>'',
'ruc'=>$persac['txtID_CLIENTE'],
'rs'=>$texto,
'tipo'=>$tipopersona,
'tdoci'=>$tipodoccli,
'mpago'=>'',
'ape1'=>'',
'ape2'=>'',
'nombre'=>'',
'tbien'=>''
);
$nn=$nn+1;	
	
}
*/
/*
$origen='05';		
$origenventa=$cons['venta'];
$ctaigv=$cons['cps'];
$ccostos=$cons['cpd'];

$vantatit='DEPRECIACION DEL MES';		
		

$n=1;	
$cel=1;	
		
		
$sql="SELECT *FROM activos_ingresos WHERE idempresa='$row[id]'  ORDER by fechauso asc ";
$rspta=ejecutarConsulta($sql);
		
while ($reg=$rspta->fetch_object()){
    
$sqlp="SELECT *FROM persona WHERE idpersona='$reg->idproveedor' ";
$pers= ejecutarConsultaSimpleFila($sqlp);
	
$texto = str_replace($no_permitidas, $permitidas, $pers['nombre']);

$tipopersona='1';
$tipodoccli='6';
	
if($pers['tipo_documento']=='DNI'){ 
$tipopersona='2';
$tipodoccli='1';
}

$depreciacion=round($reg->costo/$reg->pordepreciacion, 5);
	
$fech=date("d", strtotime($reg->fechauso));
$aniod=$fechat= date("d/m/Y", strtotime($fechatot.'-'.$fech));	
$fechap=$anio=$fechat= date("Y-m-d", strtotime($fechatot.'-'.$fech));

$sqlca="SELECT *FROM tipo_cambio WHERE fecha='$fechap'  ";
$conca= ejecutarConsultaSimpleFila($sqlca);
	
$sqlcat="SELECT *FROM categoria WHERE idcategoria='$reg->ccostos'  ";
$cat= ejecutarConsultaSimpleFila($sqlcat);

if($reg->moneda=='PEN'){ $moneda="S"; }else{ $moneda="D";  }
		
$data[]=array(
'origen'=>$origen,
'vou'=>''.$n,
'fecha'=>$aniod,
'cuenta'=>$reg->ctagastos,
'debe'=>''.$depreciacion,
'haber'=>'0.00',
'moneda'=>$moneda,
'tc'=>'1.00',
'doc'=>$reg->tipodoc,
'numero'=>$reg->serie.'-'.$reg->numero,
'fechad'=>$aniod,
'fechav'=>$aniod,
'codigo'=>$pers['txtID_CLIENTE'],
'cc'=>$cat['descripcion'],
'pre'=>'',
'fe'=>'',
'glosa'=>$vantatit,
'tl'=>'',
'neto1'=>'',
'neto2'=>'',
'neto3'=>'',
'neto4'=>'',
'neto5'=>'',
'neto6'=>'',
'neto7'=>'',
'neto8'=>'',
'neto9'=>'',
'igv'=>'',
'rdoc'=>'',
'rnum'=>'',
'rfec'=>'',
'snum'=>'',
'sfec'=>'',
'ruc'=>$pers['txtID_CLIENTE'],
'rs'=>$texto,
'tipo'=>$tipopersona,
'tdoci'=>$tipodoccli,
'mpago'=>'',
'ape1'=>'',
'ape2'=>'',
'nombre'=>'',
'tbien'=>''
);
	
$data[]=array(
'origen'=>$origen,
'vou'=>''.$n,
'fecha'=>$aniod,
'cuenta'=>$reg->ctadepreciacion,
'debe'=>'0.00',
'haber'=>''.$depreciacion,
'moneda'=>$moneda,
'tc'=>'1.00',
'doc'=>$reg->tipodoc,
'numero'=>$reg->serie.'-'.$reg->numero,
'fechad'=>$aniod,
'fechav'=>$aniod,
'codigo'=>$pers['txtID_CLIENTE'],
'cc'=>'',
'pre'=>'',
'fe'=>'',
'glosa'=>$vantatit,
'tl'=>'',
'neto1'=>'',
'neto2'=>'',
'neto3'=>'',
'neto4'=>'',
'neto5'=>'',
'neto6'=>'',
'neto7'=>'',
'neto8'=>'',
'neto9'=>'',
'igv'=>'',
'rdoc'=>'',
'rnum'=>'',
'rfec'=>'',
'snum'=>'',
'sfec'=>'',
'ruc'=>$pers['txtID_CLIENTE'],
'rs'=>$texto,
'tipo'=>$tipopersona,
'tdoci'=>$tipodoccli,
'mpago'=>'',
'ape1'=>'',
'ape2'=>'',
'nombre'=>'',
'tbien'=>''
);
	
	
$n=$n+1;	
}
				
		
		
	/*	
$rspta=$venta->listarsisf($fecha_inicio, $fecha_fin);
	*/	
	/*	
$sql="SELECT *FROM activos_ingresos ORDER by fechauso asc ";
$rspta=ejecutarConsulta($sql);
		
while ($reg=$rspta->fetch_object()){
	
$n=$n+1;
	



	
}
		
	*/	
	

$meses = array("Enero","Febrero","Marzo","Abril","Mayo","Junio","Julio","Agosto","Septiembre","Octubre","Noviembre","Diciembre");

$fechames=date("t/m/Y", strtotime($fecha_fin));
$finicio=date("Y-m", strtotime($fecha_inicio));	
$ffin=date("Y-m", strtotime($fecha_fin));
$mes=date("m", strtotime($fecha_fin));

$cadena=ltrim($mes, "0");
$cadena=$cadena-1;
$periodonombre=$meses[$cadena];

	
///PLANILLAS//
$vantatit='PLANILLAS MES DE '.$periodonombre;
$origenpago=$cons['pago'];	
$ccompras=$cons['ccomprassoles'];
$nnn='0';

$origen='11';

$ctadebe='621101';
$movilidad='622001';
$bonos='622002';
$otrasrem='622009';
$essaludebe='627101';
$ctasigfamiliar='622010';


$essaludeber='403101';
$onp='403201';
$ctarenta5ta='401731';
$afp='417001';
$adelantos='141101';
$sueldporpagar='411111';


$moneda='S';
$tcambio='1.00';

$permisos=array();
$exploded=explode(',', $row['paquetes']);	
foreach ($exploded as $index){
	array_push($permisos, $index);
}
in_array(4,$permisos)?$paqueteotros=1:$paqueteotros=0;

if ($paqueteotros==101){
$nnn=$nnn+1;

$sqlext3="SELECT SUM(monto) AS total, SUM(horas) AS horastot, SUM(minutos) AS minutostot  FROM planillas_extras WHERE periodo='$finicio' AND idempresa='$row[id]'  AND tipocodigo='0909' ";
$faext3= ejecutarConsultaSimpleFila($sqlext3);

$sqlext6="SELECT SUM(monto) AS total, SUM(horas) AS horastot, SUM(minutos) AS minutostot FROM planillas_extras WHERE periodo='$finicio'  AND tipocodigo='1003' ";
$faext6= ejecutarConsultaSimpleFila($sqlext6);

$sqlext5="SELECT SUM(monto) AS total, SUM(horas) AS horastot, SUM(minutos) AS minutostot  FROM planillas_extras WHERE periodo='$finicio' AND idempresa='$row[id]'  AND tipocodigo='1005' ";
$faext5= ejecutarConsultaSimpleFila($sqlext5);

$sqletrab="SELECT SUM(remuneracion) AS total, SUM(salud) AS totsalud, SUM(aportemonto) AS totaporte, SUM(rentan5ta) AS totquita, SUM(afpmonto) AS totafp, SUM(saludvidamonto) AS totsaludvida, SUM(primaseguro) AS totprima, SUM(familiarmonto) AS totfmiliar  FROM planilla_mensual WHERE idempresa='$row[id]' AND periodo='$finicio' ";
$trab= ejecutarConsultaSimpleFila($sqletrab);

$totalnoafectos=$faext3['total']+$faext6['total'];
$totalremuneracionf=$totalnoafectos+$trab['total'];

$restasalud='0.00';;
if($trab['totsaludvida']>'0'){
$fondopensiones=$trab['totsaludvida'];	
}

$fondopensiones='0.00';
if($trab['totaporte']>'0'){
$fondopensiones=($trab['total']*10)/100;	
}

$descuento=$trab['totaporte']+$trab['afpmonto']+$trab['totprima']+$trab['totquita']+$fondopensiones+$restasalud;

$sueldo=$totalremuneracionf;


$data[]=array(
'origen'=>$origen,
'vou'=>''.$nnn,
'fecha'=>$fechames,
'cuenta'=>$ctadebe,
'debe'=>''.$totalremuneracionf,
'haber'=>'0.00',
'moneda'=>$moneda,
'tc'=>$tcambio,
'doc'=>'',
'numero'=>'',
'fechad'=>$fechames,
'fechav'=>$fechames,
'codigo'=>'',
'cc'=>'',
'pre'=>'',
'fe'=>'O101',
'glosa'=>$vantatit,
'tl'=>'',
'neto1'=>'',
'neto2'=>'',
'neto3'=>'',
'neto4'=>'',
'neto5'=>'',
'neto6'=>'',
'neto7'=>'',
'neto8'=>'',
'neto9'=>'',
'igv'=>'',
'rdoc'=>'',
'rnum'=>'',
'rfec'=>'',
'snum'=>'',
'sfec'=>'',
'ruc'=>'',
'rs'=>'',
'tipo'=>'',
'tdoci'=>'',
'mpago'=>'',
'ape1'=>'',
'ape2'=>'',
'nombre'=>'',
'tbien'=>''
);

/*asignacion familiar*/
$asigfamiliar='0.00';
if($trab['totalfamiliar']!=''){ $asigfamiliar=$trab['totalfamiliar']; }

$data[]=array(
'origen'=>$origen,
'vou'=>''.$nnn,
'fecha'=>$fechames,
'cuenta'=>$ctasigfamiliar,
'debe'=>''.$asigfamiliar,
'haber'=>'0.00',
'moneda'=>$moneda,
'tc'=>$tcambio,
'doc'=>'',
'numero'=>'',
'fechad'=>$fechames,
'fechav'=>$fechames,
'codigo'=>'',
'cc'=>'',
'pre'=>'',
'fe'=>'O101',
'glosa'=>$vantatit,
'tl'=>'',
'neto1'=>'',
'neto2'=>'',
'neto3'=>'',
'neto4'=>'',
'neto5'=>'',
'neto6'=>'',
'neto7'=>'',
'neto8'=>'',
'neto9'=>'',
'igv'=>'',
'rdoc'=>'',
'rnum'=>'',
'rfec'=>'',
'snum'=>'',
'sfec'=>'',
'ruc'=>'',
'rs'=>'',
'tipo'=>'',
'tdoci'=>'',
'mpago'=>'',
'ape1'=>'',
'ape2'=>'',
'nombre'=>'',
'tbien'=>''
);


$montomovilidad='0.00';
if($faext3){ $montomovilidad=$faext3['total']; }

$data[]=array(
'origen'=>$origen,
'vou'=>''.$nnn,
'fecha'=>$fechames,
'cuenta'=>$movilidad,
'debe'=>$montomovilidad,
'haber'=>'0.00',
'moneda'=>$moneda,
'tc'=>$tcambio,
'doc'=>'',
'numero'=>'',
'fechad'=>$fechames,
'fechav'=>$fechames,
'codigo'=>'',
'cc'=>'',
'pre'=>'',
'fe'=>'O101',
'glosa'=>$vantatit,
'tl'=>'',
'neto1'=>'',
'neto2'=>'',
'neto3'=>'',
'neto4'=>'',
'neto5'=>'',
'neto6'=>'',
'neto7'=>'',
'neto8'=>'',
'neto9'=>'',
'igv'=>'',
'rdoc'=>'',
'rnum'=>'',
'rfec'=>'',
'snum'=>'',
'sfec'=>'',
'ruc'=>'',
'rs'=>'',
'tipo'=>'',
'tdoci'=>'',
'mpago'=>'',
'ape1'=>'',
'ape2'=>'',
'nombre'=>'',
'tbien'=>''
);


$data[]=array(
'origen'=>$origen,
'vou'=>''.$nnn,
'fecha'=>$fechames,
'cuenta'=>$otrasrem,
'debe'=>$faext5['total'],
'haber'=>'0.00',
'moneda'=>$moneda,
'tc'=>$tcambio,
'doc'=>'',
'numero'=>'',
'fechad'=>$fechames,
'fechav'=>$fechames,
'codigo'=>'',
'cc'=>'',
'pre'=>'',
'fe'=>'O101',
'glosa'=>$vantatit,
'tl'=>'',
'neto1'=>'',
'neto2'=>'',
'neto3'=>'',
'neto4'=>'',
'neto5'=>'',
'neto6'=>'',
'neto7'=>'',
'neto8'=>'',
'neto9'=>'',
'igv'=>'',
'rdoc'=>'',
'rnum'=>'',
'rfec'=>'',
'snum'=>'',
'sfec'=>'',
'ruc'=>'',
'rs'=>'',
'tipo'=>'',
'tdoci'=>'',
'mpago'=>'',
'ape1'=>'',
'ape2'=>'',
'nombre'=>'',
'tbien'=>''
);

$data[]=array(
'origen'=>$origen,
'vou'=>''.$nnn,
'fecha'=>$fechames,
'cuenta'=>$essaludebe,
'debe'=>$trab['totsalud'],
'haber'=>'0.00',
'moneda'=>$moneda,
'tc'=>$tcambio,
'doc'=>'',
'numero'=>'',
'fechad'=>$fechames,
'fechav'=>$fechames,
'codigo'=>'',
'cc'=>'',
'pre'=>'',
'fe'=>'O101',
'glosa'=>$vantatit,
'tl'=>'',
'neto1'=>'',
'neto2'=>'',
'neto3'=>'',
'neto4'=>'',
'neto5'=>'',
'neto6'=>'',
'neto7'=>'',
'neto8'=>'',
'neto9'=>'',
'igv'=>'',
'rdoc'=>'',
'rnum'=>'',
'rfec'=>'',
'snum'=>'',
'sfec'=>'',
'ruc'=>'',
'rs'=>'',
'tipo'=>'',
'tdoci'=>'',
'mpago'=>'',
'ape1'=>'',
'ape2'=>'',
'nombre'=>'',
'tbien'=>''
);



$data[]=array(
'origen'=>$origen,
'vou'=>''.$nnn,
'fecha'=>$fechames,
'cuenta'=>$essaludeber,
'debe'=>'0.00',
'haber'=>$trab['totsalud'],
'moneda'=>$moneda,
'tc'=>$tcambio,
'doc'=>'',
'numero'=>'',
'fechad'=>$fechames,
'fechav'=>$fechames,
'codigo'=>'',
'cc'=>'',
'pre'=>'',
'fe'=>'O101',
'glosa'=>$vantatit,
'tl'=>'',
'neto1'=>'',
'neto2'=>'',
'neto3'=>'',
'neto4'=>'',
'neto5'=>'',
'neto6'=>'',
'neto7'=>'',
'neto8'=>'',
'neto9'=>'',
'igv'=>'',
'rdoc'=>'',
'rnum'=>'',
'rfec'=>'',
'snum'=>'',
'sfec'=>'',
'ruc'=>'',
'rs'=>'',
'tipo'=>'',
'tdoci'=>'',
'mpago'=>'',
'ape1'=>'',
'ape2'=>'',
'nombre'=>'',
'tbien'=>''
);

$data[]=array(
'origen'=>$origen,
'vou'=>''.$nnn,
'fecha'=>$fechames,
'cuenta'=>$onp,
'debe'=>'0.00',
'haber'=>$trab['totaporte'],
'moneda'=>$moneda,
'tc'=>$tcambio,
'doc'=>'',
'numero'=>'',
'fechad'=>$fechames,
'fechav'=>$fechames,
'codigo'=>'',
'cc'=>'',
'pre'=>'',
'fe'=>'O101',
'glosa'=>$vantatit,
'tl'=>'',
'neto1'=>'',
'neto2'=>'',
'neto3'=>'',
'neto4'=>'',
'neto5'=>'',
'neto6'=>'',
'neto7'=>'',
'neto8'=>'',
'neto9'=>'',
'igv'=>'',
'rdoc'=>'',
'rnum'=>'',
'rfec'=>'',
'snum'=>'',
'sfec'=>'',
'ruc'=>'',
'rs'=>'',
'tipo'=>'',
'tdoci'=>'',
'mpago'=>'',
'ape1'=>'',
'ape2'=>'',
'nombre'=>'',
'tbien'=>''
);

/*QUINTA*/
$renta5ta='0.00';
if($trab['totquita']!=''){ $renta5ta=$trab['totquita']; }

$data[]=array(
'origen'=>$origen,
'vou'=>''.$nnn,
'fecha'=>$fechames,
'cuenta'=>$ctarenta5ta,
'debe'=>'0.00',
'haber'=>$renta5ta,
'moneda'=>$moneda,
'tc'=>$tcambio,
'doc'=>'',
'numero'=>'',
'fechad'=>$fechames,
'fechav'=>$fechames,
'codigo'=>'',
'cc'=>'',
'pre'=>'',
'fe'=>'O101',
'glosa'=>$vantatit,
'tl'=>'',
'neto1'=>'',
'neto2'=>'',
'neto3'=>'',
'neto4'=>'',
'neto5'=>'',
'neto6'=>'',
'neto7'=>'',
'neto8'=>'',
'neto9'=>'',
'igv'=>'',
'rdoc'=>'',
'rnum'=>'',
'rfec'=>'',
'snum'=>'',
'sfec'=>'',
'ruc'=>'',
'rs'=>'',
'tipo'=>'',
'tdoci'=>'',
'mpago'=>'',
'ape1'=>'',
'ape2'=>'',
'nombre'=>'',
'tbien'=>''
);


$data[]=array(
'origen'=>$origen,
'vou'=>''.$nnn,
'fecha'=>$fechames,
'cuenta'=>$afp,
'debe'=>'0.00',
'haber'=>round($trab['totafp'], 2).'',
'moneda'=>$moneda,
'tc'=>$tcambio,
'doc'=>'',
'numero'=>'',
'fechad'=>$fechames,
'fechav'=>$fechames,
'codigo'=>'',
'cc'=>'',
'pre'=>'',
'fe'=>'O101',
'glosa'=>$vantatit,
'tl'=>'',
'neto1'=>'',
'neto2'=>'',
'neto3'=>'',
'neto4'=>'',
'neto5'=>'',
'neto6'=>'',
'neto7'=>'',
'neto8'=>'',
'neto9'=>'',
'igv'=>'',
'rdoc'=>'',
'rnum'=>'',
'rfec'=>'',
'snum'=>'',
'sfec'=>'',
'ruc'=>'',
'rs'=>'',
'tipo'=>'',
'tdoci'=>'',
'mpago'=>'',
'ape1'=>'',
'ape2'=>'',
'nombre'=>'',
'tbien'=>''
);

/*
SUELDO POR PAGAR
*/
$data[]=array(
'origen'=>$origen,
'vou'=>''.$nnn,
'fecha'=>$fechames,
'cuenta'=>$sueldporpagar,
'debe'=>'0.00',
'haber'=>round($sueldo, 2).'',
'moneda'=>$moneda,
'tc'=>$tcambio,
'doc'=>'',
'numero'=>'',
'fechad'=>$fechames,
'fechav'=>$fechames,
'codigo'=>'',
'cc'=>'',
'pre'=>'',
'fe'=>'O101',
'glosa'=>$vantatit,
'tl'=>'',
'neto1'=>'',
'neto2'=>'',
'neto3'=>'',
'neto4'=>'',
'neto5'=>'',
'neto6'=>'',
'neto7'=>'',
'neto8'=>'',
'neto9'=>'',
'igv'=>'',
'rdoc'=>'',
'rnum'=>'',
'rfec'=>'',
'snum'=>'',
'sfec'=>'',
'ruc'=>'',
'rs'=>'',
'tipo'=>'',
'tdoci'=>'',
'mpago'=>'',
'ape1'=>'',
'ape2'=>'',
'nombre'=>'',
'tbien'=>''
);



}




	
header('Content-Type: application/json');	
echo json_encode($data);
exit();
}

if($ruce == '20548960771')
{
    include '../../../cine/config/config.php';
    include '../../../cine/helpers/helpers.php';
    include '../../../cine/libraries/conexion.php';
    
    if(isset($_GET['fechai'])){  $fecha_inicio=$_REQUEST["fechai"]; }else{ $fecha_inicio=''; }
    if(isset($_GET['fechaf'])){  $fecha_fin=$_REQUEST["fechaf"]; }else{ $fecha_fin=''; }
    $ruc=$_REQUEST["ruc"];
    
    $no_permitidas= array ("á","é","í","ó","ú","Á","É","Í","Ó","Ú","À","Ã","Ì","Ò","Ù","Ã™","Ã ","Ã¨","Ã¬","Ã²","Ã¹","ç","Ç","Ã¢","ê","Ã®","Ã´","Ã»","Ã", "ÃŠ", "ÃŽ", "Ã", "Ã›", "ü","Ã¶", "Ã–","Ã¯","Ã¤","«","Ò","Ã","Ã","Ã‹","*","%", "'", '"');
    $permitidas= array ("a","e","i","o","u","A","E","I","O","U","N","A","E","I","O","U","a","e","i","o","u","c","C","a","e","i","o","u","A","E","I","O","U","u","o","O","i", "a", "e", "U", "I", "A", "E", ".", ".", "", "");

    $ruce  = $_GET['ruc'];
    $fi    = $_GET['fechai'];
    $ff    = $_GET['fechaf'];
    
    $query_empresa = $connect->prepare("SELECT * FROM tbl_empresas WHERE ruc = $ruce");
    $query_empresa->execute();
    $row_config=$query_empresa->fetch(PDO::FETCH_ASSOC);

    //print_r($row_config);exit();
    
    $empresa        = $row_config['id_empresa'];
    /*DATOS PARA VENTAS SE DEBE PONER ESTOS PARAMETROS EN ALMACEN*/
    $origen_venta        = '50';
    $origen_cobranzas    = '90';
    $cta_igv_venta       = '4011111';
    $cta_12_s_venta      = '1212115';
    $cta_12_d_venta      = $row_config['cta_cobrar_dolar'];
    /*comprobantes aceptados solo boletas*/
    $query_venta     = "SELECT * FROM vw_tbl_ventas_diarias2 WHERE ruc= $ruce  AND fecha BETWEEN '$fi' AND '$ff' AND tipocomp = '03'";
    $resultado_venta = $connect->query($query_venta);
    $row_venta       = $resultado_venta->fetchAll(PDO::FETCH_ASSOC);
    $n=0;
    $data= Array();
    $vou=0;
    
   // var_dump($row_venta);exit();
    
    foreach($row_venta as $row)
    {
         $idventa = $row['id'];
         $tdoc     = $row['tipocomp'];
         $ndoc     = $row['serie'].'-'.$row['desde'].'-'.$row['hasta'];
         $moneda  = $row['moneda'];
    
        if($row['moneda'] == 'PEN')
        {
            $cta_12 =  $cta_12_s_venta;
            $moneda =  'S';
        }
    
        else
        {
            $cta_12 =  $cta_12_d_venta;
            $moneda =  'D';
        }
    
        $cliente       = $row['idcliente'];
        $query = "SELECT * FROM tbl_contribuyente WHERE id_persona = $cliente";
        //echo $query;exit();
        $query_cliente = $connect->prepare($query);
        $query_cliente->execute();
        $row_cliente   = $query_cliente->fetch(PDO::FETCH_ASSOC);
    
        $ruc          = $row_cliente['num_doc'];
        $persona      = $row_cliente['nombre_persona'];
        $texto = str_replace($no_permitidas, $permitidas, $persona);
        $tipo_doc     = $row_cliente['tipo_doc'];
        $tipo         = '2';
        
        $total = $row['total'];
    
        $vou+=1;
    
        $row['correlativo_ref'] = '';             
    	if($row['tipocomp']=='07')
    	{     
    	    /*doc ref*/
    
            $tcomp =$row['tipocomp_ref'];
            $scmop =$row['serie_ref'];
            $ccomp = $row['desde'];
            
            
            $query_dr = "SELECT * FROM tbl_venta_cab WHERE idempresa=$empresa and tipocomp = $tcomp and serie =  '$scmop' and correlativo = $ccomp";
            echo $query_dr;
            $resultado_dr = $connect->prepare($query_dr);
            $resultado_dr->execute();
            $row__dr = $resultado_dr->fetch(PDO::FETCH_ASSOC);
            
            $fecha_dr = $row__dr['fecha_emision'];
            /*fin doc ref*/
    
    			$data[]=array(
    			'origen'=>$origen_venta,
    			'vou'=>''.$vou,
    			'fecha'=>date("d/m/Y", strtotime($row['fecha'])),
    			'cuenta'=>$cta_12,
    			'debe'=>'0.00',
    			'haber'=>''.$total,
    			'moneda'=>$moneda,
    			'tc'=>'3.00',
    			'doc'=>$tdoc,
    			'numero'=>$ndoc,
    			'fechad'=> date("d/m/Y", strtotime($row['fecha'])),
    			'fechav'=> date("d/m/Y", strtotime($row['fecha'])),
    			'codigo'=>$ruc,
    			'cc'=>'',
    			'pre'=>'',
    			'fe'=>'',
    			'glosa'=>'NC '.$tdoc.'-'.$ndoc.' DOC REF: '.$row['tipocomp_ref'].'-'.$row['serie_ref'].'-'.$row['correlativo_ref'],
    			'tl'=>'',
    			'neto1'=>'',
    			'neto2'=>'',
    			'neto3'=>'',
    			'neto4'=>'',
    			'neto5'=>'',
    			'neto6'=>'',
    			'neto7'=>'',
    			'neto8'=>'',
    			'neto9'=>'',
    			'igv'=>'',
    			'rdoc'=>$row['tipocomp_ref'],
    			'rnum'=>$row['serie_ref'].'-'.$row['correlativo_ref'],
    			'rfec'=>date("d/m/Y", strtotime($fecha_dr)),
    			'snum'=>'',	
    			'sfec'=>'',
    			'ruc'=>$ruc,
    			'rs'=>$persona,
    			'tipo'=>$tipo,
    			'tdoci'=>$tipo_doc,
    			'mpago'=>'',
    			'ape1'=>'',
    			'ape2'=>'',
    			'nombre'=>'',
    			'tbien'=>'',
    			'refmonto'=>'0.00'
    			);
    	            
    	        /*cuenta 40*/
    			//$vou+=1;
    
    			$data[]=array(
    					'origen'=>$origen_venta,
    					'vou'=>''.$vou,
    					'fecha'=>date("d/m/Y", strtotime($row['fecha'])),
    					'cuenta'=>$cta_igv_venta,
    					'debe'=>$row['igv'],
    					'haber'=>'0.00',
    					'moneda'=>$moneda,
    					'tc'=>'3.00',
    					'doc'=>$tdoc,
    					'numero'=>$ndoc,
    					'fechad'=> date("d/m/Y", strtotime($row['fecha'])),
    					'fechav'=> date("d/m/Y", strtotime($row['fecha'])),
    					'codigo'=>$ruc,
    					'cc'=>'',
    					'pre'=>'',
    					'fe'=>'',
    					'glosa'=>'NC '.$tdoc.'-'.$ndoc.' DOC REF: '.$row['tipocomp_ref'].'-'.$row['serie_ref'].'-'.$row['correlativo_ref'],
    					'tl'=>'V',
    					'neto1'=>$row['op_gravadas'],
    					'neto2'=>'',
    					'neto3'=>'',
    					'neto4'=>'',
    					'neto5'=>$row['op_exoneradas'],
    					'neto6'=>$row['op_inafectas'],
    					'neto7'=>'',
    					'neto8'=>'',
    					'neto9'=>'',
    					'igv'=>$row['igv'],
    					'rdoc'=>$row['tipocomp_ref'],
    					'rnum'=>$row['serie_ref'].'-'.$row['correlativo_ref'],
    					'rfec'=>date("d/m/Y", strtotime($fecha_dr)),
    					'snum'=>'',	
    					'sfec'=>'',
    					'ruc'=>$ruc,
    					'rs'=>$persona,
    					'tipo'=>$tipo,
    					'tdoci'=>$tipo_doc,
    					'mpago'=>'',
    					'ape1'=>'',
    					'ape2'=>'',
    					'nombre'=>'',
    					'tbien'=>'',
    					'refmonto'=>'0.00');
    					
    					
    
    				//$vou+=1 cuenta 70;
    
    				$data[]=array(
    						'origen'=>$origen_venta,
    						'vou'=>''.$vou,
    						'fecha'=>date("d/m/Y", strtotime($row['fecha'])),
    						'cuenta'=>'7011111',
    						'debe'=>$row['op_gravadas'] + $row['op_exoneradas'] + $row['op_inafectas'],
    						'haber'=>'0.00',
    						'moneda'=>$moneda,
    						'tc'=>'3.00',
    						'doc'=>$tdoc,
    						'numero'=>$ndoc,
    						'fechad'=> date("d/m/Y", strtotime($row['fecha'])),
    						'fechav'=> date("d/m/Y", strtotime($row['fecha'])),
    						'codigo'=>$ruc,
    						'cc'=>'',
    						'pre'=>'',
    						'fe'=>'',
    						'glosa'=>'NOTA DE CREDITO '.$tdoc.'-'.$ndoc.' DOC REF: '.$row['tipocomp_ref'].'-'.$row['serie_ref'].'-'.$row['correlativo_ref'],
    						'tl'=>'V',
    						'neto1'=>$row['op_gravadas'],
    						'neto2'=>'',
    						'neto3'=>'',
    						'neto4'=>'',
    						'neto5'=>$row['op_exoneradas'],
    						'neto6'=>$row['op_inafectas'],
    						'neto7'=>'',
    						'neto8'=>'',
    						'neto9'=>'',
    						'igv'=>$row['igv'],
    						'rdoc'=>$row['tipocomp_ref'],
    						'rnum'=>$row['serie_ref'].'-'.$row['correlativo_ref'],
    						'rfec'=>'',
    						'snum'=>'',	
    						'sfec'=>'',
    						'ruc'=>$ruc,
    						'rs'=>$persona,
    						'tipo'=>$tipo,
    						'tdoci'=>$tipo_doc,
    						'mpago'=>'',
    						'ape1'=>'',
    						'ape2'=>'',
    						'nombre'=>'',
    						'tbien'=>'',
    						'refmonto'=>'0.00');
    					
    					
    	    
    	  
    
    		
    
    	}
    	else /*diferente a nota de credito*/
    	{
     // echo 'hola';
    	    $data[]=array(
    					'origen'=>$origen_venta,
    					'vou'=>''.$vou,
    					'fecha'=>date("d/m/Y", strtotime($row['fecha'])),
    					'cuenta'=>$cta_12,
    					'debe'=>$total,
    					'haber'=>'0.00',
    					'moneda'=>$moneda,
    					'tc'=>'3.00',
    					'doc'=>$tdoc,
    					'numero'=>$ndoc,
    					'fechad'=> date("d/m/Y", strtotime($row['fecha'])),
    					'fechav'=> date("d/m/Y", strtotime($row['fecha'])),
    					'codigo'=>$ruc,
    					'cc'=>'',
    					'pre'=>'',
    					'fe'=>'',
    					'glosa'=>'RESUMEN DE BOLETAS '.$tdoc.'-'.$ndoc,
    					'tl'=>'V',
    					'neto1'=>$row['op_gravadas'],
    					'neto2'=>'',
    					'neto3'=>'',
    					'neto4'=>'',
    					'neto5'=>$row['op_exoneradas'],
    					'neto6'=>$row['op_inafectas'],
    					'neto7'=>'',
    					'neto8'=>'',
    					'neto9'=>'',
    					'igv'=>$row['igv'],
    					'rdoc'=>$row['tipocomp_ref'],
    					'rnum'=>$row['serie_ref'].'-'.$row['correlativo_ref'],
    					'rfec'=>'',
    					'snum'=>'',	
    					'sfec'=>'',
    					'ruc'=>$ruc,
    					'rs'=>$persona,
    					'tipo'=>$tipo,
    					'tdoci'=>$tipo_doc,
    					'mpago'=>'',
    					'ape1'=>'',
    					'ape2'=>'',
    					'nombre'=>'',
    					'tbien'=>'',
    					'refmonto'=>'0.00');
    
    	    /*cuenta 70*/
    	    $data[]=array(
    					'origen'=>$origen_venta,
    					'vou'=>''.$vou,
    					'fecha'=>date("d/m/Y", strtotime($row['fecha'])),
    					'cuenta'=>'7011111',
    					'debe'=>'0.00',
    					'haber'=>"".($row['op_gravadas'] + $row['op_exoneradas'] + $row['op_inafectas']),
    					'moneda'=>$moneda,
    					'tc'=>'3.00',
    					'doc'=>$tdoc,
    					'numero'=>$ndoc,
    					'fechad'=> date("d/m/Y", strtotime($row['fecha'])),
    					'fechav'=> date("d/m/Y", strtotime($row['fecha'])),
    					'codigo'=>$ruc,
    					'cc'=>'',
    					'pre'=>'',
    					'fe'=>'',
    					'glosa'=>'POR LA VENTA DEL CPE '.$tdoc.'-'.$ndoc,
    					'tl'=>'V',
    					'neto1'=>"".$row['op_gravadas'],
    					'neto2'=>'',
    					'neto3'=>'',
    					'neto4'=>'',
    					'neto5'=>"".$row['op_exoneradas'],
    					'neto6'=>"".$row['op_inafectas'],
    					'neto7'=>'',
    					'neto8'=>'',
    					'neto9'=>'',
    					'igv'=>"".$row['igv'],
    					'rdoc'=>$row['tipocomp_ref'],
    					'rnum'=>$row['serie_ref'].'-'.$row['correlativo_ref'],
    					'rfec'=>'',
    					'snum'=>'',	
    					'sfec'=>'',
    					'ruc'=>$ruc,
    					'rs'=>$persona,
    					'tipo'=>$tipo,
    					'tdoci'=>$tipo_doc,
    					'mpago'=>'',
    					'ape1'=>'',
    					'ape2'=>'',
    					'nombre'=>'',
    					'tbien'=>'',
    					'refmonto'=>'0.00');    
    
    	   
    	   
    	                
    		/*cuenta 40*/
    		   //$vou+=1;
    		   
    		  
    	                                 
    	    $data[]=array(
    					'origen'=>$origen_venta,
    					'vou'=>''.$vou,
    					'fecha'=>date("d/m/Y", strtotime($row['fecha'])),
    					'cuenta'=>$cta_igv_venta,
    					'debe'=>'0.00',
    					'haber'=>"".$row['igv'],
    					'moneda'=>$moneda,
    					'tc'=>'3.00',
    					'doc'=>$tdoc,
    					'numero'=>$ndoc,
    					'fechad'=> date("d/m/Y", strtotime($row['fecha'])),
    					'fechav'=> date("d/m/Y", strtotime($row['fecha'])),
    					'codigo'=>$ruc,
    					'cc'=>'',
    					'pre'=>'',
    					'fe'=>'',
    					'glosa'=>'POR LA VENTA DEL CPE '.$tdoc.'-'.$ndoc,
    					'tl'=>'V',
    					'neto1'=>$row['op_gravadas'],
    					'neto2'=>'',
    					'neto3'=>'',
    					'neto4'=>'',
    					'neto5'=>$row['op_exoneradas'],
    					'neto6'=>$row['op_inafectas'],
    					'neto7'=>'',
    					'neto8'=>'',
    					'neto9'=>'',
    					'igv'=>$row['igv'],
    					'rdoc'=>$row['tipocomp_ref'],
    					'rnum'=>$row['serie_ref'].'-'.$row['correlativo_ref'],
    					'rfec'=>'',
    					'snum'=>'',	
    					'sfec'=>'',
    					'ruc'=>$ruc,
    					'rs'=>$persona,
    					'tipo'=>$tipo,
    					'tdoci'=>$tipo_doc,
    					'mpago'=>'',
    					'ape1'=>'',
    					'ape2'=>'',
    					'nombre'=>'',
    					'tbien'=>'',
    					'refmonto'=>'0.00');                
    
    	    //$vou+=1;   
    
    	}
    }
//exit();
/*************anulados*********************/

//$vou = $vouventa;
$query_anulado    = "SELECT * FROM vw_tbl_venta_cab WHERE ruc= $ruce  AND fecha_emision BETWEEN '$fi' AND '$ff' AND tipocomp in ('01','03','07','08') AND feestado in ('3','5','6')";
$resultado_anulado = $connect->query($query_anulado);
$row_anulado       = $resultado_anulado->fetchAll(PDO::FETCH_ASSOC);

//echo $query_anulado;
//print_r($row_anulado);
/*cuenta 40*/
foreach($row_anulado as $anulado)
{
	$vou+=1;
	$data[]=array(
			'origen'=>$origen_venta,
			'vou'=>''.$vou,
			'fecha'=>date("d/m/Y", strtotime($anulado['fecha_emision'])),
			'cuenta'=>$cta_igv_venta,
			'debe'=>'0.00',
			'haber'=>'0.00',
			'moneda'=>$moneda,
			'tc'=>'3.00',
			'doc'=>$anulado['tipocomp'],
			'numero'=>$anulado['serie'].'-'.$anulado['correlativo'],
			'fechad'=> date("d/m/Y", strtotime($anulado['fecha_emision'])),
			'fechav'=> date("d/m/Y", strtotime($anulado['fecha_vencimiento'])),
			'codigo'=>'00000000000',
			'cc'=>'',
			'pre'=>'',
			'fe'=>'',
			'glosa'=>'CPE ANULADO '.$anulado['tipocomp'].'-'.$anulado['serie'].'-'.$anulado['correlativo'],
			'tl'=>'V',
			'neto1'=>'',
			'neto2'=>'',
			'neto3'=>'',
			'neto4'=>'',
			'neto5'=>'',
			'neto6'=>'',
			'neto7'=>'',
			'neto8'=>'',
			'neto9'=>'',
			'igv'=>'',
			'rdoc'=>$anulado['tipocomp_ref'],
			'rnum'=>$anulado['serie_ref'].'-'.$anulado['correlativo_ref'],
			'rfec'=>'',
			'snum'=>'',	
			'sfec'=>'',
			'ruc'=>'00000000000',
			'rs'=>'CPE ANULADO',
			'tipo'=>'1',
			'tdoci'=>'0',
			'mpago'=>'',
			'ape1'=>'',
			'ape2'=>'',
			'nombre'=>'',
			'tbien'=>'',
			'refmonto'=>'0.00'
			);

            
}
/*****ASIENTOS DE COBRANZAS***/
$query_venta_id     = "SELECT * FROM vw_tbl_ventas_diarias2 WHERE ruc= $ruce  AND fecha BETWEEN '$fi' AND '$ff' AND tipocomp = '03'";
$resultado_venta_id = $connect->query($query_venta_id);
$row_venta_id       = $resultado_venta_id->fetchAll(PDO::FETCH_ASSOC);
$vou1 = 0;
//echo $query_venta_id;
foreach($row_venta_id as $row_id)
{
$vou1+=1;
$id_venta_cab = $row_id['id'];
$tdoc         = $row_id['tipocomp'];
$ndoc          = $row_id['serie'].'-'.$row_id['desde'].'-'.$row_id['hasta'];

$data[]=array(
			'origen'=>$origen_cobranzas,
			'vou'=>''.$vou1,
			'fecha'=>date("d/m/Y", strtotime($row_id['fecha'])),
			'cuenta'=>'1011111',
			'debe'=>''.$row_id['total'],
			'haber'=>'0.00',
			'moneda'=>$moneda,
			'tc'=>'3.00',
			'doc'=>'',
			'numero'=>'',
			'fechad'=> date("d/m/Y", strtotime($row_id['fecha'])),
			'fechav'=> date("d/m/Y", strtotime($row_id['fecha'])),
			'codigo'=>'',
			'cc'=>'',
			'pre'=>'',
			'fe'=>'',
			'glosa'=>'COBRANZAS',
			'tl'=>'',
			'neto1'=>'',
			'neto2'=>'',
			'neto3'=>'',
			'neto4'=>'',
			'neto5'=>'',
			'neto6'=>'',
			'neto7'=>'',
			'neto8'=>'',
			'neto9'=>'',
			'igv'=>'',
			'rdoc'=>'',
			'rnum'=>'',
			'rfec'=>'',
			'snum'=>'',	
			'sfec'=>'',
			'ruc'=>'',
			'rs'=>'',
			'tipo'=>'',
			'tdoci'=>'',
			'mpago'=>'',
			'ape1'=>'',
			'ape2'=>'',
			'nombre'=>'',
			'tbien'=>'',
			'refmonto'=>'0.00'
			);




$data[]=array(
							'origen'=>$origen_cobranzas,
							'vou'=>''.$vou1,
							'fecha'=>date("d/m/Y", strtotime($row_id['fecha'])),
							'cuenta'=>$cta_12,
							'debe'=>'0.00',
							'haber'=>''.$row_id['total'],
							'moneda'=>$moneda,
							'tc'=>'3.00',
							'doc'=>''.$tdoc,
							'numero'=>''.$ndoc,
							'fechad'=> date("d/m/Y", strtotime($row_id['fecha'])),
							'fechav'=> date("d/m/Y", strtotime($row_id['fecha'])),
							'codigo'=>'',
							'cc'=>'',
							'pre'=>'',
							'fe'=>'',
							'glosa'=>'COBRANZA DEL CPE '.$tdoc.'-'.$ndoc,
							'tl'=>'',
							'neto1'=>'',
							'neto2'=>'',
							'neto3'=>'',
							'neto4'=>'',
							'neto5'=>'',
							'neto6'=>'',
							'neto7'=>'',
							'neto8'=>'',
							'neto9'=>'',
							'igv'=>'',
							'rdoc'=>''.$row_id['tipocomp_ref'],
							'rnum'=>''.$row_id['serie_ref'].'-'.$row['correlativo_ref'],
							'rfec'=>'',
							'snum'=>'',	
							'sfec'=>'',
							'ruc'=>''.$ruc,
							'rs'=>''.$row_venta['nombre_persona'],
							'tipo'=>''.$tipo,
							'tdoci'=>''.$row_venta['tipo_doc'],
							'mpago'=>'',
							'ape1'=>'',
							'ape2'=>'',
							'nombre'=>'',
							'tbien'=>'',
							'refmonto'=>'0.00'
							);






}

/******************************procesos de documentos con dni y ruc*************************/

$ruce  = $_GET['ruc'];
$fi    = $_GET['fechai'];
$ff    = $_GET['fechaf'];

$query_empresa = $connect->prepare("SELECT * FROM tbl_empresas WHERE ruc = $ruce");
$query_empresa->execute();
$row_config=$query_empresa->fetch(PDO::FETCH_ASSOC);

//print_r($row_config);exit();

$empresa        = $row_config['id_empresa'];
/*DATOS PARA VENTAS*/
$origen_venta        = '50';
$origen_cobranzas    = '90';
$cta_igv_venta       = '4011111';
$cta_12_s_venta      = '1212115';
$cta_12_d_venta      = $row_config['cta_cobrar_dolar'];
/*********************/
/*DATOS PARA COMPRAS*/
/*******************/
$origen_compras       = $row_config['origen_compra'];
$origen_pagos         = $row_config['origen_pagos'];
$cta_igv_compra       = $row_config['cta_igv_compra'];
$cta_42_s_compra      = $row_config['cta_pagar_soles'];
$cta_42_d_compra      = $row_config['cta_pagar_dolar'];


$query_venta     = "SELECT * FROM vw_tbl_venta_cab WHERE ruc= $ruce  AND fecha_emision BETWEEN '$fi' AND '$ff' AND tipocomp in ('01','03','07','08') AND feestado in ('1','2','8') and tipo_doc_ide <> '0'";
$resultado_venta = $connect->query($query_venta);
$row_venta       = $resultado_venta->fetchAll(PDO::FETCH_ASSOC);
$n=0;
//$data= Array();
//$vou=0;
foreach($row_venta as $row)
{
     $idventa = $row['id'];
     $tdoc     = $row['tipocomp'];
     $ndoc     = $row['serie'].'-'.$row['correlativo'];
    //$moneda  = $row['codmoneda'];

    if($row['codmoneda'] == 'PEN')
    {
        $cta_12 =  $cta_12_s_venta;
        $moneda =  'S';
    }

    else
    {
        $cta_12 =  $cta_12_d_venta;
        $moneda =  'D';
    }

    $cliente       = $row['idcliente'];
    $query_cliente = $connect->prepare("SELECT * FROM tbl_contribuyente WHERE id_persona = $cliente");
    $query_cliente->execute();
    $row_cliente   = $query_cliente->fetch(PDO::FETCH_ASSOC);

    $ruc          = $row_cliente['num_doc'];
    $persona      = $row_cliente['nombre_persona'];
    $texto = str_replace($no_permitidas, $permitidas, $persona);
    $tipo_doc     = $row_cliente['tipo_doc'];
    $tipo         = '2';
    
    if($ruc == '00000000')
    {
        $ruc = '11111111';
    }



    $total = $row['total'];

    $vou+=1;

                 
	if($row['tipocomp']=='07')
	{     
	    /*doc ref*/

        $tcomp =$row['tipocomp_ref'];
        $scmop =$row['serie_ref'];
        $ccomp = $row['correlativo_ref'];
        
        
        
        $query_dr = "SELECT * FROM tbl_venta_cab WHERE idempresa=$empresa and tipocomp = $tcomp and serie =  '$scmop' and correlativo = $ccomp";
        //echo $query_dr;
        $resultado_dr = $connect->prepare($query_dr);
        $resultado_dr->execute();
        $row__dr = $resultado_dr->fetch(PDO::FETCH_ASSOC);
        
        $fecha_dr = $row__dr['fecha_emision'];
        /*fin doc ref*/

			$data[]=array(
			'origen'=>$origen_venta,
			'vou'=>''.$vou,
			'fecha'=>date("d/m/Y", strtotime($row['fecha_emision'])),
			'cuenta'=>$cta_12,
			'debe'=>'0.00',
			'haber'=>''.$total,
			'moneda'=>$moneda,
			'tc'=>'3.00',
			'doc'=>$tdoc,
			'numero'=>$ndoc,
			'fechad'=> date("d/m/Y", strtotime($row['fecha_emision'])),
			'fechav'=> date("d/m/Y", strtotime($row['fecha_vencimiento'])),
			'codigo'=>$ruc,
			'cc'=>'',
			'pre'=>'',
			'fe'=>'',
			'glosa'=>'NC '.$tdoc.'-'.$ndoc.' DOC REF: '.$row['tipocomp_ref'].'-'.$row['serie_ref'].'-'.$row['correlativo_ref'],
			'tl'=>'',
			'neto1'=>'',
			'neto2'=>'',
			'neto3'=>'',
			'neto4'=>'',
			'neto5'=>'',
			'neto6'=>'',
			'neto7'=>'',
			'neto8'=>'',
			'neto9'=>'',
			'igv'=>'',
			'rdoc'=>$row['tipocomp_ref'],
			'rnum'=>$row['serie_ref'].'-'.$row['correlativo_ref'],
			'rfec'=>date("d/m/Y", strtotime($fecha_dr)),
			'snum'=>'',	
			'sfec'=>'',
			'ruc'=>$ruc,
			'rs'=>$persona,
			'tipo'=>$tipo,
			'tdoci'=>$tipo_doc,
			'mpago'=>'',
			'ape1'=>'',
			'ape2'=>'',
			'nombre'=>'',
			'tbien'=>'',
			'refmonto'=>'0.00'
			);
	            
	        /*cuenta 40*/
			//$vou+=1;

			$data[]=array(
					'origen'=>$origen_venta,
					'vou'=>''.$vou,
					'fecha'=>date("d/m/Y", strtotime($row['fecha_emision'])),
					'cuenta'=>$cta_igv_venta,
					'debe'=>$row['igv'],
					'haber'=>'0.00',
					'moneda'=>$moneda,
					'tc'=>'3.00',
					'doc'=>$tdoc,
					'numero'=>$ndoc,
					'fechad'=> date("d/m/Y", strtotime($row['fecha_emision'])),
					'fechav'=> date("d/m/Y", strtotime($row['fecha_vencimiento'])),
					'codigo'=>$ruc,
					'cc'=>'',
					'pre'=>'',
					'fe'=>'',
					'glosa'=>'NC '.$tdoc.'-'.$ndoc.' DOC REF: '.$row['tipocomp_ref'].'-'.$row['serie_ref'].'-'.$row['correlativo_ref'],
					'tl'=>'V',
					'neto1'=>$row['op_gravadas'],
					'neto2'=>'',
					'neto3'=>'',
					'neto4'=>'',
					'neto5'=>$row['op_exoneradas'],
					'neto6'=>$row['op_inafectas'],
					'neto7'=>'',
					'neto8'=>'',
					'neto9'=>'',
					'igv'=>$row['igv'],
					'rdoc'=>$row['tipocomp_ref'],
					'rnum'=>$row['serie_ref'].'-'.$row['correlativo_ref'],
					'rfec'=>date("d/m/Y", strtotime($fecha_dr)),
					'snum'=>'',	
					'sfec'=>'',
					'ruc'=>$ruc,
					'rs'=>$persona,
					'tipo'=>$tipo,
					'tdoci'=>$tipo_doc,
					'mpago'=>'',
					'ape1'=>'',
					'ape2'=>'',
					'nombre'=>'',
					'tbien'=>'',
					'refmonto'=>'0.00');	
	    
	  

		$query_det = "SELECT * FROM vw_tbl_venta_det WHERE idventa=$idventa";
		$resultado_det = $connect->query($query_det);
		$row_det      = $resultado_det->fetchAll(PDO::FETCH_ASSOC);

		foreach($row_det as $det)
		{

				//$vou+=1;

				$data[]=array(
						'origen'=>$origen_venta,
						'vou'=>''.$vou,
						'fecha'=>date("d/m/Y", strtotime($row['fecha_emision'])),
						'cuenta'=>$det['cta_venta'],
						'debe'=>$det['valor_total'],
						'haber'=>'0.00',
						'moneda'=>$moneda,
						'tc'=>'3.00',
						'doc'=>$tdoc,
						'numero'=>$ndoc,
						'fechad'=> date("d/m/Y", strtotime($row['fecha_emision'])),
						'fechav'=> date("d/m/Y", strtotime($row['fecha_vencimiento'])),
						'codigo'=>$ruc,
						'cc'=>'',
						'pre'=>'',
						'fe'=>'',
						'glosa'=>'NOTA DE CREDITO '.$tdoc.'-'.$ndoc.' DOC REF: '.$row['tipocomp_ref'].'-'.$row['serie_ref'].'-'.$row['correlativo_ref'],
						'tl'=>'V',
						'neto1'=>$row['op_gravadas'],
						'neto2'=>'',
						'neto3'=>'',
						'neto4'=>'',
						'neto5'=>$row['op_exoneradas'],
						'neto6'=>$row['op_inafectas'],
						'neto7'=>'',
						'neto8'=>'',
						'neto9'=>'',
						'igv'=>$row['igv'],
						'rdoc'=>$row['tipocomp_ref'],
						'rnum'=>$row['serie_ref'].'-'.$row['correlativo_ref'],
						'rfec'=>'',
						'snum'=>'',	
						'sfec'=>'',
						'ruc'=>$ruc,
						'rs'=>$persona,
						'tipo'=>$tipo,
						'tdoci'=>$tipo_doc,
						'mpago'=>'',
						'ape1'=>'',
						'ape2'=>'',
						'nombre'=>'',
						'tbien'=>'',
						'refmonto'=>'0.00');
		}

	}
	else /*diferente a nota de credito*/
	{

	    $data[]=array(
					'origen'=>$origen_venta,
					'vou'=>''.$vou,
					'fecha'=>date("d/m/Y", strtotime($row['fecha_emision'])),
					'cuenta'=>$cta_12,
					'debe'=>$total,
					'haber'=>'0.00',
					'moneda'=>$moneda,
					'tc'=>'3.00',
					'doc'=>$tdoc,
					'numero'=>$ndoc,
					'fechad'=> date("d/m/Y", strtotime($row['fecha_emision'])),
					'fechav'=> date("d/m/Y", strtotime($row['fecha_vencimiento'])),
					'codigo'=>$ruc,
					'cc'=>'',
					'pre'=>'',
					'fe'=>'',
					'glosa'=>'POR LA VENTA DEL CPE '.$tdoc.'-'.$ndoc,
					'tl'=>'V',
					'neto1'=>$row['op_gravadas'],
					'neto2'=>'',
					'neto3'=>'',
					'neto4'=>'',
					'neto5'=>$row['op_exoneradas'],
					'neto6'=>$row['op_inafectas'],
					'neto7'=>'',
					'neto8'=>'',
					'neto9'=>'',
					'igv'=>$row['igv'],
					'rdoc'=>$row['tipocomp_ref'],
					'rnum'=>$row['serie_ref'].'-'.$row['correlativo_ref'],
					'rfec'=>'',
					'snum'=>'',	
					'sfec'=>'',
					'ruc'=>$ruc,
					'rs'=>$persona,
					'tipo'=>$tipo,
					'tdoci'=>$tipo_doc,
					'mpago'=>'',
					'ape1'=>'',
					'ape2'=>'',
					'nombre'=>'',
					'tbien'=>'',
					'refmonto'=>'0.00');

	    /*cuenta 70*/
	   

	    $query_det = "SELECT * FROM vw_tbl_venta_det WHERE idventa=$idventa";
	    $resultado_det = $connect->query($query_det);
	    $row_det      = $resultado_det->fetchAll(PDO::FETCH_ASSOC);
	    $valorut = 0;
	    foreach($row_det as $det)
	    {
	                    
	        if($det['codigo_afectacion']=='10')
	        {
	            $valoru=$det['valor_total']/1.18;
	        }
	        else
	        {
	            $valoru=$det['valor_total'];
	        }    
	            
	                        
	        //$vou+=1;
	                    
	    $data[]=array(
					'origen'=>$origen_venta,
					'vou'=>''.$vou,
					'fecha'=>date("d/m/Y", strtotime($row['fecha_emision'])),
					'cuenta'=>$det['cta_venta'],
					'debe'=>'0.00',
					'haber'=>$valoru,
					'moneda'=>$moneda,
					'tc'=>'3.00',
					'doc'=>$tdoc,
					'numero'=>$ndoc,
					'fechad'=> date("d/m/Y", strtotime($row['fecha_emision'])),
					'fechav'=> date("d/m/Y", strtotime($row['fecha_vencimiento'])),
					'codigo'=>$ruc,
					'cc'=>'',
					'pre'=>'',
					'fe'=>'',
					'glosa'=>'POR LA VENTA DEL CPE '.$tdoc.'-'.$ndoc,
					'tl'=>'V',
					'neto1'=>$row['op_gravadas'],
					'neto2'=>'',
					'neto3'=>'',
					'neto4'=>'',
					'neto5'=>$row['op_exoneradas'],
					'neto6'=>$row['op_inafectas'],
					'neto7'=>'',
					'neto8'=>'',
					'neto9'=>'',
					'igv'=>$row['igv'],
					'rdoc'=>$row['tipocomp_ref'],
					'rnum'=>$row['serie_ref'].'-'.$row['correlativo_ref'],
					'rfec'=>'',
					'snum'=>'',	
					'sfec'=>'',
					'ruc'=>$ruc,
					'rs'=>$persona,
					'tipo'=>$tipo,
					'tdoci'=>$tipo_doc,
					'mpago'=>'',
					'ape1'=>'',
					'ape2'=>'',
					'nombre'=>'',
					'tbien'=>'',
					'refmonto'=>'0.00');                 
	                  
	                $valorut = $valorut + $valoru;

	                }
	                
		/*cuenta 40*/
		   //$vou+=1;
		   
		   $igvt =  $total-$valorut;
	                                 
	    $data[]=array(
					'origen'=>$origen_venta,
					'vou'=>''.$vou,
					'fecha'=>date("d/m/Y", strtotime($row['fecha_emision'])),
					'cuenta'=>$cta_igv_venta,
					'debe'=>'0.00',
					'haber'=>"".$igvt,
					'moneda'=>$moneda,
					'tc'=>'3.00',
					'doc'=>$tdoc,
					'numero'=>$ndoc,
					'fechad'=> date("d/m/Y", strtotime($row['fecha_emision'])),
					'fechav'=> date("d/m/Y", strtotime($row['fecha_vencimiento'])),
					'codigo'=>$ruc,
					'cc'=>'',
					'pre'=>'',
					'fe'=>'',
					'glosa'=>'POR LA VENTA DEL CPE '.$tdoc.'-'.$ndoc,
					'tl'=>'V',
					'neto1'=>$row['op_gravadas'],
					'neto2'=>'',
					'neto3'=>'',
					'neto4'=>'',
					'neto5'=>$row['op_exoneradas'],
					'neto6'=>$row['op_inafectas'],
					'neto7'=>'',
					'neto8'=>'',
					'neto9'=>'',
					'igv'=>$row['igv'],
					'rdoc'=>$row['tipocomp_ref'],
					'rnum'=>$row['serie_ref'].'-'.$row['correlativo_ref'],
					'rfec'=>'',
					'snum'=>'',	
					'sfec'=>'',
					'ruc'=>$ruc,
					'rs'=>$persona,
					'tipo'=>$tipo,
					'tdoci'=>$tipo_doc,
					'mpago'=>'',
					'ape1'=>'',
					'ape2'=>'',
					'nombre'=>'',
					'tbien'=>'',
					'refmonto'=>'0.00');                

	    //$vou+=1;   

	}
}


/*****ASIENTOS DE COBRANZAS***/
$query_venta_id     = "SELECT id,tipocomp,serie,correlativo FROM vw_tbl_venta_cab WHERE ruc= $ruce  AND fecha_emision BETWEEN '$fi' AND '$ff' AND tipocomp in ('01','03','07','08') AND feestado in ('1','2','8') and tipo_doc_ide <> '0'";
$resultado_venta_id = $connect->query($query_venta_id);
$row_venta_id       = $resultado_venta_id->fetchAll(PDO::FETCH_ASSOC);
//$vou = 1;
//echo $query_venta_id;
foreach($row_venta_id as $row_id)
{
$vou1+=1;
$id_venta_cab = $row_id['id'];
$tdoc         = $row_id['tipocomp'];
$ndoc          = $row_id['serie'].'-'.$row_id['correlativo'];

$query_pago     = "SELECT * FROM vw_tbl_venta_pago WHERE idempresa= $empresa  AND fecha_emision BETWEEN '$fi' AND '$ff' AND id_venta = $id_venta_cab";
//echo $query_pago;
$resultado_pago = $connect->query($query_pago);
$row_pago       = $resultado_pago->fetchAll(PDO::FETCH_ASSOC);

$importe_pago =0;

foreach($row_pago as $rpago)
{

$importe_pagar = $rpago['importe_pago'] - $rpago['vuelto'];

$data[]=array(
			'origen'=>$origen_cobranzas,
			'vou'=>''.$vou1,
			'fecha'=>date("d/m/Y", strtotime($rpago['fecha_emision'])),
			'cuenta'=>''.$rpago['cuenta'],
			'debe'=>''.$importe_pagar,
			'haber'=>'0.00',
			'moneda'=>$moneda,
			'tc'=>'3.00',
			'doc'=>'',
			'numero'=>'',
			'fechad'=> date("d/m/Y", strtotime($rpago['fecha_emision'])),
			'fechav'=> date("d/m/Y", strtotime($rpago['fecha_vencimiento'])),
			'codigo'=>'',
			'cc'=>'',
			'pre'=>'',
			'fe'=>'',
			'glosa'=>'COBRANZAS',
			'tl'=>'',
			'neto1'=>'',
			'neto2'=>'',
			'neto3'=>'',
			'neto4'=>'',
			'neto5'=>'',
			'neto6'=>'',
			'neto7'=>'',
			'neto8'=>'',
			'neto9'=>'',
			'igv'=>'',
			'rdoc'=>'',
			'rnum'=>'',
			'rfec'=>'',
			'snum'=>'',	
			'sfec'=>'',
			'ruc'=>'',
			'rs'=>'',
			'tipo'=>'',
			'tdoci'=>'',
			'mpago'=>'',
			'ape1'=>'',
			'ape2'=>'',
			'nombre'=>'',
			'tbien'=>'',
			'refmonto'=>'0.00'
			);

    $importe_pago =$importe_pago  + $importe_pagar ;



}

		if($importe_pago>0)
		{
				$query_venta     = "SELECT * FROM vw_tbl_venta_cab WHERE  id = $id_venta_cab";
				$resultado_venta = $connect->query($query_venta);
				$row_venta       = $resultado_venta->fetch(PDO::FETCH_ASSOC);


				$ruc = $row_venta['codcliente'];
				if($ruc == '00000000')
				{
				$ruc = '11111111';
				}

				$data[]=array(
							'origen'=>$origen_cobranzas,
							'vou'=>''.$vou1,
							'fecha'=>date("d/m/Y", strtotime($rpago['fecha_emision'])),
							'cuenta'=>$cta_12,
							'debe'=>'0.00',
							'haber'=>''.$importe_pago,
							'moneda'=>$moneda,
							'tc'=>'3.00',
							'doc'=>''.$tdoc,
							'numero'=>''.$ndoc,
							'fechad'=> date("d/m/Y", strtotime($row['fecha_emision'])),
							'fechav'=> date("d/m/Y", strtotime($row['fecha_vencimiento'])),
							'codigo'=>'',
							'cc'=>'',
							'pre'=>'',
							'fe'=>'',
							'glosa'=>'COBRANZA DEL CPE '.$tdoc.'-'.$ndoc,
							'tl'=>'',
							'neto1'=>'',
							'neto2'=>'',
							'neto3'=>'',
							'neto4'=>'',
							'neto5'=>'',
							'neto6'=>'',
							'neto7'=>'',
							'neto8'=>'',
							'neto9'=>'',
							'igv'=>'',
							'rdoc'=>''.$row['tipocomp_ref'],
							'rnum'=>''.$row['serie_ref'].'-'.$row['correlativo_ref'],
							'rfec'=>'',
							'snum'=>'',	
							'sfec'=>'',
							'ruc'=>''.$ruc,
							'rs'=>''.$row_venta['nombre_persona'],
							'tipo'=>''.$tipo,
							'tdoci'=>''.$row_venta['tipo_doc'],
							'mpago'=>'',
							'ape1'=>'',
							'ape2'=>'',
							'nombre'=>'',
							'tbien'=>'',
							'refmonto'=>'0.00'
							);



		}




}


    
    
    header('Content-Type: application/json');	
    echo json_encode($data);

exit();
    
}

/*********************importacion smartbase a siscont************************/

include '../../config/config.php';
include '../../helpers/helpers.php';
include '../../libraries/conexion.php'; 

$no_permitidas= array ("á","é","í","ó","ú","Á","É","Í","Ó","Ú","À","Ã","Ì","Ò","Ù","Ã™","Ã ","Ã¨","Ã¬","Ã²","Ã¹","ç","Ç","Ã¢","ê","Ã®","Ã´","Ã»","Ã", "ÃŠ", "ÃŽ", "Ã", "Ã›", "ü","Ã¶", "Ã–","Ã¯","Ã¤","«","Ò","Ã","Ã","Ã‹","*","%", "'", '"');
$permitidas= array ("a","e","i","o","u","A","E","I","O","U","N","A","E","I","O","U","a","e","i","o","u","c","C","a","e","i","o","u","A","E","I","O","U","u","o","O","i", "a", "e", "U", "I", "A", "E", ".", ".", "", "");

$ruce  = $_GET['ruc'];
$fi    = $_GET['fechai'];
$ff    = $_GET['fechaf'];

$query_empresa = $connect->prepare("SELECT * FROM tbl_empresas WHERE ruc = $ruce");
$query_empresa->execute();
$row_config=$query_empresa->fetch(PDO::FETCH_ASSOC);

//print_r($row_config);exit();

$empresa        = $row_config['id_empresa'];
/*DATOS PARA VENTAS*/
$origen_venta        = $row_config['origen_venta'];
$origen_cobranzas    = $row_config['origen_cobranzas'];
$cta_igv_venta       = $row_config['cta_igv_venta'];
$cta_12_s_venta      = $row_config['cta_cobrar_soles'];
$cta_12_d_venta      = $row_config['cta_cobrar_dolar'];
/*********************/
/*DATOS PARA COMPRAS*/
/*******************/
$origen_compras       = $row_config['origen_compra'];
$origen_pagos         = $row_config['origen_pagos'];
$cta_igv_compra       = $row_config['cta_igv_compra'];
$cta_42_s_compra      = $row_config['cta_pagar_soles'];
$cta_42_d_compra      = $row_config['cta_pagar_dolar'];


$query_venta     = "SELECT `vc`.`id` AS `id`,`vc`.`idempresa` AS `idempresa`,`em`.`ruc` AS `ruc`,concat(`em`.`ruc`,'-',convert(`vc`.`tipocomp` using utf8),'-',convert(`vc`.`serie` using utf8),'-',`vc`.`correlativo`) AS `movkey`,`vc`.`tipocomp` AS `tipocomp`,if((`vc`.`tipocomp` = '01'),'FACTURA ELECTRONICA',if((`vc`.`tipocomp` = '03'),'BOLETA DE VENTA ELECTRONICA',if((`vc`.`tipocomp` = '99'),'NOTA DE VENTA ELECTRONICA','NOTA DE CREDITO'))) AS `nomdoc`,`vc`.`serie` AS `serie`,`vc`.`correlativo` AS `correlativo`,`vc`.`fecha_emision` AS `fecha_emision`,`vc`.`fecha_vencimiento` AS `fecha_vencimiento`,cast(`vc`.`orden_compra` as char(20) charset utf8mb4) AS `orden_compra`,`vc`.`condicion_venta` AS `condicion_venta`,if((`vc`.`condicion_venta` = '1'),'CONTADO','CREDITO') AS `det_condicion`,`vc`.`cuotas_credito` AS `cuotas_credito`,`vc`.`codmoneda` AS `codmoneda`,`vc`.`op_gravadas` AS `op_gravadas`,`vc`.`op_exoneradas` AS `op_exoneradas`,`vc`.`op_inafectas` AS `op_inafectas`,`vc`.`igv` AS `igv`,`vc`.`total` AS `total`,`vc`.`cod_det` AS `cod_det`,`vc`.`por_det` AS `por_det`,`vc`.`imp_det` AS `imp_det`,`vc`.`idcliente` AS `idcliente`,`vc`.`codcliente` AS `codcliente`,`vc`.`feestado` AS `feestado`,`es`.`nombre` AS `estado_cpe`,`vc`.`fecodigoerror` AS `fecodigoerror`,`vc`.`femensajesunat` AS `femensajesunat`,`vc`.`nombrexml` AS `nombrexml`,`vc`.`xmlbase64` AS `xmlbase64`,`vc`.`cdrbase64` AS `cdrbase64`,`vc`.`hash` AS `hash`,`vc`.`tipocomp_ref` AS `tipocomp_ref`,`vc`.`serie_ref` AS `serie_ref`,`vc`.`correlativo_ref` AS `correlativo_ref`,`vc`.`cod_motivo` AS `cod_motivo`,`vc`.`des_motivo` AS `des_motivo`,`vc`.`estado` AS `estado`,`vc`.`vendedor` AS `vendedor`,`tc`.`nombre_persona` AS `nombre_persona`,`tc`.`direccion_persona` AS `direccion_persona`,`tc`.`distrito` AS `distrito`,`tc`.`provincia` AS `provincia`,`tc`.`departamento` AS `departamento`,`tc`.`tipo_doc` AS `tipo_doc`,`tc`.`num_doc` AS `num_doc`,`tc`.`correo` AS `correo`,`vc`.`idempresa` AS `empresa`,`tc`.`servidor_cpe` AS `servidor_cpe`,`tc`.`envio_automatico` AS `envio_automatico`,`tc`.`envio_resumen` AS `envio_resumen`,`vc`.`obs` AS `obs`,`vc`.`cheque` AS `cheque`,`vc`.`hora_emision` AS `hora_emision`,`vc`.`guia_remision` AS `guia_remision`,`u`.`usuario` AS `nom_usuario`,`u`.`id_usuario` AS `id_usuario`,`vc`.`tc` AS `tc` 
FROM ((((`tbl_venta_cab` `vc` left join `tbl_contribuyente` `tc` on((`vc`.`idcliente` = `tc`.`id_persona`))) left join `tbl_estado` `es` on((`vc`.`feestado` = `es`.`estado`))) left join `tbl_empresas` `em` on((`vc`.`idempresa` = `em`.`id_empresa`))) left join `tbl_usuarios` `u` on((`u`.`id_usuario` = `vc`.`vendedor`)))
WHERE em.ruc= $ruce  AND vc.fecha_emision BETWEEN '$fi' AND '$ff' AND vc.tipocomp in ('01','03','07','08') AND vc.feestado in ('1','2','8')";
$resultado_venta = $connect->query($query_venta);
$row_venta       = $resultado_venta->fetchAll(PDO::FETCH_ASSOC);



$n=0;
$data= Array();
$vou=0;
foreach($row_venta as $row)
{
     $idventa = $row['id'];
     $tdoc     = $row['tipocomp'];
     $ndoc     = $row['serie'].'-'.$row['correlativo'];
    //$moneda  = $row['codmoneda'];

    if($row['codmoneda'] == 'PEN')
    {
        $cta_12 =  $cta_12_s_venta;
        $moneda =  'S';
    }

    else
    {
        $cta_12 =  $cta_12_d_venta;
        $moneda =  'D';
    }

    $cliente       = $row['idcliente'];
    $query_cliente = $connect->prepare("SELECT * FROM tbl_contribuyente WHERE id_persona = $cliente");
    $query_cliente->execute();
    $row_cliente   = $query_cliente->fetch(PDO::FETCH_ASSOC);

    $ruc          = $row_cliente['num_doc'];
    $persona      = $row_cliente['nombre_persona'];
    $texto = str_replace($no_permitidas, $permitidas, $persona);
    $tipo_doc     = $row_cliente['tipo_doc'];
    $tipo         = '2';
    
    if($ruc == '00000000')
    {
        $ruc = '11111111';
    }



    $total = $row['total'];

    $vou+=1;

                 
	if($row['tipocomp']=='07')
	{     
	    /*doc ref*/

        $tcomp =$row['tipocomp_ref'];
        $scmop =$row['serie_ref'];
        $ccomp = $row['correlativo_ref'];
        
        
        
        $query_dr = "SELECT * FROM tbl_venta_cab WHERE idempresa=$empresa and tipocomp = $tcomp and serie =  '$scmop' and correlativo = $ccomp";
        //echo $query_dr;
        $resultado_dr = $connect->prepare($query_dr);
        $resultado_dr->execute();
        $row__dr = $resultado_dr->fetch(PDO::FETCH_ASSOC);
        
        $fecha_dr = $row__dr['fecha_emision'];
        /*fin doc ref*/

			$data[]=array(
			'origen'=>$origen_venta,
			'vou'=>''.$vou,
			'fecha'=>date("d/m/Y", strtotime($row['fecha_emision'])),
			'cuenta'=>$cta_12,
			'debe'=>'0.00',
			'haber'=>''.$total,
			'moneda'=>$moneda,
			'tc'=>'3.00',
			'doc'=>$tdoc,
			'numero'=>$ndoc,
			'fechad'=> date("d/m/Y", strtotime($row['fecha_emision'])),
			'fechav'=> date("d/m/Y", strtotime($row['fecha_vencimiento'])),
			'codigo'=>$ruc,
			'cc'=>'',
			'pre'=>'',
			'fe'=>'',
			'glosa'=>'NC '.$tdoc.'-'.$ndoc.' DOC REF: '.$row['tipocomp_ref'].'-'.$row['serie_ref'].'-'.$row['correlativo_ref'],
			'tl'=>'',
			'neto1'=>'',
			'neto2'=>'',
			'neto3'=>'',
			'neto4'=>'',
			'neto5'=>'',
			'neto6'=>'',
			'neto7'=>'',
			'neto8'=>'',
			'neto9'=>'',
			'igv'=>'',
			'rdoc'=>$row['tipocomp_ref'],
			'rnum'=>$row['serie_ref'].'-'.$row['correlativo_ref'],
			'rfec'=>date("d/m/Y", strtotime($fecha_dr)),
			'snum'=>'',	
			'sfec'=>'',
			'ruc'=>$ruc,
			'rs'=>$persona,
			'tipo'=>$tipo,
			'tdoci'=>$tipo_doc,
			'mpago'=>'',
			'ape1'=>'',
			'ape2'=>'',
			'nombre'=>'',
			'tbien'=>'',
			'refmonto'=>'0.00'
			);
	            
	        /*cuenta 40*/
			//$vou+=1;

			$data[]=array(
					'origen'=>$origen_venta,
					'vou'=>''.$vou,
					'fecha'=>date("d/m/Y", strtotime($row['fecha_emision'])),
					'cuenta'=>$cta_igv_venta,
					'debe'=>$row['igv'],
					'haber'=>'0.00',
					'moneda'=>$moneda,
					'tc'=>'3.00',
					'doc'=>$tdoc,
					'numero'=>$ndoc,
					'fechad'=> date("d/m/Y", strtotime($row['fecha_emision'])),
					'fechav'=> date("d/m/Y", strtotime($row['fecha_vencimiento'])),
					'codigo'=>$ruc,
					'cc'=>'',
					'pre'=>'',
					'fe'=>'',
					'glosa'=>'NC '.$tdoc.'-'.$ndoc.' DOC REF: '.$row['tipocomp_ref'].'-'.$row['serie_ref'].'-'.$row['correlativo_ref'],
					'tl'=>'V',
					'neto1'=>$row['op_gravadas'],
					'neto2'=>'',
					'neto3'=>'',
					'neto4'=>'',
					'neto5'=>$row['op_exoneradas'],
					'neto6'=>$row['op_inafectas'],
					'neto7'=>'',
					'neto8'=>'',
					'neto9'=>'',
					'igv'=>$row['igv'],
					'rdoc'=>$row['tipocomp_ref'],
					'rnum'=>$row['serie_ref'].'-'.$row['correlativo_ref'],
					'rfec'=>date("d/m/Y", strtotime($fecha_dr)),
					'snum'=>'',	
					'sfec'=>'',
					'ruc'=>$ruc,
					'rs'=>$persona,
					'tipo'=>$tipo,
					'tdoci'=>$tipo_doc,
					'mpago'=>'',
					'ape1'=>'',
					'ape2'=>'',
					'nombre'=>'',
					'tbien'=>'',
					'refmonto'=>'0.00');	
	    
	  

		$query_det = "SELECT `d`.`idventa` AS `idventa`,`d`.`item` AS `item`,`d`.`idproducto` AS `codigo`,if(isnull(`d`.`nombre_producto`),upper(`p`.`nombre`),convert(`d`.`nombre_producto` using utf8)) AS `descripcion`,`d`.`descripcion_producto` AS `descripcion2`,`d`.`cantidad` AS `cantidad`,`p`.`factor` AS `factor`,`p`.`costo` AS `costo`,`d`.`cantidad_factor` AS `cantidad_factor`,`d`.`cantidad_unitario` AS `cantidad_unitario`,if(((`c`.`feestado` = '4') or (`c`.`feestado` = '5') or (`c`.`feestado` = '6')),0,`d`.`valor_unitario`) AS `valor_unitario`,if(((`c`.`feestado` = '4') or (`c`.`feestado` = '5') or (`c`.`feestado` = '6')),0,`d`.`precio_unitario`) AS `precio_unitario`,'01' AS `tipo_precio`,if(((`c`.`feestado` = '4') or (`c`.`feestado` = '5') or (`c`.`feestado` = '6')),0,`d`.`igv`) AS `igv`,`d`.`porcentaje_igv` AS `porcentaje_igv`,if(((`c`.`feestado` = '4') or (`c`.`feestado` = '5') or (`c`.`feestado` = '6')),0,`d`.`valor_total`) AS `valor_total`,if(((`c`.`feestado` = '4') or (`c`.`feestado` = '5') or (`c`.`feestado` = '6')),0,`d`.`importe_total`) AS `importe_total`,`u`.`cod_SUNAT` AS `unidad`,`p`.`unidad` AS `unidadf`,`p`.`unidadu` AS `unidadu`,`a`.`codigo` AS `codigo_afectacion_alt`,`a`.`codigo_afectacion` AS `codigo_afectacion`,`a`.`nombre_afectacion` AS `nombre_afectacion`,`a`.`cod_int` AS `tipo_afectacion`,`ca`.`cuenta_venta` AS `cta_venta`,`d`.`mxmn` AS `mxmn`,`c`.`idempresa` AS `empresa`,`c`.`feestado` AS `feestado` from (((((`tbl_venta_det` `d` left join `tbl_productos` `p` on((`d`.`idproducto` = `p`.`id`))) left join `vw_tbl_tipo_afectacion` `a` on((`p`.`afectacion` = `a`.`codigo`))) left join `tbl_unidad` `u` on((`p`.`unidad` = `u`.`cod`))) left join `tbl_categorias` `ca` on((`p`.`categoria` = `ca`.`id`))) left join `tbl_venta_cab` `c` on((`d`.`idventa` = `c`.`id`)))
		WHERE d.idventa=$idventa";
		$resultado_det = $connect->query($query_det);
		$row_det      = $resultado_det->fetchAll(PDO::FETCH_ASSOC);
//var_dump($row_det);exit();
		foreach($row_det as $det)
		{

				//$vou+=1;

				$data[]=array(
						'origen'=>$origen_venta,
						'vou'=>''.$vou,
						'fecha'=>date("d/m/Y", strtotime($row['fecha_emision'])),
						'cuenta'=>$det['cta_venta'],
						'debe'=>$det['valor_total'],
						'haber'=>'0.00',
						'moneda'=>$moneda,
						'tc'=>'3.00',
						'doc'=>$tdoc,
						'numero'=>$ndoc,
						'fechad'=> date("d/m/Y", strtotime($row['fecha_emision'])),
						'fechav'=> date("d/m/Y", strtotime($row['fecha_vencimiento'])),
						'codigo'=>$ruc,
						'cc'=>'',
						'pre'=>'',
						'fe'=>'',
						'glosa'=>'NOTA DE CREDITO '.$tdoc.'-'.$ndoc.' DOC REF: '.$row['tipocomp_ref'].'-'.$row['serie_ref'].'-'.$row['correlativo_ref'],
						'tl'=>'V',
						'neto1'=>$row['op_gravadas'],
						'neto2'=>'',
						'neto3'=>'',
						'neto4'=>'',
						'neto5'=>$row['op_exoneradas'],
						'neto6'=>$row['op_inafectas'],
						'neto7'=>'',
						'neto8'=>'',
						'neto9'=>'',
						'igv'=>$row['igv'],
						'rdoc'=>$row['tipocomp_ref'],
						'rnum'=>$row['serie_ref'].'-'.$row['correlativo_ref'],
						'rfec'=>'',
						'snum'=>'',	
						'sfec'=>'',
						'ruc'=>$ruc,
						'rs'=>$persona,
						'tipo'=>$tipo,
						'tdoci'=>$tipo_doc,
						'mpago'=>'',
						'ape1'=>'',
						'ape2'=>'',
						'nombre'=>'',
						'tbien'=>'',
						'refmonto'=>'0.00');
		}

	}
	else /*diferente a nota de credito*/
	{

	    $data[]=array(
					'origen'=>$origen_venta,
					'vou'=>''.$vou,
					'fecha'=>date("d/m/Y", strtotime($row['fecha_emision'])),
					'cuenta'=>$cta_12,
					'debe'=>$total,
					'haber'=>'0.00',
					'moneda'=>$moneda,
					'tc'=>'3.00',
					'doc'=>$tdoc,
					'numero'=>$ndoc,
					'fechad'=> date("d/m/Y", strtotime($row['fecha_emision'])),
					'fechav'=> date("d/m/Y", strtotime($row['fecha_vencimiento'])),
					'codigo'=>$ruc,
					'cc'=>'',
					'pre'=>'',
					'fe'=>'',
					'glosa'=>'POR LA VENTA DEL CPE '.$tdoc.'-'.$ndoc,
					'tl'=>'V',
					'neto1'=>$row['op_gravadas'],
					'neto2'=>'',
					'neto3'=>'',
					'neto4'=>'',
					'neto5'=>$row['op_exoneradas'],
					'neto6'=>$row['op_inafectas'],
					'neto7'=>'',
					'neto8'=>'',
					'neto9'=>'',
					'igv'=>$row['igv'],
					'rdoc'=>$row['tipocomp_ref'],
					'rnum'=>$row['serie_ref'].'-'.$row['correlativo_ref'],
					'rfec'=>'',
					'snum'=>'',	
					'sfec'=>'',
					'ruc'=>$ruc,
					'rs'=>$persona,
					'tipo'=>$tipo,
					'tdoci'=>$tipo_doc,
					'mpago'=>'',
					'ape1'=>'',
					'ape2'=>'',
					'nombre'=>'',
					'tbien'=>'',
					'refmonto'=>'0.00');

	    /*cuenta 70*/
	   

	    $query_det = "SELECT `d`.`idventa` AS `idventa`,`d`.`item` AS `item`,`d`.`idproducto` AS `codigo`,if(isnull(`d`.`nombre_producto`),upper(`p`.`nombre`),convert(`d`.`nombre_producto` using utf8)) AS `descripcion`,`d`.`descripcion_producto` AS `descripcion2`,`d`.`cantidad` AS `cantidad`,`p`.`factor` AS `factor`,`p`.`costo` AS `costo`,`d`.`cantidad_factor` AS `cantidad_factor`,`d`.`cantidad_unitario` AS `cantidad_unitario`,if(((`c`.`feestado` = '4') or (`c`.`feestado` = '5') or (`c`.`feestado` = '6')),0,`d`.`valor_unitario`) AS `valor_unitario`,if(((`c`.`feestado` = '4') or (`c`.`feestado` = '5') or (`c`.`feestado` = '6')),0,`d`.`precio_unitario`) AS `precio_unitario`,'01' AS `tipo_precio`,if(((`c`.`feestado` = '4') or (`c`.`feestado` = '5') or (`c`.`feestado` = '6')),0,`d`.`igv`) AS `igv`,`d`.`porcentaje_igv` AS `porcentaje_igv`,if(((`c`.`feestado` = '4') or (`c`.`feestado` = '5') or (`c`.`feestado` = '6')),0,`d`.`valor_total`) AS `valor_total`,if(((`c`.`feestado` = '4') or (`c`.`feestado` = '5') or (`c`.`feestado` = '6')),0,`d`.`importe_total`) AS `importe_total`,`u`.`cod_SUNAT` AS `unidad`,`p`.`unidad` AS `unidadf`,`p`.`unidadu` AS `unidadu`,`a`.`codigo` AS `codigo_afectacion_alt`,`a`.`codigo_afectacion` AS `codigo_afectacion`,`a`.`nombre_afectacion` AS `nombre_afectacion`,`a`.`cod_int` AS `tipo_afectacion`,`ca`.`cuenta_venta` AS `cta_venta`,`d`.`mxmn` AS `mxmn`,`c`.`idempresa` AS `empresa`,`c`.`feestado` AS `feestado` 
	    FROM (((((`tbl_venta_det` `d` left join `tbl_productos` `p` on((`d`.`idproducto` = `p`.`id`))) left join `vw_tbl_tipo_afectacion` `a` on((`p`.`afectacion` = `a`.`codigo`))) left join `tbl_unidad` `u` on((`p`.`unidad` = `u`.`cod`))) left join `tbl_categorias` `ca` on((`p`.`categoria` = `ca`.`id`))) left join `tbl_venta_cab` `c` on((`d`.`idventa` = `c`.`id`)))
	    WHERE d.idventa=$idventa";
	    $resultado_det = $connect->query($query_det);
	    $row_det      = $resultado_det->fetchAll(PDO::FETCH_ASSOC);
	    $valorut = 0;
	    foreach($row_det as $det)
	    {
	                    
	        if($det['codigo_afectacion']=='10')
	        {
	            $valoru=$det['valor_total']/1.18;
	        }
	        else
	        {
	            $valoru=$det['valor_total'];
	        }    
	            
	                        
	        //$vou+=1;
	                    
	    $data[]=array(
					'origen'=>$origen_venta,
					'vou'=>''.$vou,
					'fecha'=>date("d/m/Y", strtotime($row['fecha_emision'])),
					'cuenta'=>$det['cta_venta'],
					'debe'=>'0.00',
					'haber'=>$valoru,
					'moneda'=>$moneda,
					'tc'=>'3.00',
					'doc'=>$tdoc,
					'numero'=>$ndoc,
					'fechad'=> date("d/m/Y", strtotime($row['fecha_emision'])),
					'fechav'=> date("d/m/Y", strtotime($row['fecha_vencimiento'])),
					'codigo'=>$ruc,
					'cc'=>'',
					'pre'=>'',
					'fe'=>'',
					'glosa'=>'POR LA VENTA DEL CPE '.$tdoc.'-'.$ndoc,
					'tl'=>'V',
					'neto1'=>$row['op_gravadas'],
					'neto2'=>'',
					'neto3'=>'',
					'neto4'=>'',
					'neto5'=>$row['op_exoneradas'],
					'neto6'=>$row['op_inafectas'],
					'neto7'=>'',
					'neto8'=>'',
					'neto9'=>'',
					'igv'=>$row['igv'],
					'rdoc'=>$row['tipocomp_ref'],
					'rnum'=>$row['serie_ref'].'-'.$row['correlativo_ref'],
					'rfec'=>'',
					'snum'=>'',	
					'sfec'=>'',
					'ruc'=>$ruc,
					'rs'=>$persona,
					'tipo'=>$tipo,
					'tdoci'=>$tipo_doc,
					'mpago'=>'',
					'ape1'=>'',
					'ape2'=>'',
					'nombre'=>'',
					'tbien'=>'',
					'refmonto'=>'0.00');                 
	                  
	                $valorut = $valorut + $valoru;

	                }
	                
		/*cuenta 40*/
		   //$vou+=1;
		   
		   $igvt =  $total-$valorut;
	                                 
	    $data[]=array(
					'origen'=>$origen_venta,
					'vou'=>''.$vou,
					'fecha'=>date("d/m/Y", strtotime($row['fecha_emision'])),
					'cuenta'=>$cta_igv_venta,
					'debe'=>'0.00',
					'haber'=>"".$igvt,
					'moneda'=>$moneda,
					'tc'=>'3.00',
					'doc'=>$tdoc,
					'numero'=>$ndoc,
					'fechad'=> date("d/m/Y", strtotime($row['fecha_emision'])),
					'fechav'=> date("d/m/Y", strtotime($row['fecha_vencimiento'])),
					'codigo'=>$ruc,
					'cc'=>'',
					'pre'=>'',
					'fe'=>'',
					'glosa'=>'POR LA VENTA DEL CPE '.$tdoc.'-'.$ndoc,
					'tl'=>'V',
					'neto1'=>$row['op_gravadas'],
					'neto2'=>'',
					'neto3'=>'',
					'neto4'=>'',
					'neto5'=>$row['op_exoneradas'],
					'neto6'=>$row['op_inafectas'],
					'neto7'=>'',
					'neto8'=>'',
					'neto9'=>'',
					'igv'=>$row['igv'],
					'rdoc'=>$row['tipocomp_ref'],
					'rnum'=>$row['serie_ref'].'-'.$row['correlativo_ref'],
					'rfec'=>'',
					'snum'=>'',	
					'sfec'=>'',
					'ruc'=>$ruc,
					'rs'=>$persona,
					'tipo'=>$tipo,
					'tdoci'=>$tipo_doc,
					'mpago'=>'',
					'ape1'=>'',
					'ape2'=>'',
					'nombre'=>'',
					'tbien'=>'',
					'refmonto'=>'0.00');                

	    //$vou+=1;   

	}
}

/*************anulados*********************/
//echo 'fin cpe';exit();
//$vou = $vouventa;
$query_anulado    = "SELECT * FROM vw_tbl_venta_cab WHERE ruc= $ruce  AND fecha_emision BETWEEN '$fi' AND '$ff' AND tipocomp in ('01','03','07','08') AND feestado in ('3','5','6')";
$resultado_anulado = $connect->query($query_anulado);
$row_anulado       = $resultado_anulado->fetchAll(PDO::FETCH_ASSOC);

//echo $query_anulado;
//print_r($row_anulado);
/*cuenta 40*/
foreach($row_anulado as $anulado)
{
	$vou+=1;
	$data[]=array(
			'origen'=>$origen_venta,
			'vou'=>''.$vou,
			'fecha'=>date("d/m/Y", strtotime($anulado['fecha_emision'])),
			'cuenta'=>$cta_igv_venta,
			'debe'=>'0.00',
			'haber'=>'0.00',
			'moneda'=>$moneda,
			'tc'=>'3.00',
			'doc'=>$anulado['tipocomp'],
			'numero'=>$anulado['serie'].'-'.$anulado['correlativo'],
			'fechad'=> date("d/m/Y", strtotime($anulado['fecha_emision'])),
			'fechav'=> date("d/m/Y", strtotime($anulado['fecha_vencimiento'])),
			'codigo'=>'00000000000',
			'cc'=>'',
			'pre'=>'',
			'fe'=>'',
			'glosa'=>'CPE ANULADO '.$anulado['tipocomp'].'-'.$anulado['serie'].'-'.$anulado['correlativo'],
			'tl'=>'V',
			'neto1'=>'',
			'neto2'=>'',
			'neto3'=>'',
			'neto4'=>'',
			'neto5'=>'',
			'neto6'=>'',
			'neto7'=>'',
			'neto8'=>'',
			'neto9'=>'',
			'igv'=>'',
			'rdoc'=>$anulado['tipocomp_ref'],
			'rnum'=>$anulado['serie_ref'].'-'.$anulado['correlativo_ref'],
			'rfec'=>'',
			'snum'=>'',	
			'sfec'=>'',
			'ruc'=>'00000000000',
			'rs'=>'CPE ANULADO',
			'tipo'=>'1',
			'tdoci'=>'0',
			'mpago'=>'',
			'ape1'=>'',
			'ape2'=>'',
			'nombre'=>'',
			'tbien'=>'',
			'refmonto'=>'0.00'
			);

            
}
/*****ASIENTOS DE COBRANZAS**/
$query_venta_id     = "SELECT id,tipocomp,serie,correlativo FROM vw_tbl_venta_cab WHERE ruc= $ruce  AND fecha_emision BETWEEN '$fi' AND '$ff' AND tipocomp in ('01','03','07','08') AND feestado in ('1','2','8')";
$resultado_venta_id = $connect->query($query_venta_id);
$row_venta_id       = $resultado_venta_id->fetchAll(PDO::FETCH_ASSOC);
$vou = 1;
//echo $query_venta_id;
foreach($row_venta_id as $row_id)
{
$vou+=1;
$id_venta_cab = $row_id['id'];
$tdoc         = $row_id['tipocomp'];
$ndoc          = $row_id['serie'].'-'.$row_id['correlativo'];

$query_pago     = "SELECT * FROM vw_tbl_venta_pago WHERE idempresa= $empresa  AND fecha_emision BETWEEN '$fi' AND '$ff' AND id_venta = $id_venta_cab";
//echo $query_pago;
$resultado_pago = $connect->query($query_pago);
$row_pago       = $resultado_pago->fetchAll(PDO::FETCH_ASSOC);

$importe_pago =0;

foreach($row_pago as $rpago)
{

$importe_pagar = $rpago['importe_pago'] - $rpago['vuelto'];

$data[]=array(
			'origen'=>$origen_cobranzas,
			'vou'=>''.$vou,
			'fecha'=>date("d/m/Y", strtotime($rpago['fecha_emision'])),
			'cuenta'=>''.$rpago['cuenta'],
			'debe'=>''.$importe_pagar,
			'haber'=>'0.00',
			'moneda'=>$moneda,
			'tc'=>'3.00',
			'doc'=>'',
			'numero'=>'',
			'fechad'=> date("d/m/Y", strtotime($rpago['fecha_emision'])),
			'fechav'=> date("d/m/Y", strtotime($rpago['fecha_vencimiento'])),
			'codigo'=>'',
			'cc'=>'',
			'pre'=>'',
			'fe'=>'',
			'glosa'=>'COBRANZAS',
			'tl'=>'',
			'neto1'=>'',
			'neto2'=>'',
			'neto3'=>'',
			'neto4'=>'',
			'neto5'=>'',
			'neto6'=>'',
			'neto7'=>'',
			'neto8'=>'',
			'neto9'=>'',
			'igv'=>'',
			'rdoc'=>'',
			'rnum'=>'',
			'rfec'=>'',
			'snum'=>'',	
			'sfec'=>'',
			'ruc'=>'',
			'rs'=>'',
			'tipo'=>'',
			'tdoci'=>'',
			'mpago'=>'',
			'ape1'=>'',
			'ape2'=>'',
			'nombre'=>'',
			'tbien'=>'',
			'refmonto'=>'0.00'
			);

    $importe_pago =$importe_pago  + $importe_pagar ;



}

if($importe_pago>0)
{
		$query_venta     = "SELECT * FROM vw_tbl_venta_cab WHERE  id = $id_venta_cab";
		$resultado_venta = $connect->query($query_venta);
		$row_venta       = $resultado_venta->fetch(PDO::FETCH_ASSOC);


		$ruc = $row_venta['codcliente'];
		if($ruc == '00000000')
		{
		$ruc = '11111111';
		}

		$data[]=array(
					'origen'=>$origen_cobranzas,
					'vou'=>''.$vou,
					'fecha'=>date("d/m/Y", strtotime($rpago['fecha_emision'])),
					'cuenta'=>$cta_12,
					'debe'=>'0.00',
					'haber'=>''.$importe_pago,
					'moneda'=>$moneda,
					'tc'=>'3.00',
					'doc'=>''.$tdoc,
					'numero'=>''.$ndoc,
					'fechad'=> date("d/m/Y", strtotime($row['fecha_emision'])),
					'fechav'=> date("d/m/Y", strtotime($row['fecha_vencimiento'])),
					'codigo'=>'',
					'cc'=>'',
					'pre'=>'',
					'fe'=>'',
					'glosa'=>'COBRANZA DEL CPE '.$tdoc.'-'.$ndoc,
					'tl'=>'',
					'neto1'=>'',
					'neto2'=>'',
					'neto3'=>'',
					'neto4'=>'',
					'neto5'=>'',
					'neto6'=>'',
					'neto7'=>'',
					'neto8'=>'',
					'neto9'=>'',
					'igv'=>'',
					'rdoc'=>''.$row['tipocomp_ref'],
					'rnum'=>''.$row['serie_ref'].'-'.$row['correlativo_ref'],
					'rfec'=>'',
					'snum'=>'',	
					'sfec'=>'',
					'ruc'=>''.$ruc,
					'rs'=>''.$row_venta['nombre_persona'],
					'tipo'=>''.$tipo,
					'tdoci'=>''.$row_venta['tipo_doc'],
					'mpago'=>'',
					'ape1'=>'',
					'ape2'=>'',
					'nombre'=>'',
					'tbien'=>'',
					'refmonto'=>'0.00'
					);



}




}


/******ASIENTOS DE COMPRAS*****
$query_compra     = "SELECT * FROM vw_tbl_compra_cab WHERE ruc= $ruce  AND fecha_emision BETWEEN '$fi' AND '$ff'";
$resultado_compra = $connect->query($query_compra);
$row_compra       = $resultado_compra->fetchAll(PDO::FETCH_ASSOC);
$n=0;
$data= Array();
$vou=0;
foreach($row_compra as $row)
{
     $idventa = $row['id'];
     $tdoc     = $row['tipocomp'];
     $ndoc     = $row['serie'].'-'.$row['correlativo'];
    //$moneda  = $row['codmoneda'];
    
    if($row['codmoneda'] == 'PEN')
    {
        $cta_42 =  $cta_42_s_compra ;
        $moneda =  'S';
    }

    else
    {
        $cta_42 =  $cta_42_d_compra;
        $moneda =  'D';
    }

    $cliente       = $row['codcliente'];
    
    $query_cliente = $connect->prepare("SELECT * FROM tbl_contribuyente WHERE num_doc = $cliente AND empresa = $empresa");
    $query_cliente->execute();
    $row_cliente   = $query_cliente->fetch(PDO::FETCH_ASSOC);

    $ruc          = $row_cliente['num_doc'];
    $persona      = $row_cliente['nombre_persona'];
    $texto = str_replace($no_permitidas, $permitidas, $persona);
    $tipo_doc     = $row_cliente['tipo_doc'];
    $tipo         = '2';
    
    if($ruc == '00000000')
    {
        $ruc = '11111111';
    }



    $total = $row['total'];

    $vou+=1;
                 
	if($row['tipocomp']=='07')
	{     

			$data[]=array(
			'origen'=>$origen_compras,
			'vou'=>''.$vou,
			'fecha'=>date("d/m/Y", strtotime($row['fecha_emision'])),
			'cuenta'=>$cta_42,
			'debe'=>''.$total,
			'haber'=>'0.00',
			'moneda'=>$moneda,
			'tc'=>'3.00',
			'doc'=>$tdoc,
			'numero'=>$ndoc,
			'fechad'=> date("d/m/Y", strtotime($row['fecha_emision'])),
			'fechav'=> date("d/m/Y", strtotime($row['fecha_vencimiento'])),
			'codigo'=>$ruc,
			'cc'=>'',
			'pre'=>'',
			'fe'=>'',
			'glosa'=>'NOTA DE CREDITO '.$tdoc.'-'.$ndoc.' DOC REF: '.$row['tipocomp_ref'].'-'.$row['serie_ref'].'-'.$row['correlativo_ref'],
			'tl'=>'',
			'neto1'=>'',
			'neto2'=>'',
			'neto3'=>'',
			'neto4'=>'',
			'neto5'=>'',
			'neto6'=>'',
			'neto7'=>'',
			'neto8'=>'',
			'neto9'=>'',
			'igv'=>'',
			'rdoc'=>$row['tipocomp_ref'],
			'rnum'=>$row['serie_ref'].'-'.$row['correlativo_ref'],
			'rfec'=>'',
			'snum'=>'',	
			'sfec'=>'',
			'ruc'=>$ruc,
			'rs'=>$persona,
			'tipo'=>$tipo,
			'tdoci'=>$tipo_doc,
			'mpago'=>'',
			'ape1'=>'',
			'ape2'=>'',
			'nombre'=>'',
			'tbien'=>'',
			'refmonto'=>'0.00'
			);
	            
	        ///cuenta 40
			//$vou+=1;
			$data[]=array(
					'origen'=>$origen_compras,
					'vou'=>''.$vou,
					'fecha'=>date("d/m/Y", strtotime($row['fecha_emision'])),
					'cuenta'=>$cta_igv_compra,
					'debe'=>'0.00',
					'haber'=>''.$row['igv'],
					'moneda'=>$moneda,
					'tc'=>'3.00',
					'doc'=>$tdoc,
					'numero'=>$ndoc,
					'fechad'=> date("d/m/Y", strtotime($row['fecha_emision'])),
					'fechav'=> date("d/m/Y", strtotime($row['fecha_vencimiento'])),
					'codigo'=>$ruc,
					'cc'=>'',
					'pre'=>'',
					'fe'=>'',
					'glosa'=>'NOTA DE CREDITO '.$tdoc.'-'.$ndoc.' DOC REF: '.$row['tipocomp_ref'].'-'.$row['serie_ref'].'-'.$row['correlativo_ref'],
					'tl'=>'V',
					'neto1'=>$row['op_gravadas'],
					'neto2'=>'',
					'neto3'=>'',
					'neto4'=>'',
					'neto5'=>$row['op_exoneradas'],
					'neto6'=>$row['op_inafectas'],
					'neto7'=>'',
					'neto8'=>'',
					'neto9'=>'',
					'igv'=>$row['igv'],
					'rdoc'=>$row['tipocomp_ref'],
					'rnum'=>$row['serie_ref'].'-'.$row['correlativo_ref'],
					'rfec'=>'',
					'snum'=>'',	
					'sfec'=>'',
					'ruc'=>$ruc,
					'rs'=>$persona,
					'tipo'=>$tipo,
					'tdoci'=>$tipo_doc,
					'mpago'=>'',
					'ape1'=>'',
					'ape2'=>'',
					'nombre'=>'',
					'tbien'=>'',
					'refmonto'=>'0.00');	
	    
	  

		$query_det = "SELECT * FROM vw_tbl_compra_det WHERE idventa=$idventa";
		$resultado_det = $connect->query($query_det);
		$row_det      = $resultado_det->fetchAll(PDO::FETCH_ASSOC);

		foreach($row_det as $det)
		{

				//$vou+=1;

				$data[]=array(
						'origen'=>$origen_compras,
						'vou'=>''.$vou,
						'fecha'=>date("d/m/Y", strtotime($row['fecha_emision'])),
						'cuenta'=>$row_det['cta_compra'],
						'debe'=>'0.00',
						'haber'=>''.$row_det['valor_total'],
						'moneda'=>$moneda,
						'tc'=>'3.00',
						'doc'=>$tdoc,
						'numero'=>$ndoc,
						'fechad'=> date("d/m/Y", strtotime($row['fecha_emision'])),
						'fechav'=> date("d/m/Y", strtotime($row['fecha_vencimiento'])),
						'codigo'=>$ruc,
						'cc'=>'',
						'pre'=>'',
						'fe'=>'',
						'glosa'=>'NOTA DE CREDITO '.$tdoc.'-'.$ndoc.' DOC REF: '.$row['tipocomp_ref'].'-'.$row['serie_ref'].'-'.$row['correlativo_ref'],
						'tl'=>'V',
						'neto1'=>$row['op_gravadas'],
						'neto2'=>'',
						'neto3'=>'',
						'neto4'=>'',
						'neto5'=>$row['op_exoneradas'],
						'neto6'=>$row['op_inafectas'],
						'neto7'=>'',
						'neto8'=>'',
						'neto9'=>'',
						'igv'=>$row['igv'],
						'rdoc'=>$row['tipocomp_ref'],
						'rnum'=>$row['serie_ref'].'-'.$row['correlativo_ref'],
						'rfec'=>'',
						'snum'=>'',	
						'sfec'=>'',
						'ruc'=>$ruc,
						'rs'=>$persona,
						'tipo'=>$tipo,
						'tdoci'=>$tipo_doc,
						'mpago'=>'',
						'ape1'=>'',
						'ape2'=>'',
						'nombre'=>'',
						'tbien'=>'',
						'refmonto'=>'0.00');
		}

	}
	else //diferente a nota de credito
	{

	    $data[]=array(
					'origen'=>$origen_compras,
					'vou'=>''.$vou,
					'fecha'=>date("d/m/Y", strtotime($row['fecha_emision'])),
					'cuenta'=>$cta_42,
					'debe'=>'0.00',
					'haber'=>''.$total,
					'moneda'=>$moneda,
					'tc'=>'3.00',
					'doc'=>$tdoc,
					'numero'=>$ndoc,
					'fechad'=> date("d/m/Y", strtotime($row['fecha_emision'])),
					'fechav'=> date("d/m/Y", strtotime($row['fecha_vencimiento'])),
					'codigo'=>$ruc,
					'cc'=>'',
					'pre'=>'',
					'fe'=>'',
					'glosa'=>'POR LA COMPRA DEL CPE '.$tdoc.'-'.$ndoc,
					'tl'=>'C',
					'neto1'=>$row['op_gravadas'],
					'neto2'=>'',
					'neto3'=>'',
					'neto4'=>'',
					'neto5'=>$row['op_exoneradas'],
					'neto6'=>$row['op_inafectas'],
					'neto7'=>'',
					'neto8'=>'',
					'neto9'=>'',
					'igv'=>$row['igv'],
					'rdoc'=>$row['tipocomp_ref'],
					'rnum'=>$row['serie_ref'].'-'.$row['correlativo_ref'],
					'rfec'=>'',
					'snum'=>'',	
					'sfec'=>'',
					'ruc'=>$ruc,
					'rs'=>$persona,
					'tipo'=>$tipo,
					'tdoci'=>$tipo_doc,
					'mpago'=>'',
					'ape1'=>'',
					'ape2'=>'',
					'nombre'=>'',
					'tbien'=>'',
					'refmonto'=>'0.00');

	    //cuenta 6x

	    $query_det = "SELECT * FROM vw_tbl_compra_det WHERE idventa=$idventa";
	    $resultado_det = $connect->query($query_det);
	    $row_det      = $resultado_det->fetchAll(PDO::FETCH_ASSOC);
	    $valorut = 0;
	    foreach($row_det as $det)
	    {
	                    
	        if($det['codigo_afectacion_alt']=='10')
	        {
	            $valoru=$det['importe_total']/1.18;
	        }
	        else
	        {
	            $valoru=$det['importe_total'];
	        }    
	           //echo 'codigo:'.$row_det->codigo_afectacion_alt;exit(); 
	                        
	        //$vou+=1;
	                    
	    $data[]=array(
					'origen'=>$origen_compras,
					'vou'=>''.$vou,
					'fecha'=>date("d/m/Y", strtotime($row['fecha_emision'])),
					'cuenta'=>$det['cta_compra'],
					'debe'=>''.round($valoru,2),
					'haber'=>'0.00',
					'moneda'=>$moneda,
					'tc'=>'3.00',
					'doc'=>$tdoc,
					'numero'=>$ndoc,
					'fechad'=> date("d/m/Y", strtotime($row['fecha_emision'])),
					'fechav'=> date("d/m/Y", strtotime($row['fecha_vencimiento'])),
					'codigo'=>$ruc,
					'cc'=>'',
					'pre'=>'',
					'fe'=>'',
					'glosa'=>'POR LA COMPRA DEL CPE '.$tdoc.'-'.$ndoc,
					'tl'=>'C',
					'neto1'=>$row['op_gravadas'],
					'neto2'=>'',
					'neto3'=>'',
					'neto4'=>'',
					'neto5'=>$row['op_exoneradas'],
					'neto6'=>$row['op_inafectas'],
					'neto7'=>'',
					'neto8'=>'',
					'neto9'=>'',
					'igv'=>$row['igv'],
					'rdoc'=>$row['tipocomp_ref'],
					'rnum'=>$row['serie_ref'].'-'.$row['correlativo_ref'],
					'rfec'=>'',
					'snum'=>'',	
					'sfec'=>'',
					'ruc'=>$ruc,
					'rs'=>$persona,
					'tipo'=>$tipo,
					'tdoci'=>$tipo_doc,
					'mpago'=>'',
					'ape1'=>'',
					'ape2'=>'',
					'nombre'=>'',
					'tbien'=>'',
					'refmonto'=>'0.00');                 
	                  
	                $valorut = $valorut + $valoru;

	                }
	                
		//cuenta 40
		   //$vou+=1;
		   
		   $igvt =  $total-$valorut;
	                                 
	    $data[]=array(
					'origen'=>$origen_venta,
					'vou'=>''.$vou,
					'fecha'=>date("d/m/Y", strtotime($row['fecha_emision'])),
					'cuenta'=>$cta_igv_compra,
					'debe'=>''.round($igvt,2),
					'haber'=>'0.00',
					'moneda'=>$moneda,
					'tc'=>'3.00',
					'doc'=>$tdoc,
					'numero'=>$ndoc,
					'fechad'=> date("d/m/Y", strtotime($row['fecha_emision'])),
					'fechav'=> date("d/m/Y", strtotime($row['fecha_vencimiento'])),
					'codigo'=>$ruc,
					'cc'=>'',
					'pre'=>'',
					'fe'=>'',
					'glosa'=>'POR LA COMPRA DEL CPE '.$tdoc.'-'.$ndoc,
					'tl'=>'C',
					'neto1'=>$row['op_gravadas'],
					'neto2'=>'',
					'neto3'=>'',
					'neto4'=>'',
					'neto5'=>$row['op_exoneradas'],
					'neto6'=>$row['op_inafectas'],
					'neto7'=>'',
					'neto8'=>'',
					'neto9'=>'',
					'igv'=>''.round($igvt,2),
					'rdoc'=>$row['tipocomp_ref'],
					'rnum'=>$row['serie_ref'].'-'.$row['correlativo_ref'],
					'rfec'=>'',
					'snum'=>'',	
					'sfec'=>'',
					'ruc'=>$ruc,
					'rs'=>$persona,
					'tipo'=>$tipo,
					'tdoci'=>$tipo_doc,
					'mpago'=>'',
					'ape1'=>'',
					'ape2'=>'',
					'nombre'=>'',
					'tbien'=>'',
					'refmonto'=>'0.00');                

	    //$vou+=1;   

	}
}
*/
header('Content-Type: application/json');
echo json_encode($data);



 ?>