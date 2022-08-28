
        <div class="col-md-3 left_col">
          <div class="left_col scroll-view">
            <div class="navbar nav_title" style="border: 0;">
              <a href="<?=base_url()?>/inicio" class="site_title"><i class="fa fa-paw"></i> <span><?=nombre()?></span></a>
            </div>

            <div class="clearfix"></div>

            <!-- menu profile quick info -->
            <div class="profile clearfix">
              <div class="profile_pic">
                <img src="<?=media()?>/images/user.png" alt="..." class="img-circle profile_img">
              </div>
              <div class="profile_info">
                <span>Bienvenido :</span>
                <h2><?= $_SESSION["nombre"] .''. $_SESSION["apellido"] ?></h2>
              </div>
            </div>
            <!-- /menu profile quick info -->

            <br />

            <!-- sidebar menu -->
            <div id="sidebar-menu" class="main_menu_side hidden-print main_menu">
              <div class="menu_section">
               
                <ul class="nav side-menu">
                  <li style="border-bottom: 1px solid white;">
                    <a><i class="fa fa-home"></i> Maestros <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                      <li><a href="<?= base_url()?>/productos">Productos</a></li>
                      <li><a href="<?= base_url()?>/categorias">Categorias</a></li>
                      <li><a href="<?= base_url()?>/marcas">Marcas</a></li>
                      <li><a href="<?= base_url()?>/almacenes">Almacenes</a></li>
                      <li><a href="<?= base_url()?>/contribuyente">Contribuyente</a></li>
                      <li><a href="<?= base_url()?>/medio_pago">Medio de Pago</a></li>
                      <li><a href="<?= base_url()?>/series">Series</a></li>
                      <li><a href="<?= base_url()?>/usuarios">Usuarios</a></li>
                    </ul>
                  </li>

                  <li style="border-bottom: 1px solid white;">
                    <a><i class="fa fa-dollar"></i> Ventas <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                      <li><a href="<?= base_url()?>/ventas">Ventas</a></li>
                      <li><a href="<?= base_url()?>/guia_salida">Guias de Salida</a></li>
                      <li><a href="<?= base_url()?>/nota_venta">Nota de Venta</a></li>
                      <li><a href="cuentas_por_cobrar">Cuentas x Cobrar</a></li>
                    </ul>
                  </li>
                  <li style="border-bottom: 1px solid white;">
                    <a><i class="fa fa-cart-plus"></i> Compras <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                      <li><a href="<?= base_url()?>/compras">Compras</a></li>
                      <li><a href="<?= base_url()?>/guia_ingreso">Guias de Ingreso</a></li>
                      <li><a href="<?= base_url()?>/ctas_por_pagar">Cuentas x Pagar</a></li>
                    </ul>
                  </li>
                  <li style="border-bottom: 1px solid white;">
                    <a><i class="fa fa-paper-plane"></i> Resumen de Cpe <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                      <li><a href="<?= base_url()?>/resumen_cpe">Envio de Resumen</a></li>
                      <li><a href="<?= base_url()?>/resumen_cpe">Consulta Resumen</a></li>
                    </ul>
                  </li>
                  <li style="border-bottom: 1px solid white;">
                    <a><i class="fa fa-sitemap"></i> Reportes <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                        
                        <li><a>Ventas<span class="fa fa-chevron-down"></span></a>
                          <ul class="nav child_menu">
                            <li class="sub_menu"><a href="<?= base_url()?>/rpt_ventas_sunat">Ventas</a>
                            </li>
                            <li><a href="<?= base_url()?>/rpt_ventas_diarias">Ventas Diarias</a>
                            </li>
                            <li><a href="#level2_2">Ventas por Vendedor</a>
                            </li>
                          </ul>
                        </li>
                        <li><a>Compras<span class="fa fa-chevron-down"></span></a>
                          <ul class="nav child_menu">
                            <li class="sub_menu"><a href="level2.html">Compras</a>
                            </li>
                            <li><a href="#level2_1">Compras Diarias</a>
                            </li>
                            <li><a href="#level2_2">Compras por Proveedor</a>
                            </li>
                          </ul>
                        </li>
                       
                    </ul>
                  </li>   
                  <li><a><i class="fa fa-cog"></i> Configuracion <span class="fa fa-chevron-down"></span></a>
                    <ul class="nav child_menu">
                      <li><a href="empresa">Datos de empresa</a></li>
                      
                    </ul>
                  </li>
                  
                  
                </ul>
              </div>
              
            </div>
            <!-- /sidebar menu -->

            <!-- /menu footer buttons -->
            
            <!-- /menu footer buttons -->
          </div>
        </div>
