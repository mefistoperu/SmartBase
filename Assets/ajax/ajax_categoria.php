<?php 

require_once("../../Config/Config.php");
require_once("../../Helpers/Helpers.php"); 
require_once("../../Libraries/Conexion.php"); 
session_start();


//####################################CREAR CLIENTE####################################////

if($_POST['action'] == 'addCategoria')
{
	
	$nombre 	  = $_POST['categoria'];
	
	$empresa      = $_POST['empresa'];
	
   	$query=$connect->prepare("INSERT INTO tbl_categorias(nombre,empresa) VALUES (?,?);");
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
if($_POST['action'] == 'ediCategoria')
{
	$nombre = $_POST['update_nombre'];
	$id     = $_POST['update_id'];

	$query=$connect->prepare("UPDATE tbl_categorias SET nombre=? WHERE id = ?");
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
if($_POST['action'] == 'delCategoria')
{
	
	$id     = $_POST['delete_id'];

	$query=$connect->prepare("UPDATE tbl_categorias SET estado=? WHERE id = ?");
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