<?php 

$empresa = $_SESSION["id_empresa"];

$query_data = "SELECT i.id as id,
i.nombre as nombre,
m.id as idmarca,
m.nombre as marca,
i.unidad as unidad,
i.unidadu as unidadu,
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
a.nombre_afectacion as nombre_afectacion,
i.sku as sku,
tc.id as idcategoria,
tc.nombre as categoria,
i.imagen as imagen,
i.venta as venta
FROM tbl_productos as i 
LEFT JOIN tbl_marcas as m
ON i.marca = m.id
LEFT JOIN  vw_tbl_tipo_afectacion as a
on i.afectacion = a.codigo
LEFT JOIN tbl_categorias as tc
ON i.categoria = tc.id
WHERE i.empresa=$empresa  AND i.estado <>'0'";
$resultado_data=$connect->prepare($query_data);
$resultado_data->execute();
$num_reg_data=$resultado_data->rowCount();

?>
<!doctype html>
<html lang="en">
  <head>
       <?php include 'views/template/head.php' ?>
       <style>
         .dataTables_wrapper .dt-buttons {
  float:none;  
  text-align:center;

}
button.dt-button{
  background-color: #ccc;
}
       </style>
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
                             
                          </div>
                         <div class="card-body">
                          
                          <table id="datatable-producto" class="table table-striped table-bordered  nowrap" cellspacing="0" width="100%">
                          <thead class="bg-dark" style="color: white">
                        <tr>
                          
                          
                          <th>Id</th>
                          <th>Nombre</th>
                          
                          <th>Stock</th>
                          <th>Stock uni.</th>
                       
                          
                          <th>P. Venta Unitario</th>
                          <th>P. x Mayor</th>
                          <th>Estado</th>
                       
                        </tr>
                      </thead>
                        <tbody>
                        <?php foreach($resultado_data as $serie ){ ?>
                          <tr>
                           
                            
                            <td><span id="id<?=$serie['id']?>"><?= $serie['id'] ?></span></td>

                            
                            <td><span id="nombre<?=$serie['id']?>"><?= $serie['nombre'] ?></span>
                              <span id="costo<?=$serie['id']?>" style="visibility: hidden;"><?= $serie['costo'] ?></span>
                              <span id="por1<?=$serie['id']?>" style="visibility: hidden;"><?= $serie['por1'] ?></span>
                              <span id="por2<?=$serie['id']?>" style="visibility: hidden;"><?= $serie['por2'] ?></span>
                              <span id="factor<?=$serie['id']?>" style="visibility: hidden;"><?= $serie['factor'] ?></span>

                              <span id="sku<?=$serie['id']?>" style="visibility: hidden;"><?= $serie['sku'] ?></span>
                              <span id="img<?=$serie['id']?>" style="visibility: hidden;"><?= $serie['imagen'] ?></span>
                              <span id="vta<?=$serie['id']?>" style="visibility: hidden;"><?= $serie['venta'] ?></span>
                             
                              <span id="descripcion<?=$serie['id']?>" style="visibility: hidden;"><?= $serie['descripcion'] ?></span>
                              <span id="afectacion<?=$serie['id']?>" style="visibility: hidden;"><?= $serie['afectacion'] ?></span>
                             </td>

                            <td align="right"><?php $stk=number_format($serie['stock']/$serie['factor'],2); 
                                     $sf = floor($stk);
                                      $su  = $serie['stock'] - ($serie['factor'] * $sf);
                                      echo $sf.' ' .$serie['unidad'].' / '.$su.' '.$serie['unidadu'] ?></td>
                            <td align="right"><?= $serie['stock'] ?></td>
                        
                          
                            <td align="right"><span id="precio_venta<?=$serie['id']?>"><?= number_format($serie['precio_venta']/$serie['factor'],2) ?></span></td>
                            <td align="right"><span id="precio_venta2<?=$serie['id']?>"><?= number_format($serie['precio_venta2'],2) ?></span></td>
                            <td align="center"><?php $e = $serie['estado'];
                               
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

              
              
              
             
            </div> <!-- /.col -->
          </div> <!-- .row -->
        </div> <!-- .container-fluid -->
       
        
      </main> <!-- main -->
    </div> <!-- .wrapper -->

    <?php include 'views/modules/modals/nuevo_producto.php' ?>
    <?php include 'views/modules/modals/editar_producto.php' ?>
    <?php include 'views/modules/modals/eliminar_producto.php' ?>
   <?php include 'views/template/pie.php' ?>
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
  <script src="assets/js/producto.js"></script>
      <script src="assets/js/funciones_producto.js"></script>

  </body>
</html>