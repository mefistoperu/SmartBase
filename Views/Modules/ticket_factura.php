<?php 

session_start();

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



$query_cabecera = $connect->prepare("SELECT * FROM vw_tbl_venta_cab WHERE id='$factura'");
$query_cabecera->execute();
$row_cabecera=$query_cabecera->fetch(PDO::FETCH_ASSOC);

//DETALLE
$query_detalle = $connect->prepare("SELECT * FROM vw_tbl_venta_det WHERE idventa='$factura'");
$query_detalle->execute();
$resultado_detalle = $query_detalle->fetchAll(PDO::FETCH_OBJ);


/*$query_pago = $connect->prepare("SELECT * FROM tbl_venta_pag as p LEFT JOIN tbl_forma_pago AS f
ON p.fdp = f.id_fdp WHERE id_venta='$factura'");
$query_pago->execute();
$resultado_pago = $query_pago->fetchAll(PDO::FETCH_OBJ);*/
$numero = $row_cabecera['total'];
include 'Assets/ajax/numeros.php';
$texto=convertir($numero);

//pagos
$query_pago = $connect->prepare("SELECT * FROM tbl_venta_pago WHERE id_venta='$factura'");
$query_pago->execute();
$resultado_pago=$query_pago->fetchAll(PDO::FETCH_OBJ);

 //print_r($row_pago);exit();
 ?>


<html> 
   <head>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Roboto+Condensed:wght@300&display=swap" rel="stylesheet"> 

   <link rel="stylesheet" href="Assets/vendors/printjs/print.min.css">
   <script src="Assets/vendors/jquery/dist/jquery.js"></script>
   <script src="Assets/vendors/printjs/print.min.js"></script>

   <style>
.zona_impresion{
   position: absolute;
   box-sizing: border-box;
width: 82mm;
   -webkit-box-shadow: 7px 6px 21px -2px rgba(0,0,0,0.58);
-moz-box-shadow: 7px 6px 21px -2px rgba(0,0,0,0.58);
box-shadow: 7px 6px 21px -2px rgba(0,0,0,0.58);
}

   </style>
    
   </head> 
    
  <body onload="window.print();" style="font-family: 'Roboto Condensed', sans-serif;">   


   <div class="zona_impresion">
   <!--codigo imprimir-->
   <br>
   <table border="0"  align="center" width="300px" style="font-size: 12px">
<thead>
      <tr>
         <td align="center">
            <!--mostramos los datos de la empresa en el doc HTML-->
            .::<strong> <?php echo $row_empresa['razon_social']?></strong>::.<br>
            
         </td>
         
      </tr>
      <tr>
          <td colspan="5">===================================================</td>
        
      </tr>
      <tr>
          <td align="left">
            Direccion:<?php echo $row_empresa['direccion'] ; ?><br>
            Telefono :997 969 487<br>
            Fijo     : 42612814 <br>
            Correo :<?php echo $row_empresa['correo'] ; ?><br>
           
         </td>
      </tr>
<tr>
    <td colspan="5">===================================================</td>
</tr>
<tr>
   <td align="center"><?php echo $row_empresa['ruc'] ; ?></td>
</tr>

<tr>
    <td colspan="5">===================================================</td>
</tr>
<tr>
   <td align="center"><strong class="text-bold" style="font-size: 16px;"><?php
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
      echo $doc;
   ?></strong> <br>
   <?=$row_cabecera['serie'] .'-'. $row_cabecera['correlativo'] ?></td>
</tr>


<?php if($row_cabecera['tipocomp'] == '07' || $row_cabecera['tipocomp']=='08'){
   echo "
   <tr>
   <td colspan='5'>===================================================</td>
</tr>
   <tr>
   <td>Motivo: ". $row_cabecera['cod_motivo']." | ". $row_cabecera['des_motivo']."</td>
  
</tr>
<tr>
   <td>Documento: ". $row_cabecera['tipocomp_ref']."-".$row_cabecera['serie_ref']."-".$row_cabecera['correlativo_ref']."</td>
</tr>
";
} ?>


<tr>
   <td colspan="5">===================================================</td>
</tr>
      <tr> 
         <td align="center"></td>
      </tr>
            <tr>
         <td align="center">
            Fecha Emision : <?= $row_cabecera['fecha_emision'] ?> <br>
            Hora          : <?= date('H:i:s') ?> <br>
         </td>
      </tr>
 
<tr>
    <td colspan="5">===================================================</td>
</tr>
<tr>
   <td align="left">Cliente: <?=$row_cabecera['nombre_persona']  ?> <br></td>
</tr>
<tr>
   <td align="left">Nro Documento: <?=$row_cabecera['num_doc'] ?> <br></td>
</tr>
<tr>
   <td align="left">Direccion: <?=$row_cabecera['direccion_persona'] ?> <br></td>
</tr>
<tr>
   <td colspan="5">===================================================</td>
</tr>
</thead>
   </table>
   <table align="center" width="300px" style="font-size: 12px">
      <thead>
        <tr>           
            <th align="left" colspan="5">Descripcion</th>
         </tr>
         <tr>           
            <th align="left">Cantidad</th>
            <th align="center">UNI</th>
            <th align="center" >P.U.</th>
            <th align="center" >V.V.</th>
            <th align="right" >Total</th>
         </tr>
 <tr>
   <td colspan="5">===================================================</td>
   </tr>
      </thead>
   
      <tbody>
       <?php  foreach($resultado_detalle as $row_detalle)
{ ?>
  
   <tr>  
         <td align="left" colspan="4"><?= strtoupper($row_detalle->descripcion) ?></td>
   </tr>
   <tr>
         <td align="left" ><?= strtoupper($row_detalle->cantidad_factor).'/'.strtoupper($row_detalle->cantidad_unitario) ?></td>
         <td align="center" ><?= strtoupper($row_detalle->unidad).'/NIU' ?></td>
         <td align="center" ><?= number_format($row_detalle->valor_unitario,2) ?></td>
         <td align="center" ><?= number_format($row_detalle->precio_unitario,2) ?></td>
         <td align="right" ><?= number_format($row_detalle->valor_unitario*$row_detalle->cantidad,2) ?></td>
   </tr>    
 <?php } ?>
      </tbody>
   </table>
    <table border="0"  align="center" width="300px" style="font-size: 12px">
      <thead>
          <tr>
         <td colspan="5">===================================================</td>
         </tr>
          <tr>
             <td>Op. Gravada</td>
             <td align="right"><?= $row_cabecera['op_gravadas'] ?></td>
          </tr>
          <tr>
             <td>Op. Exonerada</td>
             <td align="right"><?= $row_cabecera['op_exoneradas'] ?></td>
          </tr>
          <tr>
             <td>Op. Inafecta</td>
             <td align="right"><?= $row_cabecera['op_inafectas'] ?></td>
          </tr>
          <tr>
             <td>I.G.V.</td>
             <td align="right"><?= $row_cabecera['igv'] ?></td>
          </tr>
          
 </thead>
    </table>
 <table border="0"  align="center" width="300px" style="font-size: 12px">
  <thead>
   <tr>
   <td colspan="4">===================================================</td>
   </tr>
   <tr>
      <td>
         SON : <?=$texto?>
      </td>
   </tr>
    <tr>
   <td colspan="4">===================================================</td>
   </tr>
   <tr>
      <td>
         Vendedor : <?=$_SESSION["nombre"]?>
      </td>
   </tr>

    <tr>
   <td colspan="4">===================================================</td>
   </tr>
    <tr>
       <td style="font-size: 14px; font-weight: bold;">TOTAL</td>
       <td align="right" style="font-size: 14px; font-weight: bold;"><?= $row_cabecera['total'] ?></td>
    </tr>
    <tr>
      <?php $fpago=0;
         foreach($resultado_pago as $row_pago){ ?>
         <td  style="font-size: 14px; font-weight: bold;"><?php 
         if($row_pago->fdp==1)
         { $f = 'EFECTIVO';  }
         else{$f = 'VISA'; } ?>
         <?=$f;?></td>
         <td align="right"  style="font-size: 14px; font-weight: bold;"> <?= $row_pago->importe_pago;?></td>
      <?php $fpago = $fpago + $row_pago->importe_pago;  } 
          
      ?>   
   </tr>
   <tr> 
      <td  style="font-size: 14px; font-weight: bold;">VUELTO : </td>
      <td align="right"  style="font-size: 14px; font-weight: bold;"><?= number_format(($row_cabecera['total'] - $fpago)*(-1),2) ?>
   </td> 
  </tr>
   <tr>
   <td colspan="4">===================================================</td>
   </tr>
    <tr>
      <td align="center">
         <img src="<?=base_url()?>/sunat/qr/<?= $row_empresa['ruc'].'-'.$row_cabecera['tipocomp'].'-'.$row_cabecera['serie'].'-'.$row_cabecera['correlativo'].'.png' ?>" alt="" width="60%">
      </td>
   </tr>

    <tr>
   <td colspan="4">===================================================</td>
</thead>

 </table>
 <table border="0"  align="center" width="300px" style="font-size: 12px">
    <tr>
       <td>
            <?php 

            if($row_cabecera['tipocomp']=='03')
            {
                    if($row_empresa['envio_resumen']=='SI')
                  {
                     $mensaje ='REPRESENTACION IMPRESA DE '. $doc;
                  } 
                  else if($row_empresa['envio_resumen']=='NO')
                  {
                     $mensaje = $doc .'  '.$row_cabecera['femensajesunat'];
                  }

            }
            else if($row_cabecera['tipocomp']=='99')
            {
                $mensaje = 'REPRESENTACION IMPRESA DE '.' '. $doc;

            }
            else if($row_cabecera['tipocomp']=='01' || $row_cabecera['tipocomp']=='07' || $row_cabecera['tipocomp']=='08')
            {
               if($row_empresa['envio_automatico']=='SI')
               {
                  $mensaje = $doc .'  '.$row_cabecera['femensajesunat'];
               }
               else
               {
                  $mensaje ='REPRESENTACION IMPRESA DE '.' '. $doc;
               }
            }

            ?>
                 <?=$mensaje?>
       </td>
    </tr>
    <tr>
          <td>Hash: <?=$row_cabecera['hash']?> </td>
    </tr>
 </table>
  <table border="0"  align="center" width="300px" style="font-size: 12px">
       <tr>
   <td colspan="4">===================================================</td>
   </tr>
    <tr>
      <td colspan="4" align="left"><?=nl2br($row_empresa['comentario']) ?></td>
   </tr>
       <tr>
   <td colspan="4" align="center">Gracias por su compra</td>

   </tr>
   <tr>
        <td colspan="4" align="center">Vuelva Pronto</td>
   </tr>
  
 </table>
    </div>
	</body>

   </html>