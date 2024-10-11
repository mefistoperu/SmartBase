<?php 

require_once("../../config/config.php");
require_once("../../helpers/helpers.php"); 
require_once("../../libraries/conexion.php"); 
session_start();



//####################################CREAR ####################################////

if($_POST['action'] == 'addSeparacion')
{
    
    $moneda=$_POST['moneda'];
	$query=$connect->prepare("INSERT INTO tbl_alq_separaciones(id_cliente,monto_separacion_soles,monto_separacion_dolar,fecha_separacion,estado) VALUES (?,?,?,?,?);");
	$resultado=$query->execute([$_POST['cliente'],$_POST['importe_soles'],$_POST['importe_dolares'],$_POST['fecha'],'1']);


	if($resultado)
	{
		$msg=$resultado;
	}
	else
	{
		$msg='error1';
	}
	echo $msg;
	exit;
}

//####################################EDITAR####################################////
if($_POST['action'] == 'editSeparacion')
{

	$query=$connect->prepare("UPDATE tbl_alq_garantias SET meses_garantia=?,importe_soles=?,importe_dolares=?, fecha_garantia=? WHERE id_garantia = ?");
	$resultado = $query->execute([$_POST['update_meses'],$_POST['update_soles'],$_POST['update_dolares'],$_POST['update_fecha'],$_POST['update_id']]);

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

//####################################ELIMINAR####################################////
if($_POST['action'] == 'delGarantia')
{

	$query=$connect->prepare("UPDATE tbl_alq_garantias SET estado=? WHERE id_garantia = ?");
	$resultado = $query->execute(['0',$_POST['delete_id']]);

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