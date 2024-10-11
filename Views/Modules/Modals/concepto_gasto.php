<!--modal crear concepto de gasto-->
<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <form method="POST" id="addConceptoGasto" name="addConceptoGasto">
    <div class="modal-content">
      <div class="modal-header bg-primary">
        <h5 class="modal-title text-white" id="exampleModalLabel">Agregar Concepto</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <div class="row">
          <div class="col-sm-12">
            <label for="">Descripcion</label>
            <input type="hidden" name="action" value="addconcepto_gasto">
            <input type="hidden" name="empresa" value="<?=$empresa?>">
            <input type="text" class="form-control input-xs" required name="descripcion" id="descripcion" onKeyUp="document.getElementById(this.id).value=document.getElementById(this.id).value.toUpperCase()">
          </div>
          
          <div class="col-sm-12">
            <label for="">Cuenta</label>
            <input type="text" class="form-control input-xs text-right" required name="cuenta" id="cuenta">
          </div>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fas fa-times-circle"></i> Cerrar</button>
        <button type="submit" class="btn btn-success"><i class="fas fa-save"></i> Guardar</button>
      </div>
    </div>
    </form>
  </div>
</div>
<!--fin modal crear concepto de gasto-->   


<!--modal editar concepto de gasto-->
<!-- Modal -->
<div class="modal fade" id="ModalConceptoGastoEdit" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <form method="POST" id="ediConceptoGasto" name="ediConceptoGasto">
    <div class="modal-content">
      <div class="modal-header bg-warning">
        <h5 class="modal-title" id="exampleModalLabel">Editar Conceptox</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <div class="row">
          <div class="col-sm-12">
            <label for="">Descripcion</label>
            <input type="hidden" name="action" value="edicongas">
            <input type="hidden" name="update_id" id="update_id">
            <input type="text" class="form-control input-xs" required name="update_descripcion" id="update_descripcion">
          </div>
          
          <div class="col-sm-12">
            <label for="">Cuenta</label>
            <input type="text" class="form-control input-xs text-right" required name="update_cuenta" id="update_cuenta">
          </div>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fas fa-times-circle"></i> Cerrar</button>
        <button type="submit" class="btn btn-success"><i class="fas fa-save"></i> Guardar</button>
      </div>
    </div>
    </form>
  </div>
</div>
<!--fin modal editar concepto de gasto-->   

<!--modal eliminar concepto de gasto-->
<!-- Modal -->
<div class="modal fade" id="ModalConceptoGastoDel" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <form method="POST" id="delConceptoGasto" name="delConceptoGasto">
    <div class="modal-content">
      <div class="modal-header bg-danger">
        <h5 class="modal-title" id="exampleModalLabel">Eliminar Concepto</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <div class="row">
          <div class="col-sm-12">
            <input type="hidden" name="action" value="delcongas">
            <input type="hidden" name="delete_id" id="delete_id">
            <h4 class="text-center text-bold">¿Seguro que desea eliminar el registro? </h4>
           
          </div>
          
          
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fas fa-times-circle"></i> Cerrar</button>
        <button type="submit" class="btn btn-success"><i class="fas fa-save"></i> Eliminar</button>
      </div>
    </div>
    </form>
  </div>
</div>
<!--fin modal elimina concepto de gasto-->   