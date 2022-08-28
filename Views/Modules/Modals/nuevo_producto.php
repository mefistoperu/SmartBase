<?php 

$query_unidad = "SELECT * FROM tbl_unidad ";
$resultado_unidad=$connect->prepare($query_unidad);
$resultado_unidad->execute(); 
$num_reg_unidad=$resultado_unidad->rowCount();

$query_marca = "SELECT * FROM tbl_marcas WHERE estado='1' AND empresa=$_SESSION[id_empresa]";
$resultado_marca=$connect->prepare($query_marca);
$resultado_marca->execute(); 
$num_reg_marca=$resultado_marca->rowCount();



$query_afectacion = "SELECT * FROM tbl_tipo_afectacion";
$resultado_afectacion=$connect->prepare($query_afectacion);
$resultado_afectacion->execute(); 
$num_reg_afectacion=$resultado_afectacion->rowCount();

 ?>


<div class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <form name="form_producto" id="form_producto">

    <div class="modal-content">


      <div class="modal-header bg-primary">
        <h4 class="modal-title" id="myModalLabel" style="color: white;">Nuevo Producto</h4>
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true" style="color: white;">×</span>
        </button>
      </div>
      <div class="modal-body">
        <div class="row">
          <div class="col-sm-9">
            <input type="hidden" name="action"  value="nuevo_producto">
            <input type="hidden" name="empresa" value="<?=$_SESSION["id_empresa"]?>">
            <label for="">Nombre:</label>
            <input type="text" class="form-control" name="nombre" id="nombre"  onkeyup="javascript:this.value=this.value.toUpperCase();" required="">
          </div>
          <div class="col-sm-3">
            <label for="">Factor</label>
            <input type="number" name="factor" id="factor" value="0" required class="form-control text-right" onkeyup="calcula_costo()">
          </div>
          
          
        </div>
        <div class="row">
            <div class="col-sm-12">
              <label for="">Descripcion</label>
              <textarea name="descripcion" id="descripcion" cols="30" rows="5" class="form-control"></textarea>
            </div>
          </div>
        <div class="row">
                 <div class="col-sm-4">
                      <label for="">Marca</label>
               <select class="form-control select2" style="width: 100%;" name="marca" id="marca">
                          
            <option selected="selected">Seleccionar Marca</option>
            <?php 
                    while($row_marca = $resultado_marca->fetch(PDO::FETCH_ASSOC) )
               {?>
                <option value="<?= $row_marca['id'] ?>"><?=$row_marca['nombre']?></option>;
               <?php  } ?>
          </select>
                  </div>
                            <div class="col-sm-4">
                      <label for="">Unidad</label>
            <select class="form-control select2" style="width: 100%;" name="unidad" id="unidad">
                          
                <option selected="selected">Seleccionar Unidad</option>
                <?php 
                        while($row_unidad = $resultado_unidad->fetch(PDO::FETCH_ASSOC) )
                   {?>
                    <option value="<?= $row_unidad['cod'] ?>"><?=$row_unidad['cod'] .' | '. $row_unidad['nombre']?></option>;
                   <?php  } ?>
            </select>
                  </div>
                  <div class="col-sm-4">
                      <label for="">Afectacion</label>
               <select class="form-control select2" style="width: 100%;" name="afectacion" id="afectacion">
                          
            <option selected="selected">Seleccionar Afectacion</option>
            <?php 
                    while($row_afectacion = $resultado_afectacion->fetch(PDO::FETCH_ASSOC) )
               {?>
                <option value="<?= $row_afectacion['codigo'] ?>"><?=$row_afectacion['descripcion']?></option>;
               <?php  } ?>
          </select>
          </div>
        </div>

        <div class="row">
          <div class="col-sm-4">
            <label for="">Precio Compra</label>
            <input type="text" class="form-control" id="precio_compra" name="precio_compra" value="0.00" onkeyup="calcula_costo()" required>
          </div>
   
                
           <div class="col-sm-4">
            <label for="">% Ganancia PV</label>
            <input type="text" class="form-control" id="por_gan1" name="por_gan1" value="0.00" required onkeyup="calcula_costo()">
          </div>
          <div class="col-sm-4">
            <label for="">Precio Venta</label>
            <input type="text" class="form-control" id="precio_venta" name="precio_venta" value="0.00"  required>
          </div>
        </div>
        <div class="row">
                  
          <div class="col-sm-4">
            <label for="">% Ganancia PVM</label>
            <input type="text" class="form-control" id="por_gan2" name="por_gan2" value="0.00" required onkeyup="calcula_costo()">
           
          </div>


          <div class="col-sm-4">
            <label for="">Precio Venta x mayor</label>
            <input type="text" class="form-control" id="precio_venta2" name="precio_venta2" value="0.00" required>
          </div>
        
        <div class="col-sm-4">
            <label for="">Codigo de Barras</label>
            <input type="text" class="form-control" id="cod_barras" name="cod_barras" value="" required>
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



