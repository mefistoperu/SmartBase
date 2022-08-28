<div class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <form name="form_almacen" id="form_almacen">

    <div class="modal-content">

      <div class="modal-header bg-primary">
        <h4 class="modal-title" id="myModalLabel" style="color: white;">Nuevo Almacen</h4>
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true" style="color: white;">×</span>
        </button>
      </div>
      <div class="modal-body">
        <div class="row">
          <div class="col-sm-6">
            <input type="hidden" name="action"  value="nuevo_almacen">
            <input type="hidden" name="empresa" value="<?=$_SESSION["id_empresa"]?>">
            <label for="">Nombre:</label>
            <input type="text" class="form-control" name="nombre" id="nombre"  onkeyup="javascript:this.value=this.value.toUpperCase();" required="">
          </div>
          <div class="col-sm-6">
            <label for="">Direccion:</label>
            <input type="text" class="form-control" name="direccion" id="direccion"  onkeyup="javascript:this.value=this.value.toUpperCase();" required="">
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