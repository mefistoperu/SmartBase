<?php 

require_once("../../config/config.php");
require_once("../../helpers/helpers.php"); 
require_once("../../libraries/conexion.php"); 
session_start();



//####################################CREAR CLIENTE####################################////

if($_POST['action'] == 'addChofer')
{
	$query=$connect->prepare("INSERT INTO tbl_gre_conductor(nombre,apellido,tdoc,ndoc,direccion,telefono,licencia,empresa) VALUES (?,?,?,?,?,?,?,?);");
	$resultado=$query->execute([$_POST['nombre'],$_POST['apellido'],$_POST['tdoc'],$_POST['ndoc'],$_POST['direccion'],$_POST['telefono'],$_POST['licencia'],$_POST['empresa']]);


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
if($_POST['action'] == 'ediChofer')
{
	 $query=$connect->prepare("UPDATE tbl_gre_conductor SET nombre=?,apellido=?,tdoc=?,ndoc=?,direccion=?,telefono=?,licencia=? WHERE id = ?");
	$resultado = $query->execute([$_POST['update_nombre'],$_POST['update_apellido'],$_POST['update_tdoc'],$_POST['update_ndoc'],$_POST['update_direccion'],$_POST['update_telefono'],$_POST['update_licencia'],$_POST['update_id']]);

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
if($_POST['action'] == 'delChofer')
{
	
	$id     = $_POST['delete_id'];

	$query=$connect->prepare("UPDATE tbl_gre_conductor SET estado=? WHERE id = ?");
	$resultado = $query->execute([$_POST['estado'],$id]);

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