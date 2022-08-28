<?php 

$id = $rutas[1];

$query_configuracion = "SELECT * FROM tbl_configuracion WHERE id_empresa ='$id'";
$resultado = $connect->prepare($query_configuracion);
$resultado->execute();
$row_configuracion = $resultado->fetch(PDO::FETCH_ASSOC);


?>
<!DOCTYPE html>
<html lang="en">
<head>
    <title><?= empresa() ?> | Editar Configuracion</title>
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
            <h1>Editar Configuracion</h1>
          </div>
          <div class="col-sm-6">
            <ol class="breadcrumb float-sm-right">
              <li class="breadcrumb-item"><a href="#">Inicio</a></li>
              <li class="breadcrumb-item active">Editar Configuracion</li>
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
            Editar Configuracion
          </h3>         
        </div>
<div class="card-body">
     
    <div class="row">
    <div class="col-12 col-sm-12 col-md-12 col-lg-12">
      <div class="card">
        <div class="card-header">
          <ul class="nav nav-tabs card-header-tabs" id="bologna-list" role="tablist">
            <li class="nav-item">
              <a class="nav-link active" href="#description" role="tab" aria-controls="description" aria-selected="true">Empresa</a>
            </li>
            <li class="nav-item">
              <a class="nav-link"  href="#history" role="tab" aria-controls="history" aria-selected="false">Contabilidad</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#deals" role="tab" aria-controls="deals" aria-selected="false">Facturacion Electronica</a>
            </li>
          </ul>
        </div>
<div class="card-body">
                  
  <div class="tab-content mt-3">
    <div class="tab-pane active" id="description" role="tabpanel">
      <div class="row">
        <div class="col-sm-3">
          <label for="">RUC</label>
          <input type="text" class="form-control" maxlength="11" value="<?=$row_configuracion['ruc']?>" onkeypress="return valideKey(event);">
        </div>
        <div class="col-sm-9">
          <label for="">Razon Social</label>
          <input type="text" class="form-control" value="<?=$row_configuracion['nombre_empresa']?>" maxlength="100">
        </div>
      </div>
      <div class="row">
     <div class="col-sm-12"><label for="">Direccion :</label>
      <input type="text" class="form-control" value="<?=$row_configuracion['direccion']?>" maxlength="100">
    </div>
      </div>
      <div class="row">
        <div class="col-sm-3"><label for="">Ubigeo :</label>
        <input type="text" class="form-control" value="<?=$row_configuracion['ubigeo']?>" maxlength="6" onkeypress="return valideKey(event);" >
      </div>
        <div class="col-sm-3"><label for="">Departamento :</label>
        <input type="text" class="form-control" value="<?=$row_configuracion['departamento']?>" maxlength="50">
      </div>
        <div class="col-sm-3"><label for="">Provincia :</label>
        <input type="text" class="form-control" value="<?=$row_configuracion['provincia']?>" maxlength="50">
      </div>
        <div class="col-sm-3"><label for="">Distrito :</label>
        <input type="text" class="form-control" value="<?=$row_configuracion['distrito']?>" maxlength="50">
      </div>
      </div>
      <div class="row">
        <div class="col-sm-6"><label for="">Correo : </label>
          <input type="text" class="form-control" value="<?=$row_configuracion['correo']?>" maxlength="100"></div>
        <div class="col-sm-6"><label for="">Telefono :</label>
          <input type="text" class="form-control" value="<?=$row_configuracion['telefono']?>" maxlength="20" onkeypress="return valideKey(event);"></div>
      </div>
    </div>
             
    <div class="tab-pane" id="history" role="tabpanel" aria-labelledby="history-tab">  
           <div class="row">
             <div class="col-sm-4">
              <label for="">Cuenta Ventas Soles :</label>
              <input type="text" class="form-control" value="<?=$row_configuracion['cuenta_12_s']?>" maxlength="7" onkeypress="return valideKey(event);">
            </div>
             <div class="col-sm-4">
              <label for="">Cuenta Ventas Dolares :</label>
              <input type="text" class="form-control" value="<?=$row_configuracion['cuenta_12_d']?>" maxlength="7" onkeypress="return valideKey(event);">
            </div>
            <div class="col-sm-4">
              <label for="">Diario Ventas :</label>
              <input type="text" class="form-control" value="<?=$row_configuracion['diario_ventas']?>" maxlength="2" onkeypress="return valideKey(event);">
            </div>
           </div>
<div class="row">
             <div class="col-sm-4">
              <label for="">Cuenta Compras Soles :</label>
              <input type="text" class="form-control" value="<?=$row_configuracion['cuenta_42_s']?>" maxlength="7" onkeypress="return valideKey(event);">
            </div>
             <div class="col-sm-4">
              <label for="">Cuenta Compras Dolares :</label>
              <input type="text" class="form-control" value="<?=$row_configuracion['cuenta_42_d']?>" maxlength="7" onkeypress="return valideKey(event);">
            </div>
            <div class="col-sm-4">
              <label for="">Diario Compras :</label>
              <input type="text" class="form-control" value="<?=$row_configuracion['diario_compras']?>" maxlength="2" onkeypress="return valideKey(event);">
            </div>
</div>
<div class="row">
  <div class="col-sm-4">
    <label for="">Cuenta I.G.V. :</label>
    <input type="text" class="form-control" value="<?=$row_configuracion['cuenta_igv']?>" maxlength="7" onkeypress="return valideKey(event);">
  </div>
  <div class="col-sm-4">
    <label for="">I.G.V. :</label>
    <input type="text" class="form-control text-right" value="<?=$row_configuracion['por_igv']?>" onkeypress="return valideKey(event);" oninput='input(this)'>
  </div>
</div>
    </div>
             
    <div class="tab-pane" id="deals" role="tabpanel" aria-labelledby="deals-tab">
            <div class="row">
              <div class="col-sm-6">
                <label for="">Usuario SOL</label>
                <input type="text" class="form-control" value="<?=$row_configuracion['usuario_sol']?>">
              </div>
              <div class="col-sm-6">
                <label for="">Clave SOL</label>
                <input type="text" class="form-control" value="<?=$row_configuracion['clave_sol']?>">
              </div>
            </div>
            <div class="row">
              <div class="col-sm-6">
                <label for="">Certificado :</label>
                <input type="text" class="form-control" value="<?=$row_configuracion['certificado']?>">
              </div>
              <div class="col-sm-6">
                <label for="">Clave Certificado :</label>
                <input type="text" class="form-control" value="<?=$row_configuracion['clave_certificado']?>">
              </div>
            </div>
    </div>
  </div>
</div>

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

<script>
  $('#bologna-list a').on('click', function (e) {
  e.preventDefault()
  $(this).tab('show')
})
</script>
</body>
</html>
