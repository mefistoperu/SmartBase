<?php 

$empresa = $_SESSION["id_empresa"];

$query_data = "SELECT * FROM tbl_empresas WHERE id_empresa=$empresa";
$resultado = $connect->prepare($query_data);
$resultado->execute();
$row_empresa = $resultado->fetch(PDO::FETCH_ASSOC);

?>
<!DOCTYPE html>
<html lang="en">
  <head>
        <?php include 'Views/Templates/head.php' ?>
  </head>

  <body class="nav-md">
    <div class="container body">
      <div class="main_container">
        <?php include 'Views/Templates/menu.php' ?>
        <?php include 'Views/Templates/cabezote.php' ?>

        <!-- page content -->
        <div class="right_col" role="main">
          <div class="">
            <div class="page-title">
              <div class="title_left">
                <h3>Empresa</h3>
              </div>

             
            </div>

            <div class="clearfix"></div>

            <div class="row">
              <div class="col-md-12 col-sm-12  ">
               <form name="datos_empresa" id="datos_empresa" enctype="multipart/form-data">
                <div class="x_panel">
                  <div class="x_title">
                    <h2>Datos de la Empresa <button class="btn btn-success" type="submit"><i class="fa fa-save"></i> Guardar</button></h2>
                    
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">

                    <ul class="nav nav-tabs bar_tabs" id="myTab" role="tablist">
                      <li class="nav-item">
                        <a class="nav-link active" id="home-tab" data-toggle="tab" href="#home" role="tab" aria-controls="home" aria-selected="true">Datos Generales</a>
                      </li>
                      <li class="nav-item">
                        <a class="nav-link" id="profile-tab" data-toggle="tab" href="#profile" role="tab" aria-controls="profile" aria-selected="false">Facturación</a>
                      </li>
                      <li class="nav-item">
                        <a class="nav-link" id="contact-tab" data-toggle="tab" href="#contact" role="tab" aria-controls="contact" aria-selected="false">Contabilidad</a>
                      </li>
                    </ul>
                 
                    <div class="tab-content" id="myTabContent">
                      <div class="tab-pane fade  active show" id="home" role="tabpanel" aria-labelledby="home-tab">
                                <div class="row">
                                  <div class="col-sm-6">
                                    <label for="">R.U.C.</label>
                                    <input type="hidden" name="action" value="datosEmpresa">
                                    <input type="hidden" name="id" id="id" value="<?=$empresa?>">
                                  <input type="text" class="form-control" placeholder="RUC" value="<?=$row_empresa['ruc']?>" name="ruc" id="ruc">
                                  </div>
                                  <div class="col-sm-6">
                                    <label for="">Razon Social</label>
                                  <input type="text" name="razon" id="razon" class="form-control" placeholder="Razon Social" value="<?=$row_empresa['razon_social']?>">
                                  </div>
                                </div>
                                <div class="row">
                                  <div class="col-sm-12">
                                    <label for="">Direccion</label>
                                  <input type="text" name="direccion" id="direccion" class="form-control" placeholder="Direccion" value="<?=$row_empresa['direccion']?>">
                                  </div>
                                </div>
                                <div class="row">
                                  <div class="col-sm-3">
                                    <label for="">Ubigeo</label>
                                  <input type="text" class="form-control" name="ubigeo"  id="ubigeo" placeholder="Ubigeo" value="<?=$row_empresa['ubigeo']?>">
                                  </div>
                                  <div class="col-sm-3">
                                    <label for="">Distrito</label>
                                  <input type="text" class="form-control" name="distrito" id="distrito" placeholder="Distrito" value="<?=$row_empresa['distrito']?>">
                                  </div>
                                  <div class="col-sm-3">
                                    <label for="">Provincia</label>
                                  <input type="text" class="form-control" name="provincia" id="provincia" placeholder="Provincia" value="<?=$row_empresa['provincia']?>">
                                  </div>
                                  <div class="col-sm-3">
                                    <label for="">Departamento</label>
                                  <input type="text" class="form-control" name="departamento" id="departamento" placeholder="Departamento" value="<?=$row_empresa['departamento']?>">
                                  </div>
                                </div>
                                <div class="row">
                                  <div class="col-sm-6">
                                    <label for="">Correo</label>
                                    <input type="text" class="form-control" name="correo" id="correo" placeholder="Correo" value="<?=$row_empresa['correo']?>">
                                  </div>
                                 <div class="col-sm-3">
                                    <label for="">Cta Detracciones</label>
                                    <input type="text" class="form-control" name="detraccion" id="detraccion" placeholder="Correo" value="<?=$row_empresa['cta_detracciones']?>">
                                 </div>
                                 <div class="col-sm-3">
                                    <label for="">Porcentaje IGV</label>
                                    <input type="text" class="form-control" name="por_igv" id="por_igv" placeholder="Correo" value="<?=$row_empresa['por_igv']?>">
                                 </div>

                                </div>
                                <div class="row">
                                  <div class="col-sm-4">
                                  <label for="">Logo</label>
                                  <input type="file" name="update_logo" id="update_logo" class="form-control">
                                  <input type="hidden" name="last_logo" id="last_logo" value="<?=$row_empresa['logo']?>">
                                 </div>

                                 
                                </div>

                                <div class="row">
                                  
                                  <div class="col-sm-4 mt-3">
                                  <img src="<?=media()?>/images/<?php if(empty($row_empresa['logo'])){$logo='logo.jpg';}else{$logo=$row_empresa['logo'];} echo $logo; ?>" alt="" width="80%">
                                 </div>
                                </div>

                      </div>
                     
                      <div class="tab-pane fade" id="profile" role="tabpanel" aria-labelledby="profile-tab">
                        <div class="row">
                          <div class="col-sm-6">
                            <label for="">Usuario SOL</label>
                            <input type="text" class="form-control" name="usuario_sol" id="usuario_sol" placeholder="Usuario SOL" value="<?=$row_empresa['usuario_sol']?>">
                          </div>
                          <div class="col-sm-6">
                            <label for="">clave SOL</label>
                            <input type="text" class="form-control" name="clave_sol" id="clave_sol" placeholder="Clave SOL" value="<?=$row_empresa['clave_sol']?>">
                          </div>
                        </div>
                        <hr>
                        <div class="row">
                          <div class="col-sm-6">
                            <label for="">Certificado Digital</label>
                            <input type="text" class="form-control" name="certificado" id="certificado" placeholder="Certificado Digital" value="<?=$row_empresa['certificado']?>">
                          </div>
                          <div class="col-sm-6">
                            <label for="">clave certificado</label>
                            <input type="text" class="form-control" name="clave_certificado" id="clave_certificado" placeholder="Clave certificado" value="<?=$row_empresa['clave_certificado']?>">
                          </div>
                        </div>
                        <hr>
                        <div class="row">
                          <div class="col-sm-6">
                            <label for="">Comentarios</label>
                            <textarea name="comentario" id="comentario" cols="30" rows="10" class="form-control"><?=nl2br($row_empresa['comentario'])?></textarea>
                          </div>
                        </div>
                      </div>
                      <div class="tab-pane fade" id="contact" role="tabpanel" aria-labelledby="contact-tab">
                        <div class="row">
                          <div class="col-sm-4">
                            <label for="">Cuenta x Cobrar Soles</label>
                            <input type="text" class="form-control" name="cta_cobrar_soles" id="cta_cobrar_soles" placeholder="Cuenta x Cobrar Soles" value="<?=$row_empresa['cta_cobrar_soles']?>">
                          </div>
                          <div class="col-sm-4">
                            <label for="">Cuenta x Cobrar Dolares</label>
                            <input type="text" class="form-control" name="cta_cobrar_dolar" id="cta_cobrar_dolar" placeholder="Cuenta x Cobrar Dolares" value="<?=$row_empresa['cta_cobrar_dolar']?>">
                          </div>
                          <div class="col-sm-4">
                            <label for="">IGV Ventas</label>
                            <input type="text" placeholder="IGV Ventas" name="cta_igv_venta" id="cta_igv_venta" class="form-control" value="<?=$row_empresa['cta_igv_venta']?>">
                          </div>
                        </div>
                        <hr>
                        <div class="row">
                          <div class="col-sm-3">
                            <label for="">Origen Ventas</label>
                            <input type="text" class="form-control" placeholder="Origen Ventas" name="origen_venta" id="origen_venta" value="<?=$row_empresa['origen_venta']?>">
                          </div>
                          <div class="col-sm-3">
                            <label for="">Origen Cobranzas</label>
                            <input type="text" class="form-control" name="origen_cobranzas" id="origen_cobranzas" placeholder="Origen Cobranzas" value="<?=$row_empresa['origen_cobranzas']?>">
                          </div>
                          <div class="col-sm-3">
                            <label for="">Origen Compras</label>
                            <input type="text" class="form-control" placeholder="Origen Compras" name="origen_compra" id="origen_compra" value="<?=$row_empresa['origen_compra']?>">
                          </div>
                          <div class="col-sm-3">
                            <label for="">Origen Pagos</label>
                            <input type="text" class="form-control" name="origen_pagos" id="origen_pagos" placeholder="Origen Pagos" value="<?=$row_empresa['origen_pagos']?>">
                          </div>
                          
                        </div>
                        <hr>
                        <div class="row">
                          <div class="col-sm-4">
                            <label for="">Cuenta x Pagar Soles</label>
                            <input type="text" class="form-control" id="cta_pagar_soles" name="cta_pagar_soles" placeholder="Cuenta x Pagar Soles" value="<?=$row_empresa['cta_pagar_soles']?>">
                          </div>
                          <div class="col-sm-4">
                            <label for="">Cuenta x Pagar Dolares</label>
                            <input type="text" class="form-control" name="cta_pagar_dolar" id="cta_pagar_dolar" placeholder="Cuenta x Pagar Dolares" value="<?=$row_empresa['cta_pagar_dolar']?>">
                          </div>
                          <div class="col-sm-4">
                            <label for="">IGV Compras</label>
                            <input type="text" placeholder="IGV Compras" name="cta_igv_compra" id="cta_igv_compra" class="form-control" value="<?=$row_empresa['cta_igv_compra']?>">
                          </div>
                        </div>
                      </div>

                    </div>
              

                  </div>
                </div>
         
              </div>
             </form>
            </div>
          </div>
        </div>
        <!-- /page content -->
        <?php include 'Views/Templates/pie.php' ?>
      </div>
    </div>
  
      <?php include 'Views/Templates/footer.php' ?>


</html>
