<?php 

  $query = "SELECT * FROM tbl_series WHERE flat = '0' AND id_empresa = $empresa";
  $resultado=$connect->prepare($query);
  $resultado->execute(); 
  $num_reg=$resultado->rowCount();

?>

<div class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog">
    <form name="form_serie_usuario" id="form_serie_usuario">

    <div class="modal-content">

      <div class="modal-header bg-primary">
        <h4 class="modal-title" id="myModalLabel" style="color: white;">Asignar Series</h4>
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true" style="color: white;">×</span>
        </button>
      </div>
      <div class="modal-body">
        <div class="row">
          <div class="col-sm-6">
            <input type="hidden" name="action"  value="nuevo_serie_usuario">
            <input type="hidden" name="usuario"  value="<?=$id_usuario ?>">
        <label for="">Serie :</label>
<select class="form-control" style="width: 100%;" name="serie_nueva" id="serie_nueva">
    <option selected="selected">Seleccionar Serie</option>
    <?php 
            while($row = $resultado->fetch(PDO::FETCH_ASSOC) )
       {?>
        <option value="<?= $row['id'] ?>"><?=$row['serie']?></option>;
       <?php  } ?>
    </select>
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