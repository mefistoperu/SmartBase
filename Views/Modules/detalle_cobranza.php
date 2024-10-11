<?php 

$id_usuario = $rutas[1];
$empresa = $_SESSION["id_empresa"];

$query_data = "SELECT * FROM vw_tbl_cta_cobro_detalle WHERE empresa = $empresa AND cliente = $id_usuario";
$resultado_data=$connect->prepare($query_data);
$resultado_data->execute();
$num_reg_data=$resultado_data->rowCount();

if(!empty($_POST))
{
$fecha_ini = $_POST['f_ini'];
$fecha_fin = $_POST['f_fin'];
$boton  = '';

$query_data = "SELECT * FROM vw_tbl_cta_cobro_detalle WHERE fecha_documento BETWEEN '$fecha_ini' AND '$fecha_fin' and empresa = $empresa AND cliente = $id_usuario ORDER BY documento";
$resultado_data=$connect->prepare($query_data);
$resultado_data->execute();
$num_reg_data=$resultado_data->rowCount();
}



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
                  <h2 class="h5 page-title">Documentos Emitidos</h2>
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
                              
                    <form method="POST" class="form-inline">
                      <label for=""> Fecha Inicial :</label>
                      <input type="date" class="form-control mr-3" name="f_ini" id="f_ini" value="<?=$fecha_ini?>">
                      <label for=""> Fecha Final :</label>
                      <input type="date" class="form-control mr-3" name="f_fin" value="<?=$fecha_fin?>" id="f_fin"> 
                      
                            <div class="form-group">
                                    <button type="submit" class="btn btn-success mr-3">Procesar</button>
                            </div>
                      
                      
                        
                          </div>
                          
                         <div class="card-body">
                          
                          <table id="dataTable-1" class="table table-bordered table-hover table-striped datatables dataTable no-footer">
                          <thead class="bg-dark" style="color: white">
                        <tr>
                          <th>Id</th>
                          <th>Documento</th>
                          <th>Fecha Documento</th>
                          <th>Monto total</th>
                          <th>Saldo</th>
                          <th>Estado</th>
                          <th>Acciones</th>
                                                 
                        </tr>
                      </thead>
                      <tbody>
                        <?php foreach($resultado_data as $data ){ ?>
                          <tr>
                            <td><?= $data['id'] ?></td>
                            <td><?= $data['documento']?></td>
                            <td><?= $data['fecha_documento'] ?></td>
                            <td align="right"><?= $data['monto'] ?></td>
                            <td align="right"><?= $data['saldo'] ?></td>
                            <td align="center"><?php $saldo = $data['saldo'];
                            if($saldo > 0)
                            {
                                $estado = 'PENDIENTE';
                                $color  = 'danger';
                             }
                             else
                             {
                               $estado = 'PAGADO';
                                $color  = 'success';  
                             }?><span class="badge badge-<?=$color?>"><?=$estado?></span></td>
                            
                            <td>
                              <a class="btn btn-warning rounded-circle" href="<?=base_url()?>\detalle_cobros\<?=$id_usuario?>\<?=$data['id']?>" > <i class="fe fe-12 fe-dollar-sign"></i></a>
                              <!--$id_usuario=codigo_cliente /  $data= id de factura-->
                            </td>
                            
                            
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
   <?php include 'views/modules/modals/serie_usuario_nuevo.php' ?>
    <?php include 'views/template/pie.php' ?>
    <script defer="" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.1/moment.min.js"></script>
<script src="https://unpkg.com/imask"></script>
     <!-- <script type="text/javascript" src="Assets/vendors/inputMask/inputmask.js" charset="utf-8"></script>-->

<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/inputmask/4.0.8/jquery.inputmask.bundle.min.js"></script>



  </body>
</html>