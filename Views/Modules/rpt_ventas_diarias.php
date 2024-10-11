
<?php 
session_start();
$empresa = $_SESSION["id_empresa"];
$usuariov = $_SESSION["id"];
$boton  = 'disabled';


if(!empty($_POST))
{
$fecha_ini = $_POST['fecha_ini'];
$fecha_fin = $_POST['fecha_fin'];
$usuario   = $_POST['usuario'];
$boton  = '';

if($usuario == 0)
{
  $query_data = "SELECT fecha FROM vw_tbl_ventas_diarias WHERE fecha BETWEEN '$fecha_ini' AND '$fecha_fin' AND idempresa = $empresa  GROUP by  fecha";
}
else
{
  $query_data = "SELECT fecha FROM vw_tbl_ventas_diarias WHERE vendedor='$usuario' and fecha BETWEEN '$fecha_ini' AND '$fecha_fin' AND idempresa = $empresa  GROUP by  fecha";
}


$resultado_data=$connect->prepare($query_data);
$resultado_data->execute();
$num_reg_data=$resultado_data->rowCount();
}

?>
<!DOCTYPE html>
<html lang="en">
  <head>
        <?php include 'views/template/head.php' ?>
        <style>
          .not-active { 
            pointer-events: none; 
            cursor: default; 
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
        

        <!-- page content -->
        <div class="container-fluid">
          <div class="row justify-content-center">
            

            

            <div class="col-12">
               <div class="row align-items-center mb-2">
                <div class="col">
                  <h2 class="h5 page-title">Reporte de ventas resumen </h2>
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
                                <div class="form-group mr-3 ml-3">
                                  <label for="ex3" class="col-form-label"> Fecha Inicio: </label>
                                  <input type="date" id="fecha_ini" name="fecha_ini" class="form-control" value="<?=$fecha_ini?>">
                                </div>
                                <div class="form-group mr-3 ml-3">
                                  <label for="ex4" class="col-form-label"> Fecha Fin: </label>
                                  <input type="date" id="fecha_fin" name="fecha_fin" class="form-control" value="<?=$fecha_fin?>">
                                </div>
                                <div class="form-group mr-3 ml-3">
                                  <label for="ex4" class="col-form-label"> Usuario: </label>
                                  <select name="usuario" id="usuario" class="form-control" required="">
                                    <option value="">Seleccionar ...</option>
                                    <option value="1">Admin</option> 
                                    <option value="5">Ventas</option>  
                                    <option value="0">Todos</option>  
                                  </select>
                                </div>
                                
                                <div class="form-group">
                                  <button type="submit" class="btn btn-success">Procesar</button>
                                  <a href="<?=base_url()?>/rpt_ventas_diarias_pdf/<?=$fecha_ini?>/<?=$fecha_fin?>/<?=$usuario?>" target="_blank" class="btn btn-danger" <?=$boton?>><i class="fas fa-file-pdf"></i> Generar PDF</a>
                                </div>
                          </form>
                        </div>

                  <div class="card-body">
                    <table id="datatable-rptvtad" class="table table-striped table-bordered  nowrap" cellspacing="0" width="100%">
                      <thead class="bg-dark" style="color: white">
                        <tr>                          
                          <th>Fecha</th>
                          <th>TD</th>
                          <th>Serie</th>
                          <th>Desde</th>
                          <th>Hasta</th>
                          <th>Op. Gravada</th>
                          <th>Op. Inafecta</th>
                          <th>Op. Exonerada</th>
                          <th>IGV</th>
                          <th>Total</th>
                          
                        </tr>
                      </thead>
                      <tbody>
                         <?php foreach($resultado_data as $data ){ ?>
                         
                            
                          <?php 
                          $fecha_dia = $data['fecha'];

                          if($usuario == 0)
                          {
                            $query_tdoc = $connect->prepare("SELECT * FROM vw_tbl_ventas_diarias WHERE  fecha ='$fecha_dia' AND idempresa = $empresa  ORDER BY tipocomp,serie");

                          }
                          else
                          {
                            $query_tdoc = $connect->prepare("SELECT * FROM vw_tbl_ventas_diarias WHERE vendedor='$usuario' and fecha ='$fecha_dia' AND idempresa = $empresa  ORDER BY tipocomp,serie");

                          }
                           
                           $query_tdoc->execute();
                           

                           foreach($query_tdoc as $tdata)
                           {

                            if($usuario == 0)
                            {
                            $query_totales_dia = $connect->prepare("SELECT sum(if(tipocomp='07',-op_gravadas,op_gravadas)) as op_gravadas,
                            sum(if(tipocomp='07',-op_exoneradas,op_exoneradas)) as op_exoneradas,
                            sum(if(tipocomp='07',-op_inafectas,op_inafectas)) as op_inafectas,
                            sum(if(tipocomp='07',-igv,igv)) as igv,
                            sum(if(tipocomp='07',-total,total)) as total
                            FROM vw_tbl_ventas_diarias WHERE  fecha = '$fecha_dia' AND idempresa = $empresa ");
                            }
                            else
                            {
                              $query_totales_dia = $connect->prepare("SELECT sum(if(tipocomp='07',-op_gravadas,op_gravadas)) as op_gravadas,
                            sum(if(tipocomp='07',-op_exoneradas,op_exoneradas)) as op_exoneradas,
                            sum(if(tipocomp='07',-op_inafectas,op_inafectas)) as op_inafectas,
                            sum(if(tipocomp='07',-igv,igv)) as igv,
                            sum(if(tipocomp='07',-total,total)) as total
                            FROM vw_tbl_ventas_diarias WHERE vendedor='$usuario' and fecha = '$fecha_dia' AND idempresa = $empresa ");
                            }

                            
                            $query_totales_dia->execute();
                            $row_td = $query_totales_dia->fetch(PDO::FETCH_ASSOC);

                                            if($tdata['tipocomp']=='07')
                                            {
                                              $op_gravadas = -($tdata['op_gravadas']);
                                              $op_exoneradas = -($tdata['op_exoneradas']);
                                              $op_inafectas = -($tdata['op_inafectas']);
                                              $igv = -($tdata['igv']);
                                              $total = -($tdata['total']);
                                            }
                                            else
                                            {
                                              $op_gravadas = ($tdata['op_gravadas']);
                                              $op_exoneradas = ($tdata['op_exoneradas']);
                                              $op_inafectas = ($tdata['op_inafectas']);
                                              $igv = ($tdata['igv']);
                                              $total = ($tdata['total']);
                                            }

                          ?>
                                           <tr>
                                            <td><?=$data['fecha']?></td>                        
                                            <td><?=$tdata['tipocomp']?></td>
                                            <td><?=$tdata['serie']?></td>
                                            <td><?=$tdata['desde']?></td>
                                            <td><?=$tdata['hasta']?></td>
                                            <td class="text-right"><?=number_format($op_gravadas,2)?></td>
                                            <td class="text-right"><?=number_format($op_exoneradas,2)?></td>
                                            <td class="text-right"><?=number_format($op_inafectas,2)?></td>
                                            <td class="text-right"><?=number_format($igv,2)?></td>
                                            <td class="text-right"><?=number_format($total,2)?></td>
                                          </tr>
                          <?php } ?>
                          <tr>
                            <td>Total</td>                        
                            <td></td>
                            <td></td>
                            <td></td>
                            <td></td>
                            <td class="text-right"><?=$row_td['op_gravadas']?></td>
                            <td class="text-right"><?=$row_td['op_exoneradas']?></td>
                            <td class="text-right"><?=$row_td['op_inafectas']?></td>
                            <td class="text-right"><?=$row_td['igv']?></td>
                            <td class="text-right"><?=$row_td['total']?></td>
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
      
      </div>
    </div>
     
      <?php include 'views/template/pie.php' ?>
    

      
  </body>
</html>
