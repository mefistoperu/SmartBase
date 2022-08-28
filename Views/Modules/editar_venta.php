<?php

$id_factura = $rutas[1];

$hoy = date('d-m-Y');
$usuario_id = $_SESSION["id_usuario"];

$query_factura_cab = "SELECT * FROM tbl_factura_cab WHERE id_factura = '$id_factura'";
$resultado_factura_cab = $connect->prepare($query_factura_cab);
$resultado_factura_cab->execute();
$row_factura_cab = $resultado_factura_cab->fetch(PDO::FETCH_ASSOC);

$query_factura_det = "SELECT * FROM tbl_factura_det WHERE id_factura_cab = '$id_factura'";
$resultado_factura_det = $connect->prepare($query_factura_det);
$resultado_factura_det->execute();


$doc_cli = $row_factura_cab["id_cliente"];

$tpcpe = $row_factura_cab["tipo_cpe"];

if($tpcpe == '01')
{
  $tipo_cpe_nombre = 'FACTURA ELECTRONICA';
}
else if($tpcpe == '03')
{
    $tipo_cpe_nombre = 'BOLETA DE VENTA ELECTRONICA';
}

$query_persona = "SELECT * FROM tbl_persona WHERE id_persona='$doc_cli'";
$resultado_persona = $connect->prepare($query_persona);
$resultado_persona->execute();
$row_persona = $resultado_persona->fetch(PDO::FETCH_ASSOC);

$query_tipo_cpe = "SELECT * FROM tbl_tipo_cpe WHERE fe_cpe='1' AND codigo_cpe IN ('01','03')";
$resultado_tipo_cpe=$connect->prepare($query_tipo_cpe);
$resultado_tipo_cpe->execute();
$num_reg_tipo_cpe=$resultado_tipo_cpe->rowCount();

$query = "SELECT * FROM tbl_configuracion";
$resultado = $connect->prepare($query);
$resultado->execute();
$row = $resultado->fetch(PDO::FETCH_ASSOC);

$tipocpe = $row['cod_cpe'];

$query_serie = "SELECT * FROM vw_tbl_serie_usuario WHERE cod_doc='$tipocpe' and usuario='$usuario_id'";
$resultado_serie = $connect->prepare($query_serie);
$resultado_serie->execute();
$row_serie = $resultado_serie->fetch(PDO::FETCH_ASSOC);


 ?>
<!DOCTYPE html>
<html lang="en">
<head>
    <title><?= empresa() ?> | Editar Venta</title>
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
            <h1>Nueva Venta</h1>
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="#">Inicio</a></li>
              <li class="breadcrumb-item active">Editar Venta</li>
            </ol>
          </div>
        </div>
      </div><!-- /.container-fluid -->
    </section>

    <!-- Main content -->
    <section class="content">


      <!-- Default box -->
 <form action="" name="editar_venta" id="editar_venta">

<div class="card">
        <div class="card-header">
          <h3 class="card-title">
            Editar Venta
          </h3>
        </div>
<div class="card-body">
         <div class="row">
          <div class="col-sm-2">
              <label for="">RUC / DNI: </label>
              <input type="hidden" name="action" value="editVenta">
              <input type="hidden" name="id_factura" value="<?= $id_factura ?>">
              <input type="hidden" name="vendedor" value="<?=$usuario_id?>" id="vendedor">
              <input type="hidden" name="cod_cliente" id="cod_cliente" value="<?=$doc_cli?>">
            <input type="text" name="nit_cliente" maxlength="11" minlength="8" id="nit_cliente" class="form-control" required="" readonly  value="<?=$row_persona['num_doc']?>">
          </div>
          <div class="col-sm-10">
              <label for="">Razon Social : </label>

            <input type="text" name="proveedor" id="proveedor" class="form-control" require readonly onkeyup="javascript:this.value=this.value.toUpperCase();" value="<?=$row_persona['nombre_persona']?>">
          </div>


      </div>
<div class="row">
            <div class="col-sm-3">

                  <label>Fecha:</label>

                  <div class="input-group">
                    <div class="input-group-prepend">
                      <span class="input-group-text"><i class="far fa-calendar-alt"></i></span>
                    </div>
                   <input id="test1" name="fecha" class="form-control" value="<?=$row_factura_cab["fecha_emision"]?>" readonly>
                  </div>

          </div>
          <div class="col-sm-3">

              <label for="">Tipo Cpe :</label>
<input type="text" name="tip_cpe" name="tip_cpe" class="form-control" value="<?=$tipo_cpe_nombre?>" readonly>
          </div>
          <div class="col-sm-3">
              <label for="">Serie : </label>
              <input type="text" name="serie" id="serie" maxlength="4" class="form-control" required="" readonly="" value="<?=$row_factura_cab["serie_cpe"]?>">
          </div>
          <div class="col-sm-3">
              <label for="">Número : </label>
              <input type="text" step="any" name="numero" id="numero" maxlength="8" class="form-control text-right" required="" readonly="" value="<?=$row_factura_cab["numero_cpe"]?>">
          </div>
</div>


<hr>
<div class="row">
  <div class="col-sm-12">
    <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#addProdcuto"><i class="fas fa-plus"></i> Agregar Producto</button>
  </div>
</div>
<hr>
<div class="row">
  <div class="col-sm-12">
     <table id="tabla" class="table table-striped table-bordered table-condensed table-hover dataTable">
        <thead>
    <tr>
      <td width="10%">Opciones</td>
      <td width="10%">Orden</td>
      <td width="50%">Nombre</td>
      <td width="10%">Cantidad</td>
      <td width="10%">Unidad</td>
      <td width="10%">P.U.</td>
      <td>Total</td>
    </tr>
  </thead>
  <tbody style="font-size: 12px">
<?php while($data = $resultado_factura_det->fetch(PDO::FETCH_ASSOC) )
{ ?>
<tr id="fila<?=$data['item']?>">
           <td><button type="button" class="btn btn-danger" onclick="eliminar(<?=$data['item']?>)"><i class="fa fa-trash"></i></button></td>
           <td><?=$data['item']?></td>
           <td><input type="hidden" name="itemarticulo[]" value="<?=$data['item']?>">
               <input type="hidden" name="idarticulo[]" value="<?=$data['codigo']?>">
               <input type="hidden" name="nomarticulo[]" value="<?=$data['descripcion']?>"> <?= $data['descripcion'] ?></td>
           <td><input type="hidden" name="precio_compra[]" value="<?=$data['precio_compra']?>">
               <input type="hidden" name="factor[]" value="<?=$data['factor']?>">
               <input type="text" min="1" class="form-control input-sm" name="cantidad[]" id="cantidad[]" value="<?=$data['cantidad_factor']?>" onkeypress="return valideKey(event);" oninput='input(this)'  onkeyup="modificarSubtotales()"></td>
           <td><input type="text" min="1" class="form-control input-sm" name="cantidadu[]" id="cantidadu[]" value="<?=$data['cantidad_unitario']?>" onkeypress="return valideKey(event);" oninput='input(this)' onkeyup="modificarSubtotales()"></td>
           <td><input type="hidden" class="form-control input-sm" name="valor_unitario[]" id="valor_unitario[]" value="<?=$data['valor_unitario']?>" readonly>
               <input type="hidden" class="form-control input-sm" name="igv_unitario[]" id="igv_unitario[]" value="<?=$data['igv']?>" readonly>
               <input type="text" class="form-control input-sm" name="precio_venta[]" id="precio_venta[]" value="<?=$data['precio_unitario']?>" readonly></td>
           <td><span id="subtotal<?=$data['item']?>" name="subtotal"><?=$data['importe_total']?></span>
               <input type="hidden" id="afectacion<?=$data['item']?>" name="afectacion[]" class="form-control input-sm" value="<?=$data['codigo_afectacion_alt']?>"></td>
</tr>


<?php } ?>
  </tbody>
    </table>
  <table class="table table-striped table-bordered table-condensed table-hover dataTable">
    <thead>
      <tr>
        <th width="20%"></th>
        <th width="20%"></th>
        <th width="20%"></th>
        <th>Op. Gravadas</th>
        <td colspan="2"><input type="text" class="form-control text-right"  readonly="" name="op_g" id="op_g" value="<?=$row_factura_cab["op_gravadas"]?>"></td>

      </tr>
       <tr>
        <th width="20%"></th>
        <th width="20%"></th>
        <th width="20%"></th>
        <th>Op. Exoneradas</th>
        <td colspan="2"><input type="text" class="form-control text-right" value="<?=$row_factura_cab["op_exoneradas"]?>" readonly="" name="op_e" id="op_e"></td>

      </tr>
       <tr>
        <th width="20%"></th>
        <th width="20%"></th>
        <th width="20%"></th>
        <th>Op. Inafectas</th>
        <td colspan="2"><input type="text" class="form-control text-right" value="<?=$row_factura_cab["op_inafectas"]?>" readonly="" name="op_i" id="op_i"></td>

      </tr>
       <tr>
        <th width="20%"></th>
        <th width="20%"></th>
        <th width="20%"></th>
        <th>Sub - Total</th>
        <td colspan="2"><input type="text" class="form-control text-right" value="<?=$row_factura_cab["subtotal"]?>" readonly="" name="subt" id="subt"></td>

      </tr>
       <tr>
        <th width="20%"></th>
        <th width="20%"></th>
        <th width="20%"></th>
        <th>I.G.V.</th>
        <td colspan="2"><input type="text" class="form-control text-right" value="<?=$row_factura_cab["igv"]?>" readonly="" name="igv" id="igv"></td>

      </tr>
       <tr>
        <th width="20%"></th>
        <th width="20%"></th>
        <th width="20%"></th>
        <th>Total</th>
        <td colspan="2"><input type="text" class="form-control text-right" value="<?=$row_factura_cab["total"]?>" readonly="" name="total" id="total"></td>

      </tr>
    </thead>


  </table>

  </div>
</div>

</div>
  <div class="card-footer text-muted">
            <a href="<?=base_url()?>/ventas" class="btn btn-danger" data-dismiss="modal"><i class="fas fa-times-circle"></i> Cancelar</a>
        <button type="submit" class="btn btn-success btnGuardar" id="btnGuardar"><i class="fas fa-save"></i> Actualizar</button>
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
<script src="<?=media()?>/js/funciones_ventas.js"></script>
<script src="<?=media()?>/js/ventas.js"></script>

<?php include 'Views/Modules/Modals/add_articulos_venta.php' ?>
   <script src="<?=media()?>/js/tablas.js"></script>
<script>
    console.log(navigator.userAgent);
    $("#test1").inputmask("datetime", {
        inputFormat: "yyyy-mm-dd",
        outputFormat: "mm-yyyy-dd",
        inputEventOnly: true
    });
</script>
</body>
</html>
