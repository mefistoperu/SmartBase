<?php 
$empresa = $_SESSION["id_empresa"];
$query_data = "SELECT * FROM tbl_contribuyente WHERE empresa = $empresa";
$resultado_data=$connect->prepare($query_data);
$resultado_data->execute();
$num_reg_data=$resultado_data->rowCount();

 ?>

<!doctype html>
<html lang="en">
  <head>
       <?php include 'views/template/head.php' ?>
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
                  <h2 class="h5 page-title">Contribuyentes </h2>
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
                             <h2><button type="button" class="btn btn-dark" data-toggle="modal" data-target="#ModalClientes"><i class="fe fe-plus-circle"></i> Nuevo</button>
                             <button type="button" class="btn btn-success" data-toggle="modal" data-target="#exampleModal">
                                 <i class="fa fa-file-excel"></i>
                                        <span> Elegir Archivo Excel</span>
                                </button>
                                
                                 <a href="<?=base_url()?>/assets/ajax/excel/clientes.xlsx" target="_blank" class="btn btn-primary"><i class="fa-solid fa-download"></i> Descargar Excel</a>
                             </h2>
                          </div>
                         <div class="card-body">
                          
                          <table id="dataTable-2" class="table table-bordered  table-hover table-striped datatables dataTable no-footer w-100">
                          <thead class="bg-dark" style="color: white">
                        
                       <tr>
                        <th width="10%">Acciones</th>
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
                              <button class="btn btn-warning rounded-circle" onclick="openModalEdit()"><i class="fe fe-edit"></i></button>
                              <button class="btn btn-danger rounded-circle" onclick="delserie()"><i class="fe fe-trash-2"></i></button>
                              <a class="btn btn-primary rounded-circle" href="<?=base_url()?>/destinos/<?=$data['id_persona']?>"><i class="fe fe-map"> </i></a>
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
                         </div>
                        </div>
                      </div>
                      
                    </div> 

              
              
              
             
            </div> <!-- /.col -->
          </div> <!-- .row -->
        </div> <!-- .container-fluid -->
       
        
      </main> <!-- main -->
    </div> <!-- .wrapper -->
   <?php include 'views/modules/modals/persona.php' ?>
    <?php include 'views/template/pie.php' ?>

    <script defer="" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.1/moment.min.js"></script>
<script src="https://unpkg.com/imask"></script>
     <!-- <script type="text/javascript" src="Assets/vendors/inputMask/inputmask.js" charset="utf-8"></script>-->

<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/inputmask/4.0.8/jquery.inputmask.bundle.min.js"></script>


<script src="assets/js/sunat_reniec.js"></script>
      <script src="assets/js/persona.js"></script>
      <script src="assets/js/funciones_persona.js"></script>
  <!--modal para cargar archivo excel-->
<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <form name="cargarCliente" id="cargarCliente" enctype="multipart/form-data">
    <div class="modal-content">
      <div class="modal-header bg-success">
        <h5 class="modal-title" id="exampleModalLabel">Elegir Archivo Excel</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
       
      </div>
      <div class="modal-body">
          
     <div class="file-input text-center">
         <input type="hidden" name="action" value="cargar_excel_producto">
         <input type="file" name="dataClientes" id="dataClientes" class="form-control"   accept=".xls,.xlsx">
        
     </div>
                                 
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
        <button type="submit" class="btn btn-success"><i class="fa-solid fa-upload"></i> Cargar Productos</button>
      </div>
    </div>
    </form>
  </div>
</div> 


  </body>
</html>