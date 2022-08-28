<?php

$id = $rutas[1];

$query_articulos = "SELECT * FROM tbl_articulo WHERE id_articulo ='$id'";
$resultado = $connect->prepare($query_articulos);
$resultado->execute();
$row_articulo = $resultado->fetch(PDO::FETCH_ASSOC);


$query_categoria = "SELECT * FROM tbl_categorias WHERE estado='1'";
$resultado_categoria=$connect->prepare($query_categoria);
$resultado_categoria->execute();
$num_reg_categoria=$resultado_categoria->rowCount();

$query_marca = "SELECT * FROM tbl_marcas WHERE estado='1'";
$resultado_marca=$connect->prepare($query_marca);
$resultado_marca->execute();
$num_reg_marca=$resultado_marca->rowCount();

$query_unidad = "SELECT * FROM tbl_unidad WHERE estado='1'";
$resultado_unidad=$connect->prepare($query_unidad);
$resultado_unidad->execute();
$num_reg_unidad=$resultado_unidad->rowCount();

$query_afectacion = "SELECT * FROM tbl_tipo_afectacion ";
$resultado_afectacion=$connect->prepare($query_afectacion);
$resultado_afectacion->execute();
$num_reg_afectacion=$resultado_afectacion->rowCount();


?>
<!DOCTYPE html>
<html lang="en">
<head>
    <title><?= empresa() ?> | Editar Articulo</title>
  <?php include 'Views/Templates/head.php' ?>
  <style>

.hide{
  display:none;}
</style>
<script type="text/javascript">
function valideKey(evt){

    // code is the decimal ASCII representation of the pressed key.
    var code = (evt.which) ? evt.which : evt.keyCode;

    if(code==8) { // backspace.
      return true;
    } else if(code>=46 && code<=57 && code!=47) { // is a number.
      return true;

    } else{ // other keys.
      return false;
    }
}


var delayTimer;
function input(ele)
{
    if(ele.value=="")
    {
      //ele.value=0.00;

  clearTimeout(delayTimer);
    delayTimer = setTimeout(function()
    {
       ele.value =0.00;
       ele.value = parseFloat(ele.value).toFixed(2).toString();
    }, 800);
    }
   else
   {
     clearTimeout(delayTimer);
    delayTimer = setTimeout(function()
    {
       ele.value = parseFloat(ele.value).toFixed(2).toString();
    }, 800);
   }
}
</script>
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
            <h1>Editar Articulo</h1>
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="#">Inicio</a></li>
              <li class="breadcrumb-item active">Editar Ariculo</li>
            </ol>
          </div>
        </div>
      </div><!-- /.container-fluid -->
    </section>

    <!-- Main content -->
    <section class="content">

      <!-- Default box -->
 <form action="" name="form_edi_articulo" id="form_edi_articulo">

<div class="card">
        <div class="card-header">
          <h3 class="card-title">
            Editar Articulo
          </h3>
        </div>
<div class="card-body">
         <div class="row">
          <div class="col-sm-12">
              <label for="">Nombre Articulo</label>
              <input type="hidden" name="action" value="ediArticulo">
              <input type="hidden" name="id" id="id" value="<?=$id?>">
            <input type="text" name="nombre" id="nombre" class="form-control" required="" onkeyup="javascript:this.value=this.value.toUpperCase();" value="<?=$row_articulo['nombre_articulo']?>">
          </div>
      </div>
      <div class="row">
          <div class="col-sm-12">
              <label for="">Descripcion</label>

            <input type="text" name="descripcion" id="descripcion" class="form-control" required="" maxlength="100" onkeyup="javascript:this.value=this.value.toUpperCase();" value="<?=$row_articulo['descripcion_articulo']?>">
          </div>
      </div>
 <!-- /.inicio -->

            <div class="row">
          <div class="col-sm-6">
              <label for="">Categoria</label>
    <select class="form-control select2" style="width: 100%;" name="categoria" id="categoria">

    <option selected="selected">Seleccionar Categoria</option>
    <?php
            while($row_categoria = $resultado_categoria->fetch(PDO::FETCH_ASSOC) )
       {?>
        <option value="<?php echo $row_categoria['id_categoria']?>"<?php if (!(strcmp($row_articulo['categoria'],$row_categoria['id_categoria'] ))) {?> selected="selected"<?php ; } ?>><?php echo $row_categoria['nombre_categoria']?></option>
       <?php  } ?>
  </select>
          </div>
           <div class="col-sm-6">
              <label for="">Marca</label>
       <select class="form-control select2" style="width: 100%;" name="marca" id="marca">

    <option selected="selected">Seleccionar Marca</option>
    <?php
            while($row_marca = $resultado_marca->fetch(PDO::FETCH_ASSOC) )
       {?>
       <option value="<?php echo $row_marca['id_marca']?>"<?php if (!(strcmp($row_articulo['marca'],$row_marca['id_marca'] ))) {?> selected="selected"<?php ; } ?>><?php echo $row_marca['nombre_marca']?></option>
       <?php  } ?>
  </select>
          </div>
      </div>
 <!-- /.fin -->

            <div class="row">
          <div class="col-sm-6">
              <label for="">Unidad</label>
   <select class="form-control select2" style="width: 100%;" name="unidad" id="unidad">

    <option selected="selected">Seleccionar Unidad</option>
    <?php
            while($row_unidad = $resultado_unidad->fetch(PDO::FETCH_ASSOC) )
       {?>
             <option value="<?php echo $row_unidad['id_unidad']?>"<?php if (!(strcmp($row_articulo['unidad'],$row_unidad['id_unidad'] ))) {?> selected="selected"<?php ; } ?>><?php echo $row_unidad['codigo_unidad']?></option>
       <?php  } ?>
  </select>
          </div>
           <div class="col-sm-6">
              <label for="">Afectacion</label>

              <select class="form-control select2" style="width: 100%;" name="afectacion" id="afectacion">

    <option selected="selected">Seleccionar Tipo Afectacion</option>
    <?php
            while($row_afectacion = $resultado_afectacion->fetch(PDO::FETCH_ASSOC) )
       {?>
            <option value="<?php echo $row_afectacion['id_tipo_afectacion']?>"<?php if (!(strcmp($row_articulo['afectacion'],$row_afectacion['id_tipo_afectacion'] ))) {?> selected="selected"<?php ; } ?>><?php echo $row_afectacion['descripcion_tipo_afectacion']?></option>
       <?php  } ?>
  </select>
          </div>
      </div>
      <div class="row">
          <div class="col-sm-6">
              <label for="">Precio Compra</label>

            <input type="text" onkeypress="return valideKey(event);" oninput='input(this)' name="precio_compra" id="precio_compra" class="form-control text-right" required="" value="<?=$row_articulo['precio_compra']?>">
          </div>
           <div class="col-sm-6">
              <label for="">Precio Venta</label>

            <input type="text" onkeypress="return valideKey(event);" oninput='input(this)' name="precio_venta" id="precio_venta" class="form-control text-right" required="" value="<?=$row_articulo['precio_venta']?>">
          </div>
      </div>


</div>
  <div class="card-footer text-muted">
            <button type="button" class="btn btn-danger" data-dismiss="modal">Cerrar</button>
        <button type="submit" class="btn btn-success">Actualizar</button>
        <div class="col-sm-4">
            <img src="<?= base_url()?>/Assets/js/ajax.gif" class="ajaxgif hide" width="100%">
          </div>
  </div>

</div>
      <!-- /.card -->
</form>

    </section>
    <!-- /.content -->
  </div>

    <?php include 'Views/Templates/footer.php' ?>
<script src="<?= base_url()?>/Assets/js/funciones_articulo.js"></script>
</body>
</html>
