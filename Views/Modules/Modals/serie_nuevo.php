<div class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" aria-hidden="true">
  <div class="modal-dialog modal-lg">
    <form name="form_series" id="form_series">

    <div class="modal-content">

      <div class="modal-header bg-primary">
        <h4 class="modal-title" id="myModalLabel" style="color: white;">Nueva Serie</h4>
        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true" style="color: white;">×</span>
        </button>
      </div>
      <div class="modal-body">
        <div class="row">
          <div class="col-sm-4">
            <input type="hidden" name="action"  value="nueva_serie">
            <input type="hidden" name="empresa" value="<?=$_SESSION["id_empresa"]?>">
            <label for="">Documento:</label>
            <select name="tdoc" id="tdoc" class="form-control">
              <?php 
            while($row_tipo_doc = $resultado_tipo_doc->fetch(PDO::FETCH_ASSOC) )
       {?>
        <option value="<?= $row_tipo_doc['cod'].'-'.$row_tipo_doc['id'] ?>"><?=$row_tipo_doc['nombre']?></option>;
       <?php  } ?>
            </select>
          </div>
          <div class="col-sm-4">
            <label for="">Serie:</label>
            <input type="text" onKeyPress="if(this.value.length==4) return false;" class="form-control" maxlength="4" onkeyup="javascript:this.value=this.value.toUpperCase();" name="serie" id="serie"  required="">
          </div>
          <div class="col-sm-4">
            <label for="">Correlativo:</label>
            <input type="number" onKeyPress="if(this.value.length==8) return false;" class="form-control" maxlength="8" max="99999999" value="1" name="correlativo" id="correlativo" />
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