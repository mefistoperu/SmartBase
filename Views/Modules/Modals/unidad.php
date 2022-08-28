
<!-- Modal -->
<div class="modal fade" id="ModalUnidad" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header bg-dark">
        <h5 class="modal-title" id="exampleModalLongTitle">Nueva Unidad</h5>
        <button type="button" class="close" style="color: white" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <form action="" name="form_add_unidad" id="form_add_unidad">


      <div class="row">
          <div class="col-sm-12">
              <label for="">Nombre Unidad</label>
              <input type="hidden" name="action" value="addUnidad">
            <input type="text" name="unidad" id="unidad" class="form-control" required="" onkeyup="javascript:this.value=this.value.toUpperCase();">
          </div>
      </div>
      <div class="row">
          <div class="col-sm-12">
              <label for="">Codigo Unidad</label>
   
            <input type="text" name="codigo" id="codigo" class="form-control" required="" maxlength="3" onkeyup="javascript:this.value=this.value.toUpperCase();">
          </div>
      </div>
      <div class="row">
          <div class="col-sm-12">
              <label for="">Factor Unidad</label>
   
            <input type="number" step="any" name="factor" id="factor" class="form-control" required="">
          </div>
      </div>


       
</div>
 
      <div class="modal-footer">
         
        <button type="button" class="btn btn-danger" data-dismiss="modal">Cerrar</button>
        <button type="submit" class="btn btn-success">Guardar</button>
         </form>
      </div>
     <div class="col-sm-4">
            <img src="<?= base_url()?>/Assets/js/ajax.gif" class="ajaxgif hide" width="100%">
          </div>
    </div>
  </div>
</div>




<!-- Modal Edit-->
<div class="modal fade" id="ModalUnidadEdit" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header bg-warning">
        <h5 class="modal-title" id="exampleModalLabel">Editar Unidad</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <form action="" name="form_edi_unidad" id="form_edi_unidad">

      <div class="row">
          <div class="col-sm-12">
              <label for="">Nombre Unidad</label>
            <input type="hidden" name="update_id" id="update_id" value="">
            <input type="hidden" name="action" value="ediUnidad">
            <input type="text"  name="update_nombre" id="update_nombre" class="form-control" required="" onkeyup="javascript:this.value=this.value.toUpperCase();">
          </div>
      </div>
      <div class="row">
          <div class="col-sm-12">
              <label for="">Codigo Unidad</label>
   
            <input type="text" name="update_codigo" id="update_codigo" class="form-control" required="" maxlength="3" onkeyup="javascript:this.value=this.value.toUpperCase();">
          </div>
      </div>
      <div class="row">
          <div class="col-sm-12">
              <label for="">Factor Unidad</label>
   
            <input type="number" step="any" name="update_factor" id="update_factor" class="form-control" required="">
          </div>
      </div>
      
    <div class="modal-footer mt-3">
        <button type="button" class="btn btn-danger" data-dismiss="modal">Cerrar</button>
        <button type="submit" class="btn btn-success">Actualizar</button>
        
    </div>
       <div class="col-sm-4">
            <img src="<?= base_url()?>/Assets/js/ajax.gif" class="ajaxgif hide" width="100%">
    </div>
   </form>

     <div class="col-sm-4">
            <img src="<?= base_url()?>/Assets/js/ajax.gif" class="ajaxgif hide" width="100%">
    </div>
    </div>
  </div>
</div>
</div>


<!-- Modal delete-->
<div class="modal fade" id="ModalUnidadDelete" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header bg-danger">
        <h5 class="modal-title" id="exampleModalLabel">Eliminar Unidad</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <form action="" name="form_del_unidad" id="form_del_unidad">

      <div class="row">
          <div class="col-sm-12">
            
            <input type="hidden" name="delete_id" id="delete_id" value="">
            <input type="hidden" name="action" value="delUnidad">
          <h5 class="text-center">¿Esta seguro que desea realizar el proceso?</h5>
          </div>
      </div>
      
    <div class="modal-footer mt-3">
        <button type="button" class="btn btn-danger" data-dismiss="modal">Cerrar</button>
        <button type="submit" class="btn btn-success">Actualizar</button>
        
    </div>
   </form>

     <div class="col-sm-4">
            <img src="<?= base_url()?>/Assets/js/ajax.gif" class="ajaxgif hide" width="100%">
          </div>
    </div>
  </div>
</div>
</div>
