<?php 

require_once("../../config/config.php");
require_once("../../helpers/helpers.php"); 
require_once("../../libraries/conexion.php"); 
session_start();



//####################################CREAR CLIENTE####################################////

if($_POST['action'] == 'addVehiculo')
{
	$query=$connect->prepare("INSERT INTO tbl_gre_vehiculo(placa,marca,certificado,modelo,anio,idempresa) VALUES (?,?,?,?,?,?);");
	$resultado=$query->execute([$_POST['placa'],$_POST['marca'],$_POST['certificado'],$_POST['modelo'],$_POST['anio'],$_POST['empresa']]);


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
if($_POST['action'] == 'ediVehiculo')
{
	 $query=$connect->prepare("UPDATE tbl_gre_vehiculo SET placa=?,marca=?,certificado=?,modelo=?,anio=? WHERE id = ?");
	$resultado = $query->execute([$_POST['update_placa'],$_POST['update_marca'],$_POST['update_certificado'],$_POST['update_modelo'],$_POST['update_anio'],$_POST['update_id']]);

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
if($_POST['action'] == 'delVehiculo')
{
	
	$id     = $_POST['delete_id'];

	$query=$connect->prepare("UPDATE tbl_gre_vehiculo SET estado=? WHERE id = ?");
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