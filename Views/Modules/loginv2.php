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
<?php include 'Views/Templates/head.php'; ?>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css" integrity="sha384-zCbKRCUGaJDkqS1kPbPd7TveP5iyJE0EjAuZQTgFLD2ylzuqKfdKlfG/eSrtxUkn" crossorigin="anonymous">
<style>
.divider:after,
.divider:before {
content: "";
flex: 1;
height: 1px;
background: #eee;
}
.h-custom {
height: calc(100% - 73px);
}
@media (max-width: 450px) {
.h-custom {
height: 100%;
}
}
form {
    border-color: 1px solid red;
    padding: 80px;
    border: 1px solid red;
    border-radius: 20px;
    background-color: white;
}
</style>
  </head>

  <body style="background-color: #ccc;">
   
     <section class="vh-100">
  <div class="container-fluid h-custom">
    <div class="row d-flex justify-content-center align-items-center h-100">
      <div class="col-md-9 col-lg-6 col-xl-5">
        <img src="http://usecim.net/wp-content/uploads/2021/03/post_thumbnail-4efabca9bd56b38edc0058c4ba006481-1024x683.jpeg"
          class="img-fluid" alt="Sample image">
      </div>
      <div class="col-md-8 col-lg-6 col-xl-4 offset-xl-1">
        <form method="POST">
        
         <h3 class="text-center text-bold">Iniciar Sesion</h3>
                
       <div class="divider d-flex align-items-center my-4">
            
          </div>

          <!-- Email input -->
          <div class="form-outline mb-4">
            <label class="form-label" for="form3Example3">RUC</label>
            <input type="text" id="ruc" name="ruc" required class="form-control form-control-lg"
              placeholder="Ingresar RUC" />
            
          </div>
          <!-- Password input -->
          <div class="form-outline mb-4">
            <label class="form-label" for="form3Example4">Usuario</label>
            <input type="text" id="usuario" required name="usuario" class="form-control form-control-lg"
              placeholder="Ingresar Usuario" />
            
          </div>
             
          <!-- Password input -->
          <div class="form-outline mb-4">
            <label class="form-label" for="form3Example4">Clave</label>
            <input type="password" id="clave" required name="clave" class="form-control form-control-lg"
              placeholder="Ingresar Clave" />
            
          </div>

         

          <div class="text-center text-lg-start mt-4 pt-2">
            <button type="submit" class="btn btn-success btn-lg"
              style="padding-left: 2.5rem; padding-right: 2.5rem;">Ingresar</button>
           
          </div>

        </form>
      </div>
    </div>
  </div>
  <div
    class="d-flex flex-column flex-md-row text-center text-md-start justify-content-between py-4 px-4 px-xl-5 bg-primary">
    <!-- Copyright -->
    <div class="text-white mb-3 mb-md-0">
      Copyright © <?=date('Y')?>. All rights reserved.
    </div>
    <!-- Copyright -->

    <!-- Right -->
    <div>
      <p style="color: white;">Smart Base</p>
  </div>

</section>
  </body>
</html>
