<?php 

require_once("../../config/config.php");
require_once("../../helpers/helpers.php"); 
require_once("../../libraries/conexion.php"); 
session_start();



//####################################CREAR CLIENTE####################################////

if($_POST['action'] == 'addtransportista')
{
	$query=$connect->prepare("INSERT INTO tbl_gre_transportista(ruc,razon,direccion,empresa) VALUES (?,?,?,?);");
	$resultado=$query->execute([$_POST['ruc'],$_POST['razon'],$_POST['direccion'],$_POST['empresa']]);


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
if($_POST['action'] == 'editransportista')
{
	 $query=$connect->prepare("UPDATE tbl_gre_transportista SET ruc=?,razon=?,direccion=? WHERE id = ?");
	$resultado = $query->execute([$_POST['update_ruc'],$_POST['update_razon'],$_POST['update_direccion'],$_POST['update_id']]);

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
if($_POST['action'] == 'deltransportista')
{
	
	$id     = $_POST['delete_id'];

	$query=$connect->prepare("UPDATE tbl_gre_transportista SET estado=? WHERE id = ?");
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