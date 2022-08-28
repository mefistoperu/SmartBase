<div id="editarAlmacen" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <form name="form_almacen_editar" id="form_almacen_editar">

    <div class="modal-content">

      <div class="modal-header bg-warning">
        <h4 class="modal-title" id="myModalLabel" style="color: white;">Editar Almacen</h4>
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true" style="color: white;">×</span>
        </button>
      </div>
      <div class="modal-body">
        <div class="row">
          <div class="col-sm-6">
            <input type="hidden" name="action"  value="editar_almacen">
            <input type="hidden" name="update_id_almacen" id="update_id_almacen"  value="">
            <label for="">Nombre:</label>
            <input type="text" class="form-control" name="update_nombre" id="update_nombre"  onkeyup="javascript:this.value=this.value.toUpperCase();" required="">
          </div>
          <div class="col-sm-6">
            <label for="">Direccion:</label>
            <input type="text" class="form-control" name="update_direccion" id="update_direccion"  onkeyup="javascript:this.value=this.value.toUpperCase();" required="">
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