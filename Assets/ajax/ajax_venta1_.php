<?php 

require_once("../../config/config.php");
require_once("../../helpers/helpers.php"); 
require_once("../../libraries/conexion.php"); 
require_once("../../sunat/api/xml.php");
require_once("../../sunat/api/ApiFacturacion.php");
session_start();




// guardar nueva venta

if($_POST['action'] == 'nueva_venta')
 {
            $query=$connect->prepare("INSERT INTO tbl_venta_cab(idempresa,tipocomp,serie,correlativo,fecha_emision,fecha_vencimiento,condicion_venta,op_gravadas,op_exoneradas,op_inafectas,igv,total,codcliente,vendedor) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?);");
            $resultado=$query->execute([$_POST['empresa'],$_POST['tip_cpe'],$_POST['serie'],$_POST['numero'],$_POST['fecha_emision'],$_POST['fecha_vencimiento'],$_POST['condicion'],$_POST['op_g'],$_POST['op_e'],$_POST['op_i'],$_POST['igv'],$_POST['total'],$_POST['ruc_persona'], $_SESSION["id"]]);
                $lastInsertId = $connect->lastInsertId();
               //registro detalle compra


                    for($i = 0; $i< count($_POST['idarticulo']); $i++)
                    {
                              $item                  = $_POST['itemarticulo'][$i];
                              $idarticulo            = $_POST['idarticulo'][$i];
                              $nomarticulo           = $_POST['nomarticulo'][$i];
                              $cantidad              = $_POST['cantidad'][$i];
                              $precio_venta          = $_POST['precio_venta'][$i];
                              $afectacion            = $_POST['afectacion'][$i];
                              $tipo_precio           = '01';
                              $unidad                = 'NIU';
                              $costo                 =  $_POST['costo'][$i];

                                      if($afectacion == '10')
                                      {
                                        $valor_unitario = $precio_venta / 1.18;
                                      }
                                      else
                                      {
                                        $valor_unitario = $precio_venta;

                                      }
                                   $igv = $precio_venta - $valor_unitario;
                                  
                                  $insert_query_detalle =$connect->prepare("INSERT INTO tbl_venta_det(idventa,item,idproducto,cantidad,valor_unitario,precio_unitario,igv,porcentaje_igv,valor_total,importe_total,costo) VALUES(?,?,?,?,?,?,?,?,?,?,?)");
                                  $resultado_detalle = $insert_query_detalle->execute([$lastInsertId,$item,$idarticulo,$cantidad,$valor_unitario,$precio_venta,$igv,18,($cantidad*$valor_unitario),($cantidad*$precio_venta),$costo]);

                                      // actualizar serie + correlativo
                                      $update_query_serie = $connect->prepare("UPDATE tbl_series SET correlativo = correlativo + ? WHERE serie = ? and correlativo = ? and id_empresa = ?");
                                    $resultado_serie   = $update_query_serie->execute([1,$_POST['serie'],$_POST['numero'],$_POST['empresa']]);
                               
                                                                     
                                             //actualizar stock insumos
                                                if($_POST['tip_cpe']=='01' || $_POST['tip_cpe']=='03')
                                            {
                                              //ACTUALIZA STOCK

                                        $query_stock  = $connect->prepare("UPDATE tbl_productos SET stock = stock - ? WHERE id=?");
                                        $resultado_stock = $query_stock->execute([$cantidad,$idarticulo]);
                                            }
                                            else if($_POST['tip_cpe']=='07')
                                            {
                                               //ACTUALIZA STOCK

                                        $query_stock  = $connect->prepare("UPDATE tbl_productos SET stock = stock + ? WHERE id=?");
                                        $resultado_stock = $query_stock->execute([$cantidad,$idarticulo]);
                                            }

                                        
                    }

              //insert deuda por cobrar

            $insert_ctemov =$connect->prepare("INSERT INTO tbl_cta_cobrar(tipo,persona,tipo_doc,ser_doc,num_doc,monto,fecha,empresa) VALUES(?,?,?,?,?,?,?,?)");
                  $resultado_detalle = $insert_ctemov->execute(['1',$_POST['ruc_persona'],$_POST['tip_cpe'],$_POST['serie'],$_POST['numero'],$_POST['total'],$_POST['fecha_emision'],$_POST['empresa']]);
                   
            //envio cpe a SUNAT///////////////////////////////////////////////
            require_once("../../sunat/api/xml.php");


            $xml = new GeneradorXML();
            //buscar ruc emisor
                    
                        $query_empresa = "SELECT * FROM tbl_empresas WHERE id_empresa = $_POST[empresa]";
                        $resultado_empresa = $connect->prepare($query_empresa);
                        $resultado_empresa->execute();
                        $row_empresa = $resultado_empresa->fetch(PDO::FETCH_ASSOC);


            //RUC DEL EMISOR - TIPO DE COMPROBANTE - SERIE DEL DOCUMENTO - CORRELATIVO
            //01-> FACTURA, 03-> BOLETA, 07-> NOTA DE CREDITO, 08-> NOTA DE DEBITO, 09->GUIA DE REMISION
            $nombrexml = $row_empresa['ruc'].'-'.$_POST['tip_cpe'].'-'.$_POST['serie'].'-'.$_POST['numero'];

            $ruta = "../../sunat/xml/".$nombrexml;
            $emisor =   array(
                        'tipodoc'       => '6',
                        'ruc'           => $row_empresa['ruc'], 
                        'razon_social'  => $row_empresa['razon_social'], 
                        'nombre_comercial'  => ' ', 
                        'direccion'     => $row_empresa['direccion'], 
                        'pais'          => 'PE', 
                        'departamento'  => $row_empresa['departamento'],//LAMBAYEQUE 
                        'provincia'     => $row_empresa['provincia'],//CHICLAYO 
                        'distrito'      => $row_empresa['distrito'], //CHICLAYO
                        'ubigeo'        => $row_empresa['ubigeo'], //CHICLAYO
                        'usuario_sol'   => $row_empresa['usuario_sol'], //USUARIO SECUNDARIO EMISOR ELECTRONICO
                        'clave_sol'     => $row_empresa['clave_sol'], //CLAVE DE USUARIO SECUNDARIO EMISOR ELECTRONICO
                        'certificado'  => $row_empresa['certificado'],
                        'clave_certificado'  =>$row_empresa['clave_certificado']
                        );
            //buscar datos cliente
                    
                        $query_cliente = "SELECT * FROM tbl_contribuyente WHERE num_doc = $_POST[ruc_persona]";
                        $resultado_cliente = $connect->prepare($query_cliente);
                        $resultado_cliente->execute();
                        $row_cliente = $resultado_cliente->fetch(PDO::FETCH_ASSOC);
                          //********************CREAR CLAVE CLIENTE SI EN CASO NO TIENE*********************//

          
                    $clave = $row_cliente['clave'];
                    $ruc_persona1 = $row_cliente['num_doc'];


                    if(empty($clave))
                    {
                        $query_ctr = $connect->prepare("UPDATE tbl_contribuyente SET clave = md5(?) WHERE num_doc = ?");
                        $resultado_ctr = $query_ctr->execute([$ruc_persona1,$ruc_persona1]);

                    }

            $cliente = array(
                        'tipodoc'       => $row_cliente['tipo_doc'],//6->ruc, 1-> dni 
                        'ruc'           => $row_cliente['num_doc'], 
                        'razon_social'  => $row_cliente['nombre_persona'], 
                        'direccion'     => $row_cliente['direccion_persona'],
                        'pais'          => 'PE'
                        );  
            $numero = $_POST['total'];
            include 'numeros.php';
            $texto=convertir($numero);

            $comprobante =  array(
                        'tipodoc'       => $_POST['tip_cpe'], //01->FACTURA, 03->BOLETA, 07->NC, 08->ND
                        'serie'         => $_POST['serie'],
                        'correlativo'   => $_POST['numero'],
                        'fecha_emision' => $_POST['fecha_emision'],
                        'moneda'        => 'PEN', //PEN->SOLES; USD->DOLARES
                        'total_opgravadas'=> $_POST['op_g'], //OP. GRAVADAS
                        'total_opexoneradas'=>$_POST['op_e'],
                        'total_opinafectas'=>$_POST['op_i'],
                        'igv'           => $_POST['igv'],
                        'total'         => $_POST['total'],
                        'total_texto'   => $texto
                    );


            //********************DATOS DE COMPROBANTE - DETALLE*********************//

            //echo 'el id ultimo es '.$lastInsertId;
            $lista_cpe_det = $connect->prepare("SELECT * FROM vw_tbl_venta_det WHERE idventa=$lastInsertId");
            
            $lista_cpe_det->execute();
            $row_cpe_det=$lista_cpe_det->fetchAll(PDO::FETCH_ASSOC);
            //print_r($row_cpe_det);

            $detalle = $row_cpe_det;
                
          // var_dump($detalle1);



            $xml->CrearXMLFactura($ruta, $emisor, $cliente, $comprobante, $detalle);


            require_once("../../sunat/api/ApiFacturacion.php");

            $objApi = new ApiFacturacion();

            if($row_empresa['envio_automatico']=='SI')
            {
                if($_POST['tip_cpe']=='03' && $row_empresa['envio_resumen']=='SI')
                {
                     require_once("phpqrcode/qrlib.php");
                        //CREAR QR INICIO
                        //codigo qr
                        /*RUC | TIPO DE DOCUMENTO | SERIE | NUMERO | MTO TOTAL IGV | 
                        MTO TOTAL DEL COMPROBANTE | FECHA DE EMISION |TIPO DE DOCUMENTO ADQUIRENTE |
                        NUMERO DE DOCUMENTO ADQUIRENTE |*/

                        $ruc = $row_empresa['ruc'];
                        $tipo_documento = $_POST['tip_cpe']; //factura
                        $serie = $_POST['serie'];
                        $correlativo = $_POST['numero'];
                        $igv = $_POST['igv'];
                        $total = $_POST['total'];
                        $fecha = $_POST['fecha_emision'];
                        $tipodoccliente = $row_cliente['tipo_doc'];
                        $nro_doc_cliente = $row_cliente['num_doc'];

                        $nombrexml = $ruc."-".$tipo_documento."-".$serie."-".$correlativo;
                        $text_qr = $ruc." | ".$tipo_documento." | ".$serie." | ".$correlativo." | ".$igv." | ".$total." | ".$fecha." | ".$tipodoccliente." | ".$nro_doc_cliente;
                        $ruta_qr = '../../sunat/qr/'.$nombrexml.'.png';

                        QRcode::png($text_qr, $ruta_qr, 'Q',15, 0);

                        echo json_encode($lastInsertId);
                        exit;

                }

               else if($_POST['tip_cpe']=='01' || $_POST['tip_cpe']=='03')
               {

                        $objApi->EnviarComprobanteElectronico($emisor,$nombrexml,$connect,$lastInsertId);
                            
                        require_once("phpqrcode/qrlib.php");
                                //CREAR QR INICIO
                                //codigo qr
                                /*RUC | TIPO DE DOCUMENTO | SERIE | NUMERO | MTO TOTAL IGV | 
                                MTO TOTAL DEL COMPROBANTE | FECHA DE EMISION |TIPO DE DOCUMENTO ADQUIRENTE |
                                NUMERO DE DOCUMENTO ADQUIRENTE |*/

                        $ruc = $row_empresa['ruc'];
                        $tipo_documento = $_POST['tip_cpe']; //factura
                        $serie = $_POST['serie'];
                        $correlativo = $_POST['numero'];
                        $igv = $_POST['igv'];
                        $total = $_POST['total'];
                        $fecha = $_POST['fecha_emision'];
                        $tipodoccliente = $row_cliente['tipo_doc'];
                        $nro_doc_cliente = $row_cliente['num_doc'];

                        $nombrexml = $ruc."-".$tipo_documento."-".$serie."-".$correlativo;
                        $text_qr = $ruc." | ".$tipo_documento." | ".$serie." | ".$correlativo." | ".$igv." | ".$total." | ".$fecha." | ".$tipodoccliente." | ".$nro_doc_cliente;
                        $ruta_qr = '../../sunat/qr/'.$nombrexml.'.png';

                        QRcode::png($text_qr, $ruta_qr, 'Q',15, 0);

                        echo json_encode($lastInsertId);
                        exit;
               }
            }
               // si envio automatico es NO
            else
            {
                require_once("phpqrcode/qrlib.php");
                        //CREAR QR INICIO
                        //codigo qr
                        /*RUC | TIPO DE DOCUMENTO | SERIE | NUMERO | MTO TOTAL IGV | 
                        MTO TOTAL DEL COMPROBANTE | FECHA DE EMISION |TIPO DE DOCUMENTO ADQUIRENTE |
                        NUMERO DE DOCUMENTO ADQUIRENTE |*/

                $ruc = $row_empresa['ruc'];
                $tipo_documento = $_POST['tip_cpe']; //factura
                $serie = $_POST['serie'];
                $correlativo = $_POST['numero'];
                $igv = $_POST['igv'];
                $total = $_POST['total'];
                $fecha = $_POST['fecha_emision'];
                $tipodoccliente = $row_cliente['tipo_doc'];
                $nro_doc_cliente = $row_cliente['num_doc'];

                $nombrexml = $ruc."-".$tipo_documento."-".$serie."-".$correlativo;
                $text_qr = $ruc." | ".$tipo_documento." | ".$serie." | ".$correlativo." | ".$igv." | ".$total." | ".$fecha." | ".$tipodoccliente." | ".$nro_doc_cliente;
                $ruta_qr = '../../sunat/qr/'.$nombrexml.'.png';

                QRcode::png($text_qr, $ruta_qr, 'Q',15, 0);

                echo json_encode($lastInsertId);
                exit;
            }
 }



// guardar nueva venta nota de credito

if($_POST['action'] == 'nueva_nota_de_credito')

{

    $porciones = explode("-", $_POST['motivo1']);
    $cmotivo= $porciones[0]; // porción1
    $cdescripcion = $porciones[1]; // porción2
                $query=$connect->prepare("INSERT INTO tbl_venta_cab(idempresa,tipocomp,serie,correlativo,fecha_emision,fecha_vencimiento,condicion_venta,op_gravadas,op_exoneradas,op_inafectas,igv,total,codcliente,tipocomp_ref,serie_ref,correlativo_ref,cod_motivo,des_motivo) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);");
            $resultado=$query->execute([$_POST['empresa'],$_POST['tip_cpe'],$_POST['serie'],$_POST['numero'],$_POST['fecha_emision'],$_POST['fecha_vencimiento'],$_POST['condicion'],$_POST['op_g'],$_POST['op_e'],$_POST['op_i'],$_POST['igv'],$_POST['total'],$_POST['ruc_persona'],$_POST['cod_doc_ref'],$_POST['serie_ref'],$_POST['num_ref'],$cmotivo,$cdescripcion]);
                $lastInsertId = $connect->lastInsertId();
               //registro detalle compra


                    for($i = 0; $i< count($_POST['idarticulo']); $i++)
                    {
                              $item                  = $_POST['itemarticulo'][$i];
                              $idarticulo            = $_POST['idarticulo'][$i];
                              $nomarticulo           = $_POST['nomarticulo'][$i];
                              $cantidad              = $_POST['cantidad'][$i];
                              $precio_venta          = $_POST['precio_venta'][$i];
                              $afectacion            = $_POST['afectacion'][$i];
                              $tipo_precio           ='01';
                              $unidad                = 'NIU';

                                      if($afectacion == '10')
                                      {
                                        $valor_unitario = $precio_venta / 1.18;
                                      }
                                      else
                                      {
                                        $valor_unitario = $precio_venta;

                                      }
                                   $igv = $precio_venta - $valor_unitario;
                                  
                                  $insert_query_detalle =$connect->prepare("INSERT INTO tbl_venta_det(idventa,item,idproducto,cantidad,valor_unitario,precio_unitario,igv,porcentaje_igv,valor_total,importe_total) VALUES(?,?,?,?,?,?,?,?,?,?)");
                                  $resultado_detalle = $insert_query_detalle->execute([$lastInsertId,$item,$idarticulo,$cantidad,$valor_unitario,$precio_venta,$igv,18,($cantidad*$valor_unitario),($cantidad*$precio_venta)]);

                                      // actualizar serie + correlativo
                                      $update_query_serie = $connect->prepare("UPDATE tbl_series SET correlativo = correlativo + ? WHERE serie = ? and correlativo = ? and id_empresa = ?");
                                    $resultado_serie   = $update_query_serie->execute([1,$_POST['serie'],$_POST['numero'],$_POST['empresa']]);
                               
                                if($cmotivo=='01' || $cmotivo=='02'  )
                                {
                                    //buscar insumos de tabla recetas
                                    
                                        $query_articulos = "SELECT * FROM tbl_recetas WHERE id_producto = '$idarticulo'";
                                        $resultado_articulos = $connect->prepare($query_articulos);
                                        $resultado_articulos->execute();
                                        //$row_articulos = $resultado_articulos->fetch(PDO::FETCH_ASSOC);
                                         foreach($resultado_articulos as $receta_insumo)
                                         {
                                             //actualizar stock insumos
                                                if($_POST['tip_cpe']=='01' || $_POST['tip_cpe']=='03')
                                            {
                                                $query_insumo = $connect->prepare("UPDATE tbl_insumos SET stock = stock - ?  WHERE id = ?");
                                                    $resultado_insumo = $query_insumo->execute([$cantidad*$receta_insumo['cantidad'],$receta_insumo['id_insumo']]);
                                            }
                                            else if($_POST['tip_cpe']=='07')
                                            {
                                                $query_insumo = $connect->prepare("UPDATE tbl_insumos SET stock = stock + ?  WHERE id = ?");
                                                    $resultado_insumo = $query_insumo->execute([$cantidad*$receta_insumo['cantidad'],$receta_insumo['id_insumo']]);
                                            }


                                         }
                                    }
                    }

              //insert deuda por cobrar

            $insert_ctemov =$connect->prepare("INSERT INTO tbl_cta_cobrar(tipo,persona,tipo_doc,ser_doc,num_doc,monto,fecha,empresa) VALUES(?,?,?,?,?,?,?,?)");
            $resultado_detalle = $insert_ctemov->execute(['2',$_POST['ruc_persona'],$_POST['tip_cpe'],$_POST['serie'],$_POST['numero'],$_POST['total'],$_POST['fecha_emision'],$_POST['empresa']]);
                   
            //envio cpe a SUNAT///////////////////////////////////////////////
            require_once("../../sunat/api/xml.php");


            $xml = new GeneradorXML();
            //buscar ruc emisor
                    
                        $query_empresa = "SELECT * FROM tbl_empresas WHERE id_empresa = $_POST[empresa]";
                        $resultado_empresa = $connect->prepare($query_empresa);
                        $resultado_empresa->execute();
                        $row_empresa = $resultado_empresa->fetch(PDO::FETCH_ASSOC);


            //RUC DEL EMISOR - TIPO DE COMPROBANTE - SERIE DEL DOCUMENTO - CORRELATIVO
            //01-> FACTURA, 03-> BOLETA, 07-> NOTA DE CREDITO, 08-> NOTA DE DEBITO, 09->GUIA DE REMISION
            $nombrexml = $row_empresa['ruc'].'-'.$_POST['tip_cpe'].'-'.$_POST['serie'].'-'.$_POST['numero'];

            $ruta = "../../sunat/xml/".$nombrexml;
            $emisor =   array(
                        'tipodoc'       => '6',
                        'ruc'           => $row_empresa['ruc'], 
                        'razon_social'  => $row_empresa['razon_social'], 
                        'nombre_comercial'  => ' ', 
                        'direccion'     => $row_empresa['direccion'], 
                        'pais'          => 'PE', 
                        'departamento'  => $row_empresa['departamento'],//LAMBAYEQUE 
                        'provincia'     => $row_empresa['provincia'],//CHICLAYO 
                        'distrito'      => $row_empresa['distrito'], //CHICLAYO
                        'ubigeo'        => $row_empresa['ubigeo'], //CHICLAYO
                        'usuario_sol'   => $row_empresa['usuario_sol'], //USUARIO SECUNDARIO EMISOR ELECTRONICO
                        'clave_sol'     => $row_empresa['clave_sol'], //CLAVE DE USUARIO SECUNDARIO EMISOR ELECTRONICO
                        'certificado'  => $row_empresa['certificado'],
                        'clave_certificado'  =>$row_empresa['clave_certificado']
                        );
            //buscar datos cliente
                    
                        $query_cliente = "SELECT * FROM tbl_contribuyente WHERE num_doc = $_POST[ruc_persona]";
                        $resultado_cliente = $connect->prepare($query_cliente);
                        $resultado_cliente->execute();
                        $row_cliente = $resultado_cliente->fetch(PDO::FETCH_ASSOC);

            $cliente = array(
                        'tipodoc'       => $row_cliente['tipo_doc'],//6->ruc, 1-> dni 
                        'ruc'           => $row_cliente['num_doc'], 
                        'razon_social'  => $row_cliente['nombre_persona'], 
                        'direccion'     => $row_cliente['direccion_persona'],
                        'pais'          => 'PE'
                        );  

            $numero = $_POST['total'];
            include 'numeros.php';
            $texto=convertir($numero);

            $comprobante =  array(
                        'tipodoc'       => $_POST['tip_cpe'], //01->FACTURA, 03->BOLETA, 07->NC, 08->ND
                        'serie'         => $_POST['serie'],
                        'correlativo'   => $_POST['numero'],
                        'fecha_emision' => $_POST['fecha_emision'],
                        'moneda'        => 'PEN', //PEN->SOLES; USD->DOLARES
                        'total_opgravadas'=> $_POST['op_g'], //OP. GRAVADAS
                        'total_opexoneradas'=>$_POST['op_e'],
                        'total_opinafectas'=>$_POST['op_i'],
                        'igv'           => $_POST['igv'],
                        'total'         => $_POST['total'],
                        'total_texto'   => $texto,
                        'tipodoc_ref'   => $_POST['cod_doc_ref'], //FACTURA
                        'serie_ref'     => $_POST['serie_ref'],
                        'correlativo_ref'=> $_POST['num_ref'],
                        'codmotivo'     => $cmotivo,
                        'descripcion'   => $cdescripcion
                    );


            //********************DATOS DE COMPROBANTE - DETALLE*********************//

            //echo 'el id ultimo es '.$lastInsertId;
            $lista_cpe_det = $connect->prepare("SELECT * FROM vw_tbl_venta_det WHERE idventa=$lastInsertId");
            
            $lista_cpe_det->execute();
            $row_cpe_det=$lista_cpe_det->fetchAll(PDO::FETCH_ASSOC);
            //print_r($row_cpe_det);

            $detalle = $row_cpe_det;

          // var_dump($detalle1);



            $xml->CrearXMLNotaCredito($ruta, $emisor, $cliente, $comprobante, $detalle);


            require_once("../../sunat/api/ApiFacturacion.php");

            $objApi = new ApiFacturacion();

            if($row_empresa['envio_automatico']=='SI')
            {
                if($_POST['tip_cpe']=='03' && $row_empresa['envio_resumen']=='SI')
                {
                     require_once("phpqrcode/qrlib.php");
                        //CREAR QR INICIO
                        //codigo qr
                        /*RUC | TIPO DE DOCUMENTO | SERIE | NUMERO | MTO TOTAL IGV | 
                        MTO TOTAL DEL COMPROBANTE | FECHA DE EMISION |TIPO DE DOCUMENTO ADQUIRENTE |
                        NUMERO DE DOCUMENTO ADQUIRENTE |*/

                $ruc = $row_empresa['ruc'];
                $tipo_documento = $_POST['tip_cpe']; //factura
                $serie = $_POST['serie'];
                $correlativo = $_POST['numero'];
                $igv = $_POST['igv'];
                $total = $_POST['total'];
                $fecha = $_POST['fecha_emision'];
                $tipodoccliente = $row_cliente['tipo_doc'];
                $nro_doc_cliente = $row_cliente['num_doc'];

                $nombrexml = $ruc."-".$tipo_documento."-".$serie."-".$correlativo;
                $text_qr = $ruc." | ".$tipo_documento." | ".$serie." | ".$correlativo." | ".$igv." | ".$total." | ".$fecha." | ".$tipodoccliente." | ".$nro_doc_cliente;
                $ruta_qr = '../../sunat/qr/'.$nombrexml.'.png';

                QRcode::png($text_qr, $ruta_qr, 'Q',15, 0);

                echo json_encode($lastInsertId);
                exit;

                }

               else
               {

                $objApi->EnviarComprobanteElectronico($emisor,$nombrexml,$connect,$lastInsertId);
                    
                require_once("phpqrcode/qrlib.php");
                        //CREAR QR INICIO
                        //codigo qr
                        /*RUC | TIPO DE DOCUMENTO | SERIE | NUMERO | MTO TOTAL IGV | 
                        MTO TOTAL DEL COMPROBANTE | FECHA DE EMISION |TIPO DE DOCUMENTO ADQUIRENTE |
                        NUMERO DE DOCUMENTO ADQUIRENTE |*/

                $ruc = $row_empresa['ruc'];
                $tipo_documento = $_POST['tip_cpe']; //factura
                $serie = $_POST['serie'];
                $correlativo = $_POST['numero'];
                $igv = $_POST['igv'];
                $total = $_POST['total'];
                $fecha = $_POST['fecha_emision'];
                $tipodoccliente = $row_cliente['tipo_doc'];
                $nro_doc_cliente = $row_cliente['num_doc'];

                $nombrexml = $ruc."-".$tipo_documento."-".$serie."-".$correlativo;
                $text_qr = $ruc." | ".$tipo_documento." | ".$serie." | ".$correlativo." | ".$igv." | ".$total." | ".$fecha." | ".$tipodoccliente." | ".$nro_doc_cliente;
                $ruta_qr = '../../sunat/qr/'.$nombrexml.'.png';

                QRcode::png($text_qr, $ruta_qr, 'Q',15, 0);

                echo json_encode($lastInsertId);
                exit;
              }
            }
               // si envio automatico es NO
            else
            {
                require_once("phpqrcode/qrlib.php");
                        //CREAR QR INICIO
                        //codigo qr
                        /*RUC | TIPO DE DOCUMENTO | SERIE | NUMERO | MTO TOTAL IGV | 
                        MTO TOTAL DEL COMPROBANTE | FECHA DE EMISION |TIPO DE DOCUMENTO ADQUIRENTE |
                        NUMERO DE DOCUMENTO ADQUIRENTE |*/

                $ruc = $row_empresa['ruc'];
                $tipo_documento = $_POST['tip_cpe']; //factura
                $serie = $_POST['serie'];
                $correlativo = $_POST['numero'];
                $igv = $_POST['igv'];
                $total = $_POST['total'];
                $fecha = $_POST['fecha_emision'];
                $tipodoccliente = $row_cliente['tipo_doc'];
                $nro_doc_cliente = $row_cliente['num_doc'];

                $nombrexml = $ruc."-".$tipo_documento."-".$serie."-".$correlativo;
                $text_qr = $ruc." | ".$tipo_documento." | ".$serie." | ".$correlativo." | ".$igv." | ".$total." | ".$fecha." | ".$tipodoccliente." | ".$nro_doc_cliente;
                $ruta_qr = '../../sunat/qr/'.$nombrexml.'.png';

                QRcode::png($text_qr, $ruta_qr, 'Q',15, 0);

                echo json_encode($lastInsertId);
                exit;
            }
}



// guardar nueva venta

if($_POST['action'] == 'sunat')
 {

                     $id_venta = $_POST['enviar_id'];            


                      //insert deuda por cobrar

                    require_once("../../sunat/api/xml.php");


                    $xml = new GeneradorXML();
                    //buscar ruc emisor
                            
                                $query_empresa = "SELECT * FROM tbl_empresas WHERE id_empresa = $_POST[empresa_id]";
                                $resultado_empresa = $connect->prepare($query_empresa);
                                $resultado_empresa->execute();
                                $row_empresa = $resultado_empresa->fetch(PDO::FETCH_ASSOC);


                                $query_cab = "SELECT * FROM vw_tbl_venta_cab WHERE id = $_POST[enviar_id]";
                                $resultado_cab = $connect->prepare($query_cab);
                                $resultado_cab->execute();
                                $row_cab = $resultado_cab->fetch(PDO::FETCH_ASSOC);


                    //RUC DEL EMISOR - TIPO DE COMPROBANTE - SERIE DEL DOCUMENTO - CORRELATIVO
                    //01-> FACTURA, 03-> BOLETA, 07-> NOTA DE CREDITO, 08-> NOTA DE DEBITO, 09->GUIA DE REMISION
                    $nombrexml = $row_empresa['ruc'].'-'.$row_cab['tipocomp'].'-'.$row_cab['serie'].'-'.$row_cab['correlativo'];

                    $ruta = "../../sunat/xml/".$nombrexml;
                    $emisor =   array(
                                'tipodoc'       => '6',
                                'ruc'           => $row_empresa['ruc'], 
                                'razon_social'  => $row_empresa['razon_social'], 
                                'nombre_comercial'  => ' ', 
                                'direccion'     => $row_empresa['direccion'], 
                                'pais'          => 'PE', 
                                'departamento'  => $row_empresa['departamento'],//LAMBAYEQUE 
                                'provincia'     => $row_empresa['provincia'],//CHICLAYO 
                                'distrito'      => $row_empresa['distrito'], //CHICLAYO
                                'ubigeo'        => $row_empresa['ubigeo'], //CHICLAYO
                                'usuario_sol'   => $row_empresa['usuario_sol'], //USUARIO SECUNDARIO EMISOR ELECTRONICO
                                'clave_sol'     => $row_empresa['clave_sol'], //CLAVE DE USUARIO SECUNDARIO EMISOR ELECTRONICO
                                'certificado'  => $row_empresa['certificado'],
                                'clave_certificado'  =>$row_empresa['clave_certificado']
                                );
                    //buscar datos cliente
                                $num_doc = $_POST['ruc_id'];
                                $query_cliente = "SELECT * FROM tbl_contribuyente WHERE num_doc = $num_doc ";
                                $resultado_cliente = $connect->prepare($query_cliente);
                                $resultado_cliente->execute();
                                $row_cliente = $resultado_cliente->fetch(PDO::FETCH_ASSOC);
                                  //********************CREAR CLAVE CLIENTE SI EN CASO NO TIENE*********************//

                  
                            $clave = $row_cliente['clave'];
                            $ruc_persona1 = $row_cliente['num_doc'];


                            if(empty($clave))
                            {
                                $query_ctr = $connect->prepare("UPDATE tbl_contribuyente SET clave = md5(?) WHERE num_doc = ?");
                                $resultado_ctr = $query_ctr->execute([$ruc_persona1,$ruc_persona1]);

                            }

                    $cliente = array(
                                'tipodoc'       => $row_cliente['tipo_doc'],//6->ruc, 1-> dni 
                                'ruc'           => $row_cliente['num_doc'], 
                                'razon_social'  => $row_cliente['nombre_persona'], 
                                'direccion'     => $row_cliente['direccion_persona'],
                                'pais'          => 'PE'
                                );  
                    $numero = $row_cab['total'];
                    include 'numeros.php';
                    $texto=convertir($numero);

                    $comprobante =  array(
                                'tipodoc'       => $row_cab['tipocomp'], //01->FACTURA, 03->BOLETA, 07->NC, 08->ND
                                'serie'         => $row_cab['serie'],
                                'correlativo'   => $row_cab['correlativo'],
                                'fecha_emision' => $row_cab['fecha_emision'],
                                'moneda'        => 'PEN', //PEN->SOLES; USD->DOLARES
                                'total_opgravadas'=> $row_cab['op_gravadas'], //OP. GRAVADAS
                                'total_opexoneradas'=>$row_cab['op_exoneradas'],
                                'total_opinafectas'=>$row_cab['op_inafectas'],
                                'igv'           => $row_cab['igv'],
                                'total'         => $row_cab['total'],
                                'total_texto'   => $texto
                            );

                    //********************DATOS DE COMPROBANTE - DETALLE*********************//

                    //echo 'el id ultimo es '.$lastInsertId;
                    $lista_cpe_det = $connect->prepare("SELECT * FROM vw_tbl_venta_det WHERE idventa=$_POST[enviar_id]");
                    
                    $lista_cpe_det->execute();
                    $row_cpe_det=$lista_cpe_det->fetchAll(PDO::FETCH_ASSOC);
                    //print_r($row_cpe_det);

                    $detalle = $row_cpe_det;
                        
                  // var_dump($detalle1);



                        $xml->CrearXMLFactura($ruta, $emisor, $cliente, $comprobante, $detalle);


                        require_once("../../sunat/api/ApiFacturacion.php");

                        $objApi = new ApiFacturacion();

                        $enviar_id=$_POST['enviar_id'];
                        $objApi->EnviarComprobanteElectronico($emisor,$nombrexml,$connect,$enviar_id);
                            
                        require_once("phpqrcode/qrlib.php");
                                //CREAR QR INICIO
                                //codigo qr
                                /*RUC | TIPO DE DOCUMENTO | SERIE | NUMERO | MTO TOTAL IGV | 
                                MTO TOTAL DEL COMPROBANTE | FECHA DE EMISION |TIPO DE DOCUMENTO ADQUIRENTE |
                                NUMERO DE DOCUMENTO ADQUIRENTE |*/

                        $ruc = $row_empresa['ruc'];
                        $tipo_documento = $row_cab['tipocomp']; //factura
                        $serie = $row_cab['serie'];
                        $correlativo = $row_cab['correlativo'];
                        $igv = $row_cab['igv'];
                        $total = $row_cab['total'];
                        $fecha = $row_cab['fecha_emision'];
                        $tipodoccliente = $row_cliente['tipo_doc'];
                        $nro_doc_cliente = $row_cliente['num_doc'];

                        $nombrexml = $ruc."-".$tipo_documento."-".$serie."-".$correlativo;
                        $text_qr = $ruc." | ".$tipo_documento." | ".$serie." | ".$correlativo." | ".$igv." | ".$total." | ".$fecha." | ".$tipodoccliente." | ".$nro_doc_cliente;
                        $ruta_qr = '../../sunat/qr/'.$nombrexml.'.png';

                        QRcode::png($text_qr, $ruta_qr, 'Q',15, 0);

                        echo json_encode($_POST['enviar_id']);
                        exit;
           
          
               
 }




 // guardar nueva venta

if($_POST['action'] == 'nota_venta')
 {
            $query=$connect->prepare("INSERT INTO tbl_venta_cab(idempresa,tipocomp,serie,correlativo,fecha_emision,fecha_vencimiento,condicion_venta,op_gravadas,op_exoneradas,op_inafectas,igv,total,codcliente,vendedor) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?);");
            $resultado=$query->execute([$_POST['empresa'],$_POST['tip_cpe'],$_POST['serie'],$_POST['numero'],$_POST['fecha_emision'],$_POST['fecha_vencimiento'],$_POST['condicion'],$_POST['op_g'],$_POST['op_e'],$_POST['op_i'],$_POST['igv'],$_POST['total'],$_POST['ruc_persona'], $_SESSION["id"]]);
                $lastInsertId = $connect->lastInsertId();
               //registro detalle compra


                    for($i = 0; $i< count($_POST['idarticulo']); $i++)
                    {
                              $item                  = $_POST['itemarticulo'][$i];
                              $idarticulo            = $_POST['idarticulo'][$i];
                              $nomarticulo           = $_POST['nomarticulo'][$i];
                              $cantidad              = $_POST['cantidad'][$i];
                              $precio_venta          = $_POST['precio_venta'][$i];
                              $afectacion            = $_POST['afectacion'][$i];
                              $tipo_precio           ='01';
                              $unidad                = 'NIU';

                                      if($afectacion == '10')
                                      {
                                        $valor_unitario = $precio_venta / 1.18;
                                      }
                                      else
                                      {
                                        $valor_unitario = $precio_venta;

                                      }
                                   $igv = $precio_venta - $valor_unitario;
                                  
                                  $insert_query_detalle =$connect->prepare("INSERT INTO tbl_venta_det(idventa,item,idproducto,cantidad,valor_unitario,precio_unitario,igv,porcentaje_igv,valor_total,importe_total) VALUES(?,?,?,?,?,?,?,?,?,?)");
                                  $resultado_detalle = $insert_query_detalle->execute([$lastInsertId,$item,$idarticulo,$cantidad,$valor_unitario,$precio_venta,$igv,18,($cantidad*$valor_unitario),($cantidad*$precio_venta)]);

                                      // actualizar serie + correlativo
                                      $update_query_serie = $connect->prepare("UPDATE tbl_series SET correlativo = correlativo + ? WHERE serie = ? and correlativo = ? and id_empresa = ?");
                                    $resultado_serie   = $update_query_serie->execute([1,$_POST['serie'],$_POST['numero'],$_POST['empresa']]);                                                            
                                   
                    }

            
                   
           
                    
                        $query_empresa = "SELECT * FROM tbl_empresas WHERE id_empresa = $_POST[empresa]";
                        $resultado_empresa = $connect->prepare($query_empresa);
                        $resultado_empresa->execute();
                        $row_empresa = $resultado_empresa->fetch(PDO::FETCH_ASSOC);


           
            $emisor =   array(
                        'tipodoc'       => '6',
                        'ruc'           => $row_empresa['ruc'], 
                        'razon_social'  => $row_empresa['razon_social'], 
                        'nombre_comercial'  => ' ', 
                        'direccion'     => $row_empresa['direccion'], 
                        'pais'          => 'PE', 
                        'departamento'  => $row_empresa['departamento'],//LAMBAYEQUE 
                        'provincia'     => $row_empresa['provincia'],//CHICLAYO 
                        'distrito'      => $row_empresa['distrito'], //CHICLAYO
                        'ubigeo'        => $row_empresa['ubigeo'], //CHICLAYO
                        'usuario_sol'   => $row_empresa['usuario_sol'], //USUARIO SECUNDARIO EMISOR ELECTRONICO
                        'clave_sol'     => $row_empresa['clave_sol'], //CLAVE DE USUARIO SECUNDARIO EMISOR ELECTRONICO
                        'certificado'  => $row_empresa['certificado'],
                        'clave_certificado'  =>$row_empresa['clave_certificado']
                        );
            //buscar datos cliente
                    
                        $query_cliente = "SELECT * FROM tbl_contribuyente WHERE num_doc = $_POST[ruc_persona]";
                        $resultado_cliente = $connect->prepare($query_cliente);
                        $resultado_cliente->execute();
                        $row_cliente = $resultado_cliente->fetch(PDO::FETCH_ASSOC);
                          //********************CREAR CLAVE CLIENTE SI EN CASO NO TIENE*********************//

          
                    $clave = $row_cliente['clave'];
                    $ruc_persona1 = $row_cliente['num_doc'];


                    if(empty($clave))
                    {
                        $query_ctr = $connect->prepare("UPDATE tbl_contribuyente SET clave = md5(?) WHERE num_doc = ?");
                        $resultado_ctr = $query_ctr->execute([$ruc_persona1,$ruc_persona1]);

                    }

            $cliente = array(
                        'tipodoc'       => $row_cliente['tipo_doc'],//6->ruc, 1-> dni 
                        'ruc'           => $row_cliente['num_doc'], 
                        'razon_social'  => $row_cliente['nombre_persona'], 
                        'direccion'     => $row_cliente['direccion_persona'],
                        'pais'          => 'PE'
                        );  
            $numero = $_POST['total'];
            include 'numeros.php';
            $texto=convertir($numero);

            $comprobante =  array(
                        'tipodoc'       => $_POST['tip_cpe'], //01->FACTURA, 03->BOLETA, 07->NC, 08->ND
                        'serie'         => $_POST['serie'],
                        'correlativo'   => $_POST['numero'],
                        'fecha_emision' => $_POST['fecha_emision'],
                        'moneda'        => 'PEN', //PEN->SOLES; USD->DOLARES
                        'total_opgravadas'=> $_POST['op_g'], //OP. GRAVADAS
                        'total_opexoneradas'=>$_POST['op_e'],
                        'total_opinafectas'=>$_POST['op_i'],
                        'igv'           => $_POST['igv'],
                        'total'         => $_POST['total'],
                        'total_texto'   => $texto
                    );

            //********************DATOS DE COMPROBANTE - DETALLE*********************//

            //echo 'el id ultimo es '.$lastInsertId;
            $lista_cpe_det = $connect->prepare("SELECT * FROM vw_tbl_venta_det WHERE idventa=$lastInsertId");
            
            $lista_cpe_det->execute();
            $row_cpe_det=$lista_cpe_det->fetchAll(PDO::FETCH_ASSOC);
            //print_r($row_cpe_det);

            $detalle = $row_cpe_det;
                
          // var_dump($detalle1);



           

          
            require_once("phpqrcode/qrlib.php");
                        //CREAR QR INICIO
                        //codigo qr
                        /*RUC | TIPO DE DOCUMENTO | SERIE | NUMERO | MTO TOTAL IGV | 
                        MTO TOTAL DEL COMPROBANTE | FECHA DE EMISION |TIPO DE DOCUMENTO ADQUIRENTE |
                        NUMERO DE DOCUMENTO ADQUIRENTE |*/

                $ruc = $row_empresa['ruc'];
                $tipo_documento = $_POST['tip_cpe']; //factura
                $serie = $_POST['serie'];
                $correlativo = $_POST['numero'];
                $igv = $_POST['igv'];
                $total = $_POST['total'];
                $fecha = $_POST['fecha_emision'];
                $tipodoccliente = $row_cliente['tipo_doc'];
                $nro_doc_cliente = $row_cliente['num_doc'];

                $nombrexml = $ruc."-".$tipo_documento."-".$serie."-".$correlativo;
                $text_qr = $ruc." | ".$tipo_documento." | ".$serie." | ".$correlativo." | ".$igv." | ".$total." | ".$fecha." | ".$tipodoccliente." | ".$nro_doc_cliente;
                $ruta_qr = '../../sunat/qr/'.$nombrexml.'.png';

                QRcode::png($text_qr, $ruta_qr, 'Q',15, 0);

                echo json_encode($lastInsertId);
                exit;
        
 }



?>
