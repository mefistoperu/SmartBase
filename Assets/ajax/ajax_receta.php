<?php 

require_once("../../config/config.php");
require_once("../../helpers/helpers.php"); 
require_once("../../libraries/conexion.php"); 
session_start();


//####################################CREAR CLIENTE####################################////

if($_POST['action'] == 'nuevo_receta')
{
	
    $query = $connect->prepare("INSERT INTO tbl_recetas(id_producto,id_insumo,cantidad) VALUES(?,?,?) ");
    $resultado = $query->execute([$_POST['producto'],$_POST['insumo'],$_POST['cantidad']]);

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

//####################################ELIMINAR CATEGORIA####################################////
if($_POST['action'] == 'delete_receta')
{
	
	$query=$connect->prepare("DELETE FROM tbl_recetas  WHERE id_receta = ?");
	$resultado = $query->execute([$_POST['delete_id_receta']]);

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