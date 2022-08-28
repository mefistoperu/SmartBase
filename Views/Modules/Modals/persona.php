
<!-- Modal -->
<div class="modal fade" id="ModalClientes" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header bg-dark">
        <h5 class="modal-title" id="exampleModalLongTitle">Nueva Contribuyente</h5>
        <button type="button" class="close" style="color: white" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <form action="" name="form_add_cliente" id="form_add_cliente">

<div class="row">
          <div class="col-sm-4">
            <input type="hidden" name="action" value="addCliente">
            <input type="hidden" name="empresa" value="<?=$empresa?>">
              <label for="">Número Doc.</label>
            <input type="text" name="dni" id="dni" class="form-control" required="">
          </div>
          <div class="col-sm-5">
              <label for="">Tipo Documento</label>
          
     
      <select id="tipo_doc" name="tipo_doc"  class="form-control">
        <option value="1">DNI</option>
        <option value="6" selected="">RUC</option>
        <option value="0">OTROS, SIN DOCUMENTO</option>
      </select>

          </div>
          <div class="col-sm-2">
                <label for="">Buscar</label>
            <button type="button" class="btn btn-primary" name="botoncito" id="botoncito"><i class="fa fa-search"></i></button>
          </div>
          <div class="col-sm-1">
            <img src="<?= base_url()?>/Assets/js/ajax.gif" class="ajaxgif hide" width="100%">
          </div>
</div>

      <div class="row">
          <div class="col-sm-12">
              <label for="">Nombre o Razon Social</label>
            <input type="text" name="razon" id="razon" class="form-control" required="" onkeyup="javascript:this.value=this.value.toUpperCase();">
          </div>
      </div>


      <div class="row">
          <div class="col-sm-12">
              <label for="">Dirección</label>
            <input type="text" name="direccion" id="direccion" class="form-control" required="" onkeyup="javascript:this.value=this.value.toUpperCase();">
          </div>
      </div>
      
<div class="row">
  <div class="col-sm-4">
              <label for="">Distrito</label>
            <input type="text" name="distrito" id="distrito" class="form-control" required="" onkeyup="javascript:this.value=this.value.toUpperCase();">
          </div>
          <div class="col-sm-4">
              <label for="">Provincia</label>
            <input type="text" name="provincia" id="provincia" class="form-control" required="" onkeyup="javascript:this.value=this.value.toUpperCase();">
          </div>
          <div class="col-sm-4">
              <label for="">Departamento</label>
            <input type="text" name="departamento" id="departamento" class="form-control" required="" onkeyup="javascript:this.value=this.value.toUpperCase();">
          </div>
          
</div>

<div class="row">
  <div class="col-sm-12">
              <label for="">Correo</label>
            <input type="email" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$" name="correo" id="correo" class="form-control" required="">
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




<!-- Modal -->
<div class="modal fade" id="ModalClientesEdit" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg" role="document">
    <div class="modal-content">
      <div class="modal-header bg-warning">
        <h5 class="modal-title" id="exampleModalLabel">Editar Cliente</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <form action="" name="form_edi_cliente" id="form_edi_cliente">
      <div class="row">
        <div class="col-sm-12">
          <label for="">Direccion</label>
          <input type="text" name="update_direccion" id="update_direccion" required onkeyup="javascript:this.value=this.value.toUpperCase();" class="form-control">
        </div>
      </div>
      <diw class="row">
        <div class="col-sm-4"><label for="">Departamento</label><input type="text" class="form-control" name="update_departamento" id="update_departamento" required></div>
        <div class="col-sm-4"><label for="">Provincia</label><input type="text" class="form-control" name="update_provincia" id="update_provincia" required></div>
        <div class="col-sm-4"><label for="">Distrito</label><input type="text" class="form-control" name="update_distrito" id="update_distrito" required></div>
      </diw>
      <div class="row">
          <div class="col-sm-12">
              <label for="">Correo</label>
            <input type="hidden" name="update_id" id="update_id" value="">
            <input type="hidden" name="action" value="ediCliente">
            
            <input type="email" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$" name="update_correo" id="update_correo" class="form-control" required="">
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


