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
include 'assets/ajax/numeros.php';
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
          border-radius: 2px;
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

      footer {
position: fixed;
bottom: -60px;
left: 0px;
right: 0px;
height: 50px;

/** Extra personal styles **/

text-align: center;
line-height: 35px;
}



  </style>
</head>
<body>

    <div class="container-fluid">
      <table>
        <thead>
          <tr>
            <th width="30%"><img src="'.base_url().'/assets/images/'.$row_empresa['logo'].'" alt="" width="200px"></th>
            <th>
              <table border="0">
                <thead border="0">
                  <tr border="0">
                    <th border="0">'.$row_empresa['razon_social'].'</th>
                  </tr>
                  <tr>
                    <th>'.$row_empresa['direccion'].'</th>
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
                    <th class="text-center border1">'.$row_empresa['ruc'].'</th>
                  </tr>
                  <tr>
                    <th class="text-center" style="background-color:#ccc">'.$doc.'</th>
                  </tr>
                  <tr>
                    <th class="text-center border2"  >'.$row_cabecera['serie'].'-'.$row_cabecera['correlativo'].'</th>
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
                    <th width="15%" class="border1 text-right" >CLIENTE</th>
                    <th width="45%" class="text-left border1 border3">'.$row_cabecera['nombre_persona'].'</th>
                    <th width="15%" class="border1 text-right">FECHA VENCIMIENTO</th>
                    <th width="35%" class="text-left border1 border3">'.$row_cabecera['fecha_vencimiento'].'</th>
                  </tr>
                  <tr>
                    <th width="15%" class="text-right" >RUC</th>
                     <th width="45%" class="text-left border3">'.$row_cabecera['num_doc'].'</th>
                     <th width="15%" class=" text-right">GUIA REMISION</th>
                    <th width="35%" class="text-left  border3"></th>
                  </tr>
                  <tr>
                    <th width="15%" class="border2 text-right">DIRECCION</th>
                     <th class="text-left border2 border3" colspan="3">'.$row_cabecera['direccion_persona'].'</th>
                  </tr>
                  <tr>
                    <th width="15%" class="border2 text-right">FECHA EMISION</th>
                     <th class="text-left border2 border3" colspan="3">'.$row_cabecera['fecha_emision'].'</th>
                  </tr>
                  <tr>
                    <th width="15%" class="border2 text-right">MONEDA</th>
                     <th class="text-left border2 border3" colspan="3">'.$mon.'</th>
                  </tr>
                </thead>
              </table>
            </td>
          </tr>';

          if($row_cabecera['tipocomp']=='07'|| $row_cabecera['tipocomp']=='08')
          {
            $output.='<tr>
            <td colspan="3">
              <table class="border">
                <thead>
                  <tr>
                    <th width="15%" class="border1">Motivo</th>
                    <th class="text-left border1 border3">'.$row_cabecera['cod_motivo'].' | '.$row_cabecera['des_motivo'].'</th>
                  </tr>
                  <tr>
                    <th width="15%" class="">Tipo Doc Ref</th>
                     <th class="text-left border3">'.$row_cabecera['nom_cod_motivo'].'</th>
                  </tr>
                  <tr>
                    <th width="15%" class="border2">Numero Ref</th>
                     <th class="text-left border2 border3">'.$row_cabecera['serie_ref'].'-'.$row_cabecera['correlativo_ref'].'</th>
                  </tr>
                </thead>
              </table>
            </td>
          </tr>';

          }

          $output.='
          <tr>
            <td colspan="3">
              <table class="border">
                <thead>
                  <tr style="background-color:#ccc">
                  <th width="8%" class="border1 text-center ">Codigo</th>
                     
                    <th class="border1 text-left border3">Descripcion</th>
                    <th width="5%" class="border1 text-center border3">U.M.</th>
                   <th width="8%" class="border1 text-center border3">Cantidad</th>
                    <th width="8%"  class="border1 text-center border3">Precio Unitario</th>
                 
                    <th width="8%"  class="border1 text-center border3">Valor Total</th>
                  </tr>
                </thead>
                <tbody style="height:100vh;">';
                  foreach ($resultado_detalle as $detalle) {
                  
                  $output.='
                     <tr>
                      <th></th>
                       
                       <th class="text-left border3">'.$detalle->descripcion.'</th>
                       <th class="text-center border3">'.$detalle->unidad.'</th>
                      <th class="text-right border3">'.$detalle->cantidad_factor.'/'.$detalle->cantidad_unitario.'</th>
                       <th class="text-right border3">'.number_format($detalle->valor_unitario,2).'</th>
                     
                       <th  class="text-right border3">'.number_format($detalle->importe_total,2).'</th>
                     </tr>';
                  } 

          $output.='
                </tbody>
                <tfoot>
                 <tr>
                   <th colspan="2" class="border2">
                    <table width="100%">
                      <thead>
                        <tr>
                          <td>SON: '.$texto.'</td>
                        </tr>
                        
                      </thead>
                    </table>
                   </th>
                    <th colspan="4" class="border3 border2">
                            <table class="border">
                          <tr>
                            <th class="text-right">Sub Total</th>
                            <th class="text-right border3">'.number_format(($row_cabecera['op_gravadas']+$row_cabecera['op_exoneradas']+$row_cabecera['op_inafectas']),2).'</th>
                          </tr>
                          
                          
                          <tr>
                            <th class="border2 text-right">I.G.V.</th>
                            <th class="border2 border3 text-right">'.number_format($row_cabecera['igv'],2).'</th>
                          </tr>
                          <tr>
                            <th class="border2 text-right">Total</th>
                            <th class="border2 border3 text-right">'.number_format($row_cabecera['total'],2).'</th>
                          </tr>
                        </table>
                    </th>
                 </tr>
                </tfood>
              </table>
            </td>
          </tr>
          <tr>
            <td colspan="3">
              <table width="100%">
               
                
<tr>
<td colspan="3">
<table class="border">
<thead>
<tr  style="background-color:#ccc">
<th class="border1 text-center">BANCO</th>
<th class="border3 border1 text-center">MONEDA</th>
<th class="border3 border1 text-center">CUENTA</th>
<th class="border3 border1 text-center">CCI</th>
</tr>
</thead>
<tbody>
<tr>
<td class=" border1 text-center">BANCO DE CREDITO</td>
<td class="border3 border1 text-center">SOLES</td>
<td class="border3 border1 text-center">191-2205119-0-28</td>
<td class="border3 border1 text-center">00219100220511902852</td>
</tr>
<tr>
<td class=" text-center">BANCO DE CREDITO</td>
<td class="border3 text-center">DOLARES</td>
<td class="border3 text-center">191-2233414-1-46</td>
<td class="border3 text-center">00219100223341414656</td>
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
<th width="5%" class="text-center" ><img src="'.base_url().'/sunat/'.$row_empresa['ruc'].'/qr/'.$row_empresa['ruc'].'-'.$row_cabecera['tipocomp'].'-'.$row_cabecera['serie'].'-'.$row_cabecera['correlativo'].'.png" alt="" width="150px">
</th>
<th width="" class="text-left border3">


OBSERVACIONES SUNAT <br />
'.$row_cabecera['femensajesunat'].'<br />



Hash: '.$row_cabecera['hash'].'<br />

Para consultar su documento inrgese a https://cpe.smartbase.club/<br />

REPRESENTACION IMPRESA DE  '.$doc .'<br />


</th>

</tr>





</thead>
</table>
</td>
</tr>

                
              </table>

            </td>
          </tr>
          <tr>
          
          </tr>
        </tbody>
        
      </table>
    </div>
    
<footer>
Powered by SmartBase<br />
</footer>
  </body>

</html>';

/*echo $output; exit();*/



$dompdf = new DOMPDF();
$dompdf->set_paper('A4','portrait');
$dompdf->load_html($output);
$dompdf->render();
$pdf = $dompdf->output();
$dompdf->stream($invoiceFileName, array("Attachment" => true));
file_put_contents($rutaGuardado.$invoiceFileName, $pdf);

 ?>


