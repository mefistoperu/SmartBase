<?php 

$lista11=$connect->query("SELECT * FROM vw_tbl_venta_cab WHERE empresa= $empresa AND tipocomp in ('01','03')");
$resultado11=$lista11->fetchAll(PDO::FETCH_OBJ);


 ?>

 <!--=====================================
  MODAL TIPO DE PROVEEDOR
  ======================================-->
  <div id="modalDocrefGre" class="modal fade" role="dialog">
    <div class="modal-dialog modal-lg">
      <div class="modal-content">
  <!--=====================================
  MODAL CABECERA
  ======================================-->
      <div class="modal-header bg-dark" >
        <h4 class="text-left">Seleccionar Documento de referencia</h4>
        <button type="button" class="close" data-dismiss="modal">&times;</button>
        
      </div>
  <!--=====================================
  MODAL CUERPO
  ======================================-->
      <div class="modal-body">
      <table id="datatable-contribuyente" class="table table-bordered table-striped table-condensed table-hover" width="100%">
       <thead class="bg-dark" style="color: white">
          <tr>
            <th>Id</th>
            <th>Tipo</th>
           <th>Serie</th>
           <th>Numero</th>
           <th>Cliente</th>
           <th>Accion</th>
          </tr>
        </thead>
        <tbody>
          <?php foreach ($resultado11 as $res21) { ?>
            <tr>
              <td><?php echo $res21->id ?></td>
              <td><?php echo $res21->tipocomp ?></td>
              <td><?php echo $res21->serie ?></td>
               <td><?php echo $res21->correlativo ?></td>
               <td><?php echo $res21->nombre_persona ?></td>
              <td  class="text-center"><a class="btn btn-success rounded-circle" onclick="enviadocgre('<?php echo $res21->id; ?>','<?php echo $res21->tipocomp; ?>','<?php echo $res21->nomdoc; ?>','<?php echo $res21->serie; ?>','<?php echo $res21->correlativo; ?>','<?php echo $res21->idcliente; ?>','<?php echo $res21->num_doc; ?>','<?php echo $res21->nombre_persona; ?>','<?php echo $res21->direccion_persona; ?>','<?php echo $res21->op_gravadas; ?>','<?php echo $res21->op_exoneradas; ?>','<?php echo $res21->op_inafectas; ?>','<?php echo $res21->igv; ?>','<?php echo $res21->total; ?>');"><i class="fe fe-check"></i></a></td>
            </tr>
          <?php } ?>
        </tbody>
         
       </table>
      </div>
  <!--=====================================
  MODAL PIE
  ======================================-->
      <div class="modal-footer">
           <button type="button" class="btn btn-danger" data-dismiss="modal">Cerrar</button>
         </div>
    </div>
    </div>
  </div>


  