<?php 

require_once("../../config/config.php");
require_once("../../helpers/helpers.php"); 
require_once("../../libraries/conexion.php"); 
session_start();

//####################################CREAR CLIENTE####################################////

if($_POST['action'] == 'addPago_Cta')
{
	
	$fecha 	   = $_POST['fecha_pago'];
	$tipo_pago = $_POST['tipo_pago'];
	$num_oper  = $_POST['num_operacion'];
	$importe   = $_POST['importe'];
	


    	$query=$connect->prepare("INSERT INTO tbl_cta_cobrar(tipo,persona,tipo_doc,ser_doc,num_doc,monto,fecha,forma_pago,numero_operacion,empresa) VALUES (?,?,?,?,?,?,?,?,?,?);");
		$resultado=$query->execute(['2',$_POST['num_doc'],$_POST['tipocomp'],$_POST['serie'],$_POST['correlativo'],$importe,$fecha,$tipo_pago,$num_oper,$_POST['empresa']]);


	$query2=$connect->prepare("INSERT INTO tbl_venta_pago(id_venta,fdp,numero_operacion,importe_pago,fecha_pago) VALUES (?,?,?,?,?);");
		$resultado2=$query2->execute([$_POST['id_factura'],$_POST['tipo_pago'],$_POST['num_operacion'],$importe,$fecha]);


	if($resultado)
	{
		$msg='ok';
	}
	else
	{
		$msg='error1';
	}
	echo $resultado; 
	//var_dump($_POST);
	exit;
}

//####################################EDITAR CLIENTE####################################////
if($_POST['action'] == 'ediMarca')
{
	$nombre = $_POST['update_nombre'];
	$id     = $_POST['update_id'];

	$query=$connect->prepare("UPDATE tbl_marcas SET nombre=? WHERE id = ?");
	$resultado = $query->execute([$nombre,$id]);

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
if($_POST['action'] == 'delMarca')
{
	
	$id     = $_POST['delete_id'];

	$query=$connect->prepare("UPDATE tbl_marcas SET estado=? WHERE id = ?");
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