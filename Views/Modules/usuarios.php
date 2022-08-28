<?php 

$empresa = $_SESSION["id_empresa"];

$query_data = "SELECT
u.id_usuario as id_usuario,
u.usuario as usuario,
u.nombre_personal as nombre_personal,
u.apellido_personal as apellido_personal,
a.id as cod_almacen,
a.nombre as almacen,
if(u.perfil='1','ADIMINISTRADOR',if(u.perfil='2','SUPERVISOR',if(u.perfil='3','VENDEDOR','NO TIENE PERFIL ASIGNADO'))) AS perfil,
u.estado,
u.id_empresa as id_empresa 
from tbl_usuarios  as u LEFT JOIN tbl_almacen as a
ON u.almacen = a.id WHERE u.id_empresa='$empresa'";
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
                <h3>Usuarios</h3>
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
                          <th>Apellido</th>
                          <th>Usuario</th>
                          <th>Almacen</th>
                          <th>Perfil</th>
                          
                          <th>Estado</th>
                          <th>Series</th>
                        </tr>
                      </thead>
                      <tbody>
                        <?php foreach($resultado_data as $usuario ){ ?>
                          <tr>
                            <td>
                              <button class="btn btn-warning rounded-circle" onclick="ediusuario()"><i class="fa fa-edit"></i></button>
                              <button class="btn btn-danger rounded-circle" onclick="delusuario()"><i class="fa fa-trash"></i></button></td>
                            <td><?= $usuario['id_usuario'] ?></td>
                            <td><?= $usuario['nombre_personal'] ?></td>
                            <td><?= $usuario['apellido_personal'] ?></td>
                            <td><?= $usuario['usuario'] ?></td>
                            <td><?= $usuario['almacen'] ?></td>
                            <td><?= $usuario['perfil'] ?></td>
                            <td><?php $e = $usuario['estado'];
                            if($e == '1')
                            {
                              $e ='Activo';
                              $c = 'success';
                            }
                            else
                            {
                              $e ='Inactivo';
                              $c = 'danger';

                            }?> 
                            <button class="btn btn-<?=$c?> btn-xs"><?=$e?></button></td>
                            <td align="center"><a href="serie_usuario/<?=$usuario['id_usuario'] ?>" class="btn btn-primary rounded-circle"><i class="fa fa-cog"></i></a></td>
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
      <?php include 'Views/Modules/Modals/usuario_nuevo.php' ?>
      <?php include 'Views/Modules/Modals/usuario_editar.php' ?>
      <?php include 'Views/Modules/Modals/usuario_delete.php' ?>
      <?php include 'Views/Templates/footer.php' ?>
      
  </body>
</html>
