<?php 

require_once("../../Config/Config.php");
require_once("../../Helpers/Helpers.php"); 
require_once("../../Libraries/Conexion.php"); 
session_start();
//listar detalle de nota de credito

if($_POST['action'] == 'listarDetalle')
{
       $idventa = $_POST['id'];
       $connect->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        
        $sql="SELECT * FROM vw_tbl_venta_det WHERE idventa like '$idventa'";
        $resultado=$connect->prepare($sql);
        $resultado->execute();
        $num_reg=$resultado->rowCount();
        $detalletabla = '';
        foreach($resultado as $serie )
        {
            $cont =1;
            $descripcion = $serie['descripcion'];
            $codigo      = $serie['codigo'];
            $descripcion = $serie['descripcion'];
            $cantidad    = $serie['cantidad'];
            $precio_unitario = $serie['precio_unitario'];
            $importe_total   = $serie['importe_total'];
            $codigo_afectacion_alt = $serie['codigo_afectacion_alt'];

            $detalletabla .='<tr id="fila'.$cont.'">
             <td><button type="button" class="btn btn-danger" onclick="eliminar('.$cont.')" disabled><i class="fa fa-trash"></i></button></td>
             <td>'.$cont.'</td>
            <td><input type="hidden" name="itemarticulo[]" value="'.$cont.'"><input type="hidden" name="idarticulo[]" value="'.$codigo.'"><input type="hidden" name="nomarticulo[]" value="'.$descripcion.'">'.$descripcion.'</td>
            <td><input type="text" min="1" class="form-control text-right" name="cantidad[]" id="cantidad[]" value="'.$cantidad.'" onkeyup="modificarSubtotales()" readonly></td>
            <td><input type="text" min="1" class="form-control text-right" name="precio_venta[]" id="precio_venta[]" value="'.$precio_unitario.'" onkeyup="modificarSubtotales()"  readonly></td>
            <td><span id="subtotal'.$cont.'" name="subtotal">'.$importe_total.'</span><input type="hidden" id="afectacion'.$cont.'" name="afectacion[]" class="form-control" value="'.$codigo_afectacion_alt.'"></td>
            </tr>';
             $cont++;
        }

        $arrayData['detalle'] = $detalletabla;

        echo json_encode($arrayData,JSON_UNESCAPED_UNICODE);


        exit();
}





//buscar persona

if($_POST['action'] == 'buscarPersona')
{
        if(!empty($_POST['cliente']))
    {
        $ndd=$_POST['cliente'];
        $connect->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        
        $sql="SELECT * FROM tbl_contribuyente WHERE num_doc like '$ndd'";
        $resultado=$connect->prepare($sql);
        $resultado->execute();
        $num_reg=$resultado->rowCount();
         $data='';

         if($num_reg>0)
         {
             $data=$resultado->fetch(PDO::FETCH_ASSOC);
         }


         else
         {
            $data =0;
         }

         echo json_encode($data,JSON_UNESCAPED_UNICODE);

    }
    exit;
}

//crear cliente
//####################################CREAR CLIENTE####################################////

if($_POST['action'] == 'addCliente')
{
    
    $dni         = $_POST['dni'];
    $tipo_doc    = $_POST['tipo_doc'];
    $razon       = $_POST['razon'];
    $direccion   = $_POST['direccion'];
    $distrito    = $_POST['distrito']; 
    $provincia   = $_POST['provincia']; 
    $departamento   = $_POST['departamento']; 
    $correo   = $_POST['correo'];
    $empresa  = $_POST['empresa'];

        $query_select = "SELECT * FROM tbl_contribuyente WHERE num_doc = '$dni' AND empresa = $empresa";
        $resultado_select=$connect->prepare($query_select);
        $resultado_select->execute();
        $num_reg_select=$resultado_select->rowCount();
        
        if($num_reg_select >= 1)
        {
          $msg = 'existe';
          echo $msg;
          exit;
        }

        else
        {
            $query=$connect->prepare("INSERT INTO tbl_contribuyente(nombre_persona,direccion_persona,distrito,provincia,departamento,tipo_doc,num_doc,correo,empresa) VALUES (?,?,?,?,?,?,?,?,?);");
            $resultado=$query->execute([$razon,$direccion,$distrito,$provincia,$departamento,$tipo_doc,$dni,$correo,$empresa]);

        $sql="SELECT * FROM tbl_contribuyente WHERE num_doc like '$dni'";
        $resultado=$connect->prepare($sql);
        $resultado->execute();
        $num_reg=$resultado->rowCount();
        $data=$resultado->fetch(PDO::FETCH_ASSOC);
        }
    


    if($resultado)
    {
        $msg='ok';
    }
    else
    {
        $msg='error1';
    }
     echo json_encode($data,JSON_UNESCAPED_UNICODE);


    exit;
}


        ////////////buscar series
        if($_POST['action'] == 'searchSerie')
        {
          $doc=$_POST['cliente'];
          $user = $_POST['usuario'];
          $emp = $_POST['empresa'];

                $query_articulos = "SELECT * FROM vw_tbl_serie_usuario WHERE cod_doc ='$doc' AND usuario='$user' AND empresa = $emp";
                $resultado = $connect->prepare($query_articulos);
                $resultado->execute();
                $row_articulo = $resultado->fetch(PDO::FETCH_ASSOC);

                echo json_encode($row_articulo);
                exit;
        }



// guardar nueva venta

if($_POST['action'] == 'nueva_venta')
 {
            $query=$connect->prepare("INSERT INTO tbl_venta_cab(idempresa,tipocomp,serie,correlativo,fecha_emision,fecha_vencimiento,condicion_venta,op_gravadas,op_exoneradas,op_inafectas,igv,total,codcliente) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?);");
            $resultado=$query->execute([$_POST['empresa'],$_POST['tip_cpe'],$_POST['serie'],$_POST['numero'],$_POST['fecha_emision'],$_POST['fecha_vencimiento'],$_POST['condicion'],$_POST['op_g'],$_POST['op_e'],$_POST['op_i'],$_POST['igv'],$_POST['total'],$_POST['ruc_persona']]);
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
                               
                                
                                   //buscar insumos de tabla recetas
                                    
                                        $query_articulos = "SELECT * FROM tbl_recetas WHERE id_producto = '$idarticulo'";
                                        $resultado_articulos = $connect->prepare($query_articulos);
                                        $resultado_articulos->execute();
                                        $row_articulos = $resultado_articulos->fetch(PDO::FETCH_ASSOC);

                                        //actualizar stock insumos

                                                $query_insumo = $connect->prepare("UPDATE tbl_insumos SET stock = stock - ?  WHERE id = ?");
                                                $resultado_insumo = $query_insumo->execute([$cantidad,$row_articulos['id_insumo']]);
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
                        'clave_sol'     => $row_empresa['clave_sol'] //CLAVE DE USUARIO SECUNDARIO EMISOR ELECTRONICO
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

            $objApi->EnviarComprobanteElectronico($emisor,$nombrexml);
            
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

                echo json_encode($lastInsertId,JSON_UNESCAPED_UNICODE);




        exit;
    }


?>
