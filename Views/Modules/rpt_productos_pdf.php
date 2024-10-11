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

$color_bg = '#073385';
$color_tx = '#ffffff';

$fecha_ini=$rutas[1];
$fecha_fin=$rutas[2];
$empresa = $_SESSION['id_empresa'];
$almacen = $_SESSION["almacen"];

$query_empresa = $connect->prepare("SELECT * FROM vw_tbl_empresas WHERE id_empresa = $empresa");
$query_empresa->execute();
$row_empresa=$query_empresa->fetch(PDO::FETCH_ASSOC);

$query_suc = $connect->prepare("SELECT * FROM tbl_almacen WHERE id = $almacen");
$query_suc->execute();
$row_suc=$query_suc->fetch(PDO::FETCH_ASSOC);

$query_pro = "SELECT categoria as categoria, empresa from vw_tbl_venta_producto WHERE fecha BETWEEN '$fecha_ini' AND '$fecha_fin' AND empresa = $empresa AND local = $almacen AND cantidad IS NOT NULL GROUP BY categoria,empresa";
//echo $query_pro; exit();
$resultado_pro = $connect->prepare($query_pro); 
$resultado_pro->execute();



$invoiceFileName = 'Reporte de ventas por producto';


$output='';

$output.='
<html>
<head>
  <link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100..900;1,100..900&display=swap" rel="stylesheet">
  
  <style>
      
        table
        {
          width: 100%;
          
        }
        th,tr{
          padding:0.5em;
        }
        tr
        {
            background-color = '.$color_bg.';
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
@page {
margin: 100px 25px;
}
body {
margin-top: 2cm;
margin-left: 1cm;
margin-right: 1cm;
margin-bottom: 1cm;
font-size : 14px
}

header {
position: fixed;
top: -60px;
left: 1cm;
right: 0px;
height: 90px;

/** Extra personal styles **/
background-color: white;
color: black;
text-align: left;
line-height: 35px;
}
      footer {
position: fixed;
bottom: 0cm;
left: 0cm;
right: 0cm;
height: 2cm;


}



  </style>

</head>
<body>
<header>'.
$row_empresa["razon_social"].'<br />'.
$row_empresa["ruc"].'<br />'.
$row_suc['nombre'].'<br />'.
'<h4 class="text-center">Reporte de venta por Producto del '.$fecha_ini.' al '.$fecha_fin.'</h4>'.
'</header>
    <div class="container-fluid">
      <table>
       
        <tbody>';

          $output.='
          <tr>
            <td colspan="3">
              <table class="border">
                 <thead>
                          <tr>
                             <th class="border1">Cod. Prod.</th>
                            <th class="border1 border3">Nom. Producto</th>
                            <th class="border1 border3">categoria</th>
                            <th class="border1 border3">Uni.</th>
                            <th class="border1 border3">Cantidad</th>
                            <th class="border1 border3">Total</th>
                          </tr>
                      </thead>
                <tbody>';
                  /*foreach*/
                  $totalfin = 0;
                  foreach($resultado_pro as $pro)
                        {
                           $categoria = $pro['categoria'];
                          $query_data = "SELECT producto,nombre,categoria,unidad,sum(cantidad) as cantidad,sum(total) as total FROM vw_tbl_venta_producto WHERE fecha BETWEEN '$fecha_ini' AND '$fecha_fin' AND empresa = $empresa AND local = $almacen AND categoria = '$categoria' GROUP BY producto,nombre,categoria,unidad  ORDER BY nombre,fecha,categoria ";
                          //echo $query_data;
                          $resultado_data=$connect->prepare($query_data);
                          $resultado_data->execute();
                          $num_reg_data=$resultado_data->rowCount();
                          $output.='<tr>
                          <td colspan="6" class="border1">'.$categoria.'</td>
                          </tr>';
                           $totalcat = 0;
                           foreach($resultado_data as $data) 
                              {
                            
                              $output .='<tr>
                                <td class="border1">'.$data['producto'].'</td>
                                <td class="border1 border3">'.$data['nombre'].'</td>
                                <td class="border1 border3">'.$data['categoria'].'</td>
                                <td class="border1 border3">'.$data['unidad'].'</td>
                                <td class="border1 border3">'.$data['cantidad'].'</td>
                                <td class="border1 border3">'.$data['total'].'</td>
                                
                              </tr>';
                              $totalcat = $totalcat + $data['total'];
                         } 
                            $output.='<tr>
          <td class="border1" colspan="5">Total '.$categoria.'</td>
          <td class="border3 border1">'.$totalcat.'</td>
          </tr>';
                      $totalfin = $totalfin + $totalcat;  } 
                        
                      

          $output.='<tr>
          <td class="border1" colspan="5">Total GENERAL </td>
          <td class="border3 border1">'.$totalfin.'</td>
          </tr>
                </tbody>
              </table>
            </td>
          </tr>
         
          
        </tbody>
        
      </table>';
      

    $output .='</div>
    
    
<footer>
Powered by SmartBase 
</footer>
  </body>

</html>';

//echo $output; exit();

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


