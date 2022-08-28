<?php 

$empresa = $_SESSION["id_empresa"];

$query_data = "SELECT i.id as id,
i.nombre as nombre,
m.id as idmarca,
m.nombre as marca,
i.unidad as unidad,
i.precio_venta as precio_venta,
i.precio_compra as precio_compra,
i.stock as stock,
i.estado as estado,
i.empresa as empresa
FROM tbl_insumos as i LEFT JOIN tbl_marcas as m
ON i.marca = m.id
WHERE i.empresa=$empresa";
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
                <h3>Insumos</h3>
              </div>

             
            </div>

            <div class="clearfix"></div>

            <div class="row">
              <div class="col-md-12 col-sm-12  ">
                <div class="x_panel">
                  <div class="x_title">
                    <h2><button type="button" class="btn btn-dark" data-toggle="modal" data-target=".bs-example-modal-lg"><i class="fa fa-plus-circle"></i> Nuevo</button></h2>
                 
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                    <table id="datatable-responsive" class="table table-striped table-bordered dt-responsive nowrap" cellspacing="0" width="100%">
                      <thead class="bg-dark" style="color: white">
                        <tr>
                          <th width="15%">Acciones</th>
                          <th>Id</th>
                          <th>Nombre</th>
                          <th width="12%">Marca</th>
                          <th width="12%">Unidad</th>
                          <th width="12%">P. Compra</th>
                          <th width="12%">Stock</th>
                          <th width="15%">Estado</th>
                       
                        </tr>
                      </thead>
                      <tbody>
                        <?php foreach($resultado_data as $serie ){ ?>
                          <tr>
                            <td>
                              <button class="btn btn-warning rounded-circle edit" value="<?=$serie['id'] ?>"><i class="fa fa-edit"></i></button>
                              <button class="btn btn-danger rounded-circle delete"  value="<?=$serie['id'] ?>"><i class="fa fa-trash"></i></button>
                            </td>
                            <td><span id="id<?=$serie['id']?>"><?= $serie['id'] ?></span></td>
                            <td><span id="nombre<?=$serie['id']?>"><?= $serie['nombre'] ?></span></td>
                            <td><span id="idmarca<?=$serie['id']?>" style="visibility: hidden;"><?= $serie['idmarca'] ?></span>
                              <span id="marca<?=$serie['id']?>"><?= $serie['marca'] ?></span></td>
                            <td><span id="unidad<?=$serie['id']?>"><?= $serie['unidad'] ?></span></td>
                            <td align="right"><span id="precio_compra<?=$serie['id']?>"><?= number_format($serie['precio_compra'],2) ?></span></td>
                            <td align="right"><span id="stock<?=$serie['id']?>"><?= number_format($serie['stock'],2) ?></span></td>
                            <td><?php $e = $serie['estado'];
                               
                               if($e=='1')
                               {
                                 $e = 'Activo';
                                 $c = 'success';
                               }
                               else
                               {
                                $e = 'Inactivo';
                                $c = 'danger';
                               }
                               
                             ?><button class="btn btn-<?=$c?>"><?=$e?></button></td>

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

      <?php include 'Views/Modules/Modals/nuevo_insumo.php' ?>
      <?php include 'Views/Modules/Modals/editar_insumo.php' ?>
      <?php include 'Views/Modules/Modals/eliminar_insumo.php' ?>
      
      <?php include 'Views/Templates/footer.php' ?>
      <script defer="" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.1/moment.min.js"></script>
<script src="https://unpkg.com/imask"></script>
     <!-- <script type="text/javascript" src="Assets/vendors/inputMask/inputmask.js" charset="utf-8"></script>-->

<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/inputmask/4.0.8/jquery.inputmask.bundle.min.js"></script>
<script type="text/javascript">
    $(document).ready(function () {
  $('#precio_compra')
    .inputmask({
      alias: 'decimal', 
      allowMinus: false,  
      digits: 2, 
      max: 999999.99
  });
})
  </script>
  <script type="text/javascript">
    $(document).ready(function () {
  $('#stock')
    .inputmask({
      alias: 'decimal', 
      allowMinus: false,  
      digits: 2, 
      max: 999999.99
  });
})
  </script>


  <script type="text/javascript">
    $(document).ready(function () {
  $('#update_precio_compra')
    .inputmask({
      alias: 'decimal', 
      allowMinus: false,  
      digits: 2, 
      max: 999999.99
  });
})
  </script>
  <script type="text/javascript">
    $(document).ready(function () {
  $('#update_stock')
    .inputmask({
      alias: 'decimal', 
      allowMinus: false,  
      digits: 2, 
      max: 999999.99
  });
})
  </script>

  <script src="Assets/js/insumo.js"></script>
      <script src="Assets/js/funciones_insumo.js"></script>
</body>
</html>
