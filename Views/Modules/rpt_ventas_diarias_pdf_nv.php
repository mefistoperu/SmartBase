<?php 
session_start();
$fecha_ini = $rutas[1];
$fecha_fin = $rutas[2];
$usuario   = $rutas[3];

if($usuario=='1')
{
  $vendedor = 'ADMIN';
}

else if($usuario =='5')
{
  $vendedor = 'VENTAS';
}

else if($usuario =='0')
{
  $vendedor = 'MES';
}
//echo $usuario;exit;

if($usuario == '0')
{
  $query_fecha = $connect->query("SELECT fecha FROM vw_tbl_ventas_diarias WHERE  fecha BETWEEN '$fecha_ini' AND '$fecha_fin'  and tipocomp='99'  GROUP by  fecha");
}
else
{
  $query_fecha = $connect->query("SELECT fecha FROM vw_tbl_ventas_diarias WHERE vendedor='$usuario' AND fecha BETWEEN '$fecha_ini' AND '$fecha_fin'  and tipocomp='99'  GROUP by  fecha");
}

$resultado_fecha = $query_fecha->fetchAll(PDO::FETCH_OBJ);
//print_r($resultado_fecha);exit();die();


if($usuario == '0')
{
$query_totales = $connect->prepare("SELECT sum(if(tipocomp='07',-op_gravadas,op_gravadas)) as op_gravadas,
                            sum(if(tipocomp='07',-op_exoneradas,op_exoneradas)) as op_exoneradas,
                            sum(if(tipocomp='07',-op_inafectas,op_inafectas)) as op_inafectas,
                            sum(if(tipocomp='07',-igv,igv)) as igv,
                            sum(if(tipocomp='07',-total,total)) as total
                            FROM vw_tbl_ventas_diarias WHERE fecha BETWEEN '$fecha_ini' AND  '$fecha_fin'");
}
else
{
$query_totales = $connect->prepare("SELECT sum(if(tipocomp='07',-op_gravadas,op_gravadas)) as op_gravadas,
                            sum(if(tipocomp='07',-op_exoneradas,op_exoneradas)) as op_exoneradas,
                            sum(if(tipocomp='07',-op_inafectas,op_inafectas)) as op_inafectas,
                            sum(if(tipocomp='07',-igv,igv)) as igv,
                            sum(if(tipocomp='07',-total,total)) as total
                            FROM vw_tbl_ventas_diarias WHERE vendedor=$usuario AND fecha BETWEEN '$fecha_ini' AND  '$fecha_fin'");  
}


                            $query_totales->execute();
                            $row_t = $query_totales->fetch(PDO::FETCH_ASSOC);
                            //print_r($row_t);exit();die();
require_once 'Assets/dompdf/lib/html5lib/Parser.php';
require_once 'Assets/dompdf/lib/php-font-lib/src/FontLib/Autoloader.php';
require_once 'Assets/dompdf/lib/php-svg-lib/src/autoload.php';
require_once 'Assets/dompdf/src/Autoloader.php';
Dompdf\Autoloader::register();
use Dompdf\Dompdf;
use Dompdf\Options;

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

        table {
           border-collapse: collapse;
         }

         .table-bordered {
  border: 1px solid #fff;
}

.table-bordered th,
.table-bordered td {
  border: 1px solid #dee2e6;
  page-break-before:auto;
}

.table-bordered thead th,
.table-bordered thead td {
  border-bottom-width: 2px;
}

        .border
        {
          border: 1px solid #000;
          border-spacing: 0;
          
           padding: 0.3em;
        }

        .border1, th
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

        hr {
  box-sizing: content-box;
  height: 0;
  overflow: visible;
}

.bg-dark {
  background-color: #343a40 !important;
}   

  </style>
</head>
<body>

    <div class="container-fluid">
      
     
    
            <h2 class="text-center">REGISTRO DE NOTA DE VENTAS DIARIAS DEL '.$fecha_ini.' AL '.$fecha_fin.'</h2>
            <hr>
             <h2 class="text-center">DEL USUARIO '.$vendedor.'</h2>
             <table class="table table-bordered">
                      <thead>
                        <tr>                          
                          <th>Fecha</th>
                          <th>TD</th>
                          <th>Serie</th>
                          <th>Desde</th>
                          <th>Hasta</th>
                          <th>Op. Gravada</th>
                          <th>Op. Inafecta</th>
                          <th>Op. Exonerada</th>
                          <th>IGV</th>
                          <th>Total</th>
                          
                        </tr>
                      </thead>
                      <tbody>';
//echo $output;exit();
                        foreach($resultado_fecha as $fechat ){

                           $fecha_dia = $fechat->fecha;

                          if($usuario == '0')
                          {
                            $query_tdoc = $connect->query("SELECT * FROM vw_tbl_ventas_diarias WHERE  fecha ='$fecha_dia' and tipocomp='99'  ORDER BY tipocomp,serie");
                          }
                          else
                          {
                            $query_tdoc = $connect->query("SELECT * FROM vw_tbl_ventas_diarias WHERE vendedor=$usuario AND fecha ='$fecha_dia' and tipocomp='99'  ORDER BY tipocomp,serie");

                          }
                           
                           $resultado_tdoc = $query_tdoc->fetchAll(PDO::FETCH_OBJ);

                           foreach($resultado_tdoc as $tdata)
                           {

                            if($usuario == '0')
                            {
                              $query_totales_dia = $connect->prepare("SELECT sum(if(tipocomp='07',-op_gravadas,op_gravadas)) as op_gravadas,
                            sum(if(tipocomp='07',-op_exoneradas,op_exoneradas)) as op_exoneradas,
                            sum(if(tipocomp='07',-op_inafectas,op_inafectas)) as op_inafectas,
                            sum(if(tipocomp='07',-igv,igv)) as igv,
                            sum(if(tipocomp='07',-total,total)) as total
                            FROM vw_tbl_ventas_diarias WHERE  fecha = '$fecha_dia' and tipocomp='99'");

                            }
                            else
                            {
                              $query_totales_dia = $connect->prepare("SELECT sum(if(tipocomp='07',-op_gravadas,op_gravadas)) as op_gravadas,
                            sum(if(tipocomp='07',-op_exoneradas,op_exoneradas)) as op_exoneradas,
                            sum(if(tipocomp='07',-op_inafectas,op_inafectas)) as op_inafectas,
                            sum(if(tipocomp='07',-igv,igv)) as igv,
                            sum(if(tipocomp='07',-total,total)) as total
                            FROM vw_tbl_ventas_diarias WHERE vendedor=$usuario AND fecha = '$fecha_dia' and tipocomp='99'");

                            }

                        
                            $query_totales_dia->execute();
                            $row_td = $query_totales_dia->fetch(PDO::FETCH_ASSOC);

                                            if($tdata->tipocomp=='07')
                                            {
                                              $op_gravadas = -($tdata->op_gravadas);
                                              $op_exoneradas = -($tdata->op_exoneradas);
                                              $op_inafectas = -($tdata->op_inafectas);
                                              $igv = -($tdata->igv);
                                              $total = -($tdata->total);
                                            }
                                            else
                                            {
                                              $op_gravadas = ($tdata->op_gravadas);
                                              $op_exoneradas = ($tdata->op_exoneradas);
                                              $op_inafectas = ($tdata->op_inafectas);
                                              $igv = ($tdata->igv);
                                              $total = ($tdata->total);
                                            }
                          
                                    //echo $output; exit();             
                                   $output.='
                                   <tr>
                                            <td>'.$tdata->fecha.'</td>                        
                                            <td>'.$tdata->tipocomp.'</td>
                                            <td>'.$tdata->serie.'</td>
                                            <td>'.$tdata->desde.'</td>
                                            <td>'.$tdata->hasta.'</td>
                                            <td class="text-right">'.number_format($op_gravadas,2).'</td>
                                            <td class="text-right">'.number_format($op_exoneradas,2).'</td>
                                            <td class="text-right">'.number_format($op_inafectas,2).'</td>
                                            <td class="text-right">'.number_format($igv,2).'</td>
                                            <td class="text-right">'.number_format($total,2).'</td>
                                          </tr>';
                           } 

                           $output .='
                            <tr class="bg-dark" style="color: white">
                            <td>Total</td>                        
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td class="text-right">'.$row_td[op_gravadas].'</td>
                            <td class="text-right">'.$row_td[op_exoneradas].'</td>
                            <td class="text-right">'.$row_td[op_inafectas].'</td>
                            <td class="text-right">'.$row_td[igv].'</td>
                            <td class="text-right">'.$row_td[total].'</td>
                          </tr>
                           ';
                        }


                        $output.='
                      </tbody>
                      <tfoot>
                         <tr class="bg-dark" style="color: white">
                            <td>Total General</td>                        
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td class="text-right">'.$row_t[op_gravadas].'</td>
                            <td class="text-right">'.$row_t[op_exoneradas].'</td>
                            <td class="text-right">'.$row_t[op_inafectas].'</td>
                            <td class="text-right">'.$row_t[igv].'</td>
                            <td class="text-right">'.$row_t[total].'</td>
                          </tr>
                      </tfoot>
                      
              </table>        
   
    </div>
  </body>

</html>';

//echo $output; exit();
$invoiceFileName = 'VENTAS DEL '.$fecha_ini.' AL '.$fecha_fin.'.pdf';
$dompdf = new DOMPDF();
$dompdf->set_paper('A4','portrait');//$dompdf->set_paper("A4", "landscape"/portrait); //esta es otra forma de ponerlo horizontal
$dompdf->load_html($output);
$dompdf->render();
$pdf = $dompdf->output();
$dompdf->stream($invoiceFileName, array("Attachment" => true));
//file_put_contents($rutaGuardado.$invoiceFileName, $pdf);
