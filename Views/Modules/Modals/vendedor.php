<?php 

$query_local = "SELECT * FROM tbl_almacen WHERE empresa = $empresa ";
$resultado_local=$connect->prepare($query_local);
$resultado_local->execute(); 
$num_reg_local=$resultado_local->rowCount();

$query_local1 = "SELECT * FROM tbl_almacen WHERE empresa = $empresa ";
$resultado_local1=$connect->prepare($query_local1);
$resultado_local1->execute(); 
$num_reg_local1=$resultado_local1->rowCount();

 ?>

<!-- Modal -->
<div class="modal fade" id="ModalCategoria" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
    <form action="" name="form_add_vendedor" id="form_add_vendedor">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header bg-dark" >
        <h5 class="modal-title" style="color: white" id="exampleModalLongTitle" >Nuevo Vendedor</h5>
        <button type="button" class="close" style="color: white" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      


      <div class="row">
          <div class="col-sm-6">
              <label for="">Nombre</label>
              <input type="hidden" name="action" value="addVendedor">
              <input type="hidden" name="empresa" value="<?=$empresa?>">
            <input type="text" name="nombrev" id="nombrev" class="form-control" required="" onkeyup="javascript:this.value=this.value.toUpperCase();">
          </div>
          <div class="col-sm-6">
              <label for="">Apellido</label>
             
            <input type="text" name="apellidov" id="apellidov" class="form-control" required="" onkeyup="javascript:this.value=this.value.toUpperCase();">
          </div>
          <div class="col-sm-6">
              <label for="">Documento</label>
             
            <input type="text" name="dniv" id="dniv" class="form-control" required="" onkeyup="javascript:this.value=this.value.toUpperCase();">
          </div>
          <div class="col-sm-6">
                      <label for="">Local </label>
            <select class="form-control select2" style="width: 100%;" name="localv" id="localv" required>
                          
                <option value="">Seleccionar Local</option>
                <?php 
                        while($row_local = $resultado_local->fetch(PDO::FETCH_ASSOC) )
                   {?>
                    <option value="<?= $row_local['id'] ?>"><?=$row_local['nombre']?></option>;
                   <?php  } ?>
            </select>
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
    <form action="" name="form_edi_vendedor" id="form_edi_vendedor">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header bg-warning">
            <h5 class="modal-title" id="exampleModalLabel">Editar Vendedor</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body">
            

          <div class="row">
              <div class="col-sm-6">
                  <label for="">Nombre</label>
                <input type="hidden" name="update_id" id="update_id" value="">
                <input type="hidden" name="action" value="ediVendedor">
                <input type="text"  name="update_nombrev" id="update_nombrev" class="form-control" required="" onkeyup="javascript:this.value=this.value.toUpperCase();">
              </div>
              <div class="col-sm-6">
                  <label for="">Apellido</label>
                 
                <input type="text" name="update_apellidov" id="update_apellidov" class="form-control" required="" onkeyup="javascript:this.value=this.value.toUpperCase();">
              </div>
              <div class="col-sm-6">
                  <label for="">Documento</label>
                 
                <input type="text" name="update_dniv" id="update_dniv" class="form-control" required="" onkeyup="javascript:this.value=this.value.toUpperCase();">
              </div>
              <div class="col-sm-6">
                      <label for="">Local </label>
            <select class="form-control" style="width: 100%;" name="update_localv" id="update_localv" required>
                          
                <option value="">Seleccionar Local</option>
                <?php 
                        while($row_local1 = $resultado_local1->fetch(PDO::FETCH_ASSOC) )
                   {?>
                    <option value="<?= $row_local1['id'] ?>"><?=$row_local1['nombre']?></option>;
                   <?php  } ?>
            </select>
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
    <form action="" name="form_del_vendedor" id="form_del_vendedor">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header bg-danger">
        <h5 class="modal-title" id="exampleModalLabel" style="color: white">Anular Vendedor</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      

      <div class="row">
          <div class="col-sm-12">
            
            <input type="hidden" name="delete_id" id="delete_id" value="">
            <input type="hidden" name="action" value="delVendedor">
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
