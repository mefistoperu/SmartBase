<?php 

$id_usuario = $rutas[1];

$query_data = "SELECT
su.id as id,
su.id_usuario as usuario,
us.usuario as nombre_usuario,
s.serie as serie,
s.correlativo as correlativo
from tbl_series_usuarios as su
LEFT JOIN tbl_series as s
ON su.id_serie = s.id 
LEFT JOIN tbl_usuarios as us
ON su.id_usuario = us.id_usuario
WHERE su.id_usuario='$id_usuario'";
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
                <h3>Serie - Usuario</h3>
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
                          <th>Id Usuario</th>
                          <th>Usuario</th>
                          <th>Serie</th>
                          <th>Correlativo</th>
                                                 
                        </tr>
                      </thead>
                      <tbody>
                        <?php foreach($resultado_data as $serie ){ ?>
                          <tr>
                            <td>
                              <a class="btn btn-warning rounded-circle" disabled><i class="fa fa-edit"></i></a>
                              <button class="btn btn-danger rounded-circle" onclick="delserieusuario()"><i class="fa fa-trash"></i></button></td>
                            <td><?= $serie['id'] ?></td>
                            <td><?= $serie['usuario'] ?></td>
                            <td><?= $serie['nombre_usuario'] ?></td>
                            <td><?= $serie['serie'] ?></td>
                            <td><?= $serie['correlativo'] ?></td>
                            
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
     <?php include 'Views/Modules/Modals/serie_usuario_nuevo.php' ?>
      <?php include 'Views/Modules/Modals/serie_usuario_delete.php' ?>
      <?php include 'Views/Templates/footer.php' ?>
      
  </body>
</html>
