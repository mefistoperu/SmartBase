<?php 

$empresa   = $_SESSION['id_empresa'];
//echo $empresa;
$fecha_ini = $rutas[1];
$fecha_fin = $rutas[2];
/*$empresa   = 1;
$fecha_ini = '2023-02-01';
$fecha_fin = '2023-03-01';*/


$query_empresa = $connect->prepare("SELECT * FROM tbl_empresas WHERE id_empresa = $empresa");
$query_empresa->execute();
$row_config=$query_empresa->fetch(PDO::FETCH_ASSOC);

$origen_venta    = $row_config['origen_venta'];
$origen_cobranzas    = $row_config['origen_cobranzas'];
$cta_igv_venta   = $row_config['cta_igv_venta'];
$cta_12_s_venta  = $row_config['cta_cobrar_soles'];
$cta_12_d_venta  = $row_config['cta_cobrar_dolar'];


$query_venta     = "SELECT * FROM vw_tbl_venta_cab WHERE idempresa= $empresa  AND fecha_emision BETWEEN '$fecha_ini' AND '$fecha_fin' AND tipocomp in ('01','03','07','08') AND feestado in ('1','2','8')";
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
    //$moneda  = $row['codmoneda'];

    if($row['codmoneda'] == 'PEN')
    {
        $cta_12 =  $cta_12_s_venta;
        $moneda =  'S';
    }

    else
    {
        $cta_12 =  $cta_12_d_venta;
        $moneda =  'D';
    }

    $cliente       = $row['idcliente'];
    $query_cliente = $connect->prepare("SELECT * FROM tbl_contribuyente WHERE id_persona = $cliente");
    $query_cliente->execute();
    $row_cliente   = $query_cliente->fetch(PDO::FETCH_ASSOC);

    $ruc          = $row_cliente['num_doc'];
    $persona      = $row_cliente['nombre_persona'];
    $tipo_doc     = $row_cliente['tipo_doc'];
    $tipo         = '2';
    
    if($ruc == '00000000')
    {
        $ruc = '11111111';
    }



    $total = $row['total'];

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
                ->setCellValue('A'.$cel, $origen_venta)
                ->setCellValue('B'.$cel, $vou)
                ->setCellValue('C'.$cel, date("d/m/Y", strtotime($row['fecha_emision'])))
                ->setCellValue('D'.$cel, $cta_12)
                ->setCellValue('E'.$cel, 0.00)
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
                ->setCellValue('Q'.$cel, 'NOTA DE CREDITO '.$tdoc.'-'.$ndoc.' DOC REF: '.$row['tipocomp_ref'].'-'.$row['serie_ref'].'-'.$row['correlativo_ref'])
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
                ->setCellValue('AD'.$cel, $row['serie_ref'].'-'.$row['correlativo_ref'])
                ->setCellValue('AE'.$cel, '')
                ->setCellValue('AF'.$cel, '')
                ->setCellValue('AG'.$cel, '')
                ->setCellValue('AH'.$cel, $ruc)
                ->setCellValue('AI'.$cel, $persona)
                ->setCellValue('AJ'.$cel, $tipo)
                ->setCellValue('AK'.$cel, $tipo_doc)
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
                ->setCellValue('A'.$cel, $origen_venta)
                ->setCellValue('B'.$cel, $vou)
                ->setCellValue('C'.$cel, date("d/m/Y", strtotime($row['fecha_emision'])))
                ->setCellValue('D'.$cel, $cta_igv_venta)
                ->setCellValue('E'.$cel, $row['igv'])
                ->setCellValue('F'.$cel, 0.00)
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
                ->setCellValue('Q'.$cel, 'NOTA DE CREDITO '.$tdoc.'-'.$ndoc.' DOC REF: '.$row['tipocomp_ref'].'-'.$row['serie_ref'].'-'.$row['correlativo_ref'])
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
                ->setCellValue('AD'.$cel, $row['serie_ref'].'-'.$row['correlativo_ref'])
                ->setCellValue('AE'.$cel, '')
                ->setCellValue('AF'.$cel, '')
                ->setCellValue('AG'.$cel, '')
                ->setCellValue('AH'.$cel, $ruc)
                ->setCellValue('AI'.$cel, $persona)
                ->setCellValue('AJ'.$cel, $tipo)
                ->setCellValue('AK'.$cel, $tipo_doc)
                ->setCellValue('AL'.$cel, '')
                ->setCellValue('AM'.$cel, '')
                ->setCellValue('AN'.$cel, '')
                ->setCellValue('AO'.$cel, '')
                ->setCellValue('AP'.$cel, '')
                ->setCellValue('AQ'.$cel, '');  
                /*cuenta 70*/
   

                $query_det = "SELECT * FROM vw_tbl_venta_det WHERE idventa=$idventa";
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
                ->setCellValue('A'.$cel, $origen_venta)
                ->setCellValue('B'.$cel, $vou)
                ->setCellValue('C'.$cel, date("d/m/Y", strtotime($row['fecha_emision'])))
                ->setCellValue('D'.$cel, $det['cta_venta'])
                ->setCellValue('E'.$cel, $det['valor_total'])
                ->setCellValue('F'.$cel, 0.00)
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
                ->setCellValue('Q'.$cel, 'NOTA DE CREDITO '.$tdoc.'-'.$ndoc.' DOC REF: '.$row['tipocomp_ref'].'-'.$row['serie_ref'].'-'.$row['correlativo_ref'])
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
                ->setCellValue('AD'.$cel, $row['serie_ref'].'-'.$row['correlativo_ref'])
                ->setCellValue('AE'.$cel, '')
                ->setCellValue('AF'.$cel, '')
                ->setCellValue('AG'.$cel, '')
                ->setCellValue('AH'.$cel, $ruc)
                ->setCellValue('AI'.$cel, $persona)
                ->setCellValue('AJ'.$cel, $tipo)
                ->setCellValue('AK'.$cel, $tipo_doc)
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
                ->setCellValue('A'.$cel, $origen_venta)
                ->setCellValue('B'.$cel, $vou)
                ->setCellValue('C'.$cel, date("d/m/Y", strtotime($row['fecha_emision'])))
                ->setCellValue('D'.$cel, $cta_12)
                ->setCellValue('E'.$cel, $total)
                ->setCellValue('F'.$cel, 0.00)
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
                ->setCellValue('Q'.$cel, 'POR LA VENTA DEL CPE '.$tdoc.'-'.$ndoc)
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
                ->setCellValue('AD'.$cel, $row['serie_ref'].'-'.$row['correlativo_ref'])
                ->setCellValue('AE'.$cel, '')
                ->setCellValue('AF'.$cel, '')
                ->setCellValue('AG'.$cel, '')
                ->setCellValue('AH'.$cel, $ruc)
                ->setCellValue('AI'.$cel, $persona)
                ->setCellValue('AJ'.$cel, $tipo)
                ->setCellValue('AK'.$cel, $tipo_doc)
                ->setCellValue('AL'.$cel, '')
                ->setCellValue('AM'.$cel, '')
                ->setCellValue('AN'.$cel, '')
                ->setCellValue('AO'.$cel, '')
                ->setCellValue('AP'.$cel, '')
                ->setCellValue('AQ'.$cel, '');   
 
                /*cuenta 70*/
   

                $query_det = "SELECT * FROM vw_tbl_venta_det WHERE idventa=$idventa";
                $resultado_det = $connect->query($query_det);
                $row_det      = $resultado_det->fetchAll(PDO::FETCH_ASSOC);
                 $valorut = 0;
                foreach($row_det as $det)
                {
                    
                    if($det['codigo_afectacion']=='10')
                        {
                            $valoru=$det['valor_total']/1.18;
                        }
                    else
                    {
                        $valoru=$det['valor_total'];
                    }    
                        
                        
                    $cel+=1;
                    $objPHPExcel->getActiveSheet()->getStyle("B".$cel)->getNumberFormat()->setFormatCode("#,##0"); 
                    $objPHPExcel->getActiveSheet()->getStyle("E".$cel.":F".$cel)->getNumberFormat()->setFormatCode("#,##0.000");
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
                    ->setCellValue('A'.$cel, $origen_venta)
                    ->setCellValue('B'.$cel, $vou)
                    ->setCellValue('C'.$cel, date("d/m/Y", strtotime($row['fecha_emision'])))
                    ->setCellValue('D'.$cel, $det['cta_venta'])
                    ->setCellValue('E'.$cel, 0.00)
                    ->setCellValue('F'.$cel, $valoru)
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
                    ->setCellValue('Q'.$cel, 'POR LA VENTA DEL CPE '.$tdoc.'-'.$ndoc)
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
                    ->setCellValue('AD'.$cel, $row['serie_ref'].'-'.$row['correlativo_ref'])
                    ->setCellValue('AE'.$cel, '')
                    ->setCellValue('AF'.$cel, '')
                    ->setCellValue('AG'.$cel, '')
                    ->setCellValue('AH'.$cel, $ruc)
                    ->setCellValue('AI'.$cel, $persona)
                    ->setCellValue('AJ'.$cel, $tipo)
                    ->setCellValue('AK'.$cel, $tipo_doc)
                    ->setCellValue('AL'.$cel, '')
                    ->setCellValue('AM'.$cel, '')
                    ->setCellValue('AN'.$cel, '')
                    ->setCellValue('AO'.$cel, '')
                    ->setCellValue('AP'.$cel, '')
                    ->setCellValue('AQ'.$cel, '');  
                    
                    $valorut = $valorut + $valoru;

                }
                
             /*cuenta 40*/
                   $cel+=1;
                   
                   $igvt =  $total-$valorut;
                                 
               
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
                ->setCellValue('A'.$cel, $origen_venta)
                ->setCellValue('B'.$cel, $vou)
                ->setCellValue('C'.$cel, date("d/m/Y", strtotime($row['fecha_emision'])))
                ->setCellValue('D'.$cel, $cta_igv_venta)
                ->setCellValue('E'.$cel, 0.00)
                ->setCellValue('F'.$cel, $igvt)
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
                ->setCellValue('Q'.$cel, 'POR LA VENTA DEL CPE '.$tdoc.'-'.$ndoc)
                ->setCellValue('R'.$cel, 'V')
                ->setCellValue('S'.$cel, $row['op_gravadas'])
                ->setCellValue('T'.$cel, 0.00)
                ->setCellValue('U'.$cel, 0.00)
                ->setCellValue('V'.$cel, 0.00)
                ->setCellValue('W'.$cel, $row['op_exoneradas'])
                ->setCellValue('X'.$cel, 0.00)
                ->setCellValue('Y'.$cel, 0.00)
                ->setCellValue('Z'.$cel, 0.00)
                ->setCellValue('AA'.$cel, 0.00)
                ->setCellValue('AB'.$cel, $row['igv'])
                ->setCellValue('AC'.$cel, $row['tipocomp_ref'])
                ->setCellValue('AD'.$cel, $row['serie_ref'].'-'.$row['correlativo_ref'])
                ->setCellValue('AE'.$cel, '')
                ->setCellValue('AF'.$cel, '')
                ->setCellValue('AG'.$cel, '')
                ->setCellValue('AH'.$cel, $ruc)
                ->setCellValue('AI'.$cel, $persona)
                ->setCellValue('AJ'.$cel, $tipo)
                ->setCellValue('AK'.$cel, $tipo_doc)
                ->setCellValue('AL'.$cel, '')
                ->setCellValue('AM'.$cel, '')
                ->setCellValue('AN'.$cel, '')
                ->setCellValue('AO'.$cel, '')
                ->setCellValue('AP'.$cel, '')
                ->setCellValue('AQ'.$cel, ''); 
    }           
                
   $vou+=1;
   
   

}

$vouventa = $vou;

/******************************cobros*******************************/
$query_venta_id     = "SELECT id,tipocomp,serie,correlativo FROM vw_tbl_venta_cab WHERE idempresa= $empresa  AND fecha_emision BETWEEN '$fecha_ini' AND '$fecha_fin' AND tipocomp in ('01','03','07','08') AND feestado in ('1','2','8')";
$resultado_venta_id = $connect->query($query_venta_id);
$row_venta_id       = $resultado_venta_id->fetchAll(PDO::FETCH_ASSOC);
$vou = 1;
$cel+=1;
foreach($row_venta_id as $row_id)
{
        $id_venta_cab = $row_id['id'];
        $tdoc         = $row_id['tipocomp'];
        $ndoc          = $row_id['serie'].'-'.$row_id['correlativo'];

        $query_pago     = "SELECT * FROM vw_tbl_venta_pago WHERE idempresa= $empresa  AND fecha_emision BETWEEN '$fecha_ini' AND '$fecha_fin' AND id_venta = $id_venta_cab";
        //echo $query_pago;
        $resultado_pago = $connect->query($query_pago);
        $row_pago       = $resultado_pago->fetchAll(PDO::FETCH_ASSOC);

        $importe_pago =0;

        foreach($row_pago as $rpago)
        {
            
                $importe_pagar = $rpago['importe_pago'] - $rpago['vuelto'];
            


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
        ->setCellValue('A'.$cel, $origen_cobranzas)
        ->setCellValue('B'.$cel, $vou)
        ->setCellValue('C'.$cel, date("d/m/Y", strtotime($rpago['fecha_emision'])))
        ->setCellValue('D'.$cel, $rpago['cuenta'])
        ->setCellValue('E'.$cel, $importe_pagar )
        ->setCellValue('F'.$cel, 0.00)
        ->setCellValue('G'.$cel, $moneda)
        ->setCellValue('H'.$cel, 3.00)
        ->setCellValue('I'.$cel, '')
        ->setCellValue('J'.$cel, '')
        ->setCellValue('K'.$cel, date("d/m/Y", strtotime($rpago['fecha_emision'])))
        ->setCellValue('L'.$cel, date("d/m/Y", strtotime($rpago['fecha_emision'])))
        ->setCellValue('M'.$cel, '')
        ->setCellValue('N'.$cel, '')
        ->setCellValue('O'.$cel, '')
        ->setCellValue('P'.$cel, '')
        ->setCellValue('Q'.$cel, 'COBRANZAS')
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
        ->setCellValue('AC'.$cel, '')
        ->setCellValue('AD'.$cel, '')
        ->setCellValue('AE'.$cel, '')
        ->setCellValue('AF'.$cel, '')
        ->setCellValue('AG'.$cel, '')
        ->setCellValue('AH'.$cel, '')
        ->setCellValue('AI'.$cel, '')
        ->setCellValue('AJ'.$cel, '')
        ->setCellValue('AK'.$cel, '')
        ->setCellValue('AL'.$cel, '')
        ->setCellValue('AM'.$cel, '')
        ->setCellValue('AN'.$cel, '')
        ->setCellValue('AO'.$cel, '')
        ->setCellValue('AP'.$cel, '')
        ->setCellValue('AQ'.$cel, ''); 

         $importe_pago =$importe_pago  + $importe_pagar ;

            $cel+=1;

        }
        
        if($importe_pago>0)
        {
            $query_venta     = "SELECT * FROM vw_tbl_venta_cab WHERE  id = $id_venta_cab";
            $resultado_venta = $connect->query($query_venta);
            $row_venta       = $resultado_venta->fetch(PDO::FETCH_ASSOC);
        
        
            $ruc = $row_venta['codcliente'];
             if($ruc == '00000000')
            {
                $ruc = '11111111';
            }

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
            ->setCellValue('A'.$cel, $origen_cobranzas)
            ->setCellValue('B'.$cel, $vou)
            ->setCellValue('C'.$cel, date("d/m/Y", strtotime($row['fecha_emision'])))
            ->setCellValue('D'.$cel, $cta_12)
            ->setCellValue('E'.$cel, 0.00)
            ->setCellValue('F'.$cel, $importe_pago)
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
            ->setCellValue('Q'.$cel, 'COBRANZA DEL CPE '.$tdoc.'-'.$ndoc)
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
            ->setCellValue('AD'.$cel, $row['serie_ref'].'-'.$row['correlativo_ref'])
            ->setCellValue('AE'.$cel, '')
            ->setCellValue('AF'.$cel, '')
            ->setCellValue('AG'.$cel, '')
            ->setCellValue('AH'.$cel, $ruc)
            ->setCellValue('AI'.$cel, $row_venta['nombre_persona'])
            ->setCellValue('AJ'.$cel, $tipo)
            ->setCellValue('AK'.$cel, $row_venta['tipo_doc'])
            ->setCellValue('AL'.$cel, '')
            ->setCellValue('AM'.$cel, '')
            ->setCellValue('AN'.$cel, '')
            ->setCellValue('AO'.$cel, '')
            ->setCellValue('AP'.$cel, '')
            ->setCellValue('AQ'.$cel, '');   
            /*cuenta 40*/
            $cel+=1;

            $vou+=1;
        }




}

        /*************anulados*********************/

$vou = $vouventa;
 $query_anulado    = "SELECT * FROM vw_tbl_venta_cab WHERE idempresa= $empresa  AND fecha_emision BETWEEN '$fecha_ini' AND '$fecha_fin' AND tipocomp in ('01','03','07','08') AND feestado in ('3','5','6')";
$resultado_anulado = $connect->query($query_anulado);
$row_anulado       = $resultado_anulado->fetchAll(PDO::FETCH_ASSOC);

/*cuenta 40*/
            foreach($row_anulado as $anulado)
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
                $objPHPExcel->getActiveSheet()->getColumnDimension('AH')->setWidth(15);
                $objPHPExcel->getActiveSheet()->getColumnDimension('AI')->setWidth(40);

                $objPHPExcel->setActiveSheetIndex(0)
                ->setCellValue('A'.$cel, $origen_venta)
                ->setCellValue('B'.$cel, $vou)
                ->setCellValue('C'.$cel, date("d/m/Y", strtotime($anulado['fecha_emision'])))
                ->setCellValue('D'.$cel, $cta_igv_venta)
                ->setCellValue('E'.$cel, 0.00)
                ->setCellValue('F'.$cel, 0.00)
                ->setCellValue('G'.$cel, $moneda)
                ->setCellValue('H'.$cel, 3.00)
                ->setCellValue('I'.$cel, $anulado['tipocomp'])
                ->setCellValue('J'.$cel, $anulado['serie'].'-'.$anulado['correlativo'])
                ->setCellValue('K'.$cel, date("d/m/Y", strtotime($anulado['fecha_emision'])))
                ->setCellValue('L'.$cel, date("d/m/Y", strtotime($anulado['fecha_vencimiento'])))
                ->setCellValue('M'.$cel, '00000000000')
                ->setCellValue('N'.$cel, '')
                ->setCellValue('O'.$cel, '')
                ->setCellValue('P'.$cel, '')
                ->setCellValue('Q'.$cel, 'CPE ANULADO '.$anulado['tipocomp'].'-'.$anulado['serie'].'-'.$anulado['correlativo'])
                ->setCellValue('R'.$cel, 'V')
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
                ->setCellValue('AC'.$cel, '')
                ->setCellValue('AD'.$cel,  '')
                ->setCellValue('AE'.$cel, '')
                ->setCellValue('AF'.$cel, '')
                ->setCellValue('AG'.$cel, '')
                ->setCellValue('AH'.$cel, '00000000000')
                ->setCellValue('AI'.$cel, 'CPE ANULADO')
                ->setCellValue('AJ'.$cel, '1')
                ->setCellValue('AK'.$cel, '0')
                ->setCellValue('AL'.$cel, '')
                ->setCellValue('AM'.$cel, '')
                ->setCellValue('AN'.$cel, '')
                ->setCellValue('AO'.$cel, '')
                ->setCellValue('AP'.$cel, '')
                ->setCellValue('AQ'.$cel, '');  
                
             
            $cel+=1;

            $vou+=1;
            }

/*      $query_pago     = "SELECT * FROM vw_tbl_venta_pago WHERE idempresa= $empresa  AND fecha_emision BETWEEN '$fecha_ini' AND '$fecha_fin'";

        //echo $query_pago;
        $resultado_pago = $connect->query($query_pago);
        $row_pago       = $resultado_pago->fetchAll(PDO::FETCH_ASSOC);
        //print_r($row_pago);
        $n=0;
        $cel+=1;
        $vou=1;

foreach ($row_pago as $pago) 
{
    $id_venta = $pago['id_venta'];
    


    //cuenta 12 de cobros

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
                ->setCellValue('A'.$cel, $origen_cobranzas)
                ->setCellValue('B'.$cel, $vou)
                ->setCellValue('C'.$cel, date("d/m/Y", strtotime($row['fecha_emision'])))
                ->setCellValue('D'.$cel, $cta_12)
                ->setCellValue('E'.$cel, $total)
                ->setCellValue('F'.$cel, 0.00)
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
                ->setCellValue('Q'.$cel, 'VENTAS DEL MES')
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
                ->setCellValue('AD'.$cel, $row['serie_ref'].'-'.$row['correlativo_ref'])
                ->setCellValue('AE'.$cel, '')
                ->setCellValue('AF'.$cel, '')
                ->setCellValue('AG'.$cel, '')
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
                //cuenta 40
               $cel+=1;

}

*/

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
header('Content-Disposition: attachment;filename="VouApp_Venta.xlsx"');
    
$objWriter = PHPExcel_IOFactory::createWriter($objPHPExcel, 'Excel2007'); 
$objWriter->save('php://output');

?>
