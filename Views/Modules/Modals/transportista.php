<!-- Modal -->
<div class="modal fade" id="ModalCategoria" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
    <form action="" name="form_add_transportista" id="form_add_transportista">
  <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header bg-dark">
        <h5 class="modal-title" id="exampleModalLongTitle">Nuevo Transportista</h5>
        <button type="button" class="close" style="color: white" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      
      <div class="row">
          <div class="col-sm-3">
              <label for="">RUC</label>
              <input type="hidden" name="action" value="addtransportista">
              <input type="hidden" name="empresa" value="<?=$empresa?>">
            <input type="text" name="ruc" id="ruc" class="form-control" required="" onkeyup="javascript:this.value=this.value.toUpperCase();">
          </div>
          <div class="col-sm-9">
              <label for="">Razon Social</label>
             
            <input type="text" name="razon" id="razon" class="form-control" required="" onkeyup="javascript:this.value=this.value.toUpperCase();">
          </div>
          
      </div>
            
      <div class="row mt-3">
        <div class="col-sm-12">
          <label for="">Direccion</label>
          <input type="text" class="form-control"   name="direccion" id="direccion" onkeyup="javascript:this.value=this.value.toUpperCase();">
        </div>
      </div>
      
   
   </div> 
      <div class="modal-footer">
         
        <button type="button" class="btn btn-danger" data-dismiss="modal">Cerrar</button>
        <button type="submit" class="btn btn-success">Guardar</button>
        
      </div>
    </div>
  </div>
     </form>
</div>




<!-- Modal Edit-->
<div class="modal fade" id="ModalCategoriaEdit" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <form action="" name="form_edi_transportista" id="form_edi_transportista">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header bg-warning">
            <h5 class="modal-title" id="exampleModalLabel">Editar transportista</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body">
      


      <div class="row">
          <div class="col-sm-3">
              <label for="">RUC</label>
              <input type="hidden" name="action" value="editransportista">
              <input type="hidden" name="update_empresa" value="<?=$empresa?>">
              <input type="hidden" name="update_id" id="update_id" value="">
            <input type="text" name="update_ruc" id="update_ruc" class="form-control" required="" onkeyup="javascript:this.value=this.value.toUpperCase();">
          </div>
          <div class="col-sm-9">
              <label for="">Razon Social</label>
             
            <input type="text" name="update_razon" id="update_razon" class="form-control" required="" onkeyup="javascript:this.value=this.value.toUpperCase();">
          </div>
          
          
      </div>
      
      
      <div class="row mt-3">
        <div class="col-sm-12">
          <label for="">Direccion</label>
          <input type="text" class="form-control"   name="update_direccion" id="update_direccion" onkeyup="javascript:this.value=this.value.toUpperCase();">
        </div>
      </div>
      
   </div> 
        <div class="modal-footer mt-3">
            <button type="button" class="btn btn-danger" data-dismiss="modal">Cerrar</button>
            <button type="submit" class="btn btn-success">Actualizar</button>
            
        </div> 
       
      </div>
    </div>
    </form>
</div>


<!-- Modal delete-->
<div class="modal fade" id="ModalCategoriaDlete" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <form action="" name="form_del_transportista" id="form_del_transportista">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header bg-danger">
        <h5 class="modal-title" id="exampleModalLabel" style="color: white">Anular transportista</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      

      <div class="row">
          <div class="col-sm-12">
            
            <input type="hidden" name="delete_id" id="delete_id" value="">
            <input type="hidden" name="action" value="deltransportista">
          <h5 class="text-center">¿Esta seguro que desea realizar el proceso?</h5>

          <select name="estado" id="estado" class="form-control">
            <option value="1">ACTIVADO</option>
            <option value="0">DESACTIVADO</option>
          </select>
          </div>
      </div>
      
    <div class="modal-footer mt-3">
        <button type="button" class="btn btn-danger" data-dismiss="modal">Cerrar</button>
        <button type="submit" class="btn btn-success">Anular</button>
        
    </div>
 
 
    </div>
  </div>
</div>
  </form>
</div>
