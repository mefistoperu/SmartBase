<?php 
session_start();
$empresa = $_SESSION["id_empresa"];
$boton  = 'disabled';

if(!empty($_POST))
{
$fecha_ini = $_POST['fecha_ini'];
$fecha_fin = $_POST['fecha_fin'];
$boton  = '';


$query_data = "SELECT fecha FROM vw_tbl_ventas_diarias WHERE fecha BETWEEN '$fecha_ini' AND '$fecha_fin' AND tipocomp<>'99' GROUP by  fecha";
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
       
           <?php if($_SESSION["perfil"]=='1'){ include 'Views/Templates/menu.php';}
                 else{include 'Views/Templates/menu_ventas.php';} ?>
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
                       <div class="form-group mr-3 ml-3">
                          <label for="ex4" class="col-form-label">Usuario </label>
                          <select name="usuario" id="usuario" class="form-control" required="">
                            <option value="">Seleccionar ...</option>
                            <option value="1">Admin</option> 
                            <option value="5">Ventas</option>  
                          </select>
                        </div>
                        
                        <div class="form-group">
                          <button type="submit" class="btn btn-success">Procesar</button>
                          <a href="<?=base_url()?>/rpt_ventas_diarias_pdf/<?=$fecha_ini?>/<?=$fecha_fin?>" class="btn btn-danger" <?=$boton?>><i class="fa fa-file-pdf-o"></i></a>
                        </div>
                      </form>
                    </div>

                   
                    
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
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
                           $query_tdoc = $connect->prepare("SELECT * FROM vw_tbl_ventas_diarias WHERE fecha ='$fecha_dia' AND tipocomp<>'99' ORDER BY tipocomp,serie");
                           $query_tdoc->execute();
                           

                           foreach($query_tdoc as $tdata)
                           {
                            $query_totales_dia = $connect->prepare("SELECT sum(if(tipocomp='07',-op_gravadas,op_gravadas)) as op_gravadas,
                            sum(if(tipocomp='07',-op_exoneradas,op_exoneradas)) as op_exoneradas,
                            sum(if(tipocomp='07',-op_inafectas,op_inafectas)) as op_inafectas,
                            sum(if(tipocomp='07',-igv,igv)) as igv,
                            sum(if(tipocomp='07',-total,total)) as total
                            FROM vw_tbl_ventas_diarias WHERE fecha = '$fecha_dia'");
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
        <?php include 'Views/Templates/pie.php' ?>
      </div>
    </div>
     
      <?php include 'Views/Templates/footer.php' ?>
    

      
  </body>
</html>
