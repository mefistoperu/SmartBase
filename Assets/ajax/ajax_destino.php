<?php 

require_once("../../config/config.php");
require_once("../../helpers/helpers.php"); 
require_once("../../libraries/conexion.php"); 
session_start();


//####################################CREAR CLIENTE####################################////

if($_POST['action'] == 'nuevo_destino')
{
	
    $query = $connect->prepare("INSERT INTO tbl_contribuyente_direccion(id_contribuyente,direccion,ubigeo,empresa) VALUES(?,?,?,?) ");
    $resultado = $query->execute([$_POST['contribuyente'],$_POST['destino'],$_POST['ubigeo'],$_POST['empresa']]);

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
if($_POST['action'] == 'delete_destino')
{
	
	$query=$connect->prepare("UPDATE tbl_contribuyente_direccion SET estado = ?  WHERE id = ?");
	$resultado = $query->execute([$_POST['estado'],$_POST['delete_id_destino']]);

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