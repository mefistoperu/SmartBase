<?php 

$query_data = "SELECT 
p.id as id,
p.nombre as nombre,
p.precio_venta as precio_venta,
p.precio2 as precio2,
p.afectacion as afectacion,
p.costo as costo,
m.nombre as marca,
p.estado as estado,
p.empresa as empresa
from tbl_productos as p LEFT JOIN tbl_marcas as m 
on p.marca = m.id WHERE p.estado='1' AND p.empresa =  $_SESSION[id_empresa]";
$resultado_data=$connect->prepare($query_data);
$resultado_data->execute();
$num_reg_data=$resultado_data->rowCount();

$query_data1 = "SELECT 
p.id as id,
p.nombre as nombre,
p.precio_venta as precio_venta,
p.precio2 as precio2,
p.afectacion as afectacion,
p.costo as costo,
m.nombre as marca,
p.estado as estado,
p.empresa as empresa
from tbl_productos as p LEFT JOIN tbl_marcas as m 
on p.marca = m.id WHERE p.estado='1' AND p.empresa =  $_SESSION[id_empresa]";
$resultado_data1=$connect->prepare($query_data1);
$resultado_data1->execute();
$num_reg_data1=$resultado_data1->rowCount();

 ?>
<!-- Modal -->
<div class="modal fade" id="addProdcuto" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
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
                   
                     <th>Marca</th>
                    <th align="right">Precio Venta</th>

                    <th>Acciones</th>
                  </tr>
                </thead>
                <tbody>
                       <?php while($row = $resultado_data->fetch(PDO::FETCH_ASSOC) ) { ?>
                          <tr>
                           <td width="10%"><?php echo $row['id'] ?></td>
                            <td><?php echo $row['nombre'] ?></td>                         
                            <th><?php echo $row['marca'] ?></th>
                            
                             <td width="10%"><?php echo $row['precio_venta'] ?></td>
                            <td width="10%">
                              <button type="button" class="btn btn-primary rounded-circle" onclick="agregar('<?=$row['id']?>','<?php echo $row['nombre'] ?>','<?php echo $row['precio_venta'] ?>','<?php echo $row['afectacion'] ?>','<?php echo $row['costo'] ?>')"><i class="fa fa-plus"></i></button>
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
              <table id="datatable-insumos1" class="table table-striped table-bordered dt-responsive nowrap table-compact" cellspacing="0" width="100%">
                <thead>
                  <tr>
                    <th width="10%">Codigo</th>
                    <th>Nombre</th>
                   <th>Marca</th>
                    
                    <th align="right">Precio Venta</th>
                    <th>Acciones</th>
                  </tr>
                </thead>
                <tbody>
                       <?php while($row1 = $resultado_data1->fetch(PDO::FETCH_ASSOC) ) { ?>
                          <tr>
                           <td width="10%"><?php echo $row1['id'] ?></td>
                            <td><?php echo $row1['nombre'] ?></td>
                           
                            <th><?php echo $row1['marca'] ?></th>
                            
                             <td width="10%"><?php echo $row1['precio2'] ?></td>
                            <td width="10%">
                              <button type="button" class="btn btn-primary rounded-circle" onclick="agregar('<?=$row1['id']?>','<?php echo $row1['nombre'] ?>','<?php echo $row1['precio2'] ?>','<?php echo $row1['afectacion'] ?>','<?php echo $row1['costo'] ?>')"><i class="fa fa-plus"></i></button>
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