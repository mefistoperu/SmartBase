<?php 
session_start();
$empresa = $_SESSION["id_empresa"];
$boton  = 'disabled';

if(!empty($_POST))
{
$fecha_ini = $_POST['fecha_ini'];
$fecha_fin = $_POST['fecha_fin'];
$boton  = '';


$query_data = "SELECT * FROM vw_tbl_ventas_sunat WHERE fecha_emision BETWEEN '$fecha_ini' AND '$fecha_fin' ORDER BY td,fecha_emision,serie,numero";
$resultado_data=$connect->prepare($query_data);
$resultado_data->execute();
$num_reg_data=$resultado_data->rowCount();
}

?>
<!DOCTYPE html>
<html lang="en">
  <head>
        <?php include 'Views/Templates/head.php' ?>
        <style>
          .not-active { 
            pointer-events: none; 
            cursor: default; 
        } 
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
                <h3>Registro de Ventas</h3>
              </div>

             
            </div>

            <div class="clearfix"></div>

            <div class="row">
              <div class="col-md-12 col-sm-12  ">
                <div class="x_panel">
                  <div class="x_title">
                    <div class="col-sm-12">

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
                          <button type="submit" class="btn btn-success">Procesar</button>
                          <a href="<?=base_url()?>/rpt_ventas_sunat_pdf/<?=$fecha_ini?>/<?=$fecha_fin?>" class="btn btn-danger" <?=$boton?>><i class="fa fa-file-pdf-o"></i></a>
                        </div>
                      </form>
                    </div>

                   
                    
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
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
          </div>
        </div>
        <!-- /page content -->
        <?php include 'Views/Templates/pie.php' ?>
      </div>
    </div>
     
      <?php include 'Views/Templates/footer.php' ?>
    

      
  </body>
</html>
