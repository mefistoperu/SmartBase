<?php 

$query_almacen = "SELECT * FROM tbl_almacen WHERE empresa = $empresa";
$resultado_almacen=$connect->prepare($query_almacen);
$resultado_almacen->execute(); 
$num_reg_almacen=$resultado_almacen->rowCount();

 ?>
<div class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <form name="form_usuario" id="form_usuario">

    <div class="modal-content">

      <div class="modal-header bg-primary">
        <h4 class="modal-title" id="myModalLabel" style="color: white;">Nuevo Usuario</h4>
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true" style="color: white;">×</span>
        </button>
      </div>
      <div class="modal-body">
        <div class="row">
          <div class="col-sm-6">
            <input type="hidden" name="action"  value="nuevo_usuario">
            <input type="hidden" name="empresa" value="<?=$_SESSION["id_empresa"]?>">
            <label for="">Nombre:</label>
            <input type="text" class="form-control" name="nombre" id="nombre"  onkeyup="javascript:this.value=this.value.toUpperCase();" required="">
          </div>
          <div class="col-sm-6">
            <label for="">Apellido:</label>
            <input type="text" class="form-control" name="apellido" id="apellido"  onkeyup="javascript:this.value=this.value.toUpperCase();" required="">
          </div>
        </div>
        <div class="row">
          <div class="col-sm-6">
            <label for="">Usuario:</label>
            <input type="text" class="form-control" name="user" id="user"  onkeyup="javascript:this.value=this.value.toUpperCase();" required="">
          </div>
          <div class="col-sm-6">
            <label for="">Clave:</label>
            <input type="password" class="form-control" name="clave" id="clave" required="">
          </div>
        </div>
        <div class="row">
          <div class="col-sm-6">
            <label for="">Perfil:</label>
            <select name="perfil" id="pefil" class="form-control select2" required>
              <option value="">Seleccionar Perfil</option>
              <option value="1">Administrador</option>
              <option value="2">Supervisor</option>
              <option value="3">Vendedor</option>
            </select>
          </div>
          <div class="col-sm-6">
            <label for="">Almacen</label>
               <select class="form-control select2" style="width: 100%;" name="almacen" id="almacen">
                          
            <option selected="selected">Seleccionar Almacen</option>
            <?php 
                    while($row_almacen = $resultado_almacen->fetch(PDO::FETCH_ASSOC) )
               {?>
                <option value="<?= $row_almacen['id'] ?>"><?=$row_almacen['nombre']?></option>;
               <?php  } ?>
          </select>
          </div>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-close"></i> Cerrar</button>
        <button type="submit" class="btn btn-success"><i class="fa fa-save"></i> Guardar</button>
      </div>

    </div>
     </form>
  </div>
</div>