<?php 
$empresa = $_SESSION["id_empresa"];
$query_data = "SELECT * FROM tbl_contribuyente WHERE empresa = $empresa";
$resultado_data=$connect->prepare($query_data);
$resultado_data->execute();
$num_reg_data=$resultado_data->rowCount();

 ?>

<!DOCTYPE html>
<html lang="en">
  <head>
        <?php include 'Views/Templates/head.php' ?>
          <style>
          .ajaxgif{
          position:absolute; bottom:12px; right:-20px;}
        .hide{
          display:none;}
        </style>
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
                <h3>Contribuyentes</h3>
              </div>

             
            </div>

            <div class="clearfix"></div>

            <div class="row">
              <div class="col-md-12 col-sm-12  ">
                <div class="x_panel">
                  <div class="x_title">
                    <h2><button type="button" class="btn btn-dark" data-toggle="modal" data-target="#ModalClientes"><i class="fa fa-plus-circle"></i> Nuevo</button></h2>
                    
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                    <table id="datatable-ventas" class="table table-striped table-bordered  nowrap" cellspacing="0" width="100%">
                      <thead class="bg-dark" style="color: white">
                        
                       <tr>
                        <th>Acciones</th>
                         <th width="10%">Id</th>
                         <th>Nombre</th>
                         <th>tip Doc</th>
                         <th>Num Doc</th>
                         <th>Direccion</th>
                         <th>Departamento</th>
                         <th>Provincia</th>
                         <th>Distrito</th>
                         <th>Correo</th>
                         
                       </tr>
                     </thead>
                     <tbody>
                      <?php while($data = $resultado_data->fetch(PDO::FETCH_ASSOC) )
                        { ?>
                         <tr>
                            <td>
                              <button class="btn btn-warning rounded-circle" onclick="openModalEdit()"><i class="fa fa-edit"></i></button>
                              <button class="btn btn-danger rounded-circle" onclick="delserie()"><i class="fa fa-trash"></i></button>
                            </td>
                          <td style="width: 10%"><?php echo $data['id_persona'] ?></td>
                          <td><?php echo $data['nombre_persona'] ?></td>
                          <td><?php echo $data['tipo_doc'] ?></td>
                           <td><?php echo $data['num_doc'] ?></td>
                           <td><?php echo $data['direccion_persona'] ?></td>
                           
                           <td><?php echo $data['departamento'] ?></td>
                           <td><?php echo $data['provincia'] ?></td>
                           <td><?php echo $data['distrito'] ?></td>
                           <td><?php echo $data['correo'] ?></td>
                          
                        </tr>

                          
                         <?php } ?>
                           </tbody>
                     </table>
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
      <?php include 'Views/Modules/Modals/persona.php' ?>
      <?php include 'Views/Templates/footer.php' ?>
      <script src="Assets/js/sunat_reniec.js"></script>
      <script src="Assets/js/persona.js"></script>
      <script src="Assets/js/funciones_persona.js"></script>
      
  </body>
</html>
