<div class="modal fade" id="ModalValidaCpe">
<div class="modal-dialog modal-xl" role="document">
      <div class="modal-content">
            <div class="modal-header bg-success">
                  <h4 class="modal-title">Validar un comprobante en SUNAT</h4>
                  <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                  </button>
            </div>
        <div class="modal-body"> 
           <div class="row p-2">
                <div class="col-sm-5">
            <div class="row">
                <div class="col-sm-12">
                  <label>Documento</label>
                  <input type="hidden" name="idcpeconsulta" id="idcpeconsulta" readonly="">
                  <input name="documento" id="documento" class="form-control" readonly="">
                </div>
                <div class="col-sm-12">
                  <label>Respuesta de SUNAT</label>
                  <textarea name="respuesta" id="respuesta" cols="10"  rows="3" class="form-control" readonly=""></textarea>
                </div>
               
            </div>
            
            
            </div>
            <div class="col-sm-7">
                <div class="row">
                <div class="col-sm-3">
                    <button class="btn btn-success btn-block mt-3" onclick="cambiaEstado('1')">Aceptado</button>
                </div>
                <div class="col-sm-3">
                    <button class="btn btn-primary btn-block mt-3" onclick="cambiaEstado('0')">Liberar</button>
                </div>
                <div class="col-sm-3">
                    <button class="btn btn-danger btn-block mt-3" onclick="cambiaEstado('5')">Baja Aceptada</button>
                </div>
                <div class="col-sm-3">
                    <button class="btn btn-warning btn-block mt-3" onclick="cambiaEstado('3')">Rechazado</button>
                </div>
                
                <div class="col-sm-3">
                    <button class="btn btn-info btn-block mt-3" onclick="reenviarCpe()">Reenviar CPE</button>
                </div>
                <div class="col-sm-3">
                    <button class="btn btn-dark btn-block mt-3" onclick="TraeCdr()">Traer CDR</button>
                </div>
            
            </div>
            
            </div>
            <div class="col-sm-12">
                <hr>
                <label>Aceptado: Si la respuesta de SUNAT indica que esta aceptado puede cambiar el estado a aceptado.</label>
                <label>Liberar: Si el sistema indica aceptado/rechazado y sunat indica que no esta en sus servidores, puede liberarlos para poder reenviarlo.</label>
                <label>Anulado: Si el sistema indica aceptado y sunat indica anulado, puede cambiar el estado a anulado.</label>
                <label>Anulado: Si el sistema indica aceptado y sunat indica rechazado, puede cambiar el estado a rechazado.</label>
               
                <label>Re-enviar: Si el comprobante esta como pendiente y la respuesta de sunat es que no esta en sus servidores, puede reenviarlo.</label>
                <p></p>
                <label>Traer CDR: Descarga el CDR del comprobante.</label>
            </div>
           </div>
           
      </div>
      <div class="modal-footer justify-content-between">
              <button type="button" class="btn btn-danger" data-dismiss="modal"><i class="far fa-times-circle"></i> Close</button>
             
            </div>
    </div>
  </div>



