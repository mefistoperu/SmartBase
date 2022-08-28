<div class="modal fade" id="ModalVentaDelete">
        <div class="modal-dialog">
          <div class="modal-content">
            <div class="modal-header bg-danger">
              <h4 class="modal-title">Anular Venta</h4>
              <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span>
              </button>
            </div>
            <div class="modal-body">
              <form id="eliminar_venta" name="form1" enctype="multipart/form-data">
                <div class="row mb-3">
                <div class="col">
                  <input type="hidden" name="action" value="delete_venta">
                  <input type="hidden" name="delete_id" id="delete_id">

                  <h3 class="text-center" style="color: red; font-size: 30px"><i class="fas fa-trash"></i></h3>
                  <hr>
                   <h3 class="text-center">¿Seguro desea anular el registro?</h3>
                </div>
              </div>



            </div>
            <div class="modal-footer justify-content-between">
              <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="far fa-times-circle"></i> Close</button>
              <button type="submit" class="btn btn-success"><i class="far fa-save"></i> Elimiar</button>
            </div>
             </form>
          </div>
          <!-- /.modal-content -->
        </div>
        <!-- /.modal-dialog -->
</div>
      <!-- /.modal -->
