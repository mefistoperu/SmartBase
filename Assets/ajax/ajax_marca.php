<?php 

require_once("../../Config/Config.php");
require_once("../../Helpers/Helpers.php"); 
require_once("../../Libraries/Conexion.php"); 
session_start();

//####################################CREAR CLIENTE####################################////

if($_POST['action'] == 'addMarca')
{
	
	$nombre 	  = $_POST['marca'];
	$empresa      = $_POST['empresa'];
	


    	$query=$connect->prepare("INSERT INTO tbl_marcas(nombre,empresa) VALUES (?,?);");
		$resultado=$query->execute([$nombre,$empresa]);


	if($resultado)
	{
		$msg='ok';
	}
	else
	{
		$msg='error1';
	}
	echo $msg;
	exit;
}

//####################################EDITAR CLIENTE####################################////
if($_POST['action'] == 'ediMarca')
{
	$nombre = $_POST['update_nombre'];
	$id     = $_POST['update_id'];

	$query=$connect->prepare("UPDATE tbl_marcas SET nombre=? WHERE id = ?");
	$resultado = $query->execute([$nombre,$id]);

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
if($_POST['action'] == 'delMarca')
{
	
	$id     = $_POST['delete_id'];

	$query=$connect->prepare("UPDATE tbl_marcas SET estado=? WHERE id = ?");
	$resultado = $query->execute(['0',$id]);

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