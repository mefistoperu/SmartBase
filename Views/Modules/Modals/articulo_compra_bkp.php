<?php 

$query_data = "SELECT * FROM tbl_insumos WHERE estado='1' AND empresa =  $_SESSION[id_empresa]";
$resultado_data=$connect->prepare($query_data);
$resultado_data->execute();
$num_reg_data=$resultado_data->rowCount();

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
                   
                    
                    <th align="right">Precio Compra</th>
                    <th>Acciones</th>
                  </tr>
                </thead>
                <tbody>
                       <?php while($row = $resultado_data->fetch(PDO::FETCH_ASSOC) ) { ?>
                          <tr>
                           <td width="10%"><?php echo $row['id'] ?></td>
                            <td><?php echo $row['nombre'] ?></td>
                           
                            
                            
                             <td width="10%"><?php echo $row['precio_compra'] ?></td>
                            <td width="10%">
                              <button type="button" class="btn btn-primary rounded-circle" onclick="agregar('<?=$row['codigo']?>','<?php echo $row['nombre'] ?>','<?php echo $row['precio_compra'] ?>')"><i class="fa fa-plus"></i></button>
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