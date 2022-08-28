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
<!DOCTYPE html>
<html lang="en">
  <head>
        <?php include 'Views/Templates/head.php' ?>

  </head>

  <body class="nav-md">
  
    <div class="container body">
      <div class="main_container">
        <?php include 'Views/Templates/menu.php' ?>
        <?php include 'Views/Templates/cabezote.php' ?>

        <!-- page content -->
        <div class="right_col" role="main">
          <div class="">
            <div class="page-title">
              <div class="title_left">
                <h3>Recetas</h3>
              </div>

             
            </div>

            <div class="clearfix"></div>

            <div class="row">
              <div class="col-md-12 col-sm-12  ">
                <div class="x_panel">
                  <div class="x_title">
                    <h2><button type="button" class="btn btn-dark" data-toggle="modal" data-target=".bs-example-modal-lg"><i class="fa fa-plus-circle"></i> Agregar</button>
                      <a href="<?=base_url()?>/productos" class="btn btn-danger">Regresar</a></h2>
                 
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                    <table id="datatable-responsive" class="table table-striped table-bordered dt-responsive nowrap" cellspacing="0" width="100%">
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
          </div>
        </div>
        <!-- /page content -->
        <?php include 'Views/Templates/pie.php' ?>


      </div>
    </div>

      <?php include 'Views/Modules/Modals/nuevo_receta.php' ?>
      <?php include 'Views/Modules/Modals/eliminar_receta.php' ?>
      
      <?php include 'Views/Templates/footer.php' ?>
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

  

  <script src="<?=base_url()?>/Assets/js/receta.js"></script>
      <script src="<?=base_url()?>/Assets/js/funciones_receta.js"></script>
</body>
</html>
