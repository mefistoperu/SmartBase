 <!--=====================================
  MODAL TIPO DE PROVEEDOR
  ======================================-->
  <div id="modalDocref" class="modal fade" role="dialog">
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
            <th>Tipo</th>
           <th>Serie</th>
        <th>Fecha Emision</th>
           <th>Numero</th>
           <th>Cliente</th>
           <th>Accion</th>
          </tr>
        </thead>
        <tbody>
          <?php foreach ($resultado1 as $res2) { ?>
            <tr>
              <td><?php echo $res2->tipocomp ?></td>
              <td><?php echo $res2->serie ?></td>
              <td><?php echo $res2->fecha_emision ?></td>
               <td><?php echo $res2->correlativo ?></td>
               <td><?php echo $res2->nombre_persona ?></td>
              <td  class="text-center"><a class="btn btn-success" onclick="enviaclientenc('<?php echo $res2->id; ?>','<?php echo $res2->tipocomp; ?>','<?php echo $res2->nomdoc; ?>','<?php echo $res2->serie; ?>','<?php echo $res2->correlativo; ?>','<?php echo $res2->idcliente; ?>','<?php echo $res2->num_doc; ?>','<?php echo $res2->nombre_persona; ?>','<?php echo $res2->direccion_persona; ?>','<?php echo $res2->op_gravadas; ?>','<?php echo $res2->op_exoneradas; ?>','<?php echo $res2->op_inafectas; ?>','<?php echo $res2->igv; ?>','<?php echo $res2->total; ?>');"><i class="fe fe-check"></i></a></td>
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


  