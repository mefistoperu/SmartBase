<?php 


$empresa   = $_SESSION['id_empresa'];
$fecha_ini = $rutas[1];
$fecha_fin = $rutas[2];
/*$empresa   = 1;
$fecha_ini = '2023-02-01';
$fecha_fin = '2023-03-01';*/



$query_empresa = $connect->prepare("SELECT * FROM tbl_empresas WHERE id_empresa = $empresa");
$query_empresa->execute();
$row_config=$query_empresa->fetch(PDO::FETCH_ASSOC);

$origen_compra    = $row_config['origen_compra'];
$cta_igv_compra   = $row_config['cta_igv_compra'];
$cta_42_s_compra  = $row_config['cta_pagar_soles'];
$cta_42_d_compra  = $row_config['cta_pagar_dolar'];
$cta_det_compras  = $row_config['cta_det_compras'];


$query_venta     = "SELECT * FROM vw_tbl_compra_cab WHERE idempresa= $empresa  AND fecha_emision BETWEEN '$fecha_ini' AND '$fecha_fin'";
$resultado_venta = $connect->query($query_venta);
$row_venta       = $resultado_venta->fetchAll(PDO::FETCH_ASSOC);
$n=0;
require_once 'assets/plugins/phpexcel/Classes/PHPExcel.php';
$objPHPExcel = new PHPExcel();
$cel=1;
$objPHPExcel->setActiveSheetIndex(0)
        ->setCellValue('A'.$cel, 'Origen')
        ->setCellValue('B'.$cel, 'Num.Voucher')
        ->setCellValue('C'.$cel, 'Fecha')
        ->setCellValue('D'.$cel, 'Cuenta')
        ->setCellValue('E'.$cel, 'Mnoto Debe')
        ->setCellValue('F'.$cel, 'Monto Haber')
        ->setCellValue('G'.$cel, 'Moneda S/D')
        ->setCellValue('H'.$cel, 'T.Cambio')
        ->setCellValue('I'.$cel, 'Doc')
        ->setCellValue('J'.$cel, 'Num.Doc')
        ->setCellValue('K'.$cel, 'Fec.Doc')
        ->setCellValue('L'.$cel, 'Fec.Ven')
        ->setCellValue('M'.$cel, 'Cod.Prov.Clie')
        ->setCellValue('N'.$cel, 'C.Costo')
        ->setCellValue('O'.$cel, 'Presupuesto')
        ->setCellValue('P'.$cel, 'F.Efectivo')
        ->setCellValue('Q'.$cel, 'Glosa')
        ->setCellValue('R'.$cel, 'Libro C/V/R')
        ->setCellValue('S'.$cel, 'Mto.Neto 1')
        ->setCellValue('T'.$cel, 'Mto.Neto 2')
        ->setCellValue('U'.$cel, 'Mto.Neto 3')
        ->setCellValue('V'.$cel, 'Mto.Neto 4')
        ->setCellValue('W'.$cel, 'Mto.Neto 5')
        ->setCellValue('X'.$cel, 'Mto.Neto 6')
        ->setCellValue('Y'.$cel, 'Mto.Neto 7')
        ->setCellValue('Z'.$cel, 'Mto.Neto 8')
        ->setCellValue('AA'.$cel, 'Mto.Neto 9')
        ->setCellValue('AB'.$cel, 'Mto.IGV')
        ->setCellValue('AC'.$cel, 'Ref.Doc')
        ->setCellValue('AD'.$cel, 'Ref.Num')
        ->setCellValue('AE'.$cel, 'Ref.Fecha')
        ->setCellValue('AF'.$cel, 'Det.Num')
        ->setCellValue('AG'.$cel, 'Det.Fecha')
        ->setCellValue('AH'.$cel, 'RUC')
        ->setCellValue('AI'.$cel, 'R.Social')
        ->setCellValue('AJ'.$cel, 'Tipo')
        ->setCellValue('AK'.$cel, 'Tip.Doc.Iden')
        ->setCellValue('AL'.$cel, 'Medio de Pago')
        ->setCellValue('AM'.$cel, 'Apellido 1')
        ->setCellValue('AN'.$cel, 'Apellido 2')
        ->setCellValue('AO'.$cel, 'Nombre')
        ->setCellValue('AP'.$cel, 'T.Bien')
        ->setCellValue('AQ'.$cel, 'refMonto');
$vou=1;

foreach($row_venta as $row)
{
     $idventa = $row['id'];
     $tdoc     = $row['tipocomp'];
     $ndoc     = $row['serie'].'-'.$row['correlativo'];
     $doc_ref  = $row['serie_ref'].'-'.$row['correlativo_ref'];

     if($doc_ref == '-')
     {
        $doc_ref = '';
     }
     else
     {
        $doc_ref = $doc_ref;
     }
    //$moneda  = $row['codmoneda'];

    if($row['codmoneda'] == 'PEN')
    {
        $cta_42 =  $cta_42_s_compra;
        $moneda =  'S';
    }

    else
    {
        $cta_42 =  $cta_42_d_compra;
        $moneda =  'D';
    }

    $cliente       = $row['codcliente'];
    $query_cliente = $connect->prepare("SELECT * FROM tbl_contribuyente WHERE num_doc = $cliente");
    $query_cliente->execute();
    $row_cliente   = $query_cliente->fetch(PDO::FETCH_ASSOC);

    $ruc          = $row_cliente['num_doc'];
    $persona      = $row_cliente['nombre_persona'];
    $tipo_doc     = $row_cliente['tipo_doc'];
    $tipo         = '1';



    $total = $row['op_gravadas'] + $row['op_exoneradas'] + $row['op_inafectas'] + $row['igv'] - $row['imp_detraccion'];

    $cel+=1;
                 
    if($row['tipocomp']=='07')
    {
              $objPHPExcel->getActiveSheet()->getStyle("B".$cel)->getNumberFormat()->setFormatCode("#,##0"); 
                $objPHPExcel->getActiveSheet()->getStyle("E".$cel.":F".$cel)->getNumberFormat()->setFormatCode("#,##0.00");
                $objPHPExcel->getActiveSheet()->getStyle("H".$cel)->getNumberFormat()->setFormatCode("#,##0.000");  
                $objPHPExcel->getActiveSheet()->getStyle("S".$cel.":AB".$cel)->getNumberFormat()->setFormatCode("#,##0.00");
                $objPHPExcel->getActiveSheet()->getColumnDimension('C')->setWidth(15);
                 $objPHPExcel->getActiveSheet()->getColumnDimension('J')->setWidth(15);
                 $objPHPExcel->getActiveSheet()->getColumnDimension('K')->setWidth(15);
                 $objPHPExcel->getActiveSheet()->getColumnDimension('L')->setWidth(15);
                $objPHPExcel->getActiveSheet()->getColumnDimension('M')->setWidth(15);
                $objPHPExcel->getActiveSheet()->getColumnDimension('Q')->setWidth(60);
                 $objPHPExcel->getActiveSheet()->getColumnDimension('AD')->setWidth(20);
                $objPHPExcel->getActiveSheet()->getColumnDimension('AH')->setWidth(15);
                $objPHPExcel->getActiveSheet()->getColumnDimension('AI')->setWidth(60);

                $objPHPExcel->setActiveSheetIndex(0)
                ->setCellValue('A'.$cel, $origen_compra)
                ->setCellValue('B'.$cel, $vou)
                ->setCellValue('C'.$cel, date("d/m/Y", strtotime($row['fecha_emision'])))
                ->setCellValue('D'.$cel, $cta_42)
                ->setCellValue('E'.$cel, $total)
                ->setCellValue('F'.$cel, '')
                ->setCellValue('G'.$cel, $moneda)
                ->setCellValue('H'.$cel, 3.00)
                ->setCellValue('I'.$cel, $tdoc)
                ->setCellValue('J'.$cel, $ndoc)
                ->setCellValue('K'.$cel, date("d/m/Y", strtotime($row['fecha_emision'])))
                ->setCellValue('L'.$cel, date("d/m/Y", strtotime($row['fecha_vencimiento'])))
                ->setCellValue('M'.$cel, $ruc)
                ->setCellValue('N'.$cel, '')
                ->setCellValue('O'.$cel, '')
                ->setCellValue('P'.$cel, '')
                ->setCellValue('Q'.$cel, 'COMPRAS DEL MES /'.$ndoc)
                ->setCellValue('R'.$cel, '')
                ->setCellValue('S'.$cel, 0.00)
                ->setCellValue('T'.$cel, 0.00)
                ->setCellValue('U'.$cel, 0.00)
                ->setCellValue('V'.$cel, 0.00)
                ->setCellValue('W'.$cel, 0.00)
                ->setCellValue('X'.$cel, 0.00)
                ->setCellValue('Y'.$cel, 0.00)
                ->setCellValue('Z'.$cel, 0.00)
                ->setCellValue('AA'.$cel, 0.00)
                ->setCellValue('AB'.$cel, 0.00)
                ->setCellValue('AC'.$cel, $row['tipocomp_ref'])
                ->setCellValue('AD'.$cel, $doc_ref)
                ->setCellValue('AE'.$cel, '')
                ->setCellValue('AF'.$cel, $row['numero_detraccion'])
                ->setCellValue('AG'.$cel, date("d/m/Y", strtotime($row['fecha_detraccion'])))
                ->setCellValue('AH'.$cel, $ruc)
                ->setCellValue('AI'.$cel, $persona)
                ->setCellValue('AJ'.$cel, $tipo_doc)
                ->setCellValue('AK'.$cel, $tipo)
                ->setCellValue('AL'.$cel, '')
                ->setCellValue('AM'.$cel, '')
                ->setCellValue('AN'.$cel, '')
                ->setCellValue('AO'.$cel, '')
                ->setCellValue('AP'.$cel, '')
                ->setCellValue('AQ'.$cel, '');   
                /*cuenta 40*/
                   $cel+=1;
                         
               
                $objPHPExcel->getActiveSheet()->getStyle("B".$cel)->getNumberFormat()->setFormatCode("#,##0"); 
                $objPHPExcel->getActiveSheet()->getStyle("E".$cel.":F".$cel)->getNumberFormat()->setFormatCode("#,##0.00");
                $objPHPExcel->getActiveSheet()->getStyle("H".$cel)->getNumberFormat()->setFormatCode("#,##0.000");  
                $objPHPExcel->getActiveSheet()->getStyle("S".$cel.":AB".$cel)->getNumberFormat()->setFormatCode("#,##0.00");
                $objPHPExcel->getActiveSheet()->getColumnDimension('C')->setWidth(15);
                 $objPHPExcel->getActiveSheet()->getColumnDimension('J')->setWidth(15);
                 $objPHPExcel->getActiveSheet()->getColumnDimension('K')->setWidth(15);
                 $objPHPExcel->getActiveSheet()->getColumnDimension('L')->setWidth(15);
                $objPHPExcel->getActiveSheet()->getColumnDimension('M')->setWidth(15);
                $objPHPExcel->getActiveSheet()->getColumnDimension('Q')->setWidth(60);
                $objPHPExcel->getActiveSheet()->getColumnDimension('AH')->setWidth(15);
                $objPHPExcel->getActiveSheet()->getColumnDimension('AI')->setWidth(40);

                $objPHPExcel->setActiveSheetIndex(0)
                ->setCellValue('A'.$cel, $origen_compra)
                ->setCellValue('B'.$cel, $vou)
                ->setCellValue('C'.$cel, date("d/m/Y", strtotime($row['fecha_emision'])))
                ->setCellValue('D'.$cel, $cta_igv_compra)
                ->setCellValue('E'.$cel, '')
                ->setCellValue('F'.$cel, $row['igv'])
                ->setCellValue('G'.$cel, $moneda)
                ->setCellValue('H'.$cel, 3.00)
                ->setCellValue('I'.$cel, $tdoc)
                ->setCellValue('J'.$cel, $ndoc)
                ->setCellValue('K'.$cel, date("d/m/Y", strtotime($row['fecha_emision'])))
                ->setCellValue('L'.$cel, date("d/m/Y", strtotime($row['fecha_vencimiento'])))
                ->setCellValue('M'.$cel, $ruc)
                ->setCellValue('N'.$cel, '')
                ->setCellValue('O'.$cel, '')
                ->setCellValue('P'.$cel, '')
                ->setCellValue('Q'.$cel, 'COMPRAS DEL MES /'.$ndoc)
                ->setCellValue('R'.$cel, 'V')
                ->setCellValue('S'.$cel, $row['op_gravadas'])
                ->setCellValue('T'.$cel, 0.00)
                ->setCellValue('U'.$cel, 0.00)
                ->setCellValue('V'.$cel, 0.00)
                ->setCellValue('W'.$cel, 0.00)
                ->setCellValue('X'.$cel, 0.00)
                ->setCellValue('Y'.$cel, 0.00)
                ->setCellValue('Z'.$cel, 0.00)
                ->setCellValue('AA'.$cel, 0.00)
                ->setCellValue('AB'.$cel, $row['igv'])
                ->setCellValue('AC'.$cel, $row['tipocomp_ref'])
                ->setCellValue('AD'.$cel, $doc_ref)
                ->setCellValue('AE'.$cel, '')
                ->setCellValue('AF'.$cel, $row['numero_detraccion'])
                ->setCellValue('AG'.$cel, date("d/m/Y", strtotime($row['fecha_detraccion'])))
                ->setCellValue('AH'.$cel, $ruc)
                ->setCellValue('AI'.$cel, $persona)
                ->setCellValue('AJ'.$cel, $tipo_doc)
                ->setCellValue('AK'.$cel, $tipo)
                ->setCellValue('AL'.$cel, '')
                ->setCellValue('AM'.$cel, '')
                ->setCellValue('AN'.$cel, '')
                ->setCellValue('AO'.$cel, '')
                ->setCellValue('AP'.$cel, '')
                ->setCellValue('AQ'.$cel, '');  
                /*cuenta 70*/
   

                $query_det = "SELECT * FROM vw_tbl_compra_det WHERE idventa=$idventa";
                $resultado_det = $connect->query($query_det);
                $row_det      = $resultado_det->fetchAll(PDO::FETCH_ASSOC);

                foreach($row_det as $det)
                {

                $cel+=1;
                $objPHPExcel->getActiveSheet()->getStyle("B".$cel)->getNumberFormat()->setFormatCode("#,##0"); 
                $objPHPExcel->getActiveSheet()->getStyle("E".$cel.":F".$cel)->getNumberFormat()->setFormatCode("#,##0.00");
                $objPHPExcel->getActiveSheet()->getStyle("H".$cel)->getNumberFormat()->setFormatCode("#,##0.000");  
                $objPHPExcel->getActiveSheet()->getStyle("S".$cel.":AB".$cel)->getNumberFormat()->setFormatCode("#,##0.00");
                $objPHPExcel->getActiveSheet()->getColumnDimension('C')->setWidth(15);
                 $objPHPExcel->getActiveSheet()->getColumnDimension('J')->setWidth(15);
                 $objPHPExcel->getActiveSheet()->getColumnDimension('K')->setWidth(15);
                 $objPHPExcel->getActiveSheet()->getColumnDimension('L')->setWidth(15);
                $objPHPExcel->getActiveSheet()->getColumnDimension('M')->setWidth(15);
                $objPHPExcel->getActiveSheet()->getColumnDimension('Q')->setWidth(60);
                $objPHPExcel->getActiveSheet()->getColumnDimension('AH')->setWidth(15);
                $objPHPExcel->getActiveSheet()->getColumnDimension('AI')->setWidth(40);

                $objPHPExcel->setActiveSheetIndex(0)
                ->setCellValue('A'.$cel, $origen_compra)
                ->setCellValue('B'.$cel, $vou)
                ->setCellValue('C'.$cel, date("d/m/Y", strtotime($row['fecha_emision'])))
                ->setCellValue('D'.$cel, $det['cta_compra'])
                ->setCellValue('E'.$cel, '')
                ->setCellValue('F'.$cel, $det['valor_total'])
                ->setCellValue('G'.$cel, $moneda)
                ->setCellValue('H'.$cel, 3.00)
                ->setCellValue('I'.$cel, $tdoc)
                ->setCellValue('J'.$cel, $ndoc)
                ->setCellValue('K'.$cel, date("d/m/Y", strtotime($row['fecha_emision'])))
                ->setCellValue('L'.$cel, date("d/m/Y", strtotime($row['fecha_vencimiento'])))
                ->setCellValue('M'.$cel, $ruc)
                ->setCellValue('N'.$cel, '')
                ->setCellValue('O'.$cel, '')
                ->setCellValue('P'.$cel, '')
                ->setCellValue('Q'.$cel, 'COMPRAS DEL MES /'.$ndoc)
                ->setCellValue('R'.$cel, '')
                ->setCellValue('S'.$cel, 0.00)
                ->setCellValue('T'.$cel, 0.00)
                ->setCellValue('U'.$cel, 0.00)
                ->setCellValue('V'.$cel, 0.00)
                ->setCellValue('W'.$cel, 0.00)
                ->setCellValue('X'.$cel, 0.00)
                ->setCellValue('Y'.$cel, 0.00)
                ->setCellValue('Z'.$cel, 0.00)
                ->setCellValue('AA'.$cel, 0.00)
                ->setCellValue('AB'.$cel, 0.00)
                ->setCellValue('AC'.$cel, $row['tipocomp_ref'])
                ->setCellValue('AD'.$cel, $doc_ref)
                ->setCellValue('AE'.$cel, '')
                ->setCellValue('AF'.$cel, $row['numero_detraccion'])
                ->setCellValue('AG'.$cel, date("d/m/Y", strtotime($row['fecha_detraccion'])))
                ->setCellValue('AH'.$cel, $ruc)
                ->setCellValue('AI'.$cel, $persona)
                ->setCellValue('AJ'.$cel, $tipo_doc)
                ->setCellValue('AK'.$cel, $tipo)
                ->setCellValue('AL'.$cel, '')
                ->setCellValue('AM'.$cel, '')
                ->setCellValue('AN'.$cel, '')
                ->setCellValue('AO'.$cel, '')
                ->setCellValue('AP'.$cel, '')
                ->setCellValue('AQ'.$cel, '');  

                }

    }
    else /*diferente a nota de credito*/
    {
                $objPHPExcel->getActiveSheet()->getStyle("B".$cel)->getNumberFormat()->setFormatCode("#,##0"); 
                $objPHPExcel->getActiveSheet()->getStyle("E".$cel.":F".$cel)->getNumberFormat()->setFormatCode("#,##0.00");
                $objPHPExcel->getActiveSheet()->getStyle("H".$cel)->getNumberFormat()->setFormatCode("#,##0.000");  
                $objPHPExcel->getActiveSheet()->getStyle("S".$cel.":AB".$cel)->getNumberFormat()->setFormatCode("#,##0.00");
                $objPHPExcel->getActiveSheet()->getColumnDimension('C')->setWidth(15);
                $objPHPExcel->getActiveSheet()->getColumnDimension('J')->setWidth(15);
                $objPHPExcel->getActiveSheet()->getColumnDimension('K')->setWidth(15);
                $objPHPExcel->getActiveSheet()->getColumnDimension('L')->setWidth(15);
                $objPHPExcel->getActiveSheet()->getColumnDimension('M')->setWidth(15);
                $objPHPExcel->getActiveSheet()->getColumnDimension('Q')->setWidth(60);
                $objPHPExcel->getActiveSheet()->getColumnDimension('AD')->setWidth(20);
                $objPHPExcel->getActiveSheet()->getColumnDimension('AH')->setWidth(15);
                $objPHPExcel->getActiveSheet()->getColumnDimension('AI')->setWidth(60);


                $objPHPExcel->setActiveSheetIndex(0)
                ->setCellValue('A'.$cel, $origen_compra)
                ->setCellValue('B'.$cel, $vou)
                ->setCellValue('C'.$cel, date("d/m/Y", strtotime($row['fecha_emision'])))
                ->setCellValue('D'.$cel, $cta_42)
                ->setCellValue('E'.$cel, '')
                ->setCellValue('F'.$cel, $total)
                ->setCellValue('G'.$cel, $moneda)
                ->setCellValue('H'.$cel, 3.00)
                ->setCellValue('I'.$cel, $tdoc)
                ->setCellValue('J'.$cel, $ndoc)
                ->setCellValue('K'.$cel, date("d/m/Y", strtotime($row['fecha_emision'])))
                ->setCellValue('L'.$cel, date("d/m/Y", strtotime($row['fecha_vencimiento'])))
                ->setCellValue('M'.$cel, $ruc)
                ->setCellValue('N'.$cel, '')
                ->setCellValue('O'.$cel, '')
                ->setCellValue('P'.$cel, '')
                ->setCellValue('Q'.$cel, 'COMPRAS DEL MES /'.$ndoc)
                ->setCellValue('R'.$cel, '')
                ->setCellValue('S'.$cel, 0.00)
                ->setCellValue('T'.$cel, 0.00)
                ->setCellValue('U'.$cel, 0.00)
                ->setCellValue('V'.$cel, 0.00)
                ->setCellValue('W'.$cel, 0.00)
                ->setCellValue('X'.$cel, 0.00)
                ->setCellValue('Y'.$cel, 0.00)
                ->setCellValue('Z'.$cel, 0.00)
                ->setCellValue('AA'.$cel, 0.00)
                ->setCellValue('AB'.$cel, 0.00)
                ->setCellValue('AC'.$cel, $row['tipocomp_ref'])
                ->setCellValue('AD'.$cel, $doc_ref)
                ->setCellValue('AE'.$cel, '')
                ->setCellValue('AF'.$cel, $row['numero_detraccion'])
                ->setCellValue('AG'.$cel, date("d/m/Y", strtotime($row['fecha_detraccion'])))
                ->setCellValue('AH'.$cel, $ruc)
                ->setCellValue('AI'.$cel, $persona)
                ->setCellValue('AJ'.$cel, $tipo_doc)
                ->setCellValue('AK'.$cel, $tipo)
                ->setCellValue('AL'.$cel, '')
                ->setCellValue('AM'.$cel, '')
                ->setCellValue('AN'.$cel, '')
                ->setCellValue('AO'.$cel, '')
                ->setCellValue('AP'.$cel, '')
                ->setCellValue('AQ'.$cel, '');   
/*cuenta detraccion*/
 
                 if($row['imp_detraccion']>0)
                 {
                      $cel+=1;
                      $objPHPExcel->getActiveSheet()->getStyle("B".$cel)->getNumberFormat()->setFormatCode("#,##0"); 
                $objPHPExcel->getActiveSheet()->getStyle("E".$cel.":F".$cel)->getNumberFormat()->setFormatCode("#,##0.00");
                $objPHPExcel->getActiveSheet()->getStyle("H".$cel)->getNumberFormat()->setFormatCode("#,##0.000");  
                $objPHPExcel->getActiveSheet()->getStyle("S".$cel.":AB".$cel)->getNumberFormat()->setFormatCode("#,##0.00");
                $objPHPExcel->getActiveSheet()->getColumnDimension('C')->setWidth(15);
                $objPHPExcel->getActiveSheet()->getColumnDimension('J')->setWidth(15);
                $objPHPExcel->getActiveSheet()->getColumnDimension('K')->setWidth(15);
                $objPHPExcel->getActiveSheet()->getColumnDimension('L')->setWidth(15);
                $objPHPExcel->getActiveSheet()->getColumnDimension('M')->setWidth(15);
                $objPHPExcel->getActiveSheet()->getColumnDimension('Q')->setWidth(60);
                $objPHPExcel->getActiveSheet()->getColumnDimension('AD')->setWidth(20);
                $objPHPExcel->getActiveSheet()->getColumnDimension('AH')->setWidth(15);
                $objPHPExcel->getActiveSheet()->getColumnDimension('AI')->setWidth(60);
                $objPHPExcel->getActiveSheet()->getColumnDimension('AF')->setWidth(15);
                $objPHPExcel->getActiveSheet()->getColumnDimension('AG')->setWidth(15);

                    $objPHPExcel->setActiveSheetIndex(0)
                ->setCellValue('A'.$cel, $origen_compra)
                ->setCellValue('B'.$cel, $vou)
                ->setCellValue('C'.$cel, date("d/m/Y", strtotime($row['fecha_emision'])))
                ->setCellValue('D'.$cel, $cta_det_compras )
                ->setCellValue('E'.$cel, '')
                ->setCellValue('F'.$cel, $row['imp_detraccion'])
                ->setCellValue('G'.$cel, $moneda)
                ->setCellValue('H'.$cel, 3.00)
                ->setCellValue('I'.$cel, $tdoc)
                ->setCellValue('J'.$cel, $ndoc)
                ->setCellValue('K'.$cel, date("d/m/Y", strtotime($row['fecha_emision'])))
                ->setCellValue('L'.$cel, date("d/m/Y", strtotime($row['fecha_vencimiento'])))
                ->setCellValue('M'.$cel, $ruc)
                ->setCellValue('N'.$cel, '')
                ->setCellValue('O'.$cel, '')
                ->setCellValue('P'.$cel, '')
                ->setCellValue('Q'.$cel, 'COMPRAS DEL MES /'.$ndoc)
                ->setCellValue('R'.$cel, '')
                ->setCellValue('S'.$cel, 0.00)
                ->setCellValue('T'.$cel, 0.00)
                ->setCellValue('U'.$cel, 0.00)
                ->setCellValue('V'.$cel, 0.00)
                ->setCellValue('W'.$cel, 0.00)
                ->setCellValue('X'.$cel, 0.00)
                ->setCellValue('Y'.$cel, 0.00)
                ->setCellValue('Z'.$cel, 0.00)
                ->setCellValue('AA'.$cel, 0.00)
                ->setCellValue('AB'.$cel, 0.00)
                ->setCellValue('AC'.$cel, $row['tipocomp_ref'])
                ->setCellValue('AD'.$cel, $doc_ref)
                ->setCellValue('AE'.$cel, '')
                ->setCellValue('AF'.$cel, $row['numero_detraccion'])
                ->setCellValue('AG'.$cel, date("d/m/Y", strtotime($row['fecha_detraccion'])))
                ->setCellValue('AH'.$cel, $ruc)
                ->setCellValue('AI'.$cel, $persona)
                ->setCellValue('AJ'.$cel, $tipo_doc)
                ->setCellValue('AK'.$cel, $tipo)
                ->setCellValue('AL'.$cel, '')
                ->setCellValue('AM'.$cel, '')
                ->setCellValue('AN'.$cel, '')
                ->setCellValue('AO'.$cel, '')
                ->setCellValue('AP'.$cel, '')
                ->setCellValue('AQ'.$cel, '');   

                
                 }
                 /*cuenta 40*/
                 $cel+=1;
               
                $objPHPExcel->getActiveSheet()->getStyle("B".$cel)->getNumberFormat()->setFormatCode("#,##0"); 
                $objPHPExcel->getActiveSheet()->getStyle("E".$cel.":F".$cel)->getNumberFormat()->setFormatCode("#,##0.00");
                $objPHPExcel->getActiveSheet()->getStyle("H".$cel)->getNumberFormat()->setFormatCode("#,##0.000");  
                $objPHPExcel->getActiveSheet()->getStyle("S".$cel.":AB".$cel)->getNumberFormat()->setFormatCode("#,##0.00");
                $objPHPExcel->getActiveSheet()->getColumnDimension('C')->setWidth(15);
                 $objPHPExcel->getActiveSheet()->getColumnDimension('J')->setWidth(15);
                 $objPHPExcel->getActiveSheet()->getColumnDimension('K')->setWidth(15);
                 $objPHPExcel->getActiveSheet()->getColumnDimension('L')->setWidth(15);
                $objPHPExcel->getActiveSheet()->getColumnDimension('M')->setWidth(15);
                $objPHPExcel->getActiveSheet()->getColumnDimension('Q')->setWidth(60);
                $objPHPExcel->getActiveSheet()->getColumnDimension('AH')->setWidth(15);
                $objPHPExcel->getActiveSheet()->getColumnDimension('AI')->setWidth(40);

                $objPHPExcel->setActiveSheetIndex(0)
                ->setCellValue('A'.$cel, $origen_compra)
                ->setCellValue('B'.$cel, $vou)
                ->setCellValue('C'.$cel, date("d/m/Y", strtotime($row['fecha_emision'])))
                ->setCellValue('D'.$cel, $cta_igv_compra)
                ->setCellValue('E'.$cel, $row['igv'])
                ->setCellValue('F'.$cel, '')
                ->setCellValue('G'.$cel, $moneda)
                ->setCellValue('H'.$cel, 3.00)
                ->setCellValue('I'.$cel, $tdoc)
                ->setCellValue('J'.$cel, $ndoc)
                ->setCellValue('K'.$cel, date("d/m/Y", strtotime($row['fecha_emision'])))
                ->setCellValue('L'.$cel, date("d/m/Y", strtotime($row['fecha_vencimiento'])))
                ->setCellValue('M'.$cel, $ruc)
                ->setCellValue('N'.$cel, '')
                ->setCellValue('O'.$cel, '')
                ->setCellValue('P'.$cel, '')
                ->setCellValue('Q'.$cel, 'COMPRAS DEL MES /'.$ndoc)
                ->setCellValue('R'.$cel, 'C')
                ->setCellValue('S'.$cel, $row['op_gravadas'])
                ->setCellValue('T'.$cel, 0.00)
                ->setCellValue('U'.$cel, 0.00)
                ->setCellValue('V'.$cel, 0.00)
                ->setCellValue('W'.$cel, 0.00)
                ->setCellValue('X'.$cel, 0.00)
                ->setCellValue('Y'.$cel, 0.00)
                ->setCellValue('Z'.$cel, 0.00)
                ->setCellValue('AA'.$cel, 0.00)
                ->setCellValue('AB'.$cel, $row['igv'])
                ->setCellValue('AC'.$cel, $row['tipocomp_ref'])
                ->setCellValue('AD'.$cel, $doc_ref)
                ->setCellValue('AE'.$cel, '')
                ->setCellValue('AF'.$cel, $row['numero_detraccion'])
                ->setCellValue('AG'.$cel, date("d/m/Y", strtotime($row['fecha_detraccion'])))
                ->setCellValue('AH'.$cel, $ruc)
                ->setCellValue('AI'.$cel, $persona)
                ->setCellValue('AJ'.$cel, $tipo_doc)
                ->setCellValue('AK'.$cel, $tipo)
                ->setCellValue('AL'.$cel, '')
                ->setCellValue('AM'.$cel, '')
                ->setCellValue('AN'.$cel, '')
                ->setCellValue('AO'.$cel, '')
                ->setCellValue('AP'.$cel, '')
                ->setCellValue('AQ'.$cel, '');  
/*cuenta 60*/
   

                $query_det = "SELECT * FROM vw_tbl_compra_det WHERE idventa=$idventa";
                $resultado_det = $connect->query($query_det);
                $row_det      = $resultado_det->fetchAll(PDO::FETCH_ASSOC);

                foreach($row_det as $det)
                {

                $cel+=1;
                $objPHPExcel->getActiveSheet()->getStyle("B".$cel)->getNumberFormat()->setFormatCode("#,##0"); 
                $objPHPExcel->getActiveSheet()->getStyle("E".$cel.":F".$cel)->getNumberFormat()->setFormatCode("#,##0.00");
                $objPHPExcel->getActiveSheet()->getStyle("H".$cel)->getNumberFormat()->setFormatCode("#,##0.000");  
                $objPHPExcel->getActiveSheet()->getStyle("S".$cel.":AB".$cel)->getNumberFormat()->setFormatCode("#,##0.00");
                $objPHPExcel->getActiveSheet()->getColumnDimension('C')->setWidth(15);
                $objPHPExcel->getActiveSheet()->getColumnDimension('J')->setWidth(15);
                $objPHPExcel->getActiveSheet()->getColumnDimension('K')->setWidth(15);
                $objPHPExcel->getActiveSheet()->getColumnDimension('L')->setWidth(15);
                $objPHPExcel->getActiveSheet()->getColumnDimension('M')->setWidth(15);
                $objPHPExcel->getActiveSheet()->getColumnDimension('Q')->setWidth(60);
                $objPHPExcel->getActiveSheet()->getColumnDimension('AD')->setWidth(20);
                $objPHPExcel->getActiveSheet()->getColumnDimension('AH')->setWidth(15);
                $objPHPExcel->getActiveSheet()->getColumnDimension('AI')->setWidth(60);


                $objPHPExcel->setActiveSheetIndex(0)
                ->setCellValue('A'.$cel, $origen_compra)
                ->setCellValue('B'.$cel, $vou)
                ->setCellValue('C'.$cel, date("d/m/Y", strtotime($row['fecha_emision'])))
                ->setCellValue('D'.$cel, $det['cta_compra'])
                ->setCellValue('E'.$cel, $det['valor_total'])
                ->setCellValue('F'.$cel, '')
                ->setCellValue('G'.$cel, $moneda)
                ->setCellValue('H'.$cel, 3.00)
                ->setCellValue('I'.$cel, $tdoc)
                ->setCellValue('J'.$cel, $ndoc)
                ->setCellValue('K'.$cel, date("d/m/Y", strtotime($row['fecha_emision'])))
                ->setCellValue('L'.$cel, date("d/m/Y", strtotime($row['fecha_vencimiento'])))
                ->setCellValue('M'.$cel, $ruc)
                ->setCellValue('N'.$cel, '')
                ->setCellValue('O'.$cel, '')
                ->setCellValue('P'.$cel, '')
                ->setCellValue('Q'.$cel, 'COMPRAS DEL MES /'.$ndoc)
                ->setCellValue('R'.$cel, '')
                ->setCellValue('S'.$cel, 0.00)
                ->setCellValue('T'.$cel, 0.00)
                ->setCellValue('U'.$cel, 0.00)
                ->setCellValue('V'.$cel, 0.00)
                ->setCellValue('W'.$cel, 0.00)
                ->setCellValue('X'.$cel, 0.00)
                ->setCellValue('Y'.$cel, 0.00)
                ->setCellValue('Z'.$cel, 0.00)
                ->setCellValue('AA'.$cel, 0.00)
                ->setCellValue('AB'.$cel, 0.00)
                ->setCellValue('AC'.$cel, $row['tipocomp_ref'])
                ->setCellValue('AD'.$cel, $doc_ref)
                ->setCellValue('AE'.$cel, '')
                ->setCellValue('AF'.$cel, $row['numero_detraccion'])
                ->setCellValue('AG'.$cel, date("d/m/Y", strtotime($row['fecha_detraccion'])))
                ->setCellValue('AH'.$cel, $ruc)
                ->setCellValue('AI'.$cel, $persona)
                ->setCellValue('AJ'.$cel, $tipo_doc)
                ->setCellValue('AK'.$cel, $tipo)
                ->setCellValue('AL'.$cel, '')
                ->setCellValue('AM'.$cel, '')
                ->setCellValue('AN'.$cel, '')
                ->setCellValue('AO'.$cel, '')
                ->setCellValue('AP'.$cel, '')
                ->setCellValue('AQ'.$cel, '');  

                }
    }           
                
   $vou+=1;



}

header('Cache-Control: no-store, no-cache, must-revalidate'); // HTTP/1.1 
header('Cache-Control: pre-check=0, post-check=0, max-age=0'); // HTTP/1.1  
header('Cache-Control: max-age=0');
header('Pragma: public'); 
header('Expires: Sat, 26 Jul 1997 05:00:00 GMT'); // Date in the past    
header('Last-Modified: ' . gmdate('D, d M Y H:i:s') . ' GMT'); 
header('Pragma: no-cache'); 
header('Expires: 0'); 
header('Content-Transfer-Encoding: none'); 
header('Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
header('Content-Disposition: attachment;filename="VouApp.xlsx"');
    
$objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel2007'); 
$objWriter->save('php://output');





 ?>         