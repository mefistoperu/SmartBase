<?php 

$query_data = "SELECT * FROM vw_tbl_unidad";
$resultado_data=$connect->prepare($query_data);
$resultado_data->execute();
$num_reg_data=$resultado_data->rowCount();

 ?>

<!DOCTYPE html>
<html lang="en">
<head>
    <title><?= empresa() ?> | Unidad de medida</title>
  <?php include 'Views/Templates/head.php' ?>
  <style>
  .ajaxgif{
  position:absolute; bottom:12px; right:-20px;}
.hide{
  display:none;}
</style>
</head>
<body class="hold-transition sidebar-mini layout-fixed">
<div class="wrapper">
  <?php include 'Views/Templates/preloader.php' ?>

  <!-- Navbar -->
  <?php include 'Views/Templates/nav.php' ?>

    <?php include 'Views/Templates/aside.php' ?>

<div class="content-wrapper" style="min-height: 1604.8px;">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1>Unidad de medida</h1>
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="#">Inicio</a></li>
              <li class="breadcrumb-item active">Unidad de medida</li>
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
            <button class="btn btn-primary"  data-toggle="modal" data-target="#ModalUnidad"><i class="fas fa-plus"></i> Agregar</button></h3>

         
        </div>
        <div class="card-body">
      <table id="tblistado" class="table table-striped table-bordered dt-responsive nowrap" style="width:100%">

         <thead>
           <tr>
             <th>Id</th>
             <th>Nombre</th>
             <th>Codigo</th>
             <th>Factor</th>
              <th>Estado</th>
             <th>Acciones</th>
           </tr>
         </thead>
         <tbody>
<?php while($data = $resultado_data->fetch(PDO::FETCH_ASSOC) )
  { ?>
   <tr>
    <td style="width: 10%"><?php echo $data['id_unidad'] ?></td>
    <td><?php echo $data['nombre_unidad'] ?></td>
    <td><?= $data['codigo_unidad']?></td>
    <td align="right"><?= $data['factor']?></td>
     <td><?php $estado = $data['estado'];
    if($estado == 'ACTIVO')
    {
      $color = 'success';
    }
    else 
    {
      $color = 'danger';
    } ?> <button class="btn btn-<?=$color?>"><?=$estado?></button></td>
    <td style="width: 15%">
    <button type="button" class="btn btn-warning editbtn" onclick="openModalEdit()"><i class="fas fa-edit"></i></button>
  
    <a href="#" class="btn btn-danger" onclick="openModalDel()"><i class="fas fa-trash-alt" readonly></i></a></td>
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
    <?php include 'Views/Modules/Modals/unidad.php' ?>

   <script src="<?=media()?>/js/tablas.js"></script>

   <script src="Assets/js/unidad.js"></script>
<script src="Assets/js/funciones_unidad.js"></script>
</body>
</html>
