

<?php 
//session_start();
$empresa = $_SESSION["id_empresa"];


if(!empty($_POST))
{
$mes = $_POST['periodo'];
$anio = $_POST['anio'];
$boton  = '';
$periodo  = $anio.$mes;

$query_data = "SELECT * FROM vw_tbl_sire_ventas WHERE periodo = $periodo and idempresa = $empresa ";
$resultado_data=$connect->prepare($query_data);
$resultado_data->execute();
$num_reg_data=$resultado_data->rowCount();
}

?>

<!doctype html>
<html lang="en">
  <head>
       <?php include 'views/template/head.php' ?>
  </head>
  <body class="horizontal dark  ">
    <div class="wrapper">
      <?php
       
       include 'views/template/nav.php';
        ?>
      
      <main role="main" class="main-content">
        <div class="container-fluid">
          <div class="row justify-content-center">
            <div class="col-12">
              <div class="row align-items-center mb-2">
                <div class="col">
                  <h2 class="h5 page-title">Ventas - SIRE</h2>
                </div>
                
              </div>
              <hr>              

                    <div class="row my-4">
                      <div class="col-md-12">
                        <div class="card shadow">
                          <div class="card-header">
                            <form class="form-inline" method="POST">
                                  <div class="form-group">
                                    <input type="hidden" name="empresa" id="empresa" value="<?=$_SESSION["id_empresa"]?> ">
                                    <label for="ex3" class="col-form-label">Periodo: </label>
                                    <select name="periodo" id="periodo" class="form-control" required>
                                      <option value="01">Enero</option>
                                      <option value="02">Febrero</option>
                                      <option value="03">Marzo</option>
                                      <option value="04">Abril</option>
                                      <option value="05">Mayo</option>
                                      <option value="06">Junio</option>
                                      <option value="07">Julio</option>
                                      <option value="08">Agosto</option>
                                      <option value="09">Setiembre</option>
                                      <option value="10">Octubre</option>
                                      <option value="11">Noviembre</option>
                                      <option value="12">Diciembre</option>
                                    </select>
                                  </div>
                                  <div class="form-group mr-3 ml-3">
                                    <label for="ex4" class="col-form-label">Año: </label>
                                    <input type="number" id="anio" name="anio" class="form-control text-right" max="2030" min="2023" value="2023">
                                  </div>
                        
                        
                                  <div class="form-group">
                                  

                                    <button type="submit" class="btn btn-success">Listar Comparativo</button>
                                    
                                    
                                    
                                  </div>
                            </form>                 
                    
                          </div>
                         <div class="card-body">
                          

                         <table id="datatable-rptvtad1" class="table table-striped table-bordered  nowrap" cellspacing="0" width="100%">
                          <thead class="bg-dark" style="color: white">
                                                           
            <tr>
                <th>Id</th>
                <th>Codigo</th>
                <th>Cliente</th>
                <th>Num. Doc</th>
                <th>Fecha</th>
                          
                <th>Importe</th>
                <th>Estado</th>
             
                

            </tr>
        </thead>
                      <tbody>
       <?php foreach($resultado_data  as $lista){ ?>
        <tr>
            <td><?=$lista['id']?></td>
            <td><?=$lista['movkey']?></td>
            <td><?=$lista['codcliente']?></td>
            <td><?=$lista['nombre_persona']?></td>
            <td><?=$lista['fecha_emision']?></td>
            <td><?=$lista['total']?></td>
            <td><?=$lista['idsire']?></td>
         
        </tr>
       <?php } ?>
   </tbody>
                        </table>
                         </div>
                        </div>
                      </div>
                      
                    </div> 

              
              
              
             
            </div> <!-- /.col -->
          </div> <!-- .row -->
        </div> <!-- .container-fluid -->
       
        
      </main> <!-- main -->
    </div> <!-- .wrapper -->

    <?php include 'views/template/pie.php' ?>

  </body>
</html>