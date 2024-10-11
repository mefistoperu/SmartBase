
<!-- Modal -->
<div class="modal fade" id="ModalMarcas" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header bg-primary">
        <h5 class="modal-title" id="exampleModalLongTitle" style="color: white">Nueva Marca</h5>
        <button type="button" class="close" style="color: white" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <form action="" name="form_add_marca" id="form_add_marca">


      <div class="row">
          <div class="col-sm-12">
              <label for="">Nombre Marca</label>
              <input type="hidden" name="action" value="addMarca">
              <input type="hidden" name="empresa" value="<?=$empresa?>">
            <input type="text" name="marca" id="marca" class="form-control" required="" onkeyup="javascript:this.value=this.value.toUpperCase();">
          </div>
      </div>


       
</div>
 
      <div class="modal-footer">
         
        <button type="button" class="btn btn-danger" data-dismiss="modal">Cerrar</button>
        <button type="submit" class="btn btn-success">Guardar</button>
         </form>
      </div>
   
    </div>
  </div>
</div>




<!-- Modal Edit-->
<div class="modal fade" id="ModalMarcaEdit" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header bg-warning">
        <h5 class="modal-title" id="exampleModalLabel">Editar Marca</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <form action="" name="form_edi_marca" id="form_edi_marca">

      <div class="row">
          <div class="col-sm-12">
              <label for="">Nombre Marca</label>
            <input type="hidden" name="update_id" id="update_id" value="">
            <input type="hidden" name="action" value="ediMarca">
            <input type="text"  name="update_nombre" id="update_nombre" class="form-control" required="" onkeyup="javascript:this.value=this.value.toUpperCase();">
          </div>
      </div>
      
    <div class="modal-footer mt-3">
        <button type="button" class="btn btn-danger" data-dismiss="modal">Cerrar</button>
        <button type="submit" class="btn btn-success">Actualizar</button>
        
    </div>

   </form>


    </div>
  </div>
</div>
</div>


<!-- Modal delete-->
<div class="modal fade" id="ModalMarcaDelete" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header bg-danger">
        <h5 class="modal-title" id="exampleModalLabel" style="color: white">Anular Marca</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <form action="" name="form_del_marca" id="form_del_marca">

      <div class="row">
          <div class="col-sm-12">
            
            <input type="hidden" name="delete_id" id="delete_id" value="">
            <input type="hidden" name="action" value="delMarca">
          <h5 class="text-center">¿Esta seguro que desea realizar el proceso?</h5>
          </div>
      </div>
      
    <div class="modal-footer mt-3">
        <button type="button" class="btn btn-danger" data-dismiss="modal">Cerrar</button>
        <button type="submit" class="btn btn-success">Anular</button>
        
    </div>
   </form>

     </div>
  </div>
</div>
</div>