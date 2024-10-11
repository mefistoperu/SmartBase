<?php
session_start();
ob_start();
//date_default_timezone_set("America/Lima");

require_once 'assets/dompdf/lib/html5lib/Parser.php';
require_once 'assets/dompdf/lib/php-font-lib/src/FontLib/Autoloader.php';
require_once 'assets/dompdf/lib/php-svg-lib/src/autoload.php';
require_once 'assets/dompdf/src/Autoloader.php';
Dompdf\Autoloader::register();
use Dompdf\Dompdf;
use Dompdf\Options;


$factura=$rutas[1];
$empresa = $_SESSION['id_empresa'];

$query_empresa = $connect->prepare("SELECT * FROM tbl_empresas WHERE id_empresa = $empresa");
$query_empresa->execute();
$row_empresa=$query_empresa->fetch(PDO::FETCH_ASSOC);



$query_cabecera = $connect->prepare("SELECT * FROM vw_tbl_venta_cab as c
LEFT JOIN tbl_contribuyente as p
ON c.codcliente = p.num_doc WHERE id=$factura");
$query_cabecera->execute();
$row_cabecera=$query_cabecera->fetch(PDO::FETCH_ASSOC);

//DETALLE
$query_detalle = $connect->query("SELECT * FROM vw_tbl_venta_det WHERE idventa=$factura ORDER BY item");
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
          font-size: 14px;
          font-family: tahoma;
        }
        table
        {
          width: 100%;
          
        }
        th,tr{
          padding:0.5em;
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
            <th><img src="'.base_url().'/assets/images/'.$row_empresa[logo].'" alt="" width="200px"></th>
          </tr>
          <tr>
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
          </tr>
          <tr>
            <th>
              <table class="border2">
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
            <td>
              <table class="border2">
                <thead>
                  <tr>
                    <th width="15%">Cliente</th>
                    <th class="text-left">'.$row_cabecera[nombre_persona].'</th>
                  </tr>
                  <tr>
                    <th width="15%" class="">RUC</th>
                     <th class="text-left">'.$row_cabecera[num_doc].'</th>
                  </tr>
                  <tr>
                    <th width="15%" class="">Direccion</th>
                     <th class="text-left">'.$row_cabecera[direccion_persona].'</th>
                  </tr>
                </thead>
              </table>
            </td>
          </tr>';

          if($row_cabecera['tipocomp']=='07'|| $row_cabecera['tipocomp']=='08')
          {
            $output.='<tr>
            <td>
              <table class="border">
                <thead>
                  <tr>
                    <th width="15%" class="border1">Motivo</th>
                    <th class="text-left border1 border3">'.$row_cabecera[cod_motivo].' | '.$row_cabecera[des_motivo].'</th>
                  </tr>
                  <tr>
                    <th width="15%" class="">Tipo Doc Ref</th>
                     <th class="text-left border3">'.$row_cabecera[nom_cod_motivo].'</th>
                  </tr>
                  <tr>
                    <th width="15%" class="border2">Numero Ref</th>
                     <th class="text-left border2 border3">'.$row_cabecera[serie_ref].'-'.$row_cabecera[correlativo_ref].'</th>
                  </tr>
                </thead>
              </table>
            </td>
          </tr>';

          }

          $output.='<tr>
            <td>
              <table class="border2">
                <thead>
                  <tr>
                    <th class="text-right" width="50%">FECHA EMISION: </th>
                    <td class="text-left">'.$row_cabecera[fecha_emision].'</td>
                  </tr>
                  <tr>
                    <th class="text-right" width="50%">FECHA DE VENCIMIENTO :</th>
                    <td class="text-left">'.$row_cabecera[fecha_vencimiento].'</td>
                  </tr>
                  <tr>
                    <th class="text-right" width="50%">CONDICION DE VENTA :</th>
                    <td class="text-left">'.$condicion.'</td>
                  </tr>
                 
                  <tr>
                    <th class="text-right" width="50%">MONEDA :</th>
                     <td class="text-left">'.$mon.'</td>
                  </tr>
                </thead>
               
                
              </table>
            </td>
          </tr>
          <tr>
            <td>
              <table class="border2" >
                <thead>
                  <tr>
                  <th class="text-left" colspan="4">Descripcion</th>
                  </tr>
                  <tr>
                     <th width="8%" class="border1 text-center">Cantidad</th>
                    
                    <th width="5%" class="border1 text-center">U.M.</th>
                   
                    <th width="8%"  class="border1 text-center">P.U.</th>
                 
                    <th width="8%"  class="border1 text-center">Total</th>
                  </tr>
                </thead>
                <tbody>';
                  foreach ($resultado_detalle as $detalle) {
                  
                  $output.='
                     <tr>
                     <th class="text-left" colspan="4">'.$detalle->descripcion.'</th>
                     </tr>
                     <tr>
                       <th class="text-right">'.$detalle->cantidad_factor.'/'.$detalle->cantidad_unitario.'</th>
                       
                       <th class="text-center">'.$detalle->unidad.'</th>
                      
                       <th class="text-right">'.number_format($detalle->valor_unitario,2).'</th>
                     
                       <th  class="text-right">'.number_format($detalle->importe_total,2).'</th>
                     </tr>';
                  } 

          $output.='
                </tbody>
              </table>
            </td>
          </tr>
          <tr>
            <td>
             <table class="border2">
                      <tr>
                        <th class="text-right">Op. Gravadas</th>
                        <th class="text-right">'.number_format($row_cabecera[op_gravadas],2).'</th>
                      </tr>
                      <tr>
                        <th class="text-right">Op. Exonerdas</th>
                        <th class="text-right">'.number_format($row_cabecera[op_exoneradas],2).'</th>
                      </tr>
                      <tr>
                        <th class="text-right">Op. Inafectas</th>
                        <th class="text-right">'.number_format($row_cabecera[op_inafectas],2).'</th>
                      </tr>
                      <tr>
                        <th class="text-right">I.G.V.</th>
                        <th class="text-right">'.number_format($row_cabecera[igv],2).'</th>
                      </tr>
                      <tr>
                        <th class="text-right">Total</th>
                        <th class="text-right">'.number_format($row_cabecera[total],2).'</th>
                      </tr>
                    </table>
             
              <table width="100%" class="border2">
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
               <table width="100%" class="border2">
                      <tr align="center">
                        <td><img src="'.base_url().'/sunat/'.$row_empresa[ruc].'/qr/'.$row_empresa[ruc].'-'.$row_cabecera[tipocomp].'-'.$row_cabecera[serie].'-'.$row_cabecera[correlativo].'.png" alt="" width="150px"></td>
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
//$dompdf->setPaper('b7', 'portrait');
$dompdf->load_html($output);
$dompdf->render();
$pdf = $dompdf->output();

$dompdf->stream($invoiceFileName, array("Attachment" => true));
file_put_contents($rutaGuardado.$invoiceFileName, $pdf);



 ?>


