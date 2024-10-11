<?php 

require_once("../../config/config.php");
require_once("../../helpers/helpers.php"); 
require_once("../../libraries/conexion.php"); 
session_start();

//####################################CREAR CLIENTE####################################////

if($_POST['action'] == 'addArticulo')
{
	$nombre 	      = $_POST['nombre'];
	$descripcion      = $_POST['descripcion'];
	$categoria 	      = $_POST['categoria'];
	$marca 	          = $_POST['marca'];
	$unidad 	      = $_POST['unidad'];
	$afectacion       = $_POST['afectacion'];
	$precio_compra 	  = $_POST['precio_compra'];
	$precio_venta 	  = $_POST['precio_venta'];
	

	


    	$query=$connect->prepare("INSERT INTO tbl_articulo(nombre_articulo,descripcion_articulo,categoria,marca,unidad,precio_venta,precio_compra,afectacion) VALUES (?,?,?,?,?,?,?,?);");
		$resultado=$query->execute([$nombre,$descripcion,$categoria,$marca,$unidad,$precio_venta,$precio_compra,$afectacion]);


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
if($_POST['action'] == 'ediArticulo')
{
	
	$id     = $_POST['id'];
	$nombre 	      = $_POST['nombre'];
	$descripcion      = $_POST['descripcion'];
	$categoria 	      = $_POST['categoria'];
	$marca 	          = $_POST['marca'];
	$unidad 	      = $_POST['unidad'];
	$afectacion       = $_POST['afectacion'];
	$precio_compra 	  = $_POST['precio_compra'];
	$precio_venta 	  = $_POST['precio_venta'];
	

	$query=$connect->prepare("UPDATE tbl_articulo SET nombre_articulo=?, descripcion_articulo=?,categoria=?,marca=?,unidad=?,afectacion=?,precio_venta=?,precio_compra=? WHERE id_articulo = ?");
	$resultado = $query->execute([$nombre,$descripcion,$categoria,$marca,$unidad,$afectacion,$precio_venta,$precio_compra,$id]);

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
if($_POST['action'] == 'delArticulo')
{
	
	$id     = $_POST['delete_id'];

	$query=$connect->prepare("UPDATE tbl_articulo SET estado=? WHERE id_articulo = ?");
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