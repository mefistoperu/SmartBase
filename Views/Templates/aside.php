<aside class="main-sidebar sidebar-dark-primary elevation-4">
    <!-- Brand Logo -->
    <a href="index3.html" class="brand-link">
      <img src="<?=media()?>/dist/img/AdminLTELogo.png" alt="AdminLTE Logo" class="brand-image img-circle elevation-3" style="opacity: .8">
      <span class="brand-text font-weight-light"><?=empresa()?></span>
    </a>

    <!-- Sidebar -->
    <div class="sidebar">
      <!-- Sidebar user panel (optional) -->
      <div class="user-panel mt-3 pb-3 mb-3 d-flex">
        <div class="image">
          <img src="<?=media()?>/dist/img/user2-160x160.jpg" class="img-circle elevation-2" alt="User Image">
        </div>
        <div class="info">
          <a href="#" class="d-block"><?= $_SESSION["personal"] ?></a>
        </div>
      </div>



      <!-- Sidebar Menu -->
      <nav class="mt-2">
        <ul class="nav nav-pills nav-sidebar flex-column" data-widget="treeview" role="menu" data-accordion="false">
      
          <li class="nav-item">
            <a href="#" class="nav-link">
              <i class="nav-icon fas fa-copy"></i>
              <p>
               Maestros
                <i class="fas fa-angle-left right"></i>
              
              </p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
                <a href="<?=base_url()?>/persona" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>Persona</p>
                </a>
              </li>
          
              <li class="nav-item">
                <a href="<?=base_url()?>/articulos" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>Articulos</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="<?=base_url()?>/marcas" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>Marcas</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="<?=base_url()?>/categorias" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>Categorias</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="<?=base_url()?>/unidad" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>Unidad de Medida</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="<?=base_url()?>/series" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>Series</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="<?=base_url()?>/usuarios" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>Usuarios</p>
                </a>
              </li>
                 <li class="nav-item">
                <a href="<?=base_url()?>/personal" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>Personal</p>
                </a>
              </li>
            </ul>
          </li>
          <li class="nav-item">
            <a href="#" class="nav-link">
              <i class="nav-icon fas fa-chart-pie"></i>
              <p>
                Compras
                <i class="right fas fa-angle-left"></i>
              </p>
            </a>
            <ul class="nav nav-treeview">
              
              <li class="nav-item">
                <a href="<?=base_url()?>/compras" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>Compras</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="<?=base_url()?>/cuentas_por_pagar" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>Cuentas por Pagar</p>
                </a>
              </li>
            
            </ul>
          </li>
          <li class="nav-item">
            <a href="#" class="nav-link">
              <i class="nav-icon fas fa-tree"></i>
              <p>
                Ventas
                <i class="fas fa-angle-left right"></i>
              </p>
            </a>
            <ul class="nav nav-treeview">
              
              <li class="nav-item">
                <a href="<?=base_url()?>/ventas" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>Ventas Electronicas</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="<?=base_url()?>/envio_sunat" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>Envios SUNAT</p>
                </a>
              </li>
              <li class="nav-item">
                <a href="<?=base_url()?>/cuentas_por_cobrar" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>Cuentas por Cobrar</p>
                </a>
              </li>
  
            </ul>
          </li>
          <li class="nav-item">
            <a href="#" class="nav-link">
              <i class="nav-icon fas fa-edit"></i>
              <p>
              Utilitarios
                <i class="fas fa-angle-left right"></i>
              </p>
            </a>
            <ul class="nav nav-treeview">
              <li class="nav-item">
                <a href="<?=base_url()?>/configuracion" class="nav-link">
                  <i class="far fa-circle nav-icon"></i>
                  <p>Configuracion</p>
                </a>
              </li>
            
 
            </ul>
          </li>


        </ul>
      </nav>
      <!-- /.sidebar-menu -->
    </div>
    <!-- /.sidebar -->
  </aside>