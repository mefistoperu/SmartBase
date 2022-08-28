<div class="modal fade updateSerie" id="updateSerie" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog">
    <form name="form_series_update" id="form_series_update">

    <div class="modal-content">

      <div class="modal-header bg-warning">
        <h4 class="modal-title" id="myModalLabel" style="color: white;">Editar Serie</h4>
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true" style="color: white;">×</span>
        </button>
      </div>
      <div class="modal-body">
        <div class="row">
          <div class="col-sm-4">
            <input type="hidden" name="action"  value="update_serie">
            <input type="hidden" name="update_empresa" value="<?=$_SESSION["id_empresa"]?>">
            <input type="hidden" name="update_id_serie" id="update_id_serie" value="">  
            <label for="">Serie:</label>
            <input type="text" id="update_serie" value="" readonly="" class="form-control">    
          </div>
          
          <div class="col-sm-7">
            <label for="">Correlativo:</label>
            <input type="number" onKeyPress="if(this.value.length==8) return false;" class="form-control border-rounded border-red" maxlength="8" max="99999999" min="1" name="update_correlativo" id="update_correlativo" />
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