<?php 

$empresa = $_SESSION["id_empresa"];

$query_data = "SELECT i.id as id,
i.nombre as nombre,
m.id as idmarca,
m.nombre as marca,
i.unidad as unidad,
i.precio_venta as precio_venta,
i.precio2 as precio_venta2,
i.costo as costo,
i.factor as factor,
i.por1 as por1,
i.por2 as por2,
i.descripcion as descripcion,
i.estado as estado,
i.empresa as empresa,
a.codigo as afectacion,
i.stock as stock,
a.descripcion as descripcion_afectacion,
a.codigo_afectacion as codigo_afectacion,
a.cod_int as cod_int,
a.nombre_afectacion as nombre_afectacion
FROM tbl_productos as i 
LEFT JOIN tbl_marcas as m
ON i.marca = m.id
LEFT JOIN  vw_tbl_tipo_afectacion as a
on i.afectacion = a.codigo
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
                <h3>Productos</h3>
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
                    <table id="datatable-producto" class="table table-striped table-bordered  nowrap" cellspacing="0" width="100%">
                      <thead class="bg-dark" style="color: white">
                        <tr>
                          <th width="15%">Acciones</th>
                          <th width="8%">Recetas</th>
                          <th>Id</th>
                          <th>Nombre</th>
                          <th width="10%">Marca</th>
                          <th width="10%">Uni.</th>
                          <th>Stock</th>
                          <th width="12%">P. Venta</th>
                          <th width="12%">P. x Mayor</th>
                          <th width="16%">Estado</th>
                       
                        </tr>
                      </thead>
                      <tbody>
                        <?php foreach($resultado_data as $serie ){ ?>
                          <tr>
                            <td>
                              <button class="btn btn-warning rounded-circle edit" value="<?=$serie['id'] ?>"><i class="fa fa-edit"></i></button>
                              <button class="btn btn-danger rounded-circle delete"  value="<?=$serie['id'] ?>"><i class="fa fa-trash"></i></button>
                            </td>
                            <td>
                              <a class="btn btn-secondary rounded-circle" href="recetas/<?=$serie['id']?>"><i class="fa fa-rocket"></i></a>
                            </td>
                            <td><span id="id<?=$serie['id']?>"><?= $serie['id'] ?></span></td>

                            
                            <td><span id="nombre<?=$serie['id']?>"><?= $serie['nombre'] ?></span>
                              <span id="costo<?=$serie['id']?>" style="visibility: hidden;"><?= $serie['costo'] ?></span>
                              <span id="por1<?=$serie['id']?>" style="visibility: hidden;"><?= $serie['por1'] ?></span>
                              <span id="por2<?=$serie['id']?>" style="visibility: hidden;"><?= $serie['por2'] ?></span>
                              <span id="factor<?=$serie['id']?>" style="visibility: hidden;"><?= $serie['factor'] ?></span>
                             
                              <span id="descripcion<?=$serie['id']?>" style="visibility: hidden;"><?= $serie['descripcion'] ?></span>
                              <span id="afectacion<?=$serie['id']?>" style="visibility: hidden;"><?= $serie['afectacion'] ?></span>
                             </td>

                            <td><span id="idmarca<?=$serie['id']?>" style="visibility: hidden;"><?= $serie['idmarca'] ?></span>
                              <span id="marca<?=$serie['id']?>"><?= $serie['marca'] ?></span></td>

                            <td><span id="unidad<?=$serie['id']?>"><?= $serie['unidad'] ?></span></td>
                            <td><?= $serie['stock'] ?></span></td>
                            <td align="right"><span id="precio_venta<?=$serie['id']?>"><?= number_format($serie['precio_venta'],2) ?></span></td>
                            <td align="right"><span id="precio_venta2<?=$serie['id']?>"><?= number_format($serie['precio_venta2'],2) ?></span></td>
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

      <?php include 'Views/Modules/Modals/nuevo_producto.php' ?>
      <?php include 'Views/Modules/Modals/editar_producto.php' ?>
      <?php include 'Views/Modules/Modals/eliminar_producto.php' ?>
      
      <?php include 'Views/Templates/footer.php' ?>
      <script defer="" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.1/moment.min.js"></script>
<script src="https://unpkg.com/imask"></script>
     <!-- <script type="text/javascript" src="Assets/vendors/inputMask/inputmask.js" charset="utf-8"></script>-->

<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/inputmask/4.0.8/jquery.inputmask.bundle.min.js"></script>

  <script type="text/javascript">
    $(document).ready(function () {
  $('#precio_venta')
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
  $('#update_precio_venta')
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
  $('#precio_venta2')
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
  $('#update_precio_venta2')
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
  $('#por_gan1')
    .inputmask({
      alias: 'numeric', 
      digits: 2,
      radixPoint: ".",
      placeholder: "0",
      autoGroup: !1,
      min: 0,
      max: 100,
      //suffix: " %",
      allowPlus: !1,
      allowMinus: !1  
      
  });
})
  </script>
    <script type="text/javascript">
    $(document).ready(function () {
  $('#update_por_gan1')
    .inputmask({
      alias: 'numeric', 
      digits: 2,
      radixPoint: ".",
      placeholder: "0",
      autoGroup: !1,
      min: 0,
      max: 100,
      //suffix: " %",
      allowPlus: !1,
      allowMinus: !1  
      
  });
})
  </script>
    <script type="text/javascript">
    $(document).ready(function () {
  $('#update_por_gan2')
    .inputmask({
      alias: 'numeric', 
      digits: 2,
      radixPoint: ".",
      placeholder: "0",
      autoGroup: !1,
      min: 0,
      max: 100,
      //suffix: " %",
      allowPlus: !1,
      allowMinus: !1  
      
  });
})
  </script>
    <script type="text/javascript">
    $(document).ready(function () {
  $('#por_gan2')
    .inputmask({
      alias: 'numeric', 
      digits: 2,
      radixPoint: ".",
      placeholder: "0",
      autoGroup: !1,
      min: 0,
      max: 100,
      //suffix: " %",
      allowPlus: !1,
      allowMinus: !1  
      
  });
})
  </script>
  <script src="Assets/js/producto.js"></script>
      <script src="Assets/js/funciones_producto.js"></script>
</body>
</html>
