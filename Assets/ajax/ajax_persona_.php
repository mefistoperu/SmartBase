<?php 

require_once("../../Config/Config.php");
require_once("../../Helpers/Helpers.php"); 
require_once("../../Libraries/Conexion.php"); 
session_start();

//####################################CREAR CLIENTE####################################////

if($_POST['action'] == 'addCliente')
{
	
	$dni 	     = $_POST['dni'];
	$tipo_doc    = $_POST['tipo_doc'];
	$razon	     = $_POST['razon'];
	$direccion   = $_POST['direccion'];
	$distrito    = $_POST['distrito']; 
	$provincia   = $_POST['provincia']; 
	$departamento   = $_POST['departamento']; 
	$correo   = $_POST['correo'];
	$empresa  = $_POST['empresa'];

    	$query_select = "SELECT * FROM tbl_contribuyente WHERE num_doc = '$dni' AND empresa = $empresa";
		$resultado_select=$connect->prepare($query_select);
		$resultado_select->execute();
		$num_reg_select=$resultado_select->rowCount();
        
        if($num_reg_select >= 1)
        {
          $msg = 'existe';
          echo $msg;
          exit;
        }

        else
        {
        	$query=$connect->prepare("INSERT INTO tbl_contribuyente(nombre_persona,direccion_persona,distrito,provincia,departamento,tipo_doc,num_doc,correo,empresa) VALUES (?,?,?,?,?,?,?,?,?);");
		    $resultado=$query->execute([$razon,$direccion,$distrito,$provincia,$departamento,$tipo_doc,$dni,$correo,$empresa]);
        }
 	


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
if($_POST['action'] == 'ediCliente')
{
	$correo = $_POST['update_correo'];
	$id     = $_POST['update_id'];

	$query=$connect->prepare("UPDATE tbl_contribuyente SET correo=? WHERE id_persona = ?");
	$resultado = $query->execute([$correo,$id]);

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