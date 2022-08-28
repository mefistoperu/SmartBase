<?php 

$query_data = "SELECT * FROM tbl_configuracion";
$resultado_data=$connect->prepare($query_data);
$resultado_data->execute();
$num_reg_data=$resultado_data->rowCount();

 ?>

<!DOCTYPE html>
<html lang="en">
<head>
    <title><?= empresa() ?> | Configuracion</title>
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

    <?php include 'Views/Templates/aside.php' ?>

<div class="content-wrapper" style="min-height: 1604.8px;">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <div class="container-fluid">
        <div class="row mb-2">
          <div class="col-sm-6">
            <h1>Configuracion</h1>
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="#">Inicio</a></li>
              <li class="breadcrumb-item active">Configuracion</li>
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
            <a class="btn btn-primary" href="#" ><i class="fas fa-plus"></i> Agregar</a></h3>

         
        </div>
        <div class="card-body">
      <table id="tblistado" class="table table-striped table-bordered dt-responsive nowrap" style="width:100%">

         <thead style="font-size: 12px">
           <tr>
             <th width="10%">Id</th>
             <th>Ruc</th>
             <th>Razon Social</th>
             <th>Telefono</th>
             <th>Estado</th>
             <th>Acciones</th>
            
          
           </tr>
         </thead>
         <tbody style="font-size: 12px">
<?php while($data = $resultado_data->fetch(PDO::FETCH_ASSOC) )
  { ?>
   <tr>
    <td style="width: 10%"><?php echo $data['id_empresa'] ?></td>
    <td><?php echo $data['ruc_empresa'] ?></td>
    <td><?php echo $data['nombre_empresa'] ?></td>
    <td><?php echo $data['telefono'] ?></td>
    <td><?php $estado = $data['estado'];
    if($estado == '1')
    {
      $color = 'success';
      $estado =  'ACTIVO';
    }
    else 
    {
      $color = 'danger';
      $estado = 'INACTIVO';
    } ?> <button class="btn btn-<?=$color?>"><?=$estado?></button></td>
     
    <td style="width: 15%">
    <a href="editar_configuracion/<?=$data['id_empresa']?>" class="btn btn-warning"><i class="fas fa-edit"></i></a>
  
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
    <?php include 'Views/Modules/Modals/marcas.php' ?>

   <script src="<?=media()?>/js/tablas.js"></script>

   <script src="Assets/js/marca.js"></script>
<script src="Assets/js/funciones_marca.js"></script>
</body>
</html>
