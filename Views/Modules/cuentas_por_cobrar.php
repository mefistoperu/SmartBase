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
                  <h2 class="h5 page-title">Cuentas por Cobrar </h2>
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
              

                         <div class="card-body">
                          
                          <table id="dataTable-2" class="table table-bordered  table-hover table-striped datatables dataTable no-footer w-100">
                          <thead class="bg-dark" style="color: white">
                        
                       <tr>
                         <th width="10%">Id</th>
                         <th width="40%">Nombre/Razón Social</th>
                         <th >Num Doc</th>
                         <th width="10%">Acciones</th>
                       </tr>
                     </thead>
                      <tbody>
                      <?php while($data = $resultado_data->fetch(PDO::FETCH_ASSOC) )
                        { ?>
                         <tr>
                            
                          <td style="width: 10%"><?php echo $data['id_persona'] ?></td>
                          <td><?php echo $data['nombre_persona'] ?></td>
                           <td><?php echo $data['num_doc'] ?></td>
                          <td>
                              <a class="btn btn-warning rounded-circle" href="<?=base_url()?>\detalle_cobranza\<?=$data['id_persona']?>"> <i class="fe fe-24 fe-dollar-sign"></i></a>
                            </td>
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
    <?php include 'views/template/pie.php' ?>

    <script defer="" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.1/moment.min.js"></script>
<script src="https://unpkg.com/imask"></script>
     <!-- <script type="text/javascript" src="Assets/vendors/inputMask/inputmask.js" charset="utf-8"></script>-->

<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/inputmask/4.0.8/jquery.inputmask.bundle.min.js"></script>



  </body>
</html>