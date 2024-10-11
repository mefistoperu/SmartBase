
<?php 
session_start();
$empresa = $_SESSION["id_empresa"];
$usuariov = $_SESSION["id"];
$boton  = 'disabled';


if(!empty($_POST))
{
$fecha_ini = $_POST['fecha_ini'];
$fecha_fin = $_POST['fecha_fin'];

$boton  = '';


   $query_data = "SELECT * FROM vw_tbl_alm_ing WHERE fecha BETWEEN '$fecha_ini' AND '$fecha_fin' AND empresa = $empresa   ORDER BY fecha";



$resultado_data=$connect->prepare($query_data);
$resultado_data->execute();
$num_reg_data=$resultado_data->rowCount();

}

?>
<!DOCTYPE html>
<html lang="en">
  <head>
        <?php include 'views/template/head.php' ?>
        <style>
          .not-active { 
            pointer-events: none; 
            cursor: default; 
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
        

        <!-- page content -->
        <div class="container-fluid">
          <div class="row justify-content-center">
            

            

            <div class="col-12">
               <div class="row align-items-center mb-2">
                <div class="col">
                  <h2 class="h5 page-title">Reporte de ingresos de almacen </h2>
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

                          <form class="form-inline" method="POST">
                                <div class="form-group mr-3 ml-3">
                                  <label for="ex3" class="col-form-label"> Fecha Inicio: </label>
                                  <input type="date" id="fecha_ini" name="fecha_ini" class="form-control" value="<?=$fecha_ini?>">
                                </div>
                                <div class="form-group mr-3 ml-3">
                                  <label for="ex4" class="col-form-label"> Fecha Fin: </label>
                                  <input type="date" id="fecha_fin" name="fecha_fin" class="form-control" value="<?=$fecha_fin?>">
                                </div>
                                
                                
                                <div class="form-group">
                                  <button type="submit" class="btn btn-success mx-1">Procesar</button>
                                  
                                </div>
                          </form>
                        </div>

                  <div class="card-body">
                    <table id="datatable-rptvtad" class="table table-striped table-bordered  nowrap" cellspacing="0" width="100%">
                      <thead class="bg-dark" style="color: white">
                        <tr>                          
                          <th>Fecha</th>
                          <th>Id</th>
                          <th>Producto</th>
                          <th>T/M</th>
                          <th>T. Doc</th>
                          <th>Num.Doc.</th>
                          <th>Cantidad</th>
                          <th>Costo Unitario</th>
                          <th>Total</th>
                          
                        </tr>
                      </thead>
                      <tbody>
                        <?php foreach($resultado_data as $data ){ ?>
                          <tr>
                            <td><?=$data['fecha']?></td>
                            <td><?=$data['codigo_producto']?></td>
                            <td><?=$data['nombre_producto']?></td>
                            <td><?=$data['tipo_movimiento']?></td>
                            <td><?=$data['tipo_doc']?></td>
                            <td><?=$data['serie_doc'].'-'.$data['num_doc']?></td>
                            <td><?=number_format($data['cantidad'],3)?></td>
                            <td><?=number_format($data['costo_unitario'],3)?></td>
                            <td><?=number_format($data['cantidad']*$data['costo_unitario'],3)?></td>
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
      
      </div>
    </div>
     
      <?php include 'views/template/pie.php' ?>
    

      
  </body>
</html>
