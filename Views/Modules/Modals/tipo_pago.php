
<?php 

$query_pago = "SELECT * FROM tbl_medio_pago ";
$resultado_pago=$connect->prepare($query_pago);
$resultado_pago->execute(); 
$num_reg_pago=$resultado_pago->rowCount();

$query_pago1 = "SELECT * FROM tbl_medio_pago ";
$resultado_pago1=$connect->prepare($query_pago1);
$resultado_pago1->execute(); 
$num_reg_pago1=$resultado_pago1->rowCount();


 ?>

<!-- Modal -->
<div class="modal fade" id="ModalTipoPago" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
    <form action="" name="form_add_mpago" id="form_add_mpago">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content">
      <div class="modal-header bg-dark">
        <h5 class="modal-title" id="exampleModalLongTitle">Nuevo Tipo Pago</h5>
        <button type="button" class="close" style="color: white" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      


      <div class="row">
          <div class="col-sm-12">
              <label for="">Nombre</label>
              <input type="hidden" name="action" value="addMpago">
              <input type="hidden" name="empresa" value="<?=$empresa?>">
            <input type="text" name="nombre_mpago" id="nombre_mpago" class="form-control" required="" onkeyup="javascript:this.value=this.value.toUpperCase();">
          </div>


      </div>
      <hr>
      <div class="row mt-3">
        <div class="col-sm-6">
                      <label for="">Medio Pago</label>
            <select class="form-control select2" style="width: 100%;" name="mpago" id="mpago" required>
                          
                <option value="">Seleccionar Medio de pago</option>
                <?php 
                        while($row_pago = $resultado_pago->fetch(PDO::FETCH_ASSOC) )
                   {?>
                    <option value="<?= $row_pago['id_mdp'] ?>"><?=$row_pago['descripcion_mdp']?></option>;
                   <?php  } ?>
            </select>
                  </div>
        <div class="col-sm-6">
          <label for="">Cuenta Pago</label>
          <input type="text" class="form-control text-right" maxlength="10" minlength="5" name="cuenta_pago" id="cuenta_pago">
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
<div class="modal fade" id="ModalTpagoEdit" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
<form action="" name="form_edi_mpago" id="form_edi_mpago">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header bg-warning">
        <h5 class="modal-title" id="exampleModalLabel">Editar Medio Pago</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        

      <div class="row">
          <div class="col-sm-12">
              <label for="">Nombre</label>
            <input type="hidden" name="update_id" id="update_id" value="">
            <input type="hidden" name="action" value="ediMpago">
            <input type="text"  name="update_nombre" id="update_nombre" class="form-control" required="" onkeyup="javascript:this.value=this.value.toUpperCase();">
          </div>
      </div>
      <hr>
      <div class="row mt-3">
        <div class="col-sm-6">
                      <label for="">Medio Pago</label>
            <select class="form-control" style="width: 100%;" name="update_tpago" id="update_tpago" required>
                          
                <option selected="selected">Seleccionar Medio de pago</option>
                <?php 
                        while($row_pagox = $resultado_pago1->fetch(PDO::FETCH_ASSOC) )
                   {?>
                    <option value="<?= $row_pagox['id_mdp'] ?>"><?=$row_pagox['descripcion_mdp']?></option>;
                   <?php  } ?>
            </select>
                  </div>
        <div class="col-sm-6">
          <label for="">Cuenta</label>
          <input type="text" class="form-control text-right" maxlength="7" minlength="5" name="update_cuenta" id="update_cuenta">
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
<div class="modal fade" id="ModalTpagoDelete" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <form action="" name="form_del_mpago" id="form_del_mpago">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header bg-danger">
        <h5 class="modal-title" id="exampleModalLabel" style="color: white">Anular Medio Pago</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
      

      <div class="row">
          <div class="col-sm-12">
            
            <input type="hidden" name="delete_id" id="delete_id" value="">
            <input type="hidden" name="action" value="delmpago">
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
