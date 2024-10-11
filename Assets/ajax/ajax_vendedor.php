<?php 

require_once("../../config/config.php");
require_once("../../helpers/helpers.php"); 
require_once("../../libraries/conexion.php"); 
session_start();



////////////llamar datos mediante un json para editar pelicula/////////////
if($_POST['action']=='buscar_vendedorx')
{
  $productos = "SELECT * FROM tbl_vendedor WHERE id=$_POST[id]";
   $resultado_productos  = $connect->prepare($productos);
   $resultado_productos->execute();
   $row_productos = $resultado_productos->fetch(PDO::FETCH_ASSOC);

   $data = json_encode($row_productos,true);

   echo $data;

   exit();

}

//####################################CREAR CLIENTE####################################////

if($_POST['action'] == 'addVendedor')
{
	
    $query = $connect->prepare("INSERT INTO tbl_vendedor(nombre,apellido,dni,idlocal,idempresa) VALUES(?,?,?,?,?) ");
    $resultado = $query->execute([$_POST['nombrev'],$_POST['apellidov'],$_POST['dniv'],$_POST['localv'],$_POST['empresa']]);

    if($resultado)
    {
    	$msg = 'exito';
    }
    else
    {
    	$msg = 'error';
    }

    echo $msg;

    exit();
}

//####################################EDITAR CLIENTE####################################////
if($_POST['action'] == 'ediVendedor')
{

	

	$query=$connect->prepare("UPDATE tbl_vendedor SET nombre=?, apellido=?,dni=?,idlocal=? WHERE id = ?");
	 $resultado = $query->execute([$_POST['update_nombrev'],$_POST['update_apellidov'],$_POST['update_dniv'],$_POST['update_localv'],$_POST['update_id']]);

	if($resultado)
	{
		$msg='ok';
	}
	else
	{
		$msg = 'error';
	}

	echo $msg;
	exit;


}


//####################################ELIMINAR CATEGORIA####################################////
if($_POST['action'] == 'delVendedor')
{
   $query=$connect->prepare("UPDATE tbl_vendedor SET estado=? WHERE id = ?");
	$resultado = $query->execute([$_POST['estado'],$_POST['delete_id']]);

	if($resultado)
	{
		$msg='ok';
	}
	else
	{
		$msg = 'error';
	}

	echo $msg;
	exit;


}