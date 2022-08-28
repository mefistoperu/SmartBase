<?php
require_once("signature.php");


class ApiFacturacion{

	public function EnviarComprobanteElectronico($emisor, $nombre,$connect,$lastInsertId, $rutacertificado="../../sunat/api/", $ruta_archivo_xml = "../../sunat/xml/", $ruta_archivo_cdr = "../../sunat/cdr/")
	{

		//firma del documento
		$objSignature = new Signature();

		$flg_firma = "0";
		$ruta = $ruta_archivo_xml.$nombre.'.XML';

		$ruta_firma = $rutacertificado.$emisor['certificado'];
		$pass_firma = $emisor['clave_certificado'];

		$resp = $objSignature->signature_xml($flg_firma, $ruta, $ruta_firma, $pass_firma);

		//print_r($resp);
		$hash = $resp['hash_cpe'];

		//Generar el .zip

		$zip = new ZipArchive();

		$nombrezip = $nombre.".ZIP";
		$rutazip = $ruta_archivo_xml.$nombre.".ZIP";

		if($zip->open($rutazip,ZIPARCHIVE::CREATE)===true){
			$zip->addFile($ruta, $nombre.'.XML');
			$zip->close();
		}


		//Enviamos el archivo a sunat

		
        //$ws = "https://e-factura.sunat.gob.pe/ol-ti-itcpfegem/billService?wsdl";
        $ws = "https://e-beta.sunat.gob.pe/ol-ti-itcpfegem-beta/billService";
		$ruta_archivo = $rutazip;
		$nombre_archivo = $nombrezip;

		//echo $ruta_archivo.','.$nombre_archivo;

		$contenido_del_zip = base64_encode(file_get_contents($ruta_archivo));

         //echo $contenido_del_zip;
		$xml_envio ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="http://service.sunat.gob.pe" xmlns:wsse="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd">
				 <soapenv:Header>
				 	<wsse:Security>
				 		<wsse:UsernameToken>
				 			<wsse:Username>'.$emisor['ruc'].$emisor['usuario_sol'].'</wsse:Username>
				 			<wsse:Password>'.$emisor['clave_sol'].'</wsse:Password>
				 		</wsse:UsernameToken>
				 	</wsse:Security>
				 </soapenv:Header>
				 <soapenv:Body>
				 	<ser:sendBill>
				 		<fileName>'.$nombre_archivo.'</fileName>
				 		<contentFile>'.$contenido_del_zip.'</contentFile>
				 	</ser:sendBill>
				 </soapenv:Body>
				</soapenv:Envelope>';

             //echo $xml_envio;
			$header = array(
						"Content-type: text/xml; charset=\"utf-8\"",
						"Accept: text/xml",
						"Cache-Control: no-cache",
						"Pragma: no-cache",
						"SOAPAction: ",
						"Content-lenght: ".strlen($xml_envio)
					);


			$ch = curl_init();
			curl_setopt($ch,CURLOPT_SSL_VERIFYPEER,1);
			curl_setopt($ch,CURLOPT_URL,$ws);
			curl_setopt($ch,CURLOPT_RETURNTRANSFER,true);
			curl_setopt($ch,CURLOPT_HTTPAUTH,CURLAUTH_ANY);
			curl_setopt($ch,CURLOPT_TIMEOUT,30);
			curl_setopt($ch,CURLOPT_POST,true);
			curl_setopt($ch,CURLOPT_POSTFIELDS,$xml_envio);
			curl_setopt($ch,CURLOPT_HTTPHEADER,$header);
			//para ejecutar los procesos de forma local en windows
			//enlace de descarga del cacert.pem https://curl.haxx.se/docs/caextract.html
			curl_setopt($ch, CURLOPT_CAINFO, dirname(__FILE__)."/cacert.pem");
			//curl_setopt($ch, CURLOPT_CAINFO, base_url()."/sunat/api/cacert.pem");

            //echo  dirname(__FILE__)."/cacert.pem";
			$response = curl_exec($ch);
           //echo $response;
			$httpcode = curl_getinfo($ch,CURLINFO_HTTP_CODE);
			//echo $httpcode;
			$estadofe = "0";
			if($httpcode == 200){ //200->La comunicación fue satisfactoria
				$doc = new DOMDocument();
				$doc->loadXML($response);

				        $codigo = '.';
						$mensaje = ' ha sido Aceptada por SUNAT';	

					if(isset($doc->getElementsByTagName('applicationResponse')->item(0)->nodeValue))
					{
						$cdr = $doc->getElementsByTagName('applicationResponse')->item(0)->nodeValue;
						$cdr = base64_decode($cdr);
						
						file_put_contents($ruta_archivo_cdr."R-".$nombrezip, $cdr);

						$zip = new ZipArchive;
						if($zip->open($ruta_archivo_cdr."R-".$nombrezip)===true)
						{
							$zip->extractTo($ruta_archivo_cdr,'R-'.$nombre.'.XML');
							$zip->close();
						}
						$estadofe ="1";
						//echo "TODO OK";
					}else{		
						$estadofe = "2";
						$codigo = $doc->getElementsByTagName("faultcode")->item(0)->nodeValue;
						$mensaje = $doc->getElementsByTagName("faultstring")->item(0)->nodeValue;
						//echo "error ".$codigo.": ".$mensaje; 
					}		

			}else{ //hay problemas comunicacion
					$estadofe = "3";
					curl_error($ch);
					//echo "Problema de conexión";
					$codigo = '.';
					$mensaje = '';	

			}
			$cod = explode('.',$codigo);
			$codigo = $cod[1];

		$query=$connect->prepare("UPDATE tbl_venta_cab SET hash=?,feestado=? ,fecodigoerror=?,femensajesunat=? WHERE id=?;");
		$resultado=$query->execute([$resp['hash_cpe'],$estadofe,$codigo,$mensaje,$lastInsertId]);

			curl_close($ch);
	}
	

public function EnviarResumenComprobantes($emisor,$nombre, $connect,$serier,$numeror, $rutacertificado="../../sunat/api/", $ruta_archivo_xml = "../../sunat/xml/",$ruta_archivo_cdr = "../../sunat/cdr/")
{

			//firma del documento
			$objSignature = new Signature();

			$flg_firma = "0";
			//$ruta_archivo_xml = "xml/";
			$ruta = $ruta_archivo_xml.$nombre.'.XML';

			$ruta_firma = $rutacertificado.$emisor['certificado'];
			$pass_firma = $emisor['clave_certificado'];

			$resp = $objSignature->signature_xml($flg_firma, $ruta, $ruta_firma, $pass_firma);

			//print_r($resp);
	        $hash = $resp['hash_cpe'];


			//Generar el .zip

			$zip = new ZipArchive();

			$nombrezip = $nombre.".ZIP";
			$rutazip = $ruta_archivo_xml.$nombre.".ZIP";

			if($zip->open($rutazip,ZIPARCHIVE::CREATE)===true){
				$zip->addFile($ruta, $nombre.'.XML');
				$zip->close();
			}


			//Enviamos el archivo a sunat

			 $ws = "https://e-beta.sunat.gob.pe/ol-ti-itcpfegem-beta/billService";

			$ruta_archivo = $ruta_archivo_xml.$nombrezip;

			$nombre_archivo = $nombrezip;
			$ruta_archivo_cdr = "../../sunat/cdr/";

			$contenido_del_zip = base64_encode(file_get_contents($ruta_archivo));
			
			$xml_envio ='<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="http://service.sunat.gob.pe" xmlns:wsse="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd">
					 <soapenv:Header>
					 	<wsse:Security>
					 		<wsse:UsernameToken>
					 			<wsse:Username>'.$emisor['ruc'].$emisor['usuario_sol'].'</wsse:Username>
					 			<wsse:Password>'.$emisor['clave_sol'].'</wsse:Password>
					 		</wsse:UsernameToken>
					 	</wsse:Security>
					 </soapenv:Header>
					 <soapenv:Body>
					 	<ser:sendSummary>
					 		<fileName>'.$nombre_archivo.'</fileName>
					 		<contentFile>'.$contenido_del_zip.'</contentFile>
					 	</ser:sendSummary>
					 </soapenv:Body>
					</soapenv:Envelope>';


				$header = array(
							"Content-type: text/xml; charset=\"utf-8\"",
							"Accept: text/xml",
							"Cache-Control: no-cache",
							"Pragma: no-cache",
							"SOAPAction: ",
							"Content-lenght: ".strlen($xml_envio)
						);


				$ch = curl_init();
				curl_setopt($ch,CURLOPT_SSL_VERIFYPEER,0);
				curl_setopt($ch,CURLOPT_URL,$ws);
				curl_setopt($ch,CURLOPT_RETURNTRANSFER,true);
				curl_setopt($ch,CURLOPT_HTTPAUTH,CURLAUTH_ANY);
				curl_setopt($ch,CURLOPT_TIMEOUT,30);
				curl_setopt($ch,CURLOPT_POST,true);
				curl_setopt($ch,CURLOPT_POSTFIELDS,$xml_envio);
				curl_setopt($ch,CURLOPT_HTTPHEADER,$header);
				//para ejecutar los procesos de forma local en windows
				//enlace de descarga del cacert.pem https://curl.haxx.se/docs/caextract.html
				curl_setopt($ch, CURLOPT_CAINFO, dirname(__FILE__)."/cacert.pem");

				$response = curl_exec($ch);

				$httpcode = curl_getinfo($ch,CURLINFO_HTTP_CODE);
				$estadofe = "0";

				$ticket = "0";
				if($httpcode == 200)
				{
					$doc = new DOMDocument();
					$doc->loadXML($response);

					if (isset($doc->getElementsByTagName('ticket')->item(0)->nodeValue)) 
					{
		                $ticket = $doc->getElementsByTagName('ticket')->item(0)->nodeValue;
						//echo "TODO OK : ".$ticket;
						$estadofe ="1";
						$codigo='.';
						$mensaje = 'Acepta por SUNAT';
					}
					else
					{		

						$codigo = $doc->getElementsByTagName("faultcode")->item(0)->nodeValue;
						$mensaje = $doc->getElementsByTagName("faultstring")->item(0)->nodeValue;
						//echo "error ".$codigo.": ".$mensaje; 
						$ticket='';
						$estadofe="2";
					}

				}
				else{
					echo curl_error($ch);
					echo "Problema de conexión";
					$codigo = '.';
					$mensaje = '';	
					$ticket = '';
					$estadofe="3";
				}

				$cod = explode('.',$codigo);
				$codigo = $cod[1];

				$query=$connect->prepare("UPDATE tbl_venta_cab SET hash=?,feestado=? ,fecodigoerror=?,femensajesunat=?,ticket=? WHERE serie_resumen=? and numero_resumen=?");
				$resultado=$query->execute([$resp['hash_cpe'],$estadofe,$codigo,$mensaje,$ticket,$serier,$numeror]);

				curl_close($ch);
				return $ticket;
}


function ConsultarTicket($emisor, $nombre, $ticket,$rutacertificado="../../sunat/api/",  $ruta_archivo_xml = "../../sunat/xml/", $ruta_archivo_cdr = "../../sunat/cdr/")
{

		$ws = "https://e-beta.sunat.gob.pe/ol-ti-itcpfegem-beta/billService";
		//$nombre	= $emisor["ruc"]."-".$cabecera["tipodoc"]."-".$cabecera["serie"]."-".$cabecera["correlativo"];
		$nombre_xml	= $nombre.".XML";

		//===============================================================//
		//FIRMADO DEL cpe CON CERTIFICADO DIGITAL
		$objSignature = new Signature();
		$flg_firma = "0";
		$ruta = $ruta_archivo_xml.$nombre_xml;
        //echo $ruta;
		$ruta_firma = $rutacertificado.$emisor['certificado'];
		$pass_firma = $emisor['clave_certificado'];

		//===============================================================//

		//ALMACENAR EL ARCHIVO EN UN ZIP
		$zip = new ZipArchive();

		$nombrezip = $nombre.".ZIP";

		if($zip->open($nombrezip,ZIPARCHIVE::CREATE)===true)
		{
			$zip->addFile($ruta, $nombre_xml);
			$zip->close();
		}

		//===============================================================//

		//ENVIAR ZIP A SUNAT
		$ruta_archivo = $ruta_archivo_xml.$nombre;
		//$nombre_archivo = $nombre;
		//$ruta_archivo_cdr = "cdr/";

		$contenido_del_zip = base64_encode(file_get_contents($ruta_archivo.'.ZIP'));
		//FIN ZIP

		$xml_envio = '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="http://service.sunat.gob.pe" xmlns:wsse="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd">
        <soapenv:Header>
        <wsse:Security>
        <wsse:UsernameToken>
        <wsse:Username>'.$emisor['ruc'].$emisor['usuario_sol'].'</wsse:Username>
        <wsse:Password>'.$emisor['clave_sol'].'</wsse:Password>
        </wsse:UsernameToken>
        </wsse:Security>
        </soapenv:Header>
        <soapenv:Body>
        <ser:getStatus>
        <ticket>' . $ticket . '</ticket>
        </ser:getStatus>
        </soapenv:Body>
        </soapenv:Envelope>';


		$header = array(
					"Content-type: text/xml; charset=\"utf-8\"",
					"Accept: text/xml",
					"Cache-Control: no-cache",
					"Pragma: no-cache",
					"SOAPAction: ",
					"Content-lenght: ".strlen($xml_envio)
				);


		$ch = curl_init();
		curl_setopt($ch,CURLOPT_SSL_VERIFYPEER,1);
		curl_setopt($ch,CURLOPT_URL,$ws);
		curl_setopt($ch,CURLOPT_RETURNTRANSFER,true);
		curl_setopt($ch,CURLOPT_HTTPAUTH,CURLAUTH_ANY);
		curl_setopt($ch,CURLOPT_TIMEOUT,30);
		curl_setopt($ch,CURLOPT_POST,true);
		curl_setopt($ch,CURLOPT_POSTFIELDS,$xml_envio);
		curl_setopt($ch,CURLOPT_HTTPHEADER,$header);
		//para ejecutar los procesos de forma local en windows
		//enlace de descarga del cacert.pem https://curl.haxx.se/docs/caextract.html
		curl_setopt($ch, CURLOPT_CAINFO, dirname(__FILE__)."/cacert.pem");

		$response = curl_exec($ch);
		$httpcode = curl_getinfo($ch,CURLINFO_HTTP_CODE);

		//echo "codigo:".$httpcode;

		if($httpcode == 200){
			$doc = new DOMDocument();
			$doc->loadXML($response);

			if(isset($doc->getElementsByTagName('content')->item(0)->nodeValue)){
				$cdr = $doc->getElementsByTagName('content')->item(0)->nodeValue;
				$cdr = base64_decode($cdr);
				

				file_put_contents($ruta_archivo_cdr."R-".$nombre.".ZIP", $cdr);

				$zip = new ZipArchive;
				if($zip->open($ruta_archivo_cdr."R-".$nombre.".ZIP")===true){
					$zip->extractTo($ruta_archivo_cdr,'R-'.$nombre.'.XML');
					$zip->close();
				}
				echo "TODO OK1";
			}else{		
				$codigo = $doc->getElementsByTagName("faultcode")->item(0)->nodeValue;
				$mensaje = $doc->getElementsByTagName("faultstring")->item(0)->nodeValue;
				echo "error ".$codigo.": ".$mensaje; 
			}

		}else{
			echo curl_error($ch);
			echo "Problema de conexión1 ";
		}

		curl_close($ch);
	}


function consultarComprobante($emisor, $comprobante){

		try{
				$ws = "https://e-beta.sunat.gob.pe/ol-ti-itcpfegem-beta/billService";
				$soapUser = "";  
				$soapPassword = "";

				$xml_post_string = '<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
				xmlns:SOAP-ENV="http://schemas.xmlsoap.org/soap/envelope/" xmlns:ser="http://service.sunat.gob.pe" 
				xmlns:wsse="http://docs.oasis-open.org/wss/2004/01/oasis-200401-wss-wssecurity-secext-1.0.xsd">
					<soapenv:Header>
						<wsse:Security>
							<wsse:UsernameToken>
								<wsse:Username>'.$emisor['ruc'].$emisor['usuariosol'].'</wsse:Username>
								<wsse:Password>'.$emisor['clavesol'].'</wsse:Password>
							</wsse:UsernameToken>
						</wsse:Security>
					</soapenv:Header>
					<soapenv:Body>
						<ser:getStatus>
							<rucComprobante>'.$emisor['ruc'].'</rucComprobante>
							<tipoComprobante>'.$comprobante['tipodoc'].'</tipoComprobante>
							<serieComprobante>'.$comprobante['serie'].'</serieComprobante>
							<numeroComprobante>'.$comprobante['correlativo'].'</numeroComprobante>
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
				); 			
			
				$ch = curl_init();
				curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, 1);
				curl_setopt($ch, CURLOPT_URL, $ws);
				curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
				curl_setopt($ch, CURLOPT_HTTPAUTH, CURLAUTH_ANY);
				curl_setopt($ch, CURLOPT_TIMEOUT, 30);
				curl_setopt($ch, CURLOPT_POST, true);
				curl_setopt($ch, CURLOPT_POSTFIELDS, $xml_post_string); // the SOAP request
				curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);
			
				//para ejecutar los procesos de forma local en windows
				//enlace de descarga del cacert.pem https://curl.haxx.se/docs/caextract.html
				curl_setopt($ch, CURLOPT_CAINFO, dirname(__FILE__)."/cacert.pem");

				$response = curl_exec($ch);
				$httpcode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
				curl_close($ch);
				echo var_dump($response);
				
			} catch (Exception $e) {
				echo "SUNAT ESTA FUERA SERVICIO: ".$e->getMessage();
			}



}



}
?>