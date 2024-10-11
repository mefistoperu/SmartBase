<?php 

require_once("../../config/config.php");
require_once("../../helpers/helpers.php"); 
require_once("../../libraries/conexion.php"); 

require("../../assets/plugins/phpmailer/class.phpmailer.php");
require("../../assets/plugins/phpmailer/class.smtp.php");

session_start();

//####################################CREAR CLIENTE####################################////

if($_POST['action'] == 'enviarCorreo')
{
    	$vta = $_POST['id'];
		$cli = $_POST['cl'];
		//require("../../views/modules/factura_pdf_correo.php");
		
		
		
		//crear_pdf($vta);

		$jsondata = array();
		$jsondata['estado'] = '0';
		$jsondata['mensaje'] = 'ERROR';

		$query_venta = "SELECT * FROM vw_tbl_venta_cab WHERE id = $vta";
		$resultado_venta = $connect->prepare($query_venta);
		$resultado_venta->execute();
		$row_venta = $resultado_venta->fetch(PDO::FETCH_ASSOC);



		$link        =  $row_venta['movkey'];
		$empresa     =  $row_venta['idempresa']; 
		$serienumero =  $row_venta['serie'].'-'.$row_venta['correlativo'];
		
//		$ruta_crea_pdf = 'http://facturacion.smartbase.club/views/modules/factura_pdf_correo.php?id='.$vta.'&emp='.$empresa;
		// $url="http://dacruzvi.webcindario.com";
//echo "<SCRIPT>window.location='$ruta_crea_pdf';</SCRIPT>"; 
//header('location:'.$ruta_crea_pdf);

		$comprobante=$link.'.PDF';
		$comprobante2=$link.'.XML';
		$comprobante3='R-'.$link.'.XML';
		
		$query_empresa = "SELECT * FROM vw_tbl_empresas WHERE id_empresa = $empresa";
        $resultado_empresa = $connect->prepare($query_empresa);
        $resultado_empresa->execute();
        $row_empresa = $resultado_empresa->fetch(PDO::FETCH_ASSOC);

		$smtp         = $row_empresa['smtp'];
		$usuario      = $row_empresa['correo_envio'];
		$contrrasenia = $row_empresa['clave_correo'];
		$puerto       = $row_empresa['puerto'];
		
		$query_cliente = "SELECT * FROM tbl_contribuyente WHERE id_persona = $cli";
        $resultado_cliente = $connect->prepare($query_cliente);
        $resultado_cliente->execute();
        $row_cliente = $resultado_cliente->fetch(PDO::FETCH_ASSOC);
        
        
     /*   if(trim($row_cliente['correo']) == '')
        {
        $jsondata['estado'] = '0';
		$jsondata['mensaje'] = 'No hay correo registrado para el envio';
		echo json_encode($jsondata);
		exit();
        }*/
        
        $invoiceFileName = $row_empresa['ruc'].'-'.$row_venta['tipocomp'].'-'.$row_venta['serie'].'-'.$row_venta['correlativo'];
        $rutaGuardado = '../../sunat/'.$row_empresa['ruc'].'/pdf/';
        
        $ruta_pdf = $rutaGuardado.$invoiceFileName;
        
        if($row_empresa['ruc'] == '20565728645')
        {
            $ruta_correo_pdf = 'factura_pdf_correo_htp';
        }
        else
        {
            $ruta_correo_pdf = 'factura_pdf_correo';
        }
        
     
        
	/*
		$mail = new PHPMailer();
		//Luego tenemos que iniciar la validación por SMTP:
		$mail->IsSMTP();
		$mail->SMTPAuth = true;
		$mail->SMTPOptions = array(
		    'ssl' => array(
		        'verify_peer' => false,
		        'verify_peer_name' => false,
		        'allow_self_signed' => true
		    )
		);

		$query_empresa = "SELECT * FROM vw_tbl_empresas WHERE id_empresa = $empresa";
        $resultado_empresa = $connect->prepare($query_empresa);
        $resultado_empresa->execute();
        $row_empresa = $resultado_empresa->fetch(PDO::FETCH_ASSOC);

		$smtp         = $row_empresa['smtp'];
		$usuario      = $row_empresa['correo_envio'];
		$contrrasenia = $row_empresa['clave_correo'];
		$puerto       = $row_empresa['puerto'];


		$mail->Host     = $smtp; // SMTP a utilizar. Por ej. smtp.elserver.com
		$mail->Username = $usuario;	
		$mail->Password = $contrrasenia;
		$mail->Port     = $puerto ; // Puerto a utilizar

		//$mail->SMTPDebug = SMTP::DEBUG_SERVER; //PARA VER SI HAY ERRORES
		$mail->From = $usuario; // Desde donde enviamos (Para mostrar)
		$mail->FromName = $row_empresa['razon_social'];


		$query_cliente = "SELECT * FROM tbl_contribuyente WHERE id_persona = $cli";
        $resultado_cliente = $connect->prepare($query_cliente);
        $resultado_cliente->execute();
        $row_cliente = $resultado_cliente->fetch(PDO::FETCH_ASSOC);

		$mail->AddAddress($row_cliente['correo']); // Esta es la dirección a donde enviamos
		$mail->IsHTML(true); // El correo se envía como HTML
        $mail->Subject = "Envío de comprobante: ".$comprobante; // Este es el titulo del email.	
        
        $ruta = base_url().'/images';

		$body ="<!doctype html>
		<html>
		<head>
		<meta charset='utf-8'>
		<title>Documento sin título</title>
		</head>

		<body>
		<img src=".$ruta."/logo/".$row_empresa['logo']." style='max-width: 300px; height: auto;' >
		<p>Estimado ".$row_cliente['nombre_persona'].",</p>
		<p>Por la presente le comunicamos que se ha emitido el siguiente comprobante electrónico:</p>
		<table border='0'>
		  <tbody>
		    <tr>
		      <td><strong>Tipo de documento</strong></td>
		      <td>:</td>
		      <td><strong>".$row_venta['nomdoc']."</strong></td>
		    </tr>
		    <tr>
		      <td><strong>Serie y número</strong></td>
		      <td>:</td>
		      <td><strong>".$serienumero."</strong></td>
		    </tr>
		    <tr>
		      <td><strong>Fecha de emisión</strong></td>
		      <td>:</td>
		      <td><strong>".date("d/m/Y", strtotime($row_venta['fecha_emision']))."</strong></td>
		    </tr>
		  </tbody>
		</table>
		<p>Se adjunta el Comprobante Electrónico.</p>
		<p>Le informamos además que a través del Portal Web puede consultar y descargar este Comprobante de Pago Electrónico.<br>
		  <a href='https://www.smartbase.club/comprobantes' target='_blank' >https://www.smartbase.club/comprobantes</a>.</p>
		<p>Atentamente,</p>
		<p>".$row_empresa['nombre_comercial']."<br>
		</p>
		</body>
		</html>";

		//$body .= "Acá continuo el <strong>mensaje</strong>";
		$mail->Body = $body; // Mensaje a enviar
		//$mail->AddAttachment("../sunat/".$row_empresa['ruc']."/pdf/".$comprobante, $comprobante);
		//$mail->AddAttachment("../sunat/".$row_empresa['ruc']."/xml/".$comprobante2, $comprobante2);
		//$mail->AddAttachment("../sunat/".$row_empresa['ruc']."/cdr/".$comprobante3, $comprobante3);
		$mail->CharSet = 'UTF-8';
		$exito = $mail->Send(); // Envía el correo.

		//unlink("../api_cpe/".$proceso."/".$config['ruc']."/".$comprobante);	/*para borrar el pdf creado*/

	/*	if($exito){

		$jsondata['estado'] = '1';
		$jsondata['mensaje'] = 'El Correo fue enviado exitosamente';

		}else{

		$jsondata['estado'] = '0';
		$jsondata['mensaje'] = 'No se pudo enviar el correo, Intenta más tarde';

		}

		echo json_encode($jsondata);
		exit();*/
		
		
		$mail = new PHPMailer(true);
		
		try
		{
		    /*server settings*/
		   $mail->SMTPDebug = 0;
		   //$mail->SMTPDebug = SMTP::DEBUG_SERVER; 
		    $mail->isSMTP();
		    $mail->Host = 'mail.smartbase.club';
		    $mail->SMTPAuth = false;
		    $mail->Username = 'soporte@smartbase.club';
		    $mail->Password = 'Sebastian.150915';
		    $mail->SMTPAutoTLS = false; 
		    //$mail->SMTPSecure = 'ssl';
		    $mail->Port = 25;
		    /*recipoents*/
		    $mail->setFrom('sistemas@smartbase.club',$row_empresa['nombre_comercial']);
		    $mail->AddAddress($row_cliente['correo']);
		    
		    $body ='<!doctype html>
		<html>
		<head>
		<meta charset="utf-8">
		<title>Documento sin título</title>
		</head>

		<body>
		<p><img src="'.base_url().'/assets/images/'.$row_empresa["logo"].'" alt="" width="300px"></p>
		<p>Estimado : '.strtoupper($row_cliente["nombre_persona"]).', </p>
		<p>Por la presente le comunicamos que se ha emitido el siguiente comprobante electrónico:</p>
		<table border="0">
		  <tbody>
		    <tr>
		      <td><strong>Tipo de documento</strong></td>
		      <td>:</td>
		      <td><strong>'.$row_venta["nomdoc"].'</strong></td>
		    </tr>
		    <tr>
		      <td><strong>Serie y número</strong></td>
		      <td>:</td>
		      <td><strong>'.$serienumero.'</strong></td>
		    </tr>
		    <tr>
		      <td><strong>Fecha de emisión</strong></td>
		      <td>:</td>
		      <td><strong>'.date("d/m/Y", strtotime($row_venta["fecha_emision"])).'</strong></td>
		    </tr>
		    <tr>
		      <td><strong>Importe</strong></td>
		      <td>:</td>
		      <td><strong>'.number_format($row_venta['total'],2).'</strong></td>
		    </tr>
		    <tr>
		      <td><strong>Hash</strong></td>
		      <td>:</td>
		      <td><strong>'.$row_venta["hash"].'</strong></td>
		    </tr>
		  </tbody>
		</table>
		<p>Se adjunta el Comprobante Electrónico.</p>
		<p>Le informamos además que a través del Portal Web puede consultar y descargar este Comprobante de Pago Electrónico.<br>
		  <a href="'.base_url().'views/modules/'.$ruta_correo_pdf.'.php?id='.$vta.'&emp='.$empresa.'" target="_blank" >Descarga tu comprobante</a>.</p>
			<p>Atentamente,</p>
		<p>'.$row_empresa["nombre_comercial"].'<br>
		
		</p>
		</body>
		</html>';
		 
/*
$mail->SMTPAuth = false;
$mail->SMTPAutoTLS = false; 
$mail->Port = 25; */
		    
		    /*content*/
		    $mail->isHTML(true);
		    $mail->Subject = 'Envio de comprobante Electrónico : '.$link;
		    $mail->Body    = $body;
		    //$mail->AddAttachment("../../sunat/".$row_empresa['ruc']."/pdf/".$comprobante, $comprobante);
		    $mail->AddAttachment("../../sunat/".$row_empresa['ruc']."/xml/".$comprobante2, $comprobante2);
    		$mail->AddAttachment("../../sunat/".$row_empresa['ruc']."/cdr/".$comprobante3, $comprobante3);
    		$mail->CharSet = 'UTF-8';
		    
		    $exito = $mail->send();
		    
		   //unlink($ruta_pdf);	/*para borrar el pdf creado*/
		   
		   if($exito){

		$jsondata['estado'] = '1';
		$jsondata['mensaje'] = 'El Correo fue enviado exitosamente';

		}else{

		$jsondata['estado'] = '0';
		$jsondata['mensaje'] = 'No se pudo enviar el correo, Intenta más tarde';

		}

		echo json_encode($jsondata);
		exit();
		  
		    
		    
		}
		catch(Exception $e)
		{
		    $mensaje = 'Hubo un error al enviar el mensaje - '.$mail->ErrorInfo;
		    echo json_encode($mensaje,true);
		}




}

?>