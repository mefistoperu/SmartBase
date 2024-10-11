<?php 

$query_cliente = "SELECT * FROM tbl_contribuyente where empresa = $empresa ";
$resultado_cliente=$connect->prepare($query_cliente);
$resultado_cliente->execute(); 
$num_reg_cliente=$resultado_cliente->rowCount();

$query_especialidad = "SELECT * FROM tbl_cita_especialidad where idempresa = $empresa ";
$resultado_especialidad=$connect->prepare($query_especialidad);
$resultado_especialidad->execute(); 
$num_reg_especialidad=$resultado_especialidad->rowCount();

 ?>

<div class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <form name="form_nueva_cita" id="form_nueva_cita">

    <div class="modal-content">

      <div class="modal-header bg-primary">
        <h4 class="modal-title" id="myModalLabel" style="color: white;">Nueva Cita</h4>
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true" style="color: white;">×</span>
        </button>
      </div>
      <div class="modal-body">
        <div class="row">
          <div class="col-sm-6">
            <input type="hidden" name="action"  value="nueva_cita">
            <input type="hidden" name="empresa" value="<?=$_SESSION["id_empresa"]?>">
            <label for="">Cliente:</label>
           
            <select class="form-control select2" style="width: 100%;" name="cliente" id="cliente">

                  <option selected="selected">Seleccionar Cliente</option>
                  <?php 
                  while($row_cliente = $resultado_cliente->fetch(PDO::FETCH_ASSOC) )
                  {?>
                  <option value="<?= $row_cliente['id_persona'] ?>"><?=$row_cliente['num_doc'] .' | '. $row_cliente['nombre_persona']?></option>;
                  <?php  } ?>
            </select>
          </div>

          <div class="col-sm-6">
            <label for="">Especialidad:</label>
            <select class="form-control select2" style="width: 100%;" name="especialidad" id="especialidad">

                  <option selected="selected">Seleccionar Especialidad</option>
                  <?php 
                  while($row_especialidad = $resultado_especialidad->fetch(PDO::FETCH_ASSOC) )
                  {?>
                  <option value="<?= $row_especialidad['id'] ?>"><?=$row_especialidad['nombre']?></option>;
                  <?php  } ?>
            </select>
          </div>
          <div class="col-sm-4">
            <label for="">Fecha:</label>
            <input type="date" class="form-control" name="fecha" id="fecha" required="">
          </div>
          <div class="col-sm-4">
            <label for="">Hora Inicio:</label>
            <input type="time" class="form-control" name="hora_ini" id="hora_ini" required="">
          </div>
          <div class="col-sm-4">
            <label for="">Hora Fin:</label>
            <input type="time" class="form-control" name="hora_fin" id="hora_fin" required="">
          </div>
          <div class="col-sm-12">
            <label for="">Comentario</label>
            <textarea class="form-control" name="comentario" id="comentario" cols="30" rows="10" onkeyup="javascript:this.value=this.value.toUpperCase();"></textarea>
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