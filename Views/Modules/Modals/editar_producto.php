<?php 


$query_unidad = "SELECT * FROM tbl_unidad ";
$resultado_unidad=$connect->prepare($query_unidad);
$resultado_unidad->execute(); 
$num_reg_unidad=$resultado_unidad->rowCount();

$query_marca = "SELECT * FROM tbl_marcas WHERE estado='1' AND empresa=$_SESSION[id_empresa]";
$resultado_marca=$connect->prepare($query_marca);
$resultado_marca->execute(); 
$num_reg_marca=$resultado_marca->rowCount();

$query_afectacion = "SELECT * FROM tbl_tipo_afectacion ";
$resultado_afectacion=$connect->prepare($query_afectacion);
$resultado_afectacion->execute(); 
$num_reg_afectacion=$resultado_afectacion->rowCount();

$query_categoria = "SELECT * FROM tbl_categorias WHERE empresa=$_SESSION[id_empresa]";
$resultado_categoria=$connect->prepare($query_categoria);
$resultado_categoria->execute(); 
$num_reg_categoria=$resultado_categoria->rowCount();

 ?>



<div id="edit" class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <form name="form_producto_edit" id="form_producto_edit" enctype="multipart/form-data">

    <div class="modal-content">


      <div class="modal-header bg-warning">
        <h4 class="modal-title" id="myModalLabel" style="color: white;">Editar Producto</h4>
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true" style="color: white;">×</span>
        </button>
      </div>
      <div class="modal-body">
        <div class="row">
          <div class="col-sm-8">
            <input type="hidden" name="action"  value="editar_producto">
            <input type="hidden" name="empresa" value="<?=$_SESSION["id_empresa"]?>">
            <input type="hidden" name="update_id" id="update_id" value="">
            <label for="">Nombre:</label>
            <input type="text" class="form-control" name="update_nombre" id="update_nombre"  onkeyup="javascript:this.value=this.value.toUpperCase();" required="">
          </div>
          <div class="col-sm-2">
            <label for="">Venta</label>
            <select name="update_dventa" id="update_dventa" class="form-control" >
              <option value="SI">SI</option>
              <option value="NO">NO</option>
            </select>
          </div>

          <div class="col-sm-2">
            <label for="">Factor</label>
            <input type="number" name="update_factor" id="update_factor" value="0" required class="form-control text-right" onkeyup="calcula_costo1()" onclick="calcula_costo1">
          </div>
          
          
        </div>
        <div class="row">
            <div class="col-sm-12">
              <label for="">Descripcion</label>
              <textarea name="update_descripcion" id="update_descripcion" cols="30" rows="5" class="form-control"></textarea>
            </div>
          </div>

        <div class="row">
         <div class="col-sm-4">
              <label for="">Marca</label>
       <select class="form-control" style="width: 100%;" name="update_marca" id="update_marca">
                  
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
   <select class="form-control" style="width: 100%;" name="update_unidad" id="update_unidad">
                  
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
       <select class="form-control" style="width: 100%;" name="update_afectacion" id="update_afectacion">
                  
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
            <input type="text" class="form-control" id="update_precio_compra" name="update_precio_compra" value="0.00" onkeyup="calcula_costo1()" required>
          </div>
         <div class="col-sm-4">
            <label for="">% Ganancia PV</label>
            <input type="text" class="form-control" id="update_por_gan1" name="update_por_gan1" value="0.00" required onkeyup="calcula_costo1()">
          </div>
          <div class="col-sm-4">
            <label for="">Precio Venta</label>
            <input type="text" class="form-control" id="update_precio_venta" name="update_precio_venta" required>
          </div>
         
        </div>
        <div class="row">
           <div class="col-sm-4">
            <label for="">% Ganancia PVM</label>
            <input type="text" class="form-control" id="update_por_gan2" name="update_por_gan2" value="0.00" required onkeyup="calcula_costo1()">
           
          </div>
          <div class="col-sm-4">
            <label for="">Precio Venta x mayor</label>
            <input type="text" class="form-control" id="update_precio_venta2" name="update_precio_venta2" required>
          </div>
          <div class="col-sm-4">
            <label for="">Codigo de Barras</label>
            <input type="text" class="form-control" id="update_cod_barras" name="update_cod_barras" value="" required>
          </div>
        </div>

        <div class="row">
           <div class="col-sm-4">
             <label for="customFile">Cargar Imagen</label>
            <input type="file" accept="image/*" name="update_imagen" id="update_imagen" class="form-control">
            <input type="hidden" name="update_last_imagen" id="update_last_imagen">
           </div>
           <div class="col-sm-4">
             <label for="customFile">Stock</label>
            <input type="text" class="form-control text-right" name="update_stock1" id="update_stock1">
           </div>
           <div class="col-sm-4">
              <label for="">Categoria</label>
       <select class="form-control" style="width: 100%;" name="update_categoria" id="update_categoria">
                  
    <option selected="selected">Seleccionar Categoria</option>
    <?php 
            while($row_categoria = $resultado_categoria->fetch(PDO::FETCH_ASSOC) )
       {?>
        <option value="<?= $row_categoria['id'] ?>"><?=$row_categoria['nombre']?></option>;
       <?php  } ?>
  </select>
          </div>

        </div>
        <div class="row mt-3">
          <div class="col-sm-6">
            <div class="card-deck mb-4">
              
              <div class="card border-0 bg-transparent">
                <img id="img1" src="" class="card-img-top img-fluid rounded" alt="" width="10px">
              </div>
            </div>
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



