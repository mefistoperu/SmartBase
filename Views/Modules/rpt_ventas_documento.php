
<?php 
session_start();
$empresa = $_SESSION["id_empresa"];
$usuariov = $_SESSION["id"];
$boton  = 'disabled';


if(!empty($_POST))
{
$fecha_ini = $_POST['fecha_ini'];
$fecha_fin = $_POST['fecha_fin'];

$boton  = '';


  $query_data = "SELECT 
CONCAT(vc.serie,'-',vc.correlativo) as numero,
vc.id as id,
vc.fecha_emision as fecha,
vc.vendedor as cod_usuario,
CONCAT(tu.nombre_personal,' ',tu.apellido_personal) as usuario,
vc.idcliente as id_cliente,
tc.tipo_doc as tipo_doc,
tc.num_doc as ruc,
tc.nombre_persona as cliente,
if(vc.tipocomp='03','BOLETA DE VENTA ELECTRONICA',IF(vc.tipocomp='01','FACTURA ELECTRONICA',IF(vc.tipocomp='07','NOTA DE CREDITO ELECTRONICA',IF(vc.tipocomp='08','NOTA DE DEBITO ELECTRONICA','NOTA DE VENTA ELECTRONICA')))) AS comprobante,
CONCAT(vc.serie,'-',vc.correlativo) as numero2,
vc.total as total_venta,
vp.fdp as id_fdp,
tp.nombre as nombre_fdp,
vp.importe_pago as importe_pago,
te.nombre as estado
from tbl_venta_cab as vc
LEFT JOIN tbl_usuarios as tu
ON vc.vendedor = tu.id_usuario
LEFT JOIN tbl_contribuyente as tc
ON vc.idcliente = tc.id_persona
LEFT JOIN tbl_estado as te
ON vc.feestado = te.estado
LEFT JOIN tbl_venta_pago as vp
ON vc.id = vp.id_venta
LEFT JOIN tbl_tipo_pago as tp
ON vp.fdp = tp.id
where idempresa = $empresa AND vc.fecha_emision BETWEEN '$fecha_ini' AND '$fecha_fin'";


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
                  <h2 class="h5 page-title">Reporte de ventas por Documento </h2>
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
                                
                                
                                <div class="form-group">
                                  <button type="submit" class="btn btn-success mr-3">Procesar</button>
                                 
                                </div>
                          </form>
                        </div>

                  <div class="card-body">
                    <table id="datatable-rptvtad" class="table table-striped table-bordered  nowrap" cellspacing="0" width="100%">
                      <thead class="bg-dark" style="color: white">
                        <tr>                          
                          <th>Numero</th>
                          <th>#</th>
                          <th>Fecha</th>
                          <th>Usuario</th>
                          <th>Cliente</th>
                          <th>T.D.</th>
                          <th>Num.Doc.</th>
                          <th>Comprobante</th>
                          <th>Numero</th>
                          <th>Total Venta</th>
                          <th>Forma de Pago</th>
                          <th>Importe Pago</th>
                          <th>Estado</th>
                        </tr>
                      </thead>
                      <tbody>
                         <?php foreach($resultado_data as $data ){ ?>
                         
                          <tr>
                           <td class="text-right"><?=$data['numero']?></td>    
                            <td ss="texclat-left"><?=$data['id']?></td>
                           <td ss="texclat-left"><?=$data['fecha']?></td>
                            <td class="text-left"><?=$data['usuario']?></td>
                            <td class="text-left"><?=$data['cliente']?></td>
                            <td class="text-right"><?=$data['tipo_doc']?></td>    
                            <td ss="texclat-left"><?=$data['ruc']?></td>
                           <td ss="texclat-left"><?=$data['comprobante']?></td>
                            <td class="text-left"><?=$data['numero']?></td>
                            <td class="text-right"><?=$data['total_venta']?></td>
                             <td ss="texclat-left"><?=$data['nombre_fdp']?></td>
                            <td class="text-left"><?=$data['importe_pago']?></td>
                            <td class="text-right"><?=$data['estado']?></td>
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
