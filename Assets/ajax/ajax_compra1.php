<?php 

require_once("../../config/config.php");
require_once("../../helpers/helpers.php"); 
require_once("../../libraries/conexion.php"); 
require_once("../../sunat/api/xml.php");
require_once("../../sunat/api/ApiFacturacion.php");
session_start();




// guardar nueva compra

if($_POST['action'] == 'nueva_venta')
 {
     
     $localemp = $_POST['alm'];
            $query=$connect->prepare("INSERT INTO tbl_compra_cab(idempresa,tipocomp,serie,correlativo,fecha_emision,fecha_vencimiento,condicion_venta,op_gravadas,op_exoneradas,op_inafectas,igv,total,codcliente,vendedor,detraccion,imp_detraccion,saldo_ft,idalmacen,idcliente) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);");
            $resultado=$query->execute([$_POST['empresa'],$_POST['tip_cpe'],$_POST['serie'],$_POST['numero'],$_POST['fecha_emision'],$_POST['fecha_vencimiento'],$_POST['condicion'],$_POST['op_g'],$_POST['op_e'],$_POST['op_i'],$_POST['igv'],$_POST['total'],$_POST['ruc_persona'], $_SESSION["id"],$_POST['det'],$_POST['imp_det'],$_POST['saldo_ft'],$localemp,$_POST['id_ruc']]);
                $lastInsertId = $connect->lastInsertId();
               //registro detalle compra


                    for($i = 0; $i< count($_POST['idarticulo']); $i++)
                    {
                              $item                  = $_POST['itemarticulo'][$i];
                              $idarticulo            = $_POST['idarticulo'][$i];
                              $nomarticulo           = $_POST['nomarticulo'][$i];
                              $cantidad              = $_POST['cantidad'][$i];
                              $precio_venta          = $_POST['precio_venta'][$i];

                              $por1                  = $_POST['por1'][$i];
                              $precio1               = $_POST['precio1'][$i];
                              $por2                  = $_POST['por2'][$i];
                              $precio2               = $_POST['precio2'][$i];


                              $afectacion            = $_POST['afectacion'][$i];
                              $tipo_precio           ='01';
                              $unidad                = 'NIU';

                              $fecven                = $_POST['fecven'][$i];

                             
                                      if($afectacion == '10')
                                      {
                                        $valor_unitario = $precio_venta / 1.18;
                                      }
                                      else
                                      {
                                        $valor_unitario = $precio_venta;

                                      }
                                   $igv = $precio_venta - $valor_unitario;
                                  
                                  $insert_query_detalle =$connect->prepare("INSERT INTO tbl_compra_det(idventa,item,idproducto,cantidad,valor_unitario,precio_unitario,igv,porcentaje_igv,valor_total,importe_total,vencimiento) VALUES(?,?,?,?,?,?,?,?,?,?,?)");
                                  $resultado_detalle = $insert_query_detalle->execute([$lastInsertId,$item,$idarticulo,$cantidad,$valor_unitario,$precio_venta,$igv,18,($cantidad*$valor_unitario),($cantidad*$precio_venta),$fecven]);

                                                                    
                                 //ACTUALIZAR COSTO, PORCENTAJE MAYORISTA, PORCENTAJE MINORISTA, PRECIO MAYORISTA Y PRECIO MINORISTA

                                        $query_insumo_costo = $connect->prepare("UPDATE tbl_productos SET costo= ?,por1=?,precio_venta=?,por2=?,precio2=? WHERE id=?");
                                        $resultado_insumo_costo = $query_insumo_costo->execute([$precio_venta,$por1,$precio1,$por2,$precio2,$idarticulo]);

                                //ACTUALIZA STOCK

                                        $query_stock  = $connect->prepare("UPDATE tbl_productos SET stock = stock + ? WHERE id=?");
                                        $resultado_stock = $query_stock->execute([$cantidad,$idarticulo]);

                                        

                                                
                    }

                      //insert deuda por pagar


                    if($_POST['tip_cpe']=='01' || $_POST['tip_cpe']=='03')
                                        {
                                            $insert_ctemov =$connect->prepare("INSERT INTO tbl_cta_pagar(tipo,persona,tipo_doc,ser_doc,num_doc,monto,fecha,empresa) VALUES(?,?,?,?,?,?,?,?)");
                          $resultado_detalle = $insert_ctemov->execute(['1',$_POST['ruc_persona'],$_POST['tip_cpe'],$_POST['serie'],$_POST['numero'],$_POST['total'],$_POST['fecha_emision'],$_POST['empresa']]);
                                        }
                                        else if($_POST['tip_cpe']=='07')
                                        {
                                           $insert_ctemov =$connect->prepare("INSERT INTO tbl_cta_pagar(tipo,persona,tipo_doc,ser_doc,num_doc,monto,fecha,empresa) VALUES(?,?,?,?,?,?,?,?)");
                          $resultado_detalle = $insert_ctemov->execute(['2',$_POST['ruc_persona'],$_POST['tip_cpe'],$_POST['serie'],$_POST['numero'],$_POST['total'],$_POST['fecha_emision'],$_POST['empresa']]);
                                        }


                    
        

          
            
            echo json_encode($lastInsertId);
                exit;
}



// guardar nueva venta

if($_POST['action'] == 'nueva_nota_credito_compra')
 {
            $query=$connect->prepare("INSERT INTO tbl_compra_cab(idempresa,tipocomp,serie,correlativo,fecha_emision,fecha_vencimiento,condicion_venta,op_gravadas,op_exoneradas,op_inafectas,igv,total,codcliente,vendedor,tipocomp_ref,serie_ref,correlativo_ref) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);");
            $resultado=$query->execute([$_POST['empresa'],$_POST['tip_cpe'],$_POST['serie'],$_POST['numero'],$_POST['fecha_emision'],$_POST['fecha_vencimiento'],$_POST['condicion'],$_POST['op_g'],$_POST['op_e'],$_POST['op_i'],$_POST['igv'],$_POST['total'],$_POST['ruc_persona'], $_SESSION["id"],$_POST['tdocref'],$_POST['sdocref'],$_POST['ndocref']]);
                $lastInsertId = $connect->lastInsertId();
               //registro detalle compra


                    for($i = 0; $i< count($_POST['idarticulo']); $i++)
                    {
                              $item                  = $_POST['itemarticulo'][$i];
                              $idarticulo            = $_POST['idarticulo'][$i];
                              $nomarticulo           = $_POST['nomarticulo'][$i];
                              $cantidad              = $_POST['cantidad'][$i];
                              $precio_venta          = $_POST['precio_venta'][$i];

                              $por1                  = $_POST['por1'][$i];
                              $precio1               = $_POST['precio1'][$i];
                              $por2                  = $_POST['por2'][$i];
                              $precio2               = $_POST['precio2'][$i];


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
                                  
                                  $insert_query_detalle =$connect->prepare("INSERT INTO tbl_compra_det(idventa,item,idproducto,cantidad,valor_unitario,precio_unitario,igv,porcentaje_igv,valor_total,importe_total) VALUES(?,?,?,?,?,?,?,?,?,?)");
                                  $resultado_detalle = $insert_query_detalle->execute([$lastInsertId,$item,$idarticulo,$cantidad,$valor_unitario,$precio_venta,$igv,18,($cantidad*$valor_unitario),($cantidad*$precio_venta)]);

                                                                    
                                 //ACTUALIZAR COSTO, PORCENTAJE MAYORISTA, PORCENTAJE MINORISTA, PRECIO MAYORISTA Y PRECIO MINORISTA

                                        $query_insumo_costo = $connect->prepare("UPDATE tbl_productos SET costo= ?,por1=?,precio_venta=?,por2=?,precio2=? WHERE id=?");
                                        $resultado_insumo_costo = $query_insumo_costo->execute([$precio_venta,$por1,$precio1,$por2,$precio2,$idarticulo]);

                                //ACTUALIZA STOCK

                                        $query_stock  = $connect->prepare("UPDATE tbl_productos SET stock = stock - ? WHERE id=?");
                                        $resultado_stock = $query_stock->execute([$cantidad,$idarticulo]);

                                        

                                                
                    }

                      //insert deuda por pagar


                    if($_POST['tip_cpe']=='01' || $_POST['tip_cpe']=='03')
                                        {
                                            $insert_ctemov =$connect->prepare("INSERT INTO tbl_cta_pagar(tipo,persona,tipo_doc,ser_doc,num_doc,monto,fecha,empresa) VALUES(?,?,?,?,?,?,?,?)");
                          $resultado_detalle = $insert_ctemov->execute(['1',$_POST['ruc_persona'],$_POST['tip_cpe'],$_POST['serie'],$_POST['numero'],$_POST['total'],$_POST['fecha_emision'],$_POST['empresa']]);
                                        }
                                        else if($_POST['tip_cpe']=='07')
                                        {
                                           $insert_ctemov =$connect->prepare("INSERT INTO tbl_cta_pagar(tipo,persona,tipo_doc,ser_doc,num_doc,monto,fecha,empresa) VALUES(?,?,?,?,?,?,?,?)");
                          $resultado_detalle = $insert_ctemov->execute(['2',$_POST['ruc_persona'],$_POST['tip_cpe'],$_POST['serie'],$_POST['numero'],$_POST['total'],$_POST['fecha_emision'],$_POST['empresa']]);
                                        }


                    
        

          
            
            echo json_encode($lastInsertId);
                exit;
}

?>
