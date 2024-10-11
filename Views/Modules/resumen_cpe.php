<?php 

$empresa = $_SESSION["id_empresa"];
$vendedor = $_SESSION["id"];

if(!empty($_POST))
{
    $fecha_ini = $_POST['f_ini'];
    
    $query_venta = "SELECT * FROM vw_tbl_resumen_cpe WHERE idempresa = $empresa  AND fecha_emision = '$fecha_ini'";
    $resultado_venta=$connect->prepare($query_venta);
    $resultado_venta->execute();
    $num_reg_venta=$resultado_venta->rowCount();

}
else
{
    $hoy = date('Y-m-d');
    $fecha_ini = $hoy;
    $fecha_fin = $hoy;
    $query_venta = "SELECT * FROM vw_tbl_resumen_cpe WHERE idempresa = $empresa AND fecha_emision='$hoy'";
    $resultado_venta=$connect->prepare($query_venta);
    $resultado_venta->execute();
    $num_reg_venta=$resultado_venta->rowCount();
}



$query_empresa = "SELECT * FROM tbl_empresas WHERE id_empresa = $empresa";
$resultado_empresa = $connect->prepare($query_empresa);
$resultado_empresa->execute();
$row_empresa = $resultado_empresa->fetch(PDO::FETCH_ASSOC);
?>
<!doctype html>
<html lang="en">
  <head>
       <?php include 'views/template/head.php' ?>
  </head>
  <body class="horizontal dark  ">
    <div class="wrapper">
      <?php
       if($_SESSION['perfil']=='1')
       {
       include 'views/template/nav.php';
       }
       else
       {
       include 'views/template/nav_ventas.php';
       } ?>
      
      <main role="main" class="main-content">
        <div class="container-fluid">
          <div class="row justify-content-center">
            <div class="col-12">
              <div class="row align-items-center mb-2">
                <div class="col">
                  <h2 class="h5 page-title">Resumen de Boletas </h2>
                </div>
                <div class="col-auto">
                  <form class="form-inline">
                    <div class="form-group d-none d-lg-inline">
                      <label for="reportrange" class="sr-only">Date Ranges</label>
                      <div id="reportrange" class="px-2 py-2 text-muted">
                        <span class="small"></span>
                      </div>
                    </div>
                    <div class="form-group">
                      <button type="button" class="btn btn-sm"><span class="fe fe-refresh-ccw fe-16 text-muted"></span></button>
                      <button type="button" class="btn btn-sm mr-2"><span class="fe fe-filter fe-16 text-muted"></span></button>
                    </div>
                  </form>
                </div>
              </div>
              <hr>
              

                    <div class="row my-4">
                      <div class="col-md-12">
                        <div class="card shadow">
                          <div class="card-header">
                      <form method="POST" class="form-inline" name="envia_resumen" id="envia_resumen">
                          <label for=""> Fecha Resumen : </label>
                          <input type="date" class="form-control mr-3" name="f_ini" id="f_ini" value="<?=$fecha_ini?>"><input type="hidden" name="action" value="resumen_cpe">
                          <input type="hidden" name="empresa" id="empresa" value="<?=$empresa?>"> 
                          <button class="btn btn-success btn-lg mr-3" type="submit">Procesar</button> 
                          <button class="btn btn-primary btnenviaResumenCpe btn-lg" name="btnenviaResumenCpe" type="button" id="btnenviaResumenCpe">Enviar Resumen</button>
                    </form>
                          </div>
                         <div class="card-body">
                          
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
                          
                          
                          
                        </tr>
                      </thead>
                      <tbody>
                        <?php foreach($resultado_venta as $ventas ){ ?>
                          <tr>
                          
                            <td><?= $ventas['id'] ?></td>
                            <td><?= $ventas['fecha_emision'] ?></td>
                            <td><?= $ventas['tipodoc'] ?></td>
                            <td><?= $ventas['serie'].'-'.$ventas['correlativo'] ?></td>
                            <td><?= $ventas['docpersona'] ?></td>
                            <td><?= $ventas['nompersona'] ?></td>
                            <td align="right"><?= $ventas['op_gravadas'] ?></td>
                            <td align="right"><?= $ventas['op_exoneradas'] ?></td>
                            <td align="right"><?= $ventas['op_inafectas'] ?></td>
                            <td align="right"><?= $ventas['igv_total'] ?></td>
                            <td align="right"><?= $ventas['importe_total'] ?></td>
                            
                            
                          </tr>
                        <?php } ?>                     
                      </tbody>
                        </table>
                         </div>
                        </div>
                      </div>
                      
                    </div> 

              
              
              
             
            </div> <!-- /.col -->
          </div> <!-- .row -->
        </div> <!-- .container-fluid -->
       
        
      </main> <!-- main -->
    </div> <!-- .wrapper -->
   <?php include 'views/modules/modals/envia_venta.php' ?>
    <?php include 'views/template/pie.php' ?>
    <script defer="" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.1/moment.min.js"></script>
<script src="https://unpkg.com/imask"></script>
     <!-- <script type="text/javascript" src="Assets/vendors/inputMask/inputmask.js" charset="utf-8"></script>-->

<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/inputmask/4.0.8/jquery.inputmask.bundle.min.js"></script>

  <?php include 'views/modules/modals/envia_venta.php' ?>
<script src="assets/js/funciones_ventas.js"></script>

  </body>
</html>