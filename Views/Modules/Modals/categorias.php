<!-- Modal -->
<div class="modal fade" id="ModalCategoria" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
    <form action="" name="form_add_categoria" id="form_add_categoria">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header bg-dark">
        <h5 class="modal-title" id="exampleModalLongTitle">Nueva Categoria</h5>
        <button type="button" class="close" style="color: white" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      


      <div class="row">
          <div class="col-sm-12">
              <label for="">Nombre Categoria</label>
              <input type="hidden" name="action" value="addCategoria">
              <input type="hidden" name="empresa" value="<?=$empresa?>">
            <input type="text" name="categoria" id="categoria" class="form-control" required="" onkeyup="javascript:this.value=this.value.toUpperCase();">
          </div>


      </div>
      <hr>
      <div class="row mt-3">
        <div class="col-sm-6">
          <label for="">Cuenta Compra</label>
          <input type="text" class="form-control text-right" maxlength="7" minlength="5" name="cuenta_compra" id="cuenta_compra">
        </div>
        <div class="col-sm-6">
          <label for="">Cuenta Venta</label>
          <input type="text" class="form-control text-right" maxlength="7" minlength="5" name="cuenta_venta" id="cuenta_venta">
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
<form action="" name="form_edi_categoria" id="form_edi_categoria">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header bg-warning">
        <h5 class="modal-title" id="exampleModalLabel">Editar Categoria</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        

      <div class="row">
          <div class="col-sm-12">
              <label for="">Nombre Categoria</label>
            <input type="hidden" name="update_id" id="update_id" value="">
            <input type="hidden" name="action" value="ediCategoria">
            <input type="text"  name="update_nombre" id="update_nombre" class="form-control" required="" onkeyup="javascript:this.value=this.value.toUpperCase();">
          </div>
      </div>
      <hr>
      <div class="row mt-3">
        <div class="col-sm-6">
          <label for="">Cuenta Compra</label>
          <input type="text" class="form-control text-right" maxlength="7" minlength="5" name="update_cuenta_compra" id="update_cuenta_compra">
        </div>
        <div class="col-sm-6">
          <label for="">Cuenta Venta</label>
          <input type="text" class="form-control text-right" maxlength="7" minlength="5" name="update_cuenta_venta" id="update_cuenta_venta">
       </div>
      </div>
      
    <div class="modal-footer mt-3">
        <button type="button" class="btn btn-danger" data-dismiss="modal">Cerrar</button>
        <button type="submit" class="btn btn-success">Actualizar</button>
        
    </div> 
    </div>
  </div>
</div>
   </form>
</div>


<!-- Modal delete-->
<div class="modal fade" id="ModalCategoriaDlete" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <form action="" name="form_del_categoria" id="form_del_categoria">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header bg-danger">
        <h5 class="modal-title" id="exampleModalLabel" style="color: white">Anular Categoria</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      

      <div class="row">
          <div class="col-sm-12">
            
            <input type="hidden" name="delete_id" id="delete_id" value="">
            <input type="hidden" name="action" value="delCategoria">
          <h5 class="text-center">¿Esta seguro que desea realizar el proceso?</h5>
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
