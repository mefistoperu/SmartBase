<?php 

require_once("../../Config/Config.php");
require_once("../../Helpers/Helpers.php"); 
require_once("../../Libraries/Conexion.php"); 
session_start();


//####################################CREAR CLIENTE####################################////

if($_POST['action'] == 'nuevo_insumo')
{
	
    $query = $connect->prepare("INSERT INTO tbl_insumos(nombre,marca,unidad,stock,precio_compra,empresa) VALUES(?,?,?,?,?,?) ");
    $resultado = $query->execute([$_POST['nombre'],$_POST['marca'],$_POST['unidad'],$_POST['stock'],$_POST['precio_compra'],$_POST['empresa']]);

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
if($_POST['action'] == 'editar_insumo')
{
	$query=$connect->prepare("UPDATE tbl_insumos SET nombre=?, marca=?,unidad=?,precio_venta=?,precio_compra=? WHERE id = ?");
	 $resultado = $query->execute([$_POST['update_nombre'],$_POST['update_marca'],$_POST['update_unidad'],$_POST['update_stock'],$_POST['update_precio_compra'],$_POST['update_id_insumo']]);

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
if($_POST['action'] == 'delete_insumo')
{
	
	$query=$connect->prepare("UPDATE tbl_insumos SET estado=? WHERE id = ?");
	$resultado = $query->execute(['0',$_POST['delete_id_insumo']]);

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