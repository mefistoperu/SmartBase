<?php 

require_once("../../config/config.php");
require_once("../../helpers/helpers.php"); 
require_once("../../libraries/conexion.php"); 
session_start();

////////////carga desde excel/////////////
if($_POST['action']=='cargar_excel_conceptoGasto')
{
    $mensaje['respuesta']='';
    $file = $_FILES['dataConceptoGasto']['name'];
    move_uploaded_file($_FILES['dataConceptoGasto']['tmp_name'],'excel/conceptoGasto.xlsx');
    
    require_once('../plugins/phpexcel/Classes/PHPExcel.php');
    $inputFileType = PHPExcel_IOFactory::identify('excel/conceptoGasto.xlsx');
    $objReader = PHPExcel_IOFactory::createReader($inputFileType);
    $objPHPExcel = $objReader->load('excel/conceptoGasto.xlsx');
    $sheet = $objPHPExcel->getSheet(0); 
    $highestRow = $sheet->getHighestRow(); 
    $highestColumn = $sheet->getHighestColumn();
    $n=0;
    
    //$xlsx = new SimpleXLSX('../../excel/productos.xlsx');
    sleep(3);//retrasamos la petición 3 segundos
    //echo $file;//devolvemos el nombre del archivo para pintar la imagen
    $num=0;
    $k = 0;
    for ($row = 2; $row <= $highestRow; $row++)
    { 
    $num++; 
        if($num>0)
        {
        
        //IMPORTAMOS LOS ARTICULOS
        $nombre=$sheet->getCell("A".$row)->getValue();
        if($nombre!='') 
        {
        
        $cuenta=$sheet->getCell("B".$row)->getValue();
        
        if($cuenta == '')
        {
        $mensaje['error'] = 'LA CUENTA CONTABLE NO  PUEDE ESTAR VACIA';
        $data = json_encode($mensaje,true);
        echo $data;
        exit();
        }
        
        $empresa  = $_SESSION['id_empresa'];
        
        $query_pro = "SELECT * FROM tbl_concepto_gasto WHERE nombre='$nombre' AND  empresa = $empresa";
        $resultado_pro=$connect->prepare($query_pro);
        $resultado_pro->execute(); 
        $num_reg_pro=$resultado_pro->rowCount();
        
        
        
        
        if($num_reg_pro == 0)
        {
        
        $query = $connect->prepare("INSERT INTO tbl_concepto_gasto(nombre,cuenta_gasto,empresa) VALUES(?,?,?) ");
        $resultado = $query->execute([$nombre,$cuenta,$empresa]);
        $k++;
        }
        
        }	
        
        }
    $mensaje['respuesta'] = 'REGISTROS PROCESADOS CON EXITO : '.$num.' EN TOTAL';
    $mensaje['procesados']  = 'SE CARGARON        : '.$k.'   EN TOTAL';
    $mensaje['noprocesados']  = 'NO SE CARGARON     : '.($num - $k).'   EN TOTAL';
    }
    
 
   $data = json_encode($mensaje,true);

   echo $data;

   exit();

}


//####################################CREAR CLIENTE####################################////

if($_POST['action'] == 'addconcepto_gasto')
{
	
	$nombre 	  = $_POST['descripcion'];
	
	$empresa      = $_POST['empresa'];
	
	$cuenta      = $_POST['cuenta'];
	
   	$query=$connect->prepare("INSERT INTO tbl_concepto_gasto(nombre,cuenta_gasto,empresa,estado) VALUES (?,?,?,?);");
	$resultado=$query->execute([$nombre,$cuenta,$empresa,'1']);


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
if($_POST['action'] == 'edicongas')
{
	$id     = $_POST['update_id'];
	$nombre = $_POST['update_descripcion'];
	$cuenta_gasto = $_POST['update_cuenta'];

	$query=$connect->prepare("UPDATE tbl_concepto_gasto SET nombre=?,cuenta_gasto=? WHERE id = ?");
	$resultado = $query->execute([$nombre,$cuenta_gasto,$id]);

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
if($_POST['action'] == 'delcongas')
{
	
	$id     = $_POST['delete_id'];

	$query=$connect->prepare("UPDATE tbl_concepto_gasto SET estado=? WHERE id = ?");
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