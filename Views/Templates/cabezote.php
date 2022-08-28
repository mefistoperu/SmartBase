<!-- top navigation -->
        <div class="top_nav">
          <div class="nav_menu">
              <div class="nav toggle" style="width: 30px;">
                <a id="menu_toggle"><i class="fa fa-bars"></i></a>

              </div>
              <div class="nav toggle" style="width:50%; font-weight:bold; margin-left: 3px;">
                 <a id="menu_toggle"><?=$_SESSION["empresa"]?></a>
              </div>
             
              <nav class="nav navbar-nav">
              <ul class=" navbar-right">
                <li class="nav-item dropdown open" style="padding-left: 10px;">
                  <a href="javascript:;" class="user-profile dropdown-toggle" aria-haspopup="true" id="navbarDropdown" data-toggle="dropdown" aria-expanded="false">
                    <img src="<?=media()?>/images/user.png" alt="">
                  </a>
                  <div class="dropdown-menu dropdown-usermenu pull-right bg-danger" aria-labelledby="navbarDropdown">
                                  
                  <a class="dropdown-item"  href="cerrar" style="color: blue"><i class="fa fa-sign-out pull-right"></i> Cerrar Sesion</a>
                  </div>
                </li>

                
              </ul>
            </nav>
          </div>
        </div>
        <!-- /top navigation -->