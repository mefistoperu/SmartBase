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



$query_cabecera = $connect->prepare("SELECT * FROM vw_tbl_compra_cab WHERE id='$factura'");
$query_cabecera->execute();
$row_cabecera=$query_cabecera->fetch(PDO::FETCH_ASSOC);

//DETALLE
$query_detalle = $connect->prepare("SELECT * FROM vw_tbl_compra_det WHERE idventa='$factura'");
$query_detalle->execute();
$resultado_detalle = $query_detalle->fetchAll(PDO::FETCH_OBJ);


/*$query_pago = $connect->prepare("SELECT * FROM tbl_venta_pag as p LEFT JOIN tbl_forma_pago AS f
ON p.fdp = f.id_fdp WHERE id_venta='$factura'");
$query_pago->execute();
$resultado_pago = $query_pago->fetchAll(PDO::FETCH_OBJ);*/
$numero = $row_cabecera['total'];
include 'Assets/ajax/numeros.php';
$texto=convertir($numero);


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
width: 100%;
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
            .::<strong>"DOCUMENTO INTERNO DE COMPRA"</strong>::.<br>
            
         </td>
         
      </tr>
      <tr>
          <td colspan="4">===================================================</td>
        
      </tr>
      <tr>
          <td align="left">
            Direccion:<?php echo $row_empresa['direccion'] ; ?><br>
            Telefono :<br>
            Correo :<?php echo $row_empresa['correo'] ; ?><br>
           
         </td>
      </tr>
<tr>
    <td colspan="4">===================================================</td>
</tr>
<tr>
   <td align="center"><?php echo $row_empresa['ruc'] ; ?></td>
</tr>

<tr>
    <td colspan="4">===================================================</td>
</tr>
<tr>
   <td align="center"><strong><?php
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
   <td colspan='4'>===================================================</td>
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
   <td colspan="4">===================================================</td>
</tr>
      <tr> 
         <td align="center"></td>
      </tr>
            <tr>
         <td align="center">
            Fecha Emision : <?= $row_cabecera['fecha_emision'] ?> <br>
            Hora          :  <br>
         </td>
      </tr>
 
<tr>
    <td colspan="4">===================================================</td>
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
   <td colspan="4">===================================================</td>
</tr>
</thead>
   </table>
   <table align="center" width="300px" style="font-size: 12px">
      <thead>
        <tr>           
            <th align="left" colspan="4">Descripcion</th>
         </tr>
         <tr>           
            <th align="left">Cantidad</th>
            <th align="center" >P.U.</th>
            <th align="center" >V.V.</th>
            <th align="right" >Total</th>
         </tr>
 <tr>
   <td colspan="4">===================================================</td>
   </tr>
      </thead>
   
      <tbody>
       <?php  foreach($resultado_detalle as $row_detalle)
{ ?>
  
   <tr>  
         <td align="left" colspan="4"><?= strtoupper($row_detalle->descripcion) ?></td>
   </tr>
   <tr>
         <td align="left" ><?= strtoupper($row_detalle->cantidad) ?></td>
         <td align="center" ><?= strtoupper($row_detalle->valor_unitario) ?></td>
         <td align="center" ><?= strtoupper($row_detalle->precio_unitario) ?></td>
         <td align="right" ><?= strtoupper($row_detalle->valor_unitario*$row_detalle->cantidad) ?></td>
   </tr>    
 <?php } ?>
      </tbody>
   </table>
    <table border="0"  align="center" width="300px" style="font-size: 12px">
      <thead>
          <tr>
         <td colspan="4">===================================================</td>
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
          <tr>
             <td>Total</td>
             <td align="right"><?= $row_cabecera['total'] ?></td>
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
    
</thead>

 </table>

  <table border="0"  align="center" width="300px" style="font-size: 12px">
       <tr>
   <td colspan="4"></td>
   </tr>
   
 </table>
    </div>
	</body>

   </html>