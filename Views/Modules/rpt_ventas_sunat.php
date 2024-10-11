
<?php 
session_start();
$empresa = $_SESSION["id_empresa"];
$boton  = 'disabled';

if(!empty($_POST))
{
$fecha_ini = $_POST['fecha_ini'];
$fecha_fin = $_POST['fecha_fin'];
$boton  = '';



$query_data = "SELECT * FROM vw_tbl_ventas_sunat WHERE fecha_emision BETWEEN '$fecha_ini' AND '$fecha_fin' and empresa = $empresa  ORDER BY td,fecha_emision,serie,numero";
$resultado_data=$connect->prepare($query_data);
$resultado_data->execute();
$num_reg_data=$resultado_data->rowCount();
}

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
                  <h2 class="h5 page-title">Reporte de ventas SUNAT </h2>
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
                                  <div class="form-group">
                                    <label for="ex3" class="col-form-label">Fecha Inicio: </label>
                                    <input type="date" id="fecha_ini" name="fecha_ini" class="form-control" value="<?=$fecha_ini?>">
                                  </div>
                                  <div class="form-group mr-3 ml-3">
                                    <label for="ex4" class="col-form-label">Fecha Fin: </label>
                                    <input type="date" id="fecha_fin" name="fecha_fin" class="form-control" value="<?=$fecha_fin?>">
                                  </div>
                                  
                                  <div class="form-group">
                                    <button type="submit" class="btn btn-success mr-3">Procesar</button>
                                    <a href="<?=base_url()?>/rpt_ventas_sunat_pdf/<?=$fecha_ini?>/<?=$fecha_fin?>" class="btn btn-danger mr-3" <?=$boton?>><i class="fas fa-file-pdf"></i> Generar PDF</a>
                                    
                                    <a href="<?=base_url()?>/ws_siscont/<?=$fecha_ini?>/<?=$fecha_fin?>" class="btn btn-primary mr-3" <?=$boton?>><i class="fas fa-file-excel"></i> excel Siscont</a>
                                  </div>
                            </form>                 
                    
                          </div>
                         <div class="card-body">
                          
                         <table id="datatable-rptvta" class="table table-striped table-bordered  nowrap" cellspacing="0" width="100%">
                          <thead class="bg-dark" style="color: white">
                              <tr>
                               
                               
                               <th>F. Emision</th>
                          <th>F. Vencimiento</th>
                          <th>TD</th>
                          <th>Serie</th>
                          <th>Numero</th>
                          <th>Doc</th>
                          <th>N. DOC</th>
                          <th>Razon Social</th>
                          <th>Valor Export</th>
                          <th>Op. Gravada</th>
                          <th>Op. Exonerada</th>
                          <th>Op. Inafecta</th>
                          <th>ISC</th>
                          <th>IGV</th>
                          <th>ICBPER</th>
                          <th>Otros</th>
                          <th>Total</th>
                          <th>T. ref</th>
                          <th>Ser. ref</th>
                          <th>Num. ref</th>
                                
                              </tr>
                      </thead>
                      <tbody>
                        <?php foreach($resultado_data as $data ){ ?>
                          <tr>
                            <td><?=$data['fecha_emision']?></td>
                            <td><?=$data['fecha_vencimiento']?></td>
                            <td><?=$data['td']?></td>
                            <td><?=$data['serie']?></td>
                            <td><?=$data['numero']?></td>
                            <td><?=$data['doc']?></td>
                            <td><?=$data['num_cli']?></td>
                            <td><?=$data['razon_social']?></td>
                            <td class="text-right"><?=$data['valor_exportacion']?></td>
                            <td class="text-right"><?=$data['op_gravadas']?></td>
                            <td class="text-right"><?=$data['op_exoneradas']?></td>
                            <td class="text-right"><?=$data['op_inafectas']?></td>
                            <td class="text-right"><?=$data['isc']?></td>
                            <td class="text-right"><?=$data['igv']?></td>
                            <td class="text-right"><?=$data['icbper']?></td>
                            <td class="text-right"><?=$data['oth']?></td>
                            <td class="text-right"><?=$data['total']?></td>
                            <td><?=$data['tipo_ref']?></td>
                            <td><?=$data['serie_ref']?></td>
                            <td><?=$data['correlativo_ref']?></td>
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

  </body>
</html>