<?php 

$empresa = $_SESSION["id_empresa"];

$query_venta = "SELECT * FROM tbl_compra_cab AS c LEFT JOIN tbl_contribuyente as x
on c.codcliente = x.num_doc WHERE idempresa = $empresa";
$resultado_venta=$connect->prepare($query_venta);
$resultado_venta->execute();
$num_reg_venta=$resultado_venta->rowCount();

$query_empresa = "SELECT * FROM tbl_empresas WHERE id_empresa = $empresa";
$resultado_empresa = $connect->prepare($query_empresa);
$resultado_empresa->execute();
$row_empresa = $resultado_empresa->fetch(PDO::FETCH_ASSOC);
?>
<!DOCTYPE html>
<html lang="en">
  <head>
        <?php include 'Views/Templates/head.php' ?>
        <style>
          .not-active { 
            pointer-events: none; 
            cursor: default; 
        } 
        </style>
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
                <h3>Compras</h3>
              </div>

             
            </div>

            <div class="clearfix"></div>

            <div class="row">
              <div class="col-md-12 col-sm-12  ">
                <div class="x_panel">
                  <div class="x_title">
                    <h2><a href="nueva_compra" type="button" class="btn btn-dark"><i class="fa fa-plus-circle"></i> Nueva Compra</a></h2>
                   
                    
                    <div class="clearfix"></div>
                  </div>
                  <div class="x_content">
                    <table id="datatable-ventas" class="table table-striped table-bordered  nowrap" cellspacing="0" width="100%">
                      <thead class="bg-dark" style="color: white">
                        <tr>
                          <th>Id</th>
                          <th>Fecha</th>
                          <th>T. Cpe</th>
                          <th>N. Cpe</th>
                          <th>Cliente</th>
                          <th>Op. Gravada</th>
                          <th>Op. Exonerada</th>
                          <th>Op. Inafecta</th>
                          <th>IGV</th>
                          <th>Total</th>
                          <th>PDF</th>
                          <th>Estado</th>
                          
                        </tr>
                      </thead>
                      <tbody>
                        <?php foreach($resultado_venta as $ventas ){ ?>
                          <tr>
                            
                            <td><?= $ventas['id'] ?></td>
                            <td><?= $ventas['fecha_emision'] ?></td>
                            <td><?= $ventas['tipocomp'] ?></td>
                            <td><?= $ventas['serie'].'-'.$ventas['correlativo'] ?></td>
                            <td><?= $ventas['nombre_persona'] ?></td>
                            <td align="right"><?= $ventas['op_gravadas'] ?></td>
                            <td align="right"><?= $ventas['op_exoneradas'] ?></td>
                            <td align="right"><?= $ventas['op_inafectas'] ?></td>
                            <td align="right"><?= $ventas['igv'] ?></td>
                            <td align="right"><?= $ventas['total'] ?></td>
                            

                            <td><a href="factura_pdf_compra/<?= $ventas['id'] ?>" class="btn btn-danger rounded-circle"><i class="fa fa-file-pdf-o"></i></a></td>
                            <td><?php $e = $ventas['feestado'];
                            if($e == 1)
                            {
                              $e ='fa fa-check';
                              $c = 'success';
                            }
                            else
                            {
                              $e ='fa fa-close';
                              $c = 'danger';

                            }?> 
                            <button class="btn btn-<?=$c?> rounded-circle"><i class="<?=$e?>"></i></button></td>
                            
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
        <!-- /page content -->
        <?php include 'Views/Templates/pie.php' ?>
      </div>
    </div>
      <?php include 'Views/Modules/Modals/categorias.php' ?>
      <?php include 'Views/Templates/footer.php' ?>
      <script src="Assets/js/categoria.js"></script>
      <script src="Assets/js/funciones_categoria.js"></script>

      
  </body>
</html>
