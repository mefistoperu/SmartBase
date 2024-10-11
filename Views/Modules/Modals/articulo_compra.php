<?php 

$query_data = "SELECT * FROM tbl_productos WHERE estado='1' AND empresa =  $_SESSION[id_empresa]";
$resultado_data=$connect->prepare($query_data);
$resultado_data->execute();
$num_reg_data=$resultado_data->rowCount();

$query_data1 = "SELECT * FROM tbl_productos WHERE estado='1' AND empresa =  $_SESSION[id_empresa]";
$resultado_data1=$connect->prepare($query_data1);
$resultado_data1->execute();
$num_reg_data1=$resultado_data1->rowCount();

 ?>
<!-- Modal -->


<div class="modal fade" id="addProdcuto1" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog modal-lg" role="document">
  
    <div class="modal-content">
      <div class="modal-header bg-primary" style="color: white">
        <h4 class="modal-title" id="exampleModalLabel">Agregar Productos</h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true" style="color: white">&times;</span>
        </button>
      </div>

      <div class="modal-body">
            <div class="container-fluid">
              <table id="datatable-insumos" class="table table-striped table-bordered dt-responsive nowrap table-compact" cellspacing="0" width="100%">
                <thead>
                  <tr>
                    <th width="10%">Codigo</th>
                    <th>Nombre</th>
                   
                    
                    <th align="right">Precio Compra</th>
                    <th>Unidad</th>
                    <th>Acciones</th>
                  </tr>
                </thead>
                <tbody>
                       <?php while($row1 = $resultado_data1->fetch(PDO::FETCH_ASSOC) ) { ?>
                          <tr>
                           <td width="10%"><?php echo $row1['id'] ?></td>
                            <td><?php echo $row1['nombre'] ?></td>
                            <td width="10%" align="right"><?php echo $row1['costo'] ?></td>
                            <td width="10%"><?php echo $row1['unidad'] ?></td>
                            <td width="10%">
                              <button type="button" class="btn btn-primary rounded-circle" onclick="agregarc('<?=$row1['id']?>','<?php echo $row1['nombre'] ?>','<?php echo $row1['costo'] ?>','<?php echo $row1['afectacion'] ?>','<?php echo $row1['por1'] ?>','<?php echo $row1['por2'] ?>','<?php echo $row1['precio_venta'] ?>','<?php echo $row1['precio2'] ?>','<?php echo $row1['factor'] ?>')"><i class="fa fa-plus"></i></button>
                            </td>
                          </tr>
                        <?php } ?>
                </tbody>
            
              </table>
            </div>
      </div>
   
    </div>
    
  </div>
</div>



