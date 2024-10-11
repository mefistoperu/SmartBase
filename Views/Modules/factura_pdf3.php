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


//CUOTAS
$query_cuota = $connect->query("SELECT * FROM tbl_venta_cuota WHERE id_venta=$factura LIMIT 1 ");
$resultado_cuota = $query_cuota->fetchAll(PDO::FETCH_OBJ);

$query_cuota1 = $connect->query("SELECT * FROM tbl_venta_cuota WHERE id_venta=$factura ORDER BY fecha_cuota");
$resultado_cuota1 = $query_cuota1->fetchAll(PDO::FETCH_OBJ);
 $pendiente_pag = 0;
 foreach ($resultado_cuota1 as $cuota1) {
     $pendiente_pag = $cuota1->importe_cuota + $pendiente_pag;
 }
 $pendiente_pag = $row_cabecera['total'] -$row_cabecera['imp_det'];
 //exit();
 
/*var_dump($resultado_cuota1);
exit();
*/
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
    $simbolo = 'S/.';
    $demon = 'SOLES';
}
else
{
  $mon='DOLARES';
  $simbolo = '$.';
  $demon = 'DOLARES';
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



if($row_cabecera['tipocomp']=='01'|| $row_cabecera['tipocomp']=='03')
{
$tbody = '62%';/*55*/
}
else if($row_cabecera['tipocomp']=='07'|| $row_cabecera['tipocomp']=='08')
{
  $tbody = '50%';/*55*/  
}
$output='';

$output.='
<html>
<head>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Lato:ital,wght@0,100;0,300;0,400;0,700;0,900;1,100;1,300;1,400;1,700;1,900&family=Rubik:ital,wght@0,300..900;1,300..900&display=swap" rel="stylesheet">

  <style>
       body
        {
          top: -300px;
          background: white;
          font-size: 15px;
         font-family: "Roboto", sans-serif;
          font-optical-sizing: auto;
          font-weight: <weight>;
          font-style: normal;
          line-height: 15px;
        }
        table
        {
          width: 100%;
          
        }
        th,tr{
          padding:0.3em;
        }
        .border
        {
          border: 2px solid #000;
          border-spacing: 0;
          border-radius: 2px;
           padding: 0.2em;
        }

        .border1
        {
          border-bottom: 1px solid #000;
           padding: 0.2em;
          border-spacing: 0;
        }
         .border2
        {
          border-top: 1px solid #000;
          border-spacing: 0;
           padding: 0.2em;
        }
         .border3
        {
          border-left: 1px solid #000;
           padding: 0.2em;
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
        
@page {
margin: 280px 30px;
}


header {
position: fixed;
top: -200px;
left: 0px;
right: 0px;
height: 10px;

/** Extra personal styles **/


color: black;
text-align: center;
line-height: 20px;
}


      footer {
position: fixed;
bottom: 200px;
left: 0px;
right: 0px;
height: 50px;

/** Extra personal styles **/

text-align: center;
line-height: 20px;
}



  </style>
</head>
<body>
<header>
<table>
<thead>
<tr>
 <th width="30%"><img src="'.base_url().'/assets/images/'.$row_empresa['logo'].'" alt="" width="300px"></th>
<th>
              <table border="0">
                <thead border="0">
                  <tr border="0">
                    <th border="0" class="text-center" ><strong style="font-size=30px;">'.$row_empresa['razon_social'].'</strong></th>
                  </tr>
                  <tr>
                    <th class="text-center">'.$row_empresa['direccion'].'</th>
                  </tr>
                  <tr>
                    <th class="text-center">Telefono: 914681522/945075467/981755775</th>
                  </tr>
                  <tr>
                    <th class="text-center">E-mail: htplogistica@hotmail.com</th>
                  </tr>
                </thead>
              </table>
</th>
<th width="30%">
  <table class="border">
    <thead>
      <tr>
        <th class="text-center border1">'.$row_empresa['ruc'].'</th>
      </tr>
      <tr>
        <th class="text-center border2" style="background-color:#ccc;font-weight:900;font-size:20px; font-style:normal;font-optical-sizing: auto;">'.$doc.'</th>
      </tr>
      <tr>
        <th class="text-center border2"  >'.$row_cabecera['serie'].'-'.$row_cabecera['correlativo'].'</th>
      </tr>
    </thead>
  </table>
</th>
</tr>
</thead>
</table>
</header>
<main>
<p style="page-break-after: never;">
    <div class="container-fluid" >
    
    
      <table>
     



        <tbody>
          <tr>
            <td colspan="3">
              <table class="">
                <thead>
                  <tr>
                    <th width="15%" class="text-left" >CLIENTE</th>
                    <th width="50%" class="text-left ">'.$row_cabecera['nombre_persona'].'</th>
                    <th width="20%" class=" text-left">FECHA VENCIMIENTO</th>
                    <th width="15%" class="text-left">'.$row_cabecera['fecha_vencimiento'].'</th>
                  </tr>
                  <tr>
                    <th width="15%" class="text-left" >RUC</th>
                     <th width="50%" class="text-left">'.$row_cabecera['num_doc'].'</th>
                     <th width="20%" class=" text-left">GUIA REMISION</th>
                    <th width="15%" class="text-left ">'.$row_cabecera['guia_remision'].'</th>
                  </tr>
                  <tr>
                    <th width="15%" class="text-left">DIRECCION</th>
                     <th class="text-left " colspan="3">'.$row_cabecera['direccion_persona'].'</th>
                     
                  </tr>
                  <tr>
                    <th width="15%" class="text-left">FECHA EMISION</th>
                     <th class="text-left " width="50%">'.$row_cabecera['fecha_emision'].'</th>
                     <th width="20%" class=" text-left">MONTO PENDIENTE DE PAGO</th>
                    <th width="15%" class="text-left ">'.$pendiente_pag.'</th>
                  </tr>
                  <tr>
                    <th width="15%" class=" text-left">MONEDA</th>
                     <th class="text-left " colspan="3">'.$mon.'</th>
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
            <td colspan="3" >
            





<table class="border" >
<tr >
<td valign="top" height="'.$tbody.'" >
            
              <table class="" >
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
                     </tr>
                     <tr><th></th><th class="text-left border3"></th></tr>
                     <tr><th></th><th class="text-left border3">'.$detalle->descripcion2.'</th></tr>';
                  } 

          $output.='
                </tbody>
               
              </table>
              
     </td>
          </tr>         
    </table>          
              
              
            </td>
          </tr>
                </tbody>
         </table>
     </div>
</p>
</main>
<footer>

        
     

    
<table>
<tbody>
<tr>
<td>
<table width="100%">
<thead>
<tr>
<td>SON: '.$texto.$demon.'</td>
</tr>
<tr>
<td>OBSERVACIONES</td>
</tr>
<tr>
<td>PLACA</td>
<td align="left">'.$row_cabecera['obs'].'</td>
</tr>

<tr>
<td>CONDUCTOR</td>
<td></td>
</tr>


</thead>
</table>
</td>
<td>
<table class="border">
<tr>
<th class="text-right">SUB TOTAL '. $simbolo.'</th>
<th class="text-right border3">'.number_format(($row_cabecera['op_gravadas']+$row_cabecera['op_exoneradas']+$row_cabecera['op_inafectas']),2).'</th>
</tr>


<tr>
<th class="border2 text-right">I.G.V. '. $simbolo.'</th>
<th class="border2 border3 text-right">'.number_format($row_cabecera['igv'],2).'</th>
</tr>
<tr>
<th class="border2 text-right">Total '. $simbolo.'</th>
<th class="border2 border3 text-right">'.number_format($row_cabecera['total'],2).'</th>
</tr>
</table>
</td>
</tr>
</tbody>
</table>


<p></p>';


    $output.='<strong>OPERACIONES SUJETAS AL S.P.O.T. T.D.L.940 CTA CTE BANCO DE LA NACION N° 00-072-100972</strong>';



$output .='<table class="border">
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
<p></p>

<table class="border">
<thead>
<tr>
<th width="5%" class="text-center" ><img src="'.base_url().'/sunat/'.$row_empresa['ruc'].'/qr/'.$row_empresa['ruc'].'-'.$row_cabecera['tipocomp'].'-'.$row_cabecera['serie'].'-'.$row_cabecera['correlativo'].'.png" alt="" width="150px">
</th>

<th width="" class="text-left border3">


OBSERVACIONES SUNAT <br />
'.$row_cabecera['femensajesunat'].' | Hash: '.$row_cabecera['hash'].'<br />

Para consultar su documento inrgese a https://cpe.smartbase.club/<br />

REPRESENTACION IMPRESA DE  '.$doc .'<br />


</th>
<th width="" class="text-center border3">';

if($row_cabecera['condicion_venta'] == '2')
{
$output.='<table class="border">
<thead>
<tr>
<th class="">CUOTA</th>
<th class="border3">MONTO</th>
<th class="border3">FECHA VENC.</th>
</tr>
</thead>';
 foreach ($resultado_cuota as $cuota) {
$output.='<tbody>
<tr>
<td class="border2">'.$cuota->num_cuota.'</td>
<td class="border3 border2">'.$cuota->importe_cuota.'</td>
<td class="border3 border2">'.$cuota->fecha_cuota.'</td>
</tr>
</tbody>';
}
$output.='</table>';
}

$output.='</th>
</tr>
</thead>
</table>

Powered by SmartBase<br />
</footer>
  </body>

</html>';

/*echo $output; exit();*/


$dompdf = new DOMPDF();
$dompdf->set_paper('A4','portrait');
$dompdf->load_html($output);
$dompdf->render();
$font = $dompdf->getFontMetrics()->getFont("Arial", "bold");
$pdf = $dompdf->output();
header('Content-Type: application/pdf');
header("Content-Disposition: inline; filename=".$invoiceFileName.".pdf");
echo $pdf;
//$dompdf->stream($invoiceFileName, array("Attachment" => true));
//file_put_contents($rutaGuardado.$invoiceFileName, $pdf);

 ?>


