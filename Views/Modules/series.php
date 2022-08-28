<?php 

$empresa = $_SESSION["id_empresa"];

$query_data = "SELECT s.id as id_serie,
s.id_td as id_td,
d.nombre as nombre,
s.serie as serie,
s.correlativo as correlativo,  s.estado as estado FROM tbl_series as s
LEFT JOIN tbl_tipo_documento as d
ON  s.id_td = d.id   WHERE id_empresa='$empresa'";
$resultado_data=$connect->prepare($query_data);
$resultado_data->execute();
$num_reg_data=$resultado_data->rowCount();

$query_tipo_doc = "SELECT * FROM tbl_tipo_documento WHERE fe='1' ";
$resultado_tipo_doc=$connect->prepare($query_tipo_doc);
$resultado_tipo_doc->execute(); 

?>
<!DOCTYPE html>
<html lang="en">
  <head>
        <?php include 'Views/Templates/head.php' ?>
  </head>

  <body class="nav-md">
    <div class="container body">
      <div class="main_container">
    
           <?php if($_SESSION["perfil"]=='1'){ include 'Views/Templates/menu.php';}
                 else{include 'Views/Templates/menu_ventas.php';} ?>
        <?php include 'Views/Templates/cabezote.php' ?>

        <!-- page content -->
        <div class="right_col" role="main">
          <div class="">
            <div class="page-title">
              <div class="title_left">
                <h3>Series</h3>
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
                          <th>T. Doc.</th>
                          <th>Descripcion</th>
                          <th>Serie</th>
                          <th>Correlativo</th>
                          <th>Estado</th>
                       
                        </tr>
                      </thead>
                      <tbody>
                        <?php foreach($resultado_data as $serie ){ ?>
                          <tr>
                            <td>
                              <button class="btn btn-warning rounded-circle" onclick="ediserie()"><i class="fa fa-edit"></i></button>
                              <button class="btn btn-danger rounded-circle" onclick="delserie()"><i class="fa fa-trash"></i></button></td>
                            <td><?= $serie['id_serie'] ?></td>
                            <td><?= $serie['id_td'] ?></td>
                            <td><?= $serie['nombre'] ?></td>
                            <td><?= $serie['serie'] ?></td>
                            <td><?= $serie['correlativo'] ?></td>
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
      <?php include 'Views/Modules/Modals/serie_nuevo.php' ?>
      <?php include 'Views/Modules/Modals/serie_editar.php' ?>
      <?php include 'Views/Modules/Modals/serie_delete.php' ?>
      <?php include 'Views/Templates/footer.php' ?>
      
  </body>
</html>
