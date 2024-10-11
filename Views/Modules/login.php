<?php 
$mensaje = '';

if(!empty($_POST))
{
  $usuario = $_POST['usuario'];
  $clave   = $_POST['clave'];
  $usuario = trim($usuario);
  $clave = trim($clave);
  $ruc   = $_POST['ruc'];

  if(empty($usuario) || empty($clave) || empty($ruc))
      {
    echo '<script>alert(usuario o clave no pueden estar vacios)</script>';
      }
  else
      {

        $connect->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        $sql="SELECT * FROM vw_tbl_usuarios WHERE usuario= :user AND clave= :pass AND ruc=:ruc";
        $resultado=$connect->prepare($sql);
        $ruc=htmlentities(addslashes($ruc));
        $usuario=htmlentities(addslashes($usuario));
        $clave=htmlentities(addslashes($clave));
        $clave=md5($clave);
        //echo $clave;
        $resultado->bindValue(":user",$usuario);
        $resultado->bindValue(":pass",$clave);
        $resultado->bindValue(":ruc",$ruc);
        $resultado->execute();
        $num_reg=$resultado->rowCount();
        //echo $num_reg;
        $row_resultado=$resultado->fetch(PDO::FETCH_ASSOC);
        if($num_reg!=0)
          {
            $_SESSION['iniciarSesion']          ="cinema";
            $_SESSION["nombre"]                 =$row_resultado['nombre'];
            $_SESSION["perfil"]                 =$row_resultado['perfil'];
            $_SESSION["sucursal"]               =$row_resultado['sucursal'];
            $_SESSION["id"]                     =$row_resultado['id'];
            $_SESSION["id_empresa"]             =$row_resultado['id_empresa'];
            $_SESSION["empresa"]                =$row_resultado['empresa'];
            $_SESSION["ruc"]                    =$row_resultado['ruc'];
            $_SESSION["fecha_vencimiento"]      =$row_resultado['fecha_vencimiento'];
            $_SESSION["nombre_almacen"]         =$row_resultado['nombre_almacen'];
            $_SESSION["almacen"]         =$row_resultado['almacen'];
            $_SESSION["farmacia"]           =$row_resultado['farmacia'];
            $_SESSION["usabarras"]          =$row_resultado['usabarras'];
            $_SESSION["servidor_cpe"]       =$row_resultado['servidor_cpe'];

            $_SESSION["nombre_svr"]       =$row_resultado['nombre_svr'];
            $_SESSION["tipo_svr"]       =$row_resultado['tipo_svr'];
            $_SESSION["venta_por_mayor"]       =$row_resultado['venta_por_mayor'];

            $_SESSION["detalle"]       =$row_resultado['detalle'];
            $_SESSION["precio"]       =$row_resultado['precio'];


            $hoy                            = date('Y-m-d');
                if($row_resultado['fecha_vencimiento'] <= $hoy)
                {
                  echo '<script>

                    alert("Cuenta con fecha de vencimiento");

                  </script>';
                  session_destroy();
                }
                else
                {
                   
                  echo '<script> window.location ="'.base_url().'/inicio"; </script>';
                }

                
          }
          else
          {
             echo '<script>

                alert("Usuario o clave incorrectos o usuario inactivo");

              </script>';
        session_destroy();
          }
      }
}

 ?>
<!doctype html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">
    <link rel="icon" href="favicon.ico">
    <title><?=nombre()?></title>
    <!-- Simple bar CSS -->
    <link rel="stylesheet" href="<?=media()?>/css/simplebar.css">
    <!-- Fonts CSS -->
    <link href="https://fonts.googleapis.com/css2?family=Overpass:ital,wght@0,100;0,200;0,300;0,400;0,600;0,700;0,800;0,900;1,100;1,200;1,300;1,400;1,600;1,700;1,800;1,900&display=swap" rel="stylesheet">
    <!-- Icons CSS -->
    <link rel="stylesheet" href="<?=media()?>/css/feather.css">
    <!-- Date Range Picker CSS -->
    <link rel="stylesheet" href="<?=media()?>/css/daterangepicker.css">
    <!-- App CSS -->
    <link rel="stylesheet" href="<?=media()?>/css/app-light.css" id="lightTheme" disabled>
    <link rel="stylesheet" href="<?=media()?>/css/app-dark.css" id="darkTheme">
  </head>
  <body class="dark ">
    <div class="wrapper vh-100">
      <div class="row align-items-center h-100">
        <form class="col-lg-3 col-md-4 col-10 mx-auto text-center" method="POST">
           <h3 class="text-center text-bold"><?=logo()?></h3>
          <hr>
          <h1 class="h6 mb-3">Ingresar Datos</h1>
          <div class="form-group">
            <label for="inputEmail" class="sr-only">Ruc</label>
            <input type="text" id="ruc" name="ruc" class="form-control form-control-lg" placeholder="Ingresar Ruc" required="" autofocus="">
          </div>
          <div class="form-group">
            <label for="inputEmail" class="sr-only">Usuario</label>
            <input type="text" id="usuario" name="usuario" class="form-control form-control-lg" placeholder="Ingresar usuario" required="" autofocus="">
          </div>
          <div class="form-group">
            <label for="inputPassword" class="sr-only">Clave</label>
            <input type="password" id="clave" name="clave" class="form-control form-control-lg" placeholder="Ingresar clave" required="">
          </div>
          
        
          <button class="btn btn-lg btn-primary btn-block" type="submit" style="color: white;">Ingresar al Sistema</button>
          <p class="mt-5 mb-3 text-muted"><?=empresa()?> © 2018 - <?=date('Y')?></p>
        </form>
      </div>
    </div>
    <script src="<?=media()?>/js/jquery.min.js"></script>
    <script src="<?=media()?>/js/popper.min.js"></script>
    <script src="<?=media()?>/js/moment.min.js"></script>
    <script src="<?=media()?>/js/bootstrap.min.js"></script>
    <script src="<?=media()?>/js/simplebar.min.js"></script>
    <script src='<?=media()?>/js/daterangepicker.js'></script>
    <script src='<?=media()?>/js/jquery.stickOnScroll.js'></script>
    <script src="<?=media()?>/js/tinycolor-min.js"></script>
    <script src="<?=media()?>/js/config.js"></script>
    <script src="<?=media()?>/js/apps.js"></script>
    <!-- Global site tag (gtag.js) - Google Analytics -->
    <script async src="https://www.googletagmanager.com/gtag/js?id=UA-56159088-1"></script>
    <script>
      window.dataLayer = window.dataLayer || [];

      function gtag()
      {
        dataLayer.push(arguments);
      }
      gtag('js', new Date());
      gtag('config', 'UA-56159088-1');
    </script>
  </body>
</html>
</body>
</html>