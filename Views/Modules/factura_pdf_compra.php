<?php
session_start();
ob_start();
//date_default_timezone_set("America/Lima");

require_once 'Assets/dompdf/lib/html5lib/Parser.php';
require_once 'Assets/dompdf/lib/php-font-lib/src/FontLib/Autoloader.php';
require_once 'Assets/dompdf/lib/php-svg-lib/src/autoload.php';
require_once 'Assets/dompdf/src/Autoloader.php';
Dompdf\Autoloader::register();
use Dompdf\Dompdf;
use Dompdf\Options;


$factura=$rutas[1];
$empresa = $_SESSION['id_empresa'];

$query_empresa = $connect->prepare("SELECT * FROM tbl_empresas WHERE id_empresa = $empresa");
$query_empresa->execute();
$row_empresa=$query_empresa->fetch(PDO::FETCH_ASSOC);



$query_cabecera = $connect->prepare("SELECT * FROM tbl_compra_cab as c
LEFT JOIN tbl_contribuyente as p
ON c.codcliente = p.num_doc WHERE id=$factura");
$query_cabecera->execute();
$row_cabecera=$query_cabecera->fetch(PDO::FETCH_ASSOC);

//DETALLE
$query_detalle = $connect->query("SELECT * FROM vw_tbl_compra_det WHERE idventa=$factura ORDER BY item");
$resultado_detalle = $query_detalle->fetchAll(PDO::FETCH_OBJ);

//var_dump($resultado_detalle);exit();
//$resultado_detalle = $query_detalle->fetchAll(PDO::FETCH_OBJ);

 if($row_cabecera['tipocomp']=='01')
      {
         $doc = 'FACTURA ELECTRONICA';
      }
      else if($row_cabecera['tipocomp']=='03')
      {
         $doc = 'BOLETA DE VENTA ELECTRONICA';
      }
      else if($row_cabecera['tipocomp']=='07')
      {
         $doc = 'NOTA DE CREDITO ELECTRONICA';
      }
      else if($row_cabecera['tipocomp']=='08')
      {
         $doc = 'NOTA DE DEBITO ELECTRONICA';
      }
      else if($row_cabecera['tipocomp']=='99')
      {
         $doc = 'NOTA DE VENTA ELECTRONICA';
      }
  if($row_cabecera['condicion_venta']=='1')
  {
    $condicion = 'CONTADO';
  }
  else
  {
    $condicion = 'CREDITO';
  }

 if($row_cabecera['codmoneda']=='PEN')
  {
    $mon = 'SOLES';
}
else
{
  $mon='DOLARES';
} 


/*$query_pago = $connect->prepare("SELECT * FROM tbl_venta_pag as p LEFT JOIN tbl_forma_pago AS f
ON p.fdp = f.id_fdp WHERE id_venta='$factura'");
$query_pago->execute();
$resultado_pago = $query_pago->fetchAll(PDO::FETCH_OBJ);*/
$numero = $row_cabecera['total'];
include 'Assets/ajax/numeros.php';
$texto=convertir($numero);
//file_put_contents($rutaGuardado.$fileName, $fileData);

$invoiceFileName = $row_empresa['ruc'].'-'.$row_cabecera['tipocomp'].'-'.$row_cabecera['serie'].'-'.$row_cabecera['correlativo'].'.pdf';
$rutaGuardado = 'sunat/pdf/';


$output='';

$output.='
<html>
<head>

  
  <style>
       body
        {
          background: white;
          font-size: 12px;
          font-family: tahoma;
        }
        table
        {
          width: 100%;
          
        }
        .border
        {
          border: 1px solid #000;
          border-spacing: 0;
          border-radius: 50%;
           padding: 0.3em;
        }

        .border1
        {
          border-bottom: 1px solid #000;
           padding: 0.3em;
          border-spacing: 0;
        }
         .border2
        {
          border-top: 1px solid #000;
          border-spacing: 0;
           padding: 0.3em;
        }
         .border3
        {
          border-left: 1px solid #000;
           padding: 0.3em;
          border-spacing: 0;
        }

        .text-center 
        {
          text-align: center !important;
        }     
        .text-left 
        {
          text-align: left !important;
        }

        .text-right
        {
          text-align: right !important;
        }  

      



  </style>
</head>
<body>

    <div class="container-fluid">
      <table>
        <thead>
          <tr>
            <th width="30%"><img src="'.base_url().'/Assets/images/'.$row_empresa[logo].'" alt="" width="200px"></th>
            <th>
              <table border="0">
                <thead border="0">
                  <tr border="0">
                    <th border="0">'.$row_empresa[razon_social].'</th>
                  </tr>
                  <tr>
                    <th>'.$row_empresa[direccion].'</th>
                  </tr>
                  <tr>
                    <th>correo</th>
                  </tr>
                </thead>
              </table>
            </th>
            <th width="20%">
              <table class="border">
                <thead>
                  <tr>
                    <th class="text-center border1">'.$row_empresa[ruc].'</th>
                  </tr>
                  <tr>
                    <th class="text-center">'.$doc.'</th>
                  </tr>
                  <tr>
                    <th class="text-center border2">'.$row_cabecera[serie].'-'.$row_cabecera[correlativo].'</th>
                  </tr>
                </thead>
              </table>
            </th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td colspan="3">
              <table class="border">
                <thead>
                  <tr>
                    <th width="15%" class="border1">Cliente</th>
                    <th class="text-left border1 border3">'.$row_cabecera[nombre_persona].'</th>
                  </tr>
                  <tr>
                    <th width="15%" class="">RUC</th>
                     <th class="text-left border3">'.$row_cabecera[num_doc].'</th>
                  </tr>
                  <tr>
                    <th width="15%" class="border2">Direccion</th>
                     <th class="text-left border2 border3">'.$row_cabecera[direccion_persona].'</th>
                  </tr>
                </thead>
              </table>
            </td>
          </tr>
          <tr>
            <td colspan="3">
              <table class="table table-bordered border">
                <thead>
                  <tr>
                    <th class="border1 text-center" width="20%">FECHA EMISION</th>
                    <th class="border1 text-center border3" width="20%">FECHA DE VENCIMIENTO</th>
                    <th class="border1 text-center border3" width="20%">CONDICION DE VENTA</th>
                    <th class="border1 text-center border3" width="20%">ORDEN DE COMPRA</th>
                    <th class="border1 text-center border3" width="20%">MONEDA</th>
                  </tr>
                </thead>
                <tbody>
                  <tr>
                    <td class="text-center">'.$row_cabecera[fecha_emision].'</td>
                    <td class="text-center border3">'.$row_cabecera[fecha_vencimiento].'</td>
                    <td class="text-center border3">'.$condicion.'</td>
                    <td class="text-center border3"></td>
                    <td class="text-center border3">'.$mon.'</td>
                  </tr>
                </tbody>
              </table>
            </td>
          </tr>
          <tr>
            <td colspan="3">
              <table class="border">
                <thead>
                  <tr>
                    <th width="5%" class="border1 text-center">Item</th>
                    <th class="border1 text-left border3">Descripcion</th>
                    <th width="5%" class="border1 text-center border3">U.M.</th>
                    <th width="8%" class="border1 text-center border3">Cantidad</th>
                    <th width="8%"  class="border1 text-center border3">P.U.</th>
                    <th width="8%"  class="border1 text-center border3">V.V.</th>
                    <th width="8%"  class="border1 text-center border3">Total</th>
                  </tr>
                </thead>
                <tbody>';
                  foreach ($resultado_detalle as $detalle) {
                  
                  $output.='
                     <tr>
                       <th class="">'.$detalle->item.'</th>
                       <th class="text-left border3">'.$detalle->descripcion.'</th>
                       <th class="text-center border3">'.$detalle->unidad.'</th>
                       <th class="text-right border3">'.$detalle->cantidad.'</th>
                       <th class="text-right border3">'.$detalle->valor_unitario.'</th>
                       <th class="text-right border3">'.$detalle->precio_unitario.'</th>
                       <th  class="text-right border3">'.$detalle->importe_total.'</th>
                     </tr>';
                  } 

          $output.='
                </tbody>
              </table>
            </td>
          </tr>
          <tr>
            <td colspan="3">
              <table width="100%">
                <tr>
                  <th width="50%">
                    <table width="100%">
                      <thead>
                        <tr>
                          <td>SON: '.$texto.'</td>
                        </tr>
                        <tr>
                          <td>
                            La '.$doc .'  '.$row_cabecera[femensajesunat].'
                          </td>
                        </tr>
                        <tr>
                          <td>Hash: '.$row_cabecera[hash].' </td>
                        </tr>
                      </thead>
                    </table>
                  </th>
                  <th width="20%">
                    <table width="100%">
                      <tr>
                        <td><img src="'.base_url().'/sunat/qr/'.$row_empresa[ruc].'-'.$row_cabecera[tipocomp].'-'.$row_cabecera[serie].'-'.$row_cabecera[correlativo].'.png" alt="" width="150px"></td>
                      </tr>
                    </table>
                  </th>
                  <th width="30%">
                    <table class="border">
                      <tr>
                        <th class="text-right">Op. Gravadas</th>
                        <th class="text-right border3">'.$row_cabecera[op_gravadas].'</th>
                      </tr>
                      <tr>
                        <th class="border2 text-right">Op. Exonerdas</th>
                        <th class="border2 border3 text-right">'.$row_cabecera[op_exoneradas].'</th>
                      </tr>
                      <tr>
                        <th class="border2 text-right">Op. Inafectas</th>
                        <th class="border2 border3 text-right">'.$row_cabecera[op_inafectas].'</th>
                      </tr>
                      <tr>
                        <th class="border2 text-right">I.G.V.</th>
                        <th class="border2 border3 text-right">'.$row_cabecera[igv].'</th>
                      </tr>
                      <tr>
                        <th class="border2 text-right">Total</th>
                        <th class="border2 border3 text-right">'.$row_cabecera[total].'</th>
                      </tr>
                    </table>
                  </th>
                </tr>
                
                
              </table>
            </td>
          </tr>
        </tbody>
        
      </table>
    </div>
  </body>

</html>';

//echo $output; exit();

$dompdf = new DOMPDF();
$dompdf->set_paper('A4','portrait');
$dompdf->load_html($output);
$dompdf->render();
$pdf = $dompdf->output();
$dompdf->stream($invoiceFileName, array("Attachment" => true));
file_put_contents($rutaGuardado.$invoiceFileName, $pdf);



 ?>


