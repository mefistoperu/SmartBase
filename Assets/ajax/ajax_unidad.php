<?php 

require_once("../../config/config.php");
require_once("../../helpers/helpers.php"); 
require_once("../../libraries/conexion.php"); 
session_start();

//####################################CREAR CLIENTE####################################////

if($_POST['action'] == 'addUnidad')
{
	
	$nombre 	  = $_POST['unidad'];
	$codigo 	  = $_POST['codigo'];
	$factor 	  = $_POST['factor'];
	
	


    	$query=$connect->prepare("INSERT INTO tbl_unidad(nombre_unidad,codigo_unidad,factor) VALUES (?,?,?);");
		$resultado=$query->execute([$nombre,$codigo,$factor]);


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
if($_POST['action'] == 'ediUnidad')
{
	$nombre = $_POST['update_nombre'];
	$id     = $_POST['update_id'];
	$codigo = $_POST['update_codigo'];
	$factor = $_POST['update_factor'];

	$query=$connect->prepare("UPDATE tbl_unidad SET nombre_unidad=?, codigo_unidad=?,factor=? WHERE id_unidad = ?");
	$resultado = $query->execute([$nombre,$codigo,$factor,$id]);

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
if($_POST['action'] == 'delUnidad')
{
	
	$id     = $_POST['delete_id'];

	$query=$connect->prepare("UPDATE tbl_unidad SET estado=? WHERE id_unidad = ?");
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