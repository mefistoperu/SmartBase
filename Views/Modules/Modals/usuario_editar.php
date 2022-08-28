<div class="modal fade updateUsuario" id="updateUsuario" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog">
    <form name="update_usuario" id="update_usuario">

    <div class="modal-content">

      <div class="modal-header bg-warning">
        <h4 class="modal-title" id="myModalLabel" style="color: white;">Editar Usuario</h4>
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true" style="color: white;">×</span>
        </button>
      </div>
      <div class="modal-body">
        <div class="row">
          <div class="col-sm-6">
            <input type="hidden" name="action"  value="editar_usuario">
            <input type="hidden" name="empresa_update" value="<?=$_SESSION["id_empresa"]?>">
            <input type="hidden" name="id_update" id="id_update" value="">
            <label for="">Nombre:</label>
            <input type="text" class="form-control" name="nombre_update" id="nombre_update"  onkeyup="javascript:this.value=this.value.toUpperCase();" required="">
          </div>
          <div class="col-sm-6">
            <label for="">Apellido:</label>
            <input type="text" class="form-control" name="apellido_update" id="apellido_update"  onkeyup="javascript:this.value=this.value.toUpperCase();" required="">
          </div>
        </div>
        <div class="row">
          <div class="col-sm-6">
            <label for="">Usuario:</label>
            <input type="text" class="form-control" name="user_update" id="user_update"  onkeyup="javascript:this.value=this.value.toUpperCase();" required="" readonly="">
          </div>
          <div class="col-sm-6">
            <label for="">Clave:</label>
            <input type="password" class="form-control" name="clave_update" id="clave_update" required="" min="8">
          </div>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-close"></i> Cerrar</button>
        <button type="submit" class="btn btn-success"><i class="fa fa-save"></i> Actualizar</button>
      </div>

    </div>
     </form>
  </div>
</div>