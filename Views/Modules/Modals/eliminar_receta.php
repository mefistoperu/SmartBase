<div id="deleteReceta" class="modal fade deleteAlmacen" id="deleteSerie" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog">
    <form name="form_delete_receta" id="form_delete_receta">

    <div class="modal-content">
      

      <div class="modal-header bg-danger">
        <h4 class="modal-title" id="myModalLabel" style="color: white;">Eliminar Insumo</h4>
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true" style="color: white;">×</span>
        </button>
      </div>
      <div class="modal-body">
        <div class="row">
          <div class="col-sm-4">
            <input type="hidden" name="action"  value="delete_receta">
          
            <input type="hidden" name="delete_id_receta" id="delete_id_receta" value="">  
          </div>         
          
        </div>
        <div class="row">
          <div class="col-sm-12" style="margin: auto;">
            <h2 class="h2 text-center"><i class="fa fa-trash"></i></h2>
            <h3>¿Seguro desea quitar el insumo?</h3>
          </div>
        </div>
        
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-close"></i> Cerrar</button>
        <button type="submit" class="btn btn-success"><i class="fa fa-save"></i> Eliminar </button>
      </div>

    </div>
     </form>
  </div>
</div>