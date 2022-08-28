<div class="modal fade deleteUsuario" id="deleteUsuario" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog">
  <form name="delete_usuario" id="delete_usuario">
    <div class="modal-content">

      <div class="modal-header bg-danger">
        <h4 class="modal-title" id="myModalLabel" style="color: white;">Eliminar Usuario</h4>
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true" style="color: white;">×</span>
        </button>
      </div>
      <div class="modal-body">
      <div class="row">
                <div class="col-sm-12" style="margin: auto; text-align: center">
                  <img src="<?=media()?>/images/error.gif" alt="" width="25%">
                </div>
                <div class="row" style="margin: auto; text-align: center;">
                  <h3 class="text-center text-bold">¿Seguro de desea eliminar el usuario ?</h3>
                  <input type="hidden" name="action" value="eliminar_usuario">
                  <input type="hidden" name="delete_id" id="delete_id" value="">
                  <input type="hidden" name="delete_empresa" id="delete_empresa" value="<?=$empresa?>">
                </div>
              </div>        
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-close"></i> Cerrar</button>
        <button type="submit" class="btn btn-success"><i class="fa fa-save"></i> Eliminar</button>
      </div>      

    </div>
  </form>
  </div>
</div>