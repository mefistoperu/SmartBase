<?php 

require_once("../../config/config.php");
require_once("../../helpers/helpers.php"); 
require_once("../../libraries/conexion.php"); 
session_start();



//####################################CREAR GARANTIA####################################////

if($_POST['action'] == 'addDocumento')
{
    $file = $_FILES['contrato_pdf'];
        // Definir la ubicación donde se guardará el archivo
        $uploadDir = 'contratos/';
        $uploadFile = $uploadDir . basename($file['name']);
        move_uploaded_file($file['tmp_name'], $uploadFile);
    
    $moneda=$_POST['moneda'];
	$query=$connect->prepare("INSERT INTO tbl_alq_contrato_pdf(id_contrato,descripcion_contrato,nombre_archivo) VALUES (?,?,?);");
	$resultado=$query->execute([$_POST['idcontrato'],$_POST['descripcion'],$file['name']]);


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


//####################################ELIMINAR ####################################////
if($_POST['action'] == 'delpdf')
{
	
	$id     = $_POST['delete_id'];

	$query=$connect->prepare("DELETE FROM tbl_alq_contrato_pdf WHERE id = ?");
	$resultado = $query->execute([$id]);

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