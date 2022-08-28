<?php

$query_data = "SELECT * FROM tbl_factura_cab WHERE aprobacion = '1'";
$resultado_data=$connect->prepare($query_data);
$resultado_data->execute();
$num_reg_data=$resultado_data->rowCount();

 ?>

<!DOCTYPE html>
<html lang="en">
<head>
    <title><?= empresa() ?> | Envio SUNAT</title>
  <?php include 'Views/Templates/head.php' ?>
  <style>

.hide{
  display:none;}
</style>
</head>
<body class="hold-transition sidebar-mini layout-fixed">
<div class="wrapper">
  <?php include 'Views/Templates/preloader.php' ?>

  <!-- Navbar -->
  <?php include 'Views/Templates/nav.php' ?>

  <?php


     if($_SESSION['perfil'] == '1')
     {
       include 'Views/Templates/aside.php';
       $ok = '';
     }
     else if($_SESSION['perfil'] == '2')
     {
       include 'Views/Templates/aside_vendedor.php';
       $ok = 'disabled';
     }

 ?>

<div class="content-wrapper" style="min-height: 1604.8px;">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1>Envios SUNAT</h1>
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="#">Inicio</a></li>
              <li class="breadcrumb-item active">Envios SUNAT</li>
            </ol>
          </div>
        </div>
      </div><!-- /.container-fluid -->
    </section>

    <!-- Main content -->
    <section class="content">

      <!-- Default box -->
      <div class="card">
        <div class="card-header">
          <h3 class="card-title">
            <a class="btn btn-primary disabled" href="nueva_venta" ><i class="fas fa-plus"></i> EnviosSUNAT</a></h3>


        </div>
        <div class="card-body">
      <table id="tblistado" class="table table-striped table-bordered dt-responsive nowrap" style="width:100%">

         <thead style="font-size: 12px">
           <tr>
             <th width="10%">Id</th>
             <th>Fecha</th>
             <th>Razon Social</th>
             <th>Num. Doc</th>
             <th>Base Imp.</th>
             <th>I.G.V.</th>
             <th>Total</th>
             <th>Estado SUNAT</th>
             <th>Acciones</th>
             <th>Documentos</th>


           </tr>
         </thead>
         <tbody style="font-size: 12px">
<?php while($data = $resultado_data->fetch(PDO::FETCH_ASSOC) )
  { ?>
   <tr>
    <td style="width: 10%"><?php echo $data['id_factura'] ?></td>
    <td><?php echo $data['fecha_emision'] ?></td>
    <td><?php echo $data['nombre_cliente'] ?></td>
    <td><?php echo $data['documento'] ?></td>
    <td align="right"><?php echo ($data['subtotal']) ?></td>
    <td align="right"><?php echo $data['igv'] ?></td>
    <td align="right"><?php echo $data['total'] ?></td>
    <td><?php $estado = $data['estado_sunat'];
    if($estado == '1')
    {
      $estado = 'ACTIVO';
      $color = 'success';
      $anu = '';
    }
    else
    {
      $estado = 'ANULADO';
      $color = 'danger';
      $anu = '';
     
    } ?> <button class="btn btn-<?=$color?> btn-sm"><?=$estado?></button>
    
  </td>
<td><a class="btn btn-secondary rounded-circle" onclick="openModalEnvia()"><i class="fas fa-paper-plane"></i></a></td>
    <td style="width: 15%">
    <a href="editar_venta/<?=$data['id_factura']?>" class="btn btn-primary rounded-circle"><i class="fas fa-file-excel"></i></a>

    <a  class="btn btn-success rounded-circle" onclick="openModalDel()"><i class="fas fa-file-alt" readonly></i></a>
    <a  class="btn btn-danger rounded-circle <?=$ok?>" onclick="openModalOk()"><i class="fas fa-file-pdf"></i></a>
</td>
  </tr>


   <?php } ?>
         </tbody>
       </table>
        </div>
        <!-- /.card-body -->

        <!-- /.card-footer-->
      </div>
      <!-- /.card -->

    </section>
    <!-- /.content -->
  </div>

    <?php include 'Views/Templates/footer.php' ?>
    <?php include 'Views/Modules/Modals/envia_venta.php' ?>
   

   <script src="<?=media()?>/js/tablas.js"></script>

   <script src="Assets/js/ventas.js"></script>
<script src="Assets/js/funciones_ventas.js"></script>
</body>
</html>
