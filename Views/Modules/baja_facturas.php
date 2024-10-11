<?php 

$empresa = $_SESSION["id_empresa"];
$vendedor = $_SESSION["id"];
$hoy = date('Y-m-d');

$max_dias = date("Y-m-d",strtotime($hoy."- 5 days")); 


 $sql_empresas="SELECT * FROM tbl_empresas WHERE id_empresa = $_SESSION[id_empresa]";
        $resultado_empresas=$connect->prepare($sql_empresas);
        $resultado_empresas->execute();
        $row_empresas = $resultado_empresas->fetch(PDO::FETCH_ASSOC);

        $fecha_certificado = $row_empresas['fecha_certificado'];

        if($hoy>$fecha_certificado)
        {
          $estado_certificado = 'Cerificado Vencido';

       
        }
        else
        {
          $estado_certificado = 'Cerificado Activo';
        }



if(!empty($_POST))
{
    $fecha_ini = $_POST['f_ini'];
   
 
    $query_venta = "SELECT * FROM tbl_venta_cab AS c LEFT JOIN tbl_contribuyente as x
    on c.idcliente = x.id_persona WHERE idempresa = $empresa  AND tipocomp in ('01','07') AND fecha_emision = '$fecha_ini' AND feestado='1' ";
    $resultado_venta=$connect->prepare($query_venta);
    $resultado_venta->execute();
    $num_reg_venta=$resultado_venta->rowCount();

}
else
{
    $hoy = date('Y-m-d');
    $fecha_ini = $hoy;
  
    $query_venta = "SELECT * FROM tbl_venta_cab AS c LEFT JOIN tbl_contribuyente as x
    on c.idcliente = x.id_persona WHERE idempresa = $empresa AND tipocomp ='01'AND fecha_emision='$hoy' AND feestado='1'";
    $resultado_venta=$connect->prepare($query_venta);
    $resultado_venta->execute();
    $num_reg_venta=$resultado_venta->rowCount();
}



$query_empresa = "SELECT * FROM tbl_empresas WHERE id_empresa = $empresa";
$resultado_empresa = $connect->prepare($query_empresa);
$resultado_empresa->execute();
$row_empresa = $resultado_empresa->fetch(PDO::FETCH_ASSOC);
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
                  <h2 class="h5 page-title">Baja de Facturas </h2>
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
                     
                    <form method="POST" class="form-inline">
                      <div class="col-sm-3">
                        <div class="row">
                        <label for=""> Fecha Generacion Baja :</label>
                      <input type="date" class="form-control mr-3 w-100" name="f_ini" id="f_ini" value="<?=$fecha_ini?>" min="<?=$max_dias?>">
                      </div>
                      </div>
                     <div class="col-sm-2">
                        <div class="row">
                        <button class="btn btn-success ml-3 mt-3 btn-block" type="submit">Listar CPE</button>
                      </div> 
                     </div>
                                 
                                          
                     </form>
                          </div>
                         <div class="card-body">
                    <form name="baja_facturas_cpe" id="baja_facturas_cpe">
                      <div class="col-sm-2">
                          <div class="row">
                        <button type="button" class="btn btn-primary ml-3 mt-3 btn-block" id="GenerarBajaFacturas" >Generar Baja</button>
                        <input type="hidden" name="action"  value="baja_cpe_facturas">
                         <input type="hidden" name="empresa"  value="<?=$empresa?>" >
                         <input type="hidden" name="fechab"  value="<?=$fecha_ini?>" >
                      </div> 
                      </div> 
                      <hr>
                         <table id="datatable-ventas" class="table table-striped table-bordered  nowrap" cellspacing="0" width="100%">
                          <thead class="bg-dark" style="color: white">
                              <tr>
                                
                                <th>*</th>
                                <th>Id</th>
                                <th>Fecha</th>
                                <th>RUC/DNI</th>
                                <th>Cliente</th>
                                <th>Serie</th>
                                <th>Numero</th>
                                <th>Importe</th>                              
                                                                                               
                              </tr>
                          </thead>
                            <tbody>
                              <?php foreach($resultado_venta as $ventas ){ ?>
                                <tr>
                                  <td><input type="checkbox" name="bajaId[]" value="<?= $ventas['id'] ?>"></td>
                                  <td><?= $ventas['id'] ?></td>                           
                                  
                                  <td><?= $ventas['fecha_emision'] ?></td>
                                  <td><?= $ventas['codcliente'] ?></td>
                                  <td><?= $ventas['nombre_persona'] ?></td>
                                  <td><?= $ventas['serie'] ?></td>
                                  <td><?= $ventas['correlativo'] ?></td>
                                  <td align="right"><?= $ventas['total'] ?></td>                             
                                  
                                  
                                </tr>
                              <?php } ?>                     
                            </tbody>
                        </table>
                    </form>
                         </div>
                        </div>
                      </div>
                      
                    </div> 

              
              
              
             
            </div> <!-- /.col -->
          </div> <!-- .row -->
        </div> <!-- .container-fluid -->
       
        
      </main> <!-- main -->
    </div> <!-- .wrapper -->
   <?php include 'views/modules/modals/envia_venta.php' ?>
    <?php include 'views/template/pie.php' ?>
    <script defer="" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.18.1/moment.min.js"></script>
<script src="https://unpkg.com/imask"></script>
     <!-- <script type="text/javascript" src="Assets/vendors/inputMask/inputmask.js" charset="utf-8"></script>-->

<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/inputmask/4.0.8/jquery.inputmask.bundle.min.js"></script>



<script src="assets/js/funciones_ventas.js"></script>

  </body>
</html>