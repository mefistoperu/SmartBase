<?php 


$query_fp = "SELECT * FROM tbl_tipo_pago WHERE empresa=$_SESSION[id_empresa] ";
$resultado_fp=$connect->prepare($query_fp);
$resultado_fp->execute(); 
$num_reg_fp=$resultado_fp->rowCount();

?>
<!-- Modal -->
<div class="modal fade" id="NuevoPago" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content modal-lg">
      <div class="modal-header bg-primary">
        <h5 class="modal-title" id="exampleModalLongTitle" style="color: white">Nuevo Pago</h5>
        <button type="button" class="close" style="color: white" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
        <form name="form_pago_cta" id="form_pago_cta">


      <div class="row">
          <div class="col-sm-6">
              <label for="">Fecha Pago</label>
              <input type="hidden" name="correlativo" value="<?=$correlativo?>">
             <input type="hidden" name="serie" value="<?=$serie?>">
             <input type="hidden" name="tipocomp" value="<?=$tipocomp?>">
             <input type="hidden" name="num_doc" value="<?=$num_doc?>">
             <input type="hidden" name="empresa" value="<?=$empresa?>">
             <input type="hidden" name="id_factura" value="<?=$id_factura?>">
              <input type="hidden" name="action" value="addPago_Cta">
              <input type="date" name="fecha_pago" value="<?= date('Y-m-d')?>" class="form-control">
          </div>
          

          
          
          
          <div class="col-sm-6">
                      <label for="">Tipo de Pago</label>
               <select class="form-control select2" style="width: 100%;" name="tipo_pago" id="tipo_pago" required>
                          
            <option value="">Seleccionar Tipo de Pago</option>
            <?php 
                    while($row_fp = $resultado_fp->fetch(PDO::FETCH_ASSOC) )
               {?>
                <option value="<?= $row_fp['id'] ?>"><?=$row_fp['nombre']?></option>;
               <?php  } ?>
          </select>
                  </div>
          
          
               <div class="col-sm-6">
            <label for="">Num. Operación</label>
            <input type="text" class="form-control" id="num_operacion" name="num_operacion" value="">
          </div>
          
          
                    <div class="col-sm-6">
            <label for="">Importe</label>
            <input type="text" class="form-control" id="importe" name="importe" value="0.00" required>
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





