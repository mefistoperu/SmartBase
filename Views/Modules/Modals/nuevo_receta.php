<?php 
$empresa = $_SESSION["id_empresa"];
$query_unidad = "SELECT * FROM tbl_productos WHERE empresa = $empresa";
$resultado_unidad=$connect->prepare($query_unidad);
$resultado_unidad->execute(); 
$num_reg_unidad=$resultado_unidad->rowCount();

?>


<div class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <form name="form_receta" id="form_receta">

    <div class="modal-content">


      <div class="modal-header bg-primary">
        <h4 class="modal-title" id="myModalLabel" style="color: white;">Agregar Insumos</h4>
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true" style="color: white;">×</span>
        </button>
      </div>
      <div class="modal-body">
        <div class="row">
          <div class="col-sm-12">
            <input type="hidden" name="action"  value="nuevo_receta">
            <input type="hidden" name="producto" value="<?=$id?>">
          </div>
          
        </div>
        <div class="row">
      <div class="col-sm-8">
              <label for="">Insumos</label>
           <select class="form-control select2" style="width: 100%;" name="insumo" id="insumo">
                          
            <option selected="selected">Seleccionar Insumo</option>
            <?php 
                    while($row_unidad = $resultado_unidad->fetch(PDO::FETCH_ASSOC) )
               {?>
                <option value="<?= $row_unidad['id'] ?>"><?= $row_unidad['nombre']?></option>;
               <?php  } ?>
          </select>
          </div>
        
          <div class="col-sm-4">
            <label for="">Cantidad</label>
            <input type="text" id="cantidad" name="cantidad" class="form-control" required>
          </div>
          
        </div>
     
      
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="fa fa-close"></i> Cerrar</button>
        <button type="submit" class="btn btn-success"><i class="fa fa-save"></i> Guardar</button>
      </div>

    </div>
     </form>
  </div>
</div>



