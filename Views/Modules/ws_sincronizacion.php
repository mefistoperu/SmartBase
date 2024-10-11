<?php 
include '../../config/config.php';
include '../../helpers/helpers.php';
include '../../libraries/conexion.php'; 


header("Access-Control-Allow-Origin: *");
// Permite la ejecucion de los metodos
header("Access-Control-Allow-Methods: GET, POST, PUT, DELETE");
date_default_timezone_set('America/Lima');
header("HTTP/1.1");
header("Content-Type: application/json; charset=UTF-8");
$jsondata            = array();
$jsondata['estado']  = '0';
$jsondata['mensaje'] = 'ERROR';	

//$array = explode("/", $_SERVER['REQUEST_URI']);
$bodyRequest = file_get_contents("php://input");
$cab = json_decode($bodyRequest, true);
$detalle = $cab['detalle'];

$ruc=$_GET['ruc'];
switch ($_GET["op"])
{
    case 'venta' :
    $query_data = "SELECT * FROM tbl_empresas WHERE ruc=$ruc";
    $resultado = $connect->prepare($query_data);
    $resultado->execute();
    $row_empresa = $resultado->fetch(PDO::FETCH_ASSOC);
    
    $hora = date('h:i:s');
    $query=$connect->prepare("INSERT INTO tbl_venta_cab(idempresa,tipocomp,serie,correlativo,fecha_emision,fecha_vencimiento,condicion_venta,op_gravadas,op_exoneradas,op_inafectas,igv,total,codcliente,vendedor,obs,cuotas_credito,hora_emision,idcliente,por_det,cod_det,imp_det) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?);");
    $resultado=$query->execute([$cab['empresa'],$cab['tdoc'],$cab['serie'],$cab['numero'],$cab['fecha_emision'],$cab['fecha_vencimiento'],$cab['condicion'],$cab['op_g'],$cab['op_e'],$cab['op_i'],$cab['igv'],$cab['total'],$cab['ruc_persona'], $_SESSION["id"],$cab['obs'],$cab['cuotas'],$hora,$cab['id_ruc'],$cab['por_det'],$cab['cod_det'],$cab['importe_det']]);
    
    $lastInsertId = $connect->lastInsertId();
    
     for($i = 0; $i< count($detalle['idarticulo']); $i++)
        {
            $item                  = $detalle['itemarticulo'][$i];
            $idarticulo            = $detalle['idarticulo'][$i];
            $nomarticulo           = $detalle['nomarticulo'][$i];
            $cantidad              = $detalle['cantidad'][$i];

            $afectacion            = $detalle['afectacion'][$i];
            $tipo_precio           = '01';
            $unidad                = 'NIU';
            $costo                 = $detalle['precio_compra'][$i];
            $factor                = $detalle['factor'][$i];
            $cantidadu             = $detalle['cantidadu'][$i];
            
            $cantidad_total        = $factor*$cantidad + $cantidadu;

            if($afectacion == '10')
            {
            $igv_unitario          = 18;
            }
            else
            {
            $igv_unitario          = 0;
            }



            $precio_venta          = $_POST['precio_venta'][$i]/$factor;
            $precio_unitario       = ($precio_venta - ($igv_unitario/$cantidad_total));
            $precio_venta_total    = $precio_venta*$cantidad_total;



            if($afectacion == 10)
            {
            $precio_venta_unitario = $precio_venta/1.18;
            $valor_unitario_total  = ($_POST['valor_unitario'][$i]/$factor)/1.18;

            $importe_total = ($cantidad_total*$precio_venta);

            $valor_total = $cantidad_total*$precio_venta_unitario;
            }
            else
            {
            $precio_venta_unitario = $precio_venta;
            $valor_unitario_total  = ($_POST['valor_unitario'][$i]/$factor);

            $importe_total = ($cantidad_total*$precio_venta);

            $valor_total = $cantidad_total*$precio_venta_unitario;

            }

            $igv_total                = $importe_total - $valor_total;
            $precio_compra            = $_POST['precio_compra'][$i];




            $insert_query_detalle =$connect->prepare("INSERT INTO tbl_venta_det(idventa,item,idproducto,cantidad,valor_unitario,precio_unitario,igv,porcentaje_igv,valor_total,importe_total,costo,cantidad_factor,factor,cantidad_unitario,mxmn,nombre_producto) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
            $resultado_detalle = $insert_query_detalle->execute([$lastInsertId,$item,$idarticulo,$cantidad_total,$precio_venta_unitario,$precio_venta,$igv_total,18,$valor_total,$importe_total,$costo,$cantidad,$factor,$cantidadu,$mxmn,$nomarticulo]);

           


        }
//procesar envio a sunat

        require_once("../../sunat/api/xml.php");
        $xml = new GeneradorXML();
        //buscar ruc emisor
        $query_empresa = "SELECT * FROM vw_tbl_empresas WHERE id_empresa = $_POST[empresa]";
        $resultado_empresa = $connect->prepare($query_empresa);
        $resultado_empresa->execute();
        $row_empresa = $resultado_empresa->fetch(PDO::FETCH_ASSOC);
    
    echo json_encode($jsondata);	
    break;    
    
}
    

 ?>         