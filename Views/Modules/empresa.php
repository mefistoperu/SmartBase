<?php 

$empresa = $_SESSION["id_empresa"];

$query_data = "SELECT * FROM tbl_empresas WHERE id_empresa=$empresa";
$resultado = $connect->prepare($query_data);
$resultado->execute();
$row_empresa = $resultado->fetch(PDO::FETCH_ASSOC);

$query_contribuyente = "SELECT * FROM tbl_contribuyente WHERE empresa =$empresa";
$resultado_contribuyente=$connect->prepare($query_contribuyente);
$resultado_contribuyente->execute(); 
$num_reg_contribuyente=$resultado_contribuyente->rowCount();


?>
<!doctype html>
<html lang="en">
  <head>
       <?php include 'views/template/head.php' ?>
       <link  href="https://write.corbpie.com/wp-content/litespeed/localres/aHR0cHM6Ly9jZG5qcy5jbG91ZGZsYXJlLmNvbS8=ajax/libs/bootswatch/4.5.0/flatly/bootstrap.min.css"/>
   
  </head>

  <body class="horizontal dark  ">
    <div class="wrapper">
      <?php
       if($_SESSION['perfil']=='1')
       {
       include 'views/template/nav.php';
       }
       else
       {
       include 'views/template/nav_ventas.php';
       } ?>
      
      <main role="main" class="main-content">
        <div class="container-fluid">
          <div class="row justify-content-center">
            <div class="col-12">
              <div class="row align-items-center mb-2">
                <div class="col">
                  <h2 class="h5 page-title">Bienvenido </h2>
                </div>
                <div class="col-auto">
                  <form class="form-inline" enctype="multipart/form-data">
                    <div class="form-group d-none d-lg-inline">
                      <label for="reportrange" class="sr-only">Date Ranges</label>
                      <div id="reportrange" class="px-2 py-2 text-muted">
                        <span class="small"></span>
                      </div>
                    </div>
                    <div class="form-group">
                      <button type="button" class="btn btn-sm"><span class="fe fe-refresh-ccw fe-16 text-muted"></span></button>
                      <button type="button" class="btn btn-sm mr-2"><span class="fe fe-filter fe-16 text-muted"></span></button>
                    </div>
                  </form>
                </div>
              </div>
              <hr>
              

              <div class="row my-4">
                      <div class="col-md-12">
                         <form name="datos_empresa" id="datos_empresa" enctype="multipart/form-data">
                        <div class="card shadow">
                          <div class="card-header">
                              <h2>Datos de la Empresa <button class="text-white btn btn-success btn-lg ml-3" type="submit"><i class="fas fa-save"></i> Actualizar</button></h2>
                          </div>
                         <div class="card-body">
                      <ul class="nav nav-tabs mb-3" id="myTab" role="tablist">
                        <li class="nav-item">
                          <a class="nav-link active" id="home-tab" data-toggle="tab" href="#home" role="tab" aria-controls="home" aria-selected="true">Datos Generales</a>
                        </li>
                        <li class="nav-item">
                          <a class="nav-link" id="profile-tab" data-toggle="tab" href="#profile" role="tab" aria-controls="profile" aria-selected="false">Facturación</a>
                        </li>
                        <li class="nav-item">
                          <a class="nav-link" id="contact-tab" data-toggle="tab" href="#contact" role="tab" aria-controls="contact" aria-selected="false">Contabilidad</a>
                        </li>
                        <li class="nav-item">
                          <a class="nav-link" id="mail-tab" data-toggle="tab" href="#mail" role="tab" aria-controls="mail" aria-selected="false">Correo</a>
                        </li>
                        <li class="nav-item">
                          <a class="nav-link" id="sire-tab" data-toggle="tab" href="#sire" role="tab" aria-controls="sire" aria-selected="false">SIRE / GRE</a>
                        </li>
                      </ul>
                     <div class="tab-content" id="myTabContent">
                      <div class="tab-pane fade  active show" id="home" role="tabpanel" aria-labelledby="home-tab">
                         
                          <hr>
                                <div class="row">
                                  <div class="col-sm-4">
                                    <label for="">R.U.C.</label>
                                    <input type="hidden" name="action" value="datosEmpresa">
                                    <input type="hidden" name="id" id="id" value="<?=$empresa?>">
                                  <input type="text" class="form-control" placeholder="RUC" value="<?=$row_empresa['ruc']?>" name="ruc" id="ruc">
                                  </div>
                                  <div class="col-sm-4">
                                    <label for="">Razon Social</label>
                                  <input type="text" name="razon" id="razon" class="form-control" placeholder="Razon Social" value="<?=$row_empresa['razon_social']?>">
                                  </div>
                                  <div class="col-sm-4">
                                    <label for="">Nombre Comercial </label>
                                  <input type="text" name="nombre_comercial" id="nombre_comercial" class="form-control" placeholder="Nombre comercial" value="<?=$row_empresa['nombre_comercial']?>">
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
                                  <div class="col-sm-2">
                                    <label for="">Top Productos</label>
                                    <input type="number" class="form-control" name="top1" id="top1" value="<?=$row_empresa['top1']?>">
                                  </div>
                                  <div class="col-sm-2">
                                    <label for="">Top Clientes</label>
                                    <input type="number" class="form-control" name="top2" id="top2" value="<?=$row_empresa['top2']?>">
                                  </div>
                                  <div class="col-sm-2">
                            <label for="">Edita detalle venta</label>
                            <select class="form-control select2" style="width: 100%;" name="detalle" id="detalle">
                              
                              <option <?= $row_empresa['detalle'] ==='SI' ? "selected='selected'": "" ?> value="SI">SI</option>
                              <option <?= $row_empresa['detalle'] ==='NO' ? "selected='selected'": "" ?> value="NO">NO</option>
                            </select>
                          </div>
                          <div class="col-sm-2">
                            <label for="">Edita precio venta</label>
                            <select class="form-control select2" style="width: 100%;" name="precio" id="precio">
                              
                              <option <?= $row_empresa['precio'] ==='SI' ? "selected='selected'": "" ?> value="SI">SI</option>
                              <option <?= $row_empresa['precio'] ==='NO' ? "selected='selected'": "" ?> value="NO">NO</option>
                            </select>
                          </div>
                                </div>
                                <div class="row">
                                  <div class="col-sm-3">
                                  <label for="">Logo</label>
                                  <input type="file" name="update_logo" id="update_logo" class="form-control">
                                  <input type="hidden" name="last_logo" id="last_logo" value="<?=$row_empresa['logo']?>">
                                 </div>
                                 <div class="col-sm-3">
                                  <label for="">Telefono</label>
                                  <input type="text" name="update_telefono" id="update_telefono" class="form-control"  value="<?=$row_empresa['telefono']?>">
                                  
                                 </div>
                                 <div class="col-sm-3">
                                  <label for="">Celular</label>
                                  <input type="text" name="update_celular" id="update_celular" class="form-control"  value="<?=$row_empresa['celular']?>">
                                  
                                 </div>
                                 <div class="col-sm-3">
                                  <label for="">Venta x Mayor</label>
                                  <select name="update_venta_mayor" id="update_venta_mayor" class="form-control">
                                    <option <?= $row_empresa['venta_por_mayor'] ==='SI' ? "selected='selected'": "" ?> value="SI">SI</option>
                                    <option <?= $row_empresa['venta_por_mayor'] ==='NO' ? "selected='selected'": "" ?> value="NO">NO</option>
                                  </select>
                                  
                                 </div>



                                 
                                </div>

                                <div class="row">
                                  
                                  <div class="col-sm-3 mt-3">
                                  <img src="<?=media()?>/images/<?php if(empty($row_empresa['logo'])){$logo='logo.jpg';}else{$logo=$row_empresa['logo'];} echo $logo; ?>" alt="" width="80%">
                                 </div>
                                </div>

                      </div>
                     
                      <div class="tab-pane fade" id="profile" role="tabpanel" aria-labelledby="profile-tab">
                        <div class="row">
                          <div class="col-sm-3">
                            <label for="">Usuario SOL</label>
                            <input type="text" class="form-control" name="usuario_sol" id="usuario_sol" placeholder="Usuario SOL" value="<?=$row_empresa['usuario_sol']?>">
                          </div>
                          <div class="col-sm-3">
                            <label for="">clave SOL</label>
                            <input type="text" class="form-control" name="clave_sol" id="clave_sol" placeholder="Clave SOL" value="<?=$row_empresa['clave_sol']?>">
                          </div>
                          <div class="col-sm-3">
                            <label for="">Cliente x Defecto</label>
                            <select class="form-control select2" style="width: 100%;" name="clidef" id="clidef">
                  
                            <?php 
                                    while($row_contr = $resultado_contribuyente->fetch(PDO::FETCH_ASSOC) )
                               {?>
                                <option value="<?= $row_contr['num_doc'] ?>"><?=$row_contr['nombre_persona']?></option>;
                               <?php  } ?>
                          </select>
                          </div>
                          <div class="col-sm-3">
                            <label for="">Envio Automatico</label>
                            <select class="form-control select2" style="width: 100%;" name="envioauto" id="envioauto">
                              
                              <option <?= $row_empresa['envio_automatico'] ==='SI' ? "selected='selected'": "" ?> value="SI">SI</option>
                              <option <?= $row_empresa['envio_automatico'] ==='NO' ? "selected='selected'": "" ?> value="NO">NO</option>
                            </select>
                          </div>
                        </div>
                        <hr>
                        <div class="row">
                          <div class="col-sm-3">
                            <label for="">Certificado Actual</label>
                            <input type="text" class="form-control" name="certificado" id="certificado" placeholder="Certificado Digital" value="<?=$row_empresa['certificado']?>" readonly>
                          </div>
                          <div class="col-sm-3">
                            <label for="">Certificado Digital</label>
                            <input type="file" class="form-control" name="certificadon" id="certificadon" placeholder="Certificado Digital" value="">
                          </div>
                          <div class="col-sm-3">
                            <label for="">clave certificado</label>
                            <input type="text" class="form-control" name="clave_certificado" id="clave_certificado" placeholder="Clave certificado" value="<?=$row_empresa['clave_certificado']?>">
                          </div>
                          <div class="col-sm-3">
                            <label for="">Envio Resumen</label>
                            <select class="form-control select2" style="width: 100%;" name="enviores" id="enviores">
                             
                              <option <?= $row_empresa['envio_resumen'] ==='SI' ? "selected='selected'": "" ?> value="SI">SI</option>
                              <option <?= $row_empresa['envio_resumen'] ==='NO' ? "selected='selected'": "" ?> value="NO">NO</option>
                          </select>
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
                          <div class="row justify-content-center">
                          <div class="col-sm-5">                            
                                <fieldset class="row border border-primary rounded p-3" >
                                    <legend class="w-auto">Datos Ventas</legend>
                                  <div class="col-sm-6">
                                    <label for="">Origen Ventas</label>
                                    <input type="text" class="form-control" placeholder="Origen Ventas" name="origen_venta" id="origen_venta" value="<?=$row_empresa['origen_venta']?>">
                                  </div>
                                  <div class="col-sm-6">
                                    <label for="">Origen Cobranzas</label>
                                    <input type="text" class="form-control" name="origen_cobranzas" id="origen_cobranzas" placeholder="Origen Cobranzas" value="<?=$row_empresa['origen_cobranzas']?>">
                                  </div>
                                  <div class="col-sm-6">
                                    <label for="">Cuenta x Cobrar Soles</label>
                                    <input type="text" class="form-control" name="cta_cobrar_soles" id="cta_cobrar_soles" placeholder="Cuenta x Cobrar Soles" value="<?=$row_empresa['cta_cobrar_soles']?>">
                                  </div>
                                  <div class="col-sm-6">
                                    <label for="">Cuenta x Cobrar Dolares</label>
                                    <input type="text" class="form-control" name="cta_cobrar_dolar" id="cta_cobrar_dolar" placeholder="Cuenta x Cobrar Dolares" value="<?=$row_empresa['cta_cobrar_dolar']?>">
                                  </div>
                                  <div class="col-sm-6">
                                    <label for="">IGV Ventas</label>
                                    <input type="text" placeholder="IGV Ventas" name="cta_igv_venta" id="cta_igv_venta" class="form-control" value="<?=$row_empresa['cta_igv_venta']?>">
                                  </div>
                                  <div class="col-sm-6">
                                    <label for="">Cuenta Detraccion Ventas</label>
                                    <input type="text" placeholder="Detraccion Ventas" name="cta_det_ventas" id="cta_det_ventas" class="form-control" value="<?=$row_empresa['cta_det_ventas']?>">
                                  </div>
                                </fieldset>
                          </div>
                          
                              <div class="col-sm-5 ml-1">
                                    <fieldset class="row border border-primary rounded p-3" >
                                      <legend class="w-auto">Datos Compras</legend>
                                      
                                      <div class="col-sm-6">
                                        <label for="">Origen Compras</label>
                                        <input type="text" class="form-control" placeholder="Origen Compras" name="origen_compra" id="origen_compra" value="<?=$row_empresa['origen_compra']?>">
                                      </div>
                                      <div class="col-sm-6">
                                        <label for="">Origen Pagos</label>
                                        <input type="text" class="form-control" name="origen_pagos" id="origen_pagos" placeholder="Origen Pagos" value="<?=$row_empresa['origen_pagos']?>">
                                      </div>
                                      <div class="col-sm-6">
                                        <label for="">Cuenta x Pagar Soles</label>
                                        <input type="text" class="form-control" id="cta_pagar_soles" name="cta_pagar_soles" placeholder="Cuenta x Pagar Soles" value="<?=$row_empresa['cta_pagar_soles']?>">
                                      </div>
                                      <div class="col-sm-6">
                                        <label for="">Cuenta x Pagar Dolares</label>
                                        <input type="text" class="form-control" name="cta_pagar_dolar" id="cta_pagar_dolar" placeholder="Cuenta x Pagar Dolares" value="<?=$row_empresa['cta_pagar_dolar']?>">
                                      </div>
                                      <div class="col-sm-6">
                                        <label for="">IGV Compras</label>
                                        <input type="text" placeholder="IGV Compras" name="cta_igv_compra" id="cta_igv_compra" class="form-control" value="<?=$row_empresa['cta_igv_compra']?>">
                                      </div>
                                      <div class="col-sm-6">
                                        <label for="">Cuenta Detraccion Compras</label>
                                        <input type="text" placeholder="Detraccion Compras" name="cta_det_compras" id="cta_det_compras" class="form-control" value="<?=$row_empresa['cta_det_compras']?>">
                                      </div>
                                    </fieldset>  
                                
                               </div>
                                                  
                      
                            <div class="col-sm-5">
                          
                              <fieldset class="row border border-primary rounded p-3" >
                                  <legend class="w-auto">Datos Honorarios</legend>
                                  <div class="col-sm-6">
                                    <label for="">Origen Honorarios</label>
                                    <input type="text" class="form-control" placeholder="Origen Honorarios" name="origen_rh" id="origen_rh" value="<?=$row_empresa['origen_rh']?>">
                                  </div>
                                  <div class="col-sm-6">
                                    <label for="">Origen Pagos</label>
                                    <input type="text" class="form-control" name="origen_pago_rh" id="origen_pago_rh" placeholder="Origen Pagos" value="<?=$row_empresa['origen_pago_rh']?>">
                                  </div>
                                  <div class="col-sm-6">
                                    <label for="">Cuenta x Pagar Soles</label>
                                    <input type="text" class="form-control" name="cta_pagar_soles_rh" id="cta_pagar_soles_rh" placeholder="Cuenta x Pagar Soles" value="<?=$row_empresa['cta_pagar_soles_rh']?>">
                                  </div>
                                  <div class="col-sm-6">
                                    <label for="">Cuenta x Pagar Dolares</label>
                                    <input type="text" class="form-control" name="cta_pagar_dolar_rh" id="cta_pagar_dolar_rh" placeholder="Cuenta x Pagar Dolares" value="<?=$row_empresa['cta_pagar_dolar_rh']?>">
                                  </div>
                                  <div class="col-sm-6">
                                    <label for="">Cuenta Retencion 4ta </label>
                                    <input type="text" placeholder="Cuenta Retencion 4ta" name="cta_retencion_4" id="cta_retencion_4" class="form-control" value="<?=$row_empresa['cta_retencion_4']?>">
                                  </div>
                                  <div class="col-sm-6">
                                    <label for="">Porcentaje Retencion 4ta</label>
                                    <input type="text" placeholder="Porcentaje Retencion 4ta" name="por_ret_4" id="por_ret_4" class="form-control" value="<?=$row_empresa['por_ret_4']?>">
                                  </div>
                              </fieldset>
                            </div>
                        
                            <div class="col-sm-5 ml-1">
                                  <fieldset class="row border border-primary rounded p-3" >
                                    <legend class="w-auto">Datos Generales</legend>
                                  
                                   <div class="col-sm-6">
                                    <label for="">Cuenta percepcion </label>
                                    <input type="text" class="form-control" placeholder="Cuenta percepcion" name="cta_percepcion" id="cta_percepcion" value="<?=$row_empresa['cta_percepcion']?>">
                                  </div>
                                  <div class="col-sm-6">
                                    <label for="">Porcentaje Imp. Renta</label>
                                    <input type="text" class="form-control" name="por_imp_rta" id="por_imp_rta" placeholder="Porcentaje Imp. Renta" value="<?=$row_empresa['por_imp_rta']?>">
                                  </div>
                                  <div class="col-sm-6">
                                    <label for="">Cuenta Retenciones</label>
                                    <input type="text" class="form-control" id="cta_retenciones" name="cta_retenciones" placeholder="Cuenta Retenciones" value="<?=$row_empresa['cta_retenciones']?>">
                                  </div>
                                  
                                  
                                  
                        
                                  </fieldset>  
                              
                             </div>
                            </div>
                      
                      </div>
                      <div class="tab-pane fade" id="mail" role="tabpanel" aria-labelledby="mail-tab">
                        <div class="row">
                          <div class="col-sm-6">
                            <label for="">correo</label>
                            <input type="text" class="form-control" name="correo_envio" id="correo_envio" placeholder="Correo envio" value="<?=$row_empresa['correo_envio']?>">
                          </div>
                          <div class="col-sm-2">
                            <label for="">Clave correo</label>
                            <input type="password" class="form-control" name="clave_correo" id="clave_correo" placeholder="Clave correo" value="<?=$row_empresa['clave_correo']?>">
                          </div>
                          <div class="col-sm-2">
                            <label for="">SMTP</label>
                            <input type="text" class="form-control" name="smtp" id="smtp" placeholder="SMTP" value="<?=$row_empresa['smtp']?>">
                          </div>
                          <div class="col-sm-2">
                            <label for="">Puerto</label>
                            <input type="text" class="form-control" name="puerto" id="puerto" placeholder="Puerto" value="<?=$row_empresa['puerto']?>">
                          </div>
                        </div>
                        <hr>
                        
                        
                        
                      </div>

                      <div class="tab-pane fade" id="sire" role="tabpanel" aria-labelledby="sire-tab">
                        <div class="row">
                          <div class="col-sm-3">
                            <label for="">USUARIO SOL(Principal)</label>
                            <input type="text" class="form-control" name="usuariosol" id="usuariosol" placeholder="Correo envio" value="<?=$row_empresa['usuariosol']?>">
                          </div>
                          <div class="col-sm-3">
                            <label for="">Clave SOL(Principal)</label>
                            <input type="text" class="form-control" name="clavesol" id="clavesol" placeholder="Clave correo" value="<?=$row_empresa['clavesol']?>">
                          </div>
                          <div class="col-sm-3">
                            <label for="">ID</label>
                            <input type="text" class="form-control" name="idgre" id="idgre" placeholder="ID Sunat" value="<?=$row_empresa['idgre']?>">
                          </div>
                          <div class="col-sm-3">
                            <label for="">SECRET</label>
                            <input type="text" class="form-control" name="secretgre" id="secretgre" placeholder="Secret" value="<?=$row_empresa['secretgre']?>">
                          </div>
                        </div>
                        <hr>
                        
                        
                        
                      </div>

                    </div>
              

                  </div>
                    </div>
                        </div>
                      </div>
                      
                    </div> 

              
              
              </form>
             
            </div> <!-- /.col -->
          </div> <!-- .row -->
        </div> <!-- .container-fluid -->
       
        
      </main> <!-- main -->
    </div> <!-- .wrapper -->
  
    <?php include 'views/template/pie.php' ?>

 <script src="https://write.corbpie.com/wp-content/litespeed/localres/aHR0cHM6Ly9jZG5qcy5jbG91ZGZsYXJlLmNvbS8=ajax/libs/jquery/3.5.1/jquery.min.js"></script>
 

    


  </body>
</html>