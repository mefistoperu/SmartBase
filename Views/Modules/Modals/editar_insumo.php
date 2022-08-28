<?php 

$query_unidad = "SELECT * FROM tbl_unidad ";
$resultado_unidad=$connect->prepare($query_unidad);
$resultado_unidad->execute(); 
$num_reg_unidad=$resultado_unidad->rowCount();

$query_marca = "SELECT * FROM tbl_marcas WHERE estado='1' AND empresa=$_SESSION[id_empresa]";
$resultado_marca=$connect->prepare($query_marca);
$resultado_marca->execute(); 
$num_reg_marca=$resultado_marca->rowCount();

 ?>


<div id="edit" class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <form name="form_insumo_editar" id="form_insumo_editar">

    <div class="modal-content">


      <div class="modal-header bg-warning">
        <h4 class="modal-title" id="myModalLabel" style="color: white;">EditarInsumo</h4>
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true" style="color: white;">×</span>
        </button>
      </div>
      <div class="modal-body">
        <div class="row">
          <div class="col-sm-12">
            <input type="hidden" name="action"  value="editar_insumo">
            <input type="hidden" name="update_id_insumo" id="update_id_insumo" value="">
            <input type="hidden" name="updapte_empresa" value="<?=$_SESSION["id_empresa"]?>">
            <label for="">Nombre:</label>
            <input type="text" class="form-control" name="update_nombre" id="update_nombre"  onkeyup="javascript:this.value=this.value.toUpperCase();" required="">
          </div>
          
        </div>
        <div class="row">
         <div class="col-sm-6">
              <label for="">Marca</label>
       <select class="form-control select2" style="width: 100%;" name="update_marca" id="update_marca">
                  
    <option selected="selected">Seleccionar Marca</option>
    <?php 
            while($row_marca = $resultado_marca->fetch(PDO::FETCH_ASSOC) )
       {?>
        <option value="<?= $row_marca['id'] ?>"><?=$row_marca['nombre']?></option>;
       <?php  } ?>
  </select>
          </div>
                    <div class="col-sm-6">
              <label for="">Unidad</label>
   <select class="form-control select2" style="width: 100%;" name="update_unidad" id="update_unidad">
                  
    <option selected="selected">Seleccionar Unidad</option>
    <?php 
            while($row_unidad = $resultado_unidad->fetch(PDO::FETCH_ASSOC) )
       {?>
        <option value="<?= $row_unidad['cod'] ?>"><?=$row_unidad['cod'] .' | '. $row_unidad['nombre']?></option>;
       <?php  } ?>
  </select>
          </div>
        </div>
        <div class="row">
          <div class="col-sm-6">
            <label for="">Precio Compra</label>
            <input type="text" id="update_precio_compra" name="update_precio_compra" class="form-control" required>
          </div>
          <div class="col-sm-6">
            <label for="">Stock</label>
            <input type="text" class="form-control" id="update_stock" name="update_stock" readonly>
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



