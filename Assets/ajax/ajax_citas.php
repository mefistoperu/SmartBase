<?php 

require_once("../../config/config.php");
require_once("../../helpers/helpers.php"); 
require_once("../../libraries/conexion.php"); 
session_start();



//####################################CREAR CLIENTE####################################////

if($_POST['action'] == 'nueva_cita')
{
	
   	$query=$connect->prepare("INSERT INTO tbl_cita(idempresa,idcliente,fecha_cita,hora_cita,hora_fin,idespecialidad,comentario) VALUES (?,?,?,?,?,?,?);");
	$resultado=$query->execute([$_POST['empresa'],$_POST['cliente'],$_POST['fecha'],$_POST['hora_ini'],$_POST['hora_fin'],$_POST['especialidad'],$_POST['comentario']]);


	if($resultado)
	{
		$msg='Procesado con exito';
	}
	else
	{
		$msg='error al procesar';
	}
	echo $msg;
	exit;
}

//####################################EDITAR CLIENTE####################################////
if($_POST['action'] == 'ediCategoria')
{
	$nombre = $_POST['update_nombre'];
	$id     = $_POST['update_id'];

	$query=$connect->prepare("UPDATE tbl_categorias SET nombre=?,cuenta_venta=?,cuenta_compra=? WHERE id = ?");
	$resultado = $query->execute([$nombre,$_POST['update_cuenta_venta'],$_POST['update_cuenta_compra'],$id]);

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