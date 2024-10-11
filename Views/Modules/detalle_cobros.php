<?php 

$id_cliente = $rutas[1];
$id_factura = $rutas[2];
$empresa = $_SESSION["id_empresa"];

$query_cliente = "SELECT * FROM tbl_contribuyente WHERE id_persona=$id_cliente";
$resultado_cliente = $connect->prepare($query_cliente);
$resultado_cliente->execute();
$row_cliente = $resultado_cliente->fetch(PDO::FETCH_ASSOC);

$num_doc= $row_cliente['num_doc'];


$query_factura = "SELECT * FROM vw_tbl_venta_cab WHERE id = $id_factura";
$resultado_factura=$connect->prepare($query_factura);
$resultado_factura->execute();
$row_factura = $resultado_factura->fetch(PDO::FETCH_ASSOC);

$tipocomp=$row_factura['tipocomp'];
$serie=$row_factura['serie'];
$correlativo=$row_factura['correlativo'];


$query_vta = "SELECT * FROM vw_tbl_venta_pago WHERE idempresa='$empresa' AND id_venta = '$id_factura'";
$resultado_vta=$connect->prepare($query_vta);
$resultado_vta->execute();
$num_reg_vta=$resultado_vta->rowCount();


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
                  <h2 class="h5 page-title">Pagos del documento </h2>
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
                        <h2><button type="button" class="btn btn-dark" data-toggle="modal" data-target="#NuevoPago"><i class="fe fe-plus-circle"></i> Nuevo</button></h2>
                          </div>
                         <div class="card-body">
                          
                          <table id="dataTable-1" class="table table-bordered table-hover table-striped datatables dataTable no-footer">
                          <thead class="bg-dark" style="color: white">
                        <tr>
                          <th width="10%">Acciones</th>
                          <th>Id</th>
                          <th>Fecha Pago</th>
                          <th>Num. Operación</th>
                          <th>Tipo de Pago</th>
                          <th>Importe</th>
                                                 
                        </tr>
                      </thead>
                      <tbody>
                               
                        <?php foreach($resultado_vta as $vta ){ ?>
                          <tr>
                            <td>
                              <button class="btn btn-danger rounded-circle" onclick="openModalDel()"><i class="fe fe-trash-2"></i></button></td>
                            <td><?= $vta['id'] ?></td>
                            <td><?= $vta['fecha_emision'] ?></td>
                            <td><?= $vta['num_ope'] ?></td>
                            <td><?= $vta['nombre'] ?></td>
                            <td><?= $vta['importe_pago'] ?></td>
                            <button class="btn btn-<?=$c?> btn-xs"><?=$e?></button></td>
                            
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
    <?php include 'views/template/pie.php' ?>
    <?php include 'views/modules/modals/add_pago.php' ?>
    <script defer="" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.1/moment.min.js"></script>
<script src="https://unpkg.com/imask"></script>
     <!-- <script type="text/javascript" src="Assets/vendors/inputMask/inputmask.js" charset="utf-8"></script>-->
<script src="<?php echo media() ?>/js/funciones_pago.js"></script>     
     

<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/inputmask/4.0.8/jquery.inputmask.bundle.min.js"></script>








  </body>
</html>