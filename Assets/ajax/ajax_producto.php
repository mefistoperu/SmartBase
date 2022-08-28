<?php 

require_once("../../Config/Config.php");
require_once("../../Helpers/Helpers.php"); 
require_once("../../Libraries/Conexion.php"); 
session_start();


//####################################CREAR CLIENTE####################################////

if($_POST['action'] == 'nuevo_producto')
{
	//print_r($_POST);
	


    $query = $connect->prepare("INSERT INTO tbl_productos(nombre,descripcion,marca,unidad,precio_venta,afectacion,empresa,precio2,costo,por1,por2,factor) VALUES(?,?,?,?,?,?,?,?,?,?,?,?) ");
    $resultado = $query->execute([$_POST['nombre'],$_POST['descripcion'],$_POST['marca'],$_POST['unidad'],$_POST['precio_venta'],$_POST['afectacion'],$_POST['empresa'],$_POST['precio_venta2'],$_POST['precio_compra'],$_POST['por_gan1'],$_POST['por_gan2'],$_POST['factor']]);

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
if($_POST['action'] == 'editar_producto')
{
	$query=$connect->prepare("UPDATE tbl_productos SET nombre=?, marca=?,unidad=?,precio_venta=?,afectacion=?,descripcion =?,precio2 = ?,factor=?,por1=?,por2=?,costo=? WHERE id = ?");
	 $resultado = $query->execute([$_POST['update_nombre'],$_POST['update_marca'],$_POST['update_unidad'],$_POST['update_precio_venta'],$_POST['update_afectacion'],$_POST['update_descripcion'],$_POST['update_precio_venta2'],$_POST['update_factor'],$_POST['update_por_gan1'],$_POST['update_por_gan2'],$_POST['update_precio_compra'],$_POST['update_id']]);

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
if($_POST['action'] == 'delete_producto')
{
	
	$query=$connect->prepare("UPDATE tbl_productos SET estado=? WHERE id = ?");
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