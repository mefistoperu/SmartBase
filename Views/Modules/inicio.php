<?php 
        
        $mes = date('m');
        
        $sql_productos="SELECT * FROM tbl_productos WHERE empresa = $_SESSION[id_empresa]";
        $resultado_productos=$connect->prepare($sql_productos);
        $resultado_productos->execute();
        $num_reg_productos=$resultado_productos->rowCount();


        $sql_contribuyente="SELECT * FROM tbl_contribuyente WHERE empresa = $_SESSION[id_empresa]";
        $resultado_contribuyente=$connect->prepare($sql_contribuyente);
        $resultado_contribuyente->execute();
        $num_reg_contribuyente=$resultado_contribuyente->rowCount();

        
        $sql_facturas="SELECT * FROM tbl_venta_cab where tipocomp ='01' AND MONTH(fecha_emision)='$mes' AND idempresa = $_SESSION[id_empresa]";
        $resultado_facturas=$connect->prepare($sql_facturas);
        $resultado_facturas->execute();
        $num_reg_facturas=$resultado_facturas->rowCount();

        $sql_boletas="SELECT * FROM tbl_venta_cab where tipocomp ='03' AND MONTH(fecha_emision)='$mes' AND idempresa = $_SESSION[id_empresa]";
        $resultado_boletas=$connect->prepare($sql_boletas);
        $resultado_boletas->execute();
        $num_reg_boletas=$resultado_boletas->rowCount();

        $sql_nc="SELECT * FROM tbl_venta_cab where tipocomp ='07' AND MONTH(fecha_emision)='$mes' AND idempresa = $_SESSION[id_empresa]";
        $resultado_nc=$connect->prepare($sql_nc);
        $resultado_nc->execute();
        $num_reg_nc=$resultado_nc->rowCount();

    

        $query_ventas = "SELECT sum(total) as total_ventas FROM tbl_venta_cab  WHERE idempresa =$_SESSION[id_empresa]";
        $resultado_ventas = $connect->prepare($query_ventas);
        $resultado_ventas->execute();
        $row_ventas = $resultado_ventas->fetch(PDO::FETCH_ASSOC);
        $ventas = $row_ventas['total_ventas'];

        $query_productos_top = "SELECT  d.idproducto,p.nombre,sum(d.cantidad) as cantidad,c.idempresa FROM tbl_venta_det
                            as d LEFT JOIN tbl_productos as p
                            on d.idproducto = p.id
                            LEFT JOIN tbl_venta_cab as c
                            ON d.idventa = c.id
                            where c.idempresa =$_SESSION[id_empresa]
                            GROUP BY d.idproducto,p.nombre
                            ORDER BY sum(d.cantidad) DESC 
                            limit 5";
        $resultado_productos_top=$connect->prepare($query_productos_top);
        $resultado_productos_top->execute();
        $num_reg_productos_top=$resultado_productos_top->rowCount();   


        $query_clientes_top = "SELECT  x.id_persona as id,x.nombre_persona as nombre,x.num_doc,sum(c.total) as total, x.empresa
                                FROM tbl_venta_cab as c 
                                LEFT JOIN tbl_contribuyente as x
                                ON c.codcliente = x.num_doc
                                WHERE x.empresa=$_SESSION[id_empresa]
                                GROUP BY x.id_persona,x.nombre_persona,x.num_doc
                                ORDER BY sum(c.total) desc
                                LIMIT 5
                                ";
        $resultado_clientes_top=$connect->prepare($query_clientes_top);
        $resultado_clientes_top->execute();
        $num_reg_clientes_top=$resultado_clientes_top->rowCount();   






      

 ?>

<!DOCTYPE html>
<html lang="en">
  <head> 
      <?php include 'Views/Templates/head.php' ?>
  </head>

  <body class="nav-md">
    <div class="container body">
      <div class="main_container">
       

           <?php if($_SESSION["perfil"]=='1'){ include 'Views/Templates/menu.php';}
                 else{include 'Views/Templates/menu_ventas.php';} ?>

           <?php include 'Views/Templates/cabezote.php' ?>
        

        <!-- page content -->
       <div class="right_col" role="main" style="min-height: 1284px; background-color: white;">
          <div class="">
            <br>

            <div class="clearfix"></div>

            <div class="row">
              <div class="col-md-12">
                <div class="">
                  <div class="x_content">
                    <div class="row">
                        <div class="animated flipInY col-lg-4 col-sm-6 col-md-6 col-xs-6 ">
                          <div class="tile-stats  bg-danger">
                            <div class="icon"><i class="fa fa-users" style="color: white"></i>
                            </div>
                            <div class="count" style="color: white"><?=$num_reg_contribuyente?></div>

                            <h3 style="color: white">Contribuyente</h3>
                            <p><a href="#" style="color: white">Listado de contribuyentes</a></p>
                            
                          </div>
                        </div>
                        <div class="animated flipInY col-lg-4 col-sm-6 col-md-6 col-xs-6">
                          <div class="tile-stats bg-primary">
                            <div class="icon"><i class="fa fa-file" style="color: white"></i>
                            </div>
                            <div class="count" style="color: white"><?=$num_reg_facturas?></div>

                            <h3 style="color: white">Facturas</h3>
                            <p><a href="#" style="color: white">Listado de Comprobantes</a></p>
                          </div>
                        </div>
                        <div class="animated flipInY col-lg-4 col-sm-6 col-md-6 col-xs-6">
                          <div class="tile-stats bg-success">
                            <div class="icon"><i class="fa fa-file" style="color: white"></i>
                            </div>
                            <div class="count" style="color: white"><?=$num_reg_boletas?></div>

                            <h3 style="color: white">Boletas de Venta</h3>
                            <p><a href="#" style="color: white">Listado de Comprobantes</a></p>
                          </div>
                        </div>
                        <div class="animated flipInY col-lg-4 col-sm-6 col-md-6 col-xs-6">
                                <div class="tile-stats bg-orange">
                                  <div class="icon"><i class="fa fa-money " style="color: white"></i>
                                  </div>
                                  <div class="count" style="color: white"><?=number_format($ventas,2,'.',',')?></div>

                                  <h3 style="color: white">Total Ventas</h3>
                                  <p><a href="#" style="color: white">Listado de Ventas</a></p>
                                </div>
                        </div>
                        <div class="animated flipInY col-lg-4 col-sm-6 col-md-6 col-xs-6">
                                  <div class="tile-stats bg-secondary">
                                    <div class="icon"><i class="fa fa-file " style="color: white"></i>
                                    </div>
                                    <div class="count" style="color: white"><?=$num_reg_boletas?></div>

                                    <h3 style="color: white">Notas de Credito</h3>
                                    <p><a href="#" style="color: white">Listado de Comprobantes</a></p>
                                  </div>
                        </div>
                        <div class="animated flipInY col-lg-4 col-sm-6 col-md-6 col-xs-6">
                                  <div class="tile-stats bg-purple">
                                    <div class="icon"><i class="fa fa-product-hunt " style="color: white"></i>
                                    </div>
                                    <div class="count" style="color: white"><?=$num_reg_productos?></div>

                                    <h3 style="color: white">Productos</h3>
                                    <p><a href="#" style="color: white">Listado de Productos</a></p>
                                  </div>
                        </div>
                    </div>



                    <hr>

                    <div class="row">
                      <div class="col-sm-6">
                        <h3 class="text-center text-lg-start text bold">Top 5 Productos</h3>
                        <table id="tabla_producto" class="table table-bordered">
                          <thead class="bg-dark" style="color:white;">
                            <tr>
                              <th>Id</th>
                              <th>Nombre</th>
                              <th>Cantidad</th>
                            </tr>
                        </thead>
                        <tbody>
                          <?php foreach($resultado_productos_top as $productos ){ ?>
                           <tr> 
                            <td><?= $productos['idproducto'] ?></td>
                            <td><?= $productos['nombre'] ?></td>
                            <td align="right"><?= number_format($productos['cantidad'],0,'.',',') ?></td>
                           </tr> 
                          <?php } ?>  
                        </tbody>
                        </table>
                      </div>
                      <div class="col-sm-6">
                        <h3 class="text-center text-lg-start text bold">Top 5 Clientes</h3>
                        <table id="tabla_producto" class="table table-bordered">
                          <thead class="bg-dark" style="color:white;">
                            <tr>
                              <th>Id</th>
                              <th>Nombre</th>
                              <th>Ventas</th>
                            </tr>
                        </thead>
                        <tbody>
                          <?php foreach($resultado_clientes_top as $clientes ){ ?>
                           <tr> 
                            <td><?= $clientes['id'] ?></td>
                            <td><?= $clientes['nombre'] ?></td>
                            <td align="right"><?= number_format($clientes['total'],0,'.',',') ?></td>
                           </tr> 
                          <?php } ?>  
                        </tbody>
                        </table>

                      </div>
                    </div>  
                    
                  </div>
                </div>
              </div>
            </div>
            <!--div class="row">


                  <div class="col-md-4 col-sm-4 ">
                    <div class="x_panel tile fixed_height_320">
                      <div class="x_title">
                        <h2>App Versions</h2>
                        <ul class="nav navbar-right panel_toolbox">
                          <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                          </li>
                          <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
                            <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                <a class="dropdown-item" href="#">Settings 1</a>
                                <a class="dropdown-item" href="#">Settings 2</a>
                              </div>
                          </li>
                          <li><a class="close-link"><i class="fa fa-close"></i></a>
                          </li>
                        </ul>
                        <div class="clearfix"></div>
                      </div>
                      <div class="x_content">
                        <h4>App Usage across versions</h4>
                        <div class="widget_summary">
                          <div class="w_left w_25">
                            <span>0.1.5.2</span>
                          </div>
                          <div class="w_center w_55">
                            <div class="progress">
                              <div class="progress-bar bg-green" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 66%;">
                                <span class="sr-only">60% Complete</span>
                              </div>
                            </div>
                          </div>
                          <div class="w_right w_20">
                            <span>123k</span>
                          </div>
                          <div class="clearfix"></div>
                        </div>

                        <div class="widget_summary">
                          <div class="w_left w_25">
                            <span>0.1.5.3</span>
                          </div>
                          <div class="w_center w_55">
                            <div class="progress">
                              <div class="progress-bar bg-green" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 45%;">
                                <span class="sr-only">60% Complete</span>
                              </div>
                            </div>
                          </div>
                          <div class="w_right w_20">
                            <span>53k</span>
                          </div>
                          <div class="clearfix"></div>
                        </div>
                        <div class="widget_summary">
                          <div class="w_left w_25">
                            <span>0.1.5.4</span>
                          </div>
                          <div class="w_center w_55">
                            <div class="progress">
                              <div class="progress-bar bg-green" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 25%;">
                                <span class="sr-only">60% Complete</span>
                              </div>
                            </div>
                          </div>
                          <div class="w_right w_20">
                            <span>23k</span>
                          </div>
                          <div class="clearfix"></div>
                        </div>
                        <div class="widget_summary">
                          <div class="w_left w_25">
                            <span>0.1.5.5</span>
                          </div>
                          <div class="w_center w_55">
                            <div class="progress">
                              <div class="progress-bar bg-green" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 5%;">
                                <span class="sr-only">60% Complete</span>
                              </div>
                            </div>
                          </div>
                          <div class="w_right w_20">
                            <span>3k</span>
                          </div>
                          <div class="clearfix"></div>
                        </div>
                        <div class="widget_summary">
                          <div class="w_left w_25">
                            <span>0.1.5.6</span>
                          </div>
                          <div class="w_center w_55">
                            <div class="progress">
                              <div class="progress-bar bg-green" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 2%;">
                                <span class="sr-only">60% Complete</span>
                              </div>
                            </div>
                          </div>
                          <div class="w_right w_20">
                            <span>1k</span>
                          </div>
                          <div class="clearfix"></div>
                        </div>

                      </div>
                    </div>
                  </div>

                  <div class="col-md-4 col-sm-4 ">
                    <div class="x_panel tile fixed_height_320 overflow_hidden">
                      <div class="x_title">
                        <h2>Device Usage</h2>
                        <ul class="nav navbar-right panel_toolbox">
                          <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                          </li>
                          <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
                            <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                <a class="dropdown-item" href="#">Settings 1</a>
                                <a class="dropdown-item" href="#">Settings 2</a>
                              </div>
                          </li>
                          <li><a class="close-link"><i class="fa fa-close"></i></a>
                          </li>
                        </ul>
                        <div class="clearfix"></div>
                      </div>
                      <div class="x_content">
                        <table class="" style="width:100%">
                          <tbody><tr>
                            <th style="width:37%;">
                              <p>Top 5</p>
                            </th>
                            <th>
                              <div class="col-lg-7 col-md-7 col-sm-7 ">
                                <p class="">Device</p>
                              </div>
                              <div class="col-lg-5 col-md-5 col-sm-5 ">
                                <p class="">Progress</p>
                              </div>
                            </th>
                          </tr>
                          <tr>
                            <td><iframe class="chartjs-hidden-iframe" style="width: 100%; display: block; border: 0px none; height: 0px; margin: 0px; position: absolute; inset: 0px;"></iframe>
                              <canvas class="canvasDoughnut" style="margin: 15px 10px 10px 0px; width: 140px; height: 140px;" width="140" height="140"></canvas>
                            </td>
                            <td>
                              <table class="tile_info">
                                <tbody><tr>
                                  <td>
                                    <p><i class="fa fa-square blue"></i>IOS </p>
                                  </td>
                                  <td>30%</td>
                                </tr>
                                <tr>
                                  <td>
                                    <p><i class="fa fa-square green"></i>Android </p>
                                  </td>
                                  <td>10%</td>
                                </tr>
                                <tr>
                                  <td>
                                    <p><i class="fa fa-square purple"></i>Blackberry </p>
                                  </td>
                                  <td>20%</td>
                                </tr>
                                <tr>
                                  <td>
                                    <p><i class="fa fa-square aero"></i>Symbian </p>
                                  </td>
                                  <td>15%</td>
                                </tr>
                                <tr>
                                  <td>
                                    <p><i class="fa fa-square red"></i>Others </p>
                                  </td>
                                  <td>30%</td>
                                </tr>
                              </tbody></table>
                            </td>
                          </tr>
                        </tbody></table>
                      </div>
                    </div>
                  </div>


                  <div class="col-md-4 col-sm-4 ">
                    <div class="x_panel tile fixed_height_320">
                      <div class="x_title">
                        <h2>Quick Settings</h2>
                        <ul class="nav navbar-right panel_toolbox">
                          <li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a>
                          </li>
                          <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-expanded="false"><i class="fa fa-wrench"></i></a>
                            <div class="dropdown-menu" aria-labelledby="dropdownMenuButton">
                                <a class="dropdown-item" href="#">Settings 1</a>
                                <a class="dropdown-item" href="#">Settings 2</a>
                              </div>
                          </li>
                          <li><a class="close-link"><i class="fa fa-close"></i></a>
                          </li>
                        </ul>
                        <div class="clearfix"></div>
                      </div>
                      <div class="x_content">
                        <div class="dashboard-widget-content">
                          <ul class="quick-list">
                            <li><i class="fa fa-calendar-o"></i><a href="#">Settings</a>
                            </li>
                            <li><i class="fa fa-bars"></i><a href="#">Subscription</a>
                            </li>
                            <li><i class="fa fa-bar-chart"></i><a href="#">Auto Renewal</a> </li>
                            <li><i class="fa fa-line-chart"></i><a href="#">Achievements</a>
                            </li>
                            <li><i class="fa fa-bar-chart"></i><a href="#">Auto Renewal</a> </li>
                            <li><i class="fa fa-line-chart"></i><a href="#">Achievements</a>
                            </li>
                            <li><i class="fa fa-area-chart"></i><a href="#">Logout</a>
                            </li>
                          </ul>

                          <div class="sidebar-widget">
                              <h4>Profile Completion</h4>
                              <canvas id="chart_gauge_01" class="" style="width: 160px; height: 100px;" width="150" height="80"></canvas>
                              <div class="goal-wrapper">
                                <span id="gauge-text" class="gauge-value pull-left">3,200</span>
                                <span class="gauge-value pull-left">%</span>
                                <span id="goal-text" class="goal-value pull-right">100%</span>
                              </div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </div>

            </div-->
          </div>
        </div>
        <!-- /page content -->
         <?php include 'Views/Templates/pie.php' ?>
      </div>
    </div>
     <?php include 'Views/Templates/footer.php' ?>
	
  </body>
</html>
