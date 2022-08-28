<?php 

$empresa = $_SESSION["id_empresa"];
$vendedor = $_SESSION["id"];

if(!empty($_POST))
{
    $fecha_ini = $_POST['f_ini'];
    
    $query_venta = "SELECT * FROM tbl_venta_cab AS c LEFT JOIN tbl_contribuyente as x
    on c.codcliente = x.num_doc WHERE idempresa = $empresa AND tipocomp ='03' AND fecha_emision = '$fecha_ini' AND feestado<>'1'";
    $resultado_venta=$connect->prepare($query_venta);
    $resultado_venta->execute();
    $num_reg_venta=$resultado_venta->rowCount();

}
else
{
    $hoy = date('Y-m-d');
    $fecha_ini = $hoy;
    $fecha_fin = $hoy;
    $query_venta = "SELECT * FROM tbl_venta_cab AS c LEFT JOIN tbl_contribuyente as x
    on c.codcliente = x.num_doc WHERE idempresa = $empresa AND tipocomp ='03'AND fecha_emision='$hoy' AND feestado<>'1'";
    $resultado_venta=$connect->prepare($query_venta);
    $resultado_venta->execute();
    $num_reg_venta=$resultado_venta->rowCount();
}



$query_empresa = "SELECT * FROM tbl_empresas WHERE id_empresa = $empresa";
$resultado_empresa = $connect->prepare($query_empresa);
$resultado_empresa->execute();
$row_empresa = $resultado_empresa->fetch(PDO::FETCH_ASSOC);
?>
<!DOCTYPE html>
<html lang="en">
  <head>
        <?php include 'Views/Templates/head.php' ?>
        <style>
          .not-active { 
            pointer-events: none; 
            cursor: default; 
        } 
        </style>
  </head>

 <body class="nav-md">
    <div class="container body">
      <div class="main_container">
        
           <?php if($_SESSION["perfil"]=='1'){ include 'Views/Templates/menu.php';}
                 else{include 'Views/Templates/menu_ventas.php';} ?>
        <?php include 'Views/Templates/cabezote.php' ?>

        <!-- page content -->
        <div class="right_col" role="main">
          <div class="">
            <div class="page-title">
              <div class="title_left">
                <h3 class="text-uppercase text-bold">Resumen de Boletas</h3>

              </div>

             
            </div>

            <div class="clearfix"></div>

            <div class="row">
              <div class="col-md-12 col-sm-12  ">
                <div class="x_panel">
                  <div class="x_title">
                    
                    <form method="POST" class="form-inline" name="envia_resumen" id="envia_resumen">
                          <label for=""> Fecha Resumen : </label>
                          <input type="date" class="form-control mr-3" name="f_ini" id="f_ini" value="<?=$fecha_ini?>"><input type="hidden" name="action" value="resumen_cpe">
                          <input type="hidden" name="empresa" id="empresa" value="<?=$empresa?>"> 
                          <button class="btn btn-success" type="submit">Procesar</button> 
                          <button class="btn btn-primary btnenviaResumenCpe" name="btnenviaResumenCpe" type="button" id="btnenviaResumenCpe">Enviar Resumen</button>
                    </form>
                    
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                    <table id="datatable-ventas" class="table table-striped table-bordered  nowrap" cellspacing="0" width="100%">
                      <thead class="bg-dark" style="color: white">
                        <tr>
                         
                          <th>Id</th>
                          <th>Fecha</th>
                          <th>T. Cpe</th>
                          <th>N. Cpe</th>
                          <th>RUC/DNI</th>
                          <th>Cliente</th>
                          <th>Op. Gravada</th>
                          <th>Op. Exonerada</th>
                          <th>Op. Inafecta</th>
                          <th>IGV</th>
                          <th>Total</th>
                          
                          <th>Codigo</th>
                          <th>Estado</th>
                          
                        </tr>
                      </thead>
                      <tbody>
                        <?php foreach($resultado_venta as $ventas ){ ?>
                          <tr>
                          
                            <td><?= $ventas['id'] ?></td>
                            <td><?= $ventas['fecha_emision'] ?></td>
                            <td><?= $ventas['tipocomp'] ?></td>
                            <td><?= $ventas['serie'].'-'.$ventas['correlativo'] ?></td>
                            <td><?= $ventas['codcliente'] ?></td>
                            <td><?= $ventas['nombre_persona'] ?></td>
                            <td align="right"><?= $ventas['op_gravadas'] ?></td>
                            <td align="right"><?= $ventas['op_exoneradas'] ?></td>
                            <td align="right"><?= $ventas['op_inafectas'] ?></td>
                            <td align="right"><?= $ventas['igv'] ?></td>
                            <td align="right"><?= $ventas['total'] ?></td>
                            
                            <td><?=$ventas['fecodigoerror']?></td>
                            <td><?php $e = $ventas['feestado'];
                            if($e == 1)
                            {
                              $e ='fa fa-check';
                              $c = 'success';
                            }
                            else
                            {
                              $e ='fa fa-close';
                              $c = 'danger';

                            }?> 
                            <button class="btn btn-<?=$c?> rounded-circle"><i class="<?=$e?>"></i></button></td>
                            
                          </tr>
                        <?php } ?>                     
                      </tbody>
                    </table>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <!-- /page content -->
        <?php include 'Views/Templates/pie.php' ?>
      </div>
    </div>
       <?php include 'Views/Modules/Modals/envia_venta.php' ?>
      <?php include 'Views/Templates/footer.php' ?>
     
     
      <script src="Assets/js/funciones_ventas.js"></script>

      
  </body>
</html>
