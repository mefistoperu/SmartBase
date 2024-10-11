
<?php 
session_start();
$empresa = $_SESSION["id_empresa"];
$usuariov = $_SESSION["id"];
$boton  = 'disabled';

$query_vendedor = "SELECT * FROM tbl_usuarios WHERE id_empresa = $empresa";
$resultado_vendedor=$connect->prepare($query_vendedor);
$resultado_vendedor->execute(); 
$num_reg_vendedor=$resultado_vendedor->rowCount();

if(!empty($_POST))
{
$fecha_ini = $_POST['fecha_ini'];
$fecha_fin = $_POST['fecha_fin'];
$usuario   = $_POST['usuario'];
$boton  = '';

if($usuario == 0)
{
  $query_data = "SELECT * FROM vw_tbl_venta_pago_tipo WHERE fecha_pago BETWEEN '$fecha_ini' AND '$fecha_fin' AND empresa = $empresa  GROUP by  id_usuario , fecha_pago";
}
else
{
  $query_data = "SELECT * FROM vw_tbl_venta_pago_tipo WHERE id_usuario='$usuario' and fecha_pago BETWEEN '$fecha_ini' AND '$fecha_fin' AND empresa = $empresa  GROUP by  id_usuario , fecha_pago";
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
                  <h2 class="h5 page-title">Reporte de ventas Vendedor </h2>
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
                      <div class="col-sm-12">
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
                                <label for="">Vendedor:</label>
                                <select class="form-control select2" name="usuario" id="usuario">
                                
                                <option value="0">--VENDEDOR POR DEFECTO--</option>
                                
                                <?php 
                                while($row_ven = $resultado_vendedor->fetch(PDO::FETCH_ASSOC) )
                                {?>
                                <option value="<?= $row_ven['id_usuario'] ?>"><?=$row_ven['usuario']?></option>;
                                <?php  } ?>
                                </select>
                                
                                </div>
                                
                                <div class="form-group">
                                  <button type="submit" class="btn btn-success mr-3">Procesar</button>
                                 
                                </div>
                          </form>
                        </div>

                  <div class="card-body">
                    <table id="datatable-rptvtad" class="table table-striped table-bordered  nowrap" cellspacing="0" width="100%">
                      <thead class="bg-dark" style="color: white">
                        <tr>                          
                          <th>Fecha</th>
                          <th>ID Usuario</th>
                          <th>Usuario</th>
                          <th>Tipo Pago</th>
                          <th>Importe</th>
                          
                          
                        </tr>
                      </thead>
                      <tbody>
                         <?php foreach($resultado_data as $data ){ ?>
                         
                          <tr>
                           <td class="text-right"><?=$data['fecha_pago']?></td>    
                            <td ss="texclat-left"><?=$data['id_usuario']?></td>
                           <td ss="texclat-left"><?=$data['usuario']?></td>
                            <td class="text-left"><?=$data['tipo_pago']?></td>
                            
                            <td class="text-right"><?=formatMoney($data['importe_pago'])?></td>
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
