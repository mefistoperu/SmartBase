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
            $_SESSION['iniciarSesion']="facturalo";
            $_SESSION["nombre"]=$row_resultado['nombre'];
            $_SESSION["perfil"]=$row_resultado['perfil'];
            $_SESSION["id"]=$row_resultado['id'];
            $_SESSION["id_empresa"]=$row_resultado['id_empresa'];
            $_SESSION["empresa"]=$row_resultado['empresa'];
            $_SESSION["ruc"]=$row_resultado['ruc'];
            
              echo '<script> window.location ="'.base_url().'/inicio"; </script>';
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

<!DOCTYPE html>
<html lang="en">
  <head>
      <?php include 'Views/Templates/head.php' ?>
  </head>

  <body class="login bg-dark">
    <div>
      <a class="hiddenanchor" id="signup"></a>
      <a class="hiddenanchor" id="signin"></a>

      <div class="login_wrapper">
        <div class="animate form login_form">
          <section class="login_content">
            <form method="POST">
              <h1 style="color: white">Iniciar Sesion</h1>
              <div class="row">
                <label for="" style="color: white">R.U.C.</label>
                <input type="text" maxlength="11" class="form-control" placeholder="RUC" required="" name="ruc" id="ruc" />
              </div>
              <div class="row">
                <label for="" style="color: white">Usuario</label>
                <input type="text" class="form-control" placeholder="Username" required="" name="usuario" id="usuario" />
              </div>
              <div class="row">
                <label for="" style="color: white">Clave</label>
                <input type="password" class="form-control" placeholder="Password" required="" name="clave" id="clave" />
              </div>
              <div>
                <button class="btn btn-success">Ingresar</button>
              </div>
              
              <div class="clearfix"></div>

              <div class="separator">
                
                <div class="clearfix"></div>
                <br />

                <div>
                  <h1 style="color: white"><i class="fa fa-paw"></i> Smart Base</h1>
                  <p style="color: white">©2018 - <?= date('Y') ?>  Todos los derechos reservados.<br>
                   V & Z SOLUCIONES INTELIGENTES S.A.C.</p>
                </div>
              </div>
            </form>
          </section>
        </div>

      </div>
    </div>
  </body>
</html>
