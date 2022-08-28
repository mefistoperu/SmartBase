<?php 

$empresa = $_SESSION["id_empresa"];

$query_data = "SELECT * FROM tbl_marcas WHERE empresa='$empresa'";
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
                <h3>Marcas</h3>
              </div>

             
            </div>

            <div class="clearfix"></div>

            <div class="row">
              <div class="col-md-12 col-sm-12  ">
                <div class="x_panel">
                  <div class="x_title">
                    <h2><button type="button" class="btn btn-dark" data-toggle="modal" data-target="#ModalMarcas"><i class="fa fa-plus-circle"></i> Nuevo</button></h2>
                    
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                    <table id="datatable-responsive" class="table table-striped table-bordered dt-responsive nowrap" cellspacing="0" width="100%">
                      <thead class="bg-dark" style="color: white">
                        <tr>
                          <th width="15%">Acciones</th>
                          <th width="10%">Id</th>
                          <th>Nombre</th>
                          <th width="15%">Estado</th>
                          
                        </tr>
                      </thead>
                      <tbody>
                        <?php foreach($resultado_data as $usuario ){ ?>
                          <tr>
                            <td>
                              <button class="btn btn-warning rounded-circle" onclick="openModalEdit()"><i class="fa fa-edit"></i></button>
                              <button class="btn btn-danger rounded-circle" onclick="openModalDel()"><i class="fa fa-trash"></i></button></td>
                            <td><?= $usuario['id'] ?></td>
                            <td><?= $usuario['nombre'] ?></td>
                            
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
      <?php include 'Views/Modules/Modals/marcas.php' ?>
      <?php include 'Views/Templates/footer.php' ?>
      <script src="Assets/js/marcas.js"></script>
      <script src="Assets/js/funciones_marca.js"></script>

      
  </body>
</html>
