<?php 
$id = $rutas[1];

$empresa = $_SESSION["id_empresa"];

$query_data = "SELECT * FROM tbl_recetas AS r
LEFT JOIN tbl_productos AS i
ON r.id_producto = i.id WHERE id_producto = $id";
$resultado_data=$connect->prepare($query_data);
$resultado_data->execute();
$num_reg_data=$resultado_data->rowCount();


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
                  <h2 class="h5 page-title">Bienvenido </h2>
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
                             <h2><button type="button" class="btn btn-dark" data-toggle="modal" data-target=".bs-example-modal-lg"><i class="fe fe-plus-circle"></i> Nuevo</button></h2>
                          </div>
                         <div class="card-body">
                          
                          <table id="dataTable-1" class="table table-bordered table-hover table-striped datatables dataTable no-footer">
                          <thead class="bg-dark" style="color: white">
                        <tr>
                          <th width="10%">Acciones</th>
                          <th width="10%">Id</th>
                          <th>Nombre</th>
                          <th width="12%">Cantidad</th>
                          
                       
                        </tr>
                      </thead>
                        <tbody>
                        <?php foreach($resultado_data as $serie ){ ?>
                          <tr>
                            <td>
                              <button class="btn btn-danger rounded-circle delete" value="<?=$serie['id_receta'] ?>"><i class="fa fa-trash"></i></button>
                              
                            </td>
                            <td><span id="id<?=$serie['id_receta']?>"><?= $serie['id_insumo'] ?></span></td>

                            
                            <td><span id="nombre<?=$serie['id_receta']?>"><?php 
                              $query_pro = "SELECT * FROM tbl_productos WHERE id =$serie[id_insumo]";
                              $resultado_pro = $connect->prepare($query_pro);
                              $resultado_pro->execute();
                              $row_pro = $resultado_pro->fetch(PDO::FETCH_ASSOC);
                              ?><?=$row_pro['nombre']?></span></td>

                            <td><span id="cantidad<?=$serie['id_receta']?>"><?= $serie['cantidad'] ?></span></td>                           
                            
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
         <?php include 'views/modules/modals/nuevo_receta.php' ?>
      <?php include 'views/modules/modals/eliminar_receta.php' ?>
    <?php include 'views/template/pie.php' ?>
     <script defer="" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.1/moment.min.js"></script>
<script src="https://unpkg.com/imask"></script>
     <!-- <script type="text/javascript" src="Assets/vendors/inputMask/inputmask.js" charset="utf-8"></script>-->

<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/inputmask/4.0.8/jquery.inputmask.bundle.min.js"></script>

  <script type="text/javascript">
    $(document).ready(function () {
  $('#cantidad')
    .inputmask({
      alias: 'decimal', 
      allowMinus: false,  
      digits: 2, 
      max: 999999.99
  });
})
  </script>

  

  <script src="<?=base_url()?>/assets/js/receta.js"></script>
      <script src="<?=base_url()?>/assets/js/funciones_receta.js"></script>

  </body>
</html>