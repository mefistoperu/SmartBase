<?php 

require_once("../../Config/Config.php");
require_once("../../Helpers/Helpers.php"); 
require_once("../../Libraries/Conexion.php"); 
session_start();

/////////////////////////datos de empresa //////////////////////////////////
if($_POST['action'] == 'datosEmpresa')
{

        
      

            $imagen_nueva=$_FILES['update_logo']['name']; 
            $imagen_antigua = $_POST['last_logo'];

            if(empty($imagen_nueva))
            {
                $imagen = $imagen_antigua;
            }
            else
            {
                 move_uploaded_file($_FILES['update_logo']['tmp_name'],'../images/'.$imagen_nueva);
                 $imagen =$imagen_nueva;
            }

          
        
     

      $insert = $connect->prepare("UPDATE tbl_empresas SET ruc=?,razon_social=?,direccion=?,distrito=?,provincia=?,departamento=?,ubigeo=?,correo=?,usuario_sol=?,clave_sol=?,certificado=?,clave_certificado=?,cta_igv_venta=?,cta_igv_compra=?,cta_pagar_soles=?,cta_pagar_dolar=?,cta_cobrar_soles=?,cta_cobrar_dolar=?,origen_venta=?,origen_cobranzas=?,origen_compra=?,origen_pagos=?,por_igv=?,cta_detracciones=?,logo=?,comentario=? WHERE id_empresa=?");
    $resultado = $insert->execute([$_POST['ruc'],$_POST['razon'],$_POST['direccion'],$_POST['distrito'],$_POST['provincia'],$_POST['departamento'],$_POST['ubigeo'],$_POST['correo'],$_POST['usuario_sol'],$_POST['clave_sol'],$_POST['certificado'],$_POST['clave_certificado'],$_POST['cta_igv_venta'],$_POST['cta_igv_compra'],$_POST['cta_pagar_soles'],$_POST['cta_pagar_dolar'],$_POST['cta_cobrar_soles'],$_POST['cta_cobrar_dolar'],$_POST['origen_venta'],$_POST['origen_cobranzas'],$_POST['origen_compra'],$_POST['origen_pagos'],$_POST['por_igv'],$_POST['detraccion'],$imagen,$_POST['comentario'],$_POST['id']]);


    if($resultado)
    {
        $mensaje = 'exito';
    }
    else
    {
        $mensaje = 'error';
    }

    echo $mensaje;

    exit;
}




/////////////////////////series //////////////////////////////////
if($_POST['action'] == 'delete_almacen')
{
    $id          = $_POST['delete_id_almacen'];
           
    $delete = $connect->prepare("UPDATE tbl_almacen SET estado = ? WHERE id = ?");
    $resultado = $delete->execute(['0',$id]);


    if($resultado)
    {
        $mensaje = 'exito';
    }
    else
    {
        $mensaje = 'error';
    }

    echo $mensaje;

    exit;
}


if($_POST['action'] == 'editar_almacen')
{
    $id = $_POST['update_id_almacen'];
    $nombre   = $_POST['update_nombre'];
    $direccion   = $_POST['update_direccion'];

     $insert = $connect->prepare("UPDATE tbl_almacen SET nombre=?,direccion=? WHERE id=?");
    $resultado = $insert->execute([$nombre,$direccion,$id]);


    if($resultado)
    {
        $mensaje = 'exito';
    }
    else
    {
        $mensaje = 'error';
    }

    echo $mensaje;

    exit;


}




if($_POST['action'] == 'nuevo_almacen')
{
    $empresa = $_POST['empresa'];
    $nombre   = $_POST['nombre'];
    $direccion   = $_POST['direccion'];

     $insert = $connect->prepare("INSERT INTO tbl_almacen(nombre,direccion,empresa) VALUES(?,?,?)");
    $resultado = $insert->execute([$nombre,$direccion,$empresa]);


    if($resultado)
    {
        $mensaje = 'exito';
    }
    else
    {
        $mensaje = 'error';
    }

    echo $mensaje;

    exit;


}



////////////////////////////////////serie - usuario////////////////////

if($_POST['action'] == 'nuevo_serie_usuario')
{
    $id_usuario = $_POST['usuario'];
    $id_serie   = $_POST['serie_nueva'];

     $insert = $connect->prepare("INSERT INTO tbl_series_usuarios(id_usuario,id_serie) VALUES(?,?)");
    $resultado = $insert->execute([$id_usuario,$id_serie]);


    $update = $connect->prepare("UPDATE tbl_series SET flat='1' WHERE id=?");
    $resultado_update = $update->execute([$id_serie]);


    if($resultado)
    {
        $mensaje = 'exito';
    }
    else
    {
        $mensaje = 'error';
    }

    echo $mensaje;

    exit;


}

if($_POST['action'] == 'delete_serie_usuario')
{
    $id = $_POST['delete_id_serie_usuario'];

     $delete = $connect->prepare("DELETE FROM tbl_series_usuarios WHERE id = ?");
    $resultado = $delete->execute([$id]);


    if($resultado)
    {
        $mensaje = 'exito';
    }
    else
    {
        $mensaje = 'error';
    }

    echo $mensaje;

    exit;


}


/////////////////////////series //////////////////////////////////
if($_POST['action'] == 'delete_serie')
{
    $id          = $_POST['delete_id_serie'];
           
    $delete = $connect->prepare("UPDATE tbl_series SET estado = ? WHERE id = ?");
    $resultado = $delete->execute(['0',$id]);


    if($resultado)
    {
        $mensaje = 'exito';
    }
    else
    {
        $mensaje = 'error';
    }

    echo $mensaje;

    exit;
}


if($_POST['action'] == 'update_serie')
{
    $empresa     = $_POST['update_empresa'];
    $id          = $_POST['update_id_serie'];
    $correlativo = $_POST['update_correlativo'];
       
    $insert = $connect->prepare("UPDATE tbl_series SET correlativo = ? WHERE id = ?");
    $resultado = $insert->execute([$correlativo,$id]);


    if($resultado)
    {
        $mensaje = 'exito';
    }
    else
    {
        $mensaje = 'error';
    }

    echo $mensaje;

    exit;
}


if($_POST['action'] == 'nueva_serie')
{
	$empresa     = $_POST['empresa'];
    $tdoc        = $_POST['tdoc'];
    $correlativo = $_POST['correlativo'];
    $serie       = $_POST['serie'];
    
    $insert = $connect->prepare("INSERT INTO tbl_series(id_td,serie,correlativo,id_empresa) VALUES(?,?,?,?)");
    $resultado = $insert->execute([$tdoc,$serie,$correlativo,$empresa]);


    if($resultado)
    {
    	$mensaje = 'exito';
    }
    else
    {
    	$mensaje = 'error';
    }

    echo $mensaje;

    exit;
}

//////////////////////usuarios //////////////////////////////////
if($_POST['action'] == 'editar_usuario')
{
	$empresa  = $_POST['empresa_update'];
    $id   	  = $_POST['id_update'];
    $clave    = $_POST['clave_update'];
    $clave    = md5($clave);
    

    $delete = $connect->prepare("UPDATE tbl_usuarios SET clave=? WHERE id_empresa=? and id_usuario=?");
    $resultado = $delete->execute([$clave,$empresa,$id]);


    if($resultado)
    {
    	$mensaje = 'exito';
    }
    else
    {
    	$mensaje = 'error';
    }

    echo $mensaje;

    exit;
}

if($_POST['action'] == 'eliminar_usuario')
{
	$empresa  = $_POST['delete_empresa'];
    $id   	  = $_POST['delete_id'];
    

    $delete = $connect->prepare("UPDATE tbl_usuarios SET estado=? WHERE id_empresa=? and id_usuario=?");
    $resultado = $delete->execute([0,$empresa,$id]);


    if($resultado)
    {
    	$mensaje = 'exito';
    }
    else
    {
    	$mensaje = 'error';
    }

    echo $mensaje;

    exit;
}

if($_POST['action'] == 'nuevo_usuario')
{
	$empresa  = $_POST['empresa'];
    $nombre   = $_POST['nombre'];
    $apellido = $_POST['apellido'];
    $usuario  = $_POST['user'];
    $clave    = $_POST['clave'];
    $clave    = md5($clave);
    $perfil   = $_POST['perfil'];
    $almacen  = $_POST['almacen'];

    $insert = $connect->prepare("INSERT INTO tbl_usuarios(usuario,clave,nombre_personal,apellido_personal,id_empresa,almacen,perfil) VALUES(?,?,?,?,?,?,?)");
    $resultado = $insert->execute([$usuario,$clave,$nombre,$apellido,$empresa,$almacen,$perfil]);


    if($resultado)
    {
    	$mensaje = 'exito';
    }
    else
    {
    	$mensaje = 'error';
    }

    echo $mensaje;

    exit;
}

?>
