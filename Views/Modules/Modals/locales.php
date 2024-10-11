<!-- Modal -->
<div class="modal fade" id="ModalCategoria" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
    <form action="" name="form_add_local" id="form_add_local">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header bg-dark">
        <h5 class="modal-title" id="exampleModalLongTitle" style="color:white">Nuevo Local</h5>
        <button type="button" class="close" style="color: white" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">

      <div class="row">
          <div class="col-sm-6">
              <label for="">Nombre Local</label>
              <input type="hidden" name="action" value="addLocal">
              <input type="hidden" name="empresa" value="<?=$empresa?>">
            <input type="text" name="local" id="local" class="form-control" required="" onkeyup="javascript:this.value=this.value.toUpperCase();">
          </div>
          
             <div class="col-sm-6">
             <label for="">Importe</label>
             <input type="text" class="form-control text-right" name="importe" id="importe">
        </div>


      </div>
      <hr>
      <div class="row mt-3">
        <div class="col-sm-6">
          <label for="">Area Local</label>
          <input type="text" class="form-control text-right" name="arealocal" id="arealocal">
        </div>
        <div class="col-sm-6">
          <label for="">Ubicacion</label>
          <input type="text" class="form-control text-right"  name="ubilocal" id="ubilocal">
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
<form action="" name="form_edi_local" id="form_edi_local">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header bg-warning">
        <h5 class="modal-title" id="exampleModalLabel" style="color:white">Editar Local</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        

      <div class="row">
          <div class="col-sm-6">
              <label for="">Nombre  Local</label>
            <input type="hidden" name="update_id" id="update_id" value="">
            <input type="hidden" name="action" value="ediLocal">
            <input type="text"  name="update_nombre" id="update_nombre" class="form-control" required="" onkeyup="javascript:this.value=this.value.toUpperCase();">
          </div>
          
        <div class="col-sm-6">
         <label for="">Importe</label>
            <input type="text" class="form-control text-right" name="update_importe" id="update_importe">
       </div>
          
      </div>
      <hr>
      <div class="row mt-3">
        <div class="col-sm-6">
          <label for="">Area</label>
          <input type="text" class="form-control text-right"  name="update_area" id="update_area">
        </div>
        <div class="col-sm-6">
          <label for="">Ubicacion</label>
          <input type="text" class="form-control text-right" name="update_ubi" id="update_ubi">
       </div>
      </div>
      
    <div class="modal-footer mt-3">
        <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fas fa-window-close"></i> Cerrar</button>
        <button type="submit" class="btn btn-success"><i class="fas fa-redo"></i> Actualizar</button>
        
    </div> 
    </div>
  </div>
</div>
   </form>
</div>


<!-- Modal delete-->
<div class="modal fade" id="ModalCategoriaDlete" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <form action="" name="form_del_local" id="form_del_local">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header bg-danger">
        <h5 class="modal-title" id="exampleModalLabel" style="color: white">Activar / Desactivar Local</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      

      <div class="row">
          <div class="col-sm-12">
            
            <input type="hidden" name="delete_id" id="delete_id" value="">
            <input type="hidden" name="action" value="delLocal">
          <h5 class="text-center">¿Esta seguro que desea realizar el proceso?</h5>
          </div>
          <div class="col-sm-12">
              <select name="estado" id="estado" class="form-control">
                  <option value="0">Disponible</option>
                  <option value="1">Separado</option>
                  <option value="2">Alquilado</option>
                  <option value="3">Uso Propio</option>
              </select>
          </div>
      </div>
      
    <div class="modal-footer mt-3">
        <button type="button" class="btn btn-danger" data-dismiss="modal">Cerrar</button>
        <button type="submit" class="btn btn-success">Actualizar Estado</button>
        
    </div>
 
 
    </div>
  </div>
</div>
  </form>
</div>
