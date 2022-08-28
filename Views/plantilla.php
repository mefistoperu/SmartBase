<?php
session_start();
error_reporting(0);

if(isset($_SESSION["iniciarSesion"]) && $_SESSION["iniciarSesion"] == "facturalo")
{
      $rutas = array();
/*=============================================
    CONTENIDO
    =============================================*/

    if(isset($_GET["ruta"]))
    {
       $rutas = explode("/",$_GET["ruta"]);

              if($rutas[0] == "inicio" ||
                 $rutas[0] == "cerrar" ||
                 $rutas[0] == "contribuyente" ||
                 $rutas[0] == "almacenes" ||
                 $rutas[0] == "categorias" ||
                 $rutas[0] == "marcas" ||
                 $rutas[0] == "series" ||
                 $rutas[0] == "insumos" ||
                 $rutas[0] == "productos" ||
                 $rutas[0] == "recetas" ||
                 $rutas[0] == "serie_usuario" ||
                 $rutas[0] == "medio_pago" ||
                 $rutas[0] == "serie_usuario" ||
                 $rutas[0] == "empresa" ||
                 $rutas[0] == "contabilidad" ||
                 $rutas[0] == "compras" ||
                 $rutas[0] == "nueva_compra" ||
                 $rutas[0] == "cuentas_por_pagar" ||
                 $rutas[0] == "ventas" ||
                 $rutas[0] == "nota_venta" ||
                 $rutas[0] == "nueva_venta" ||
                 $rutas[0] == "nueva_nota_venta" ||
                 $rutas[0] == "nueva_compra" ||
                 $rutas[0] == "nueva_nota_credito" ||
                 $rutas[0] == "nueva_nota_debito" ||
                 $rutas[0] == "cuentas_por_cobrar" ||
                 $rutas[0] == "cuentas_por_pagar" ||
                 $rutas[0] == "ticket_factura" ||
                 $rutas[0] == "ticket_factura_compra" ||
                 $rutas[0] == "factura_pdf" ||
                 $rutas[0] == "factura_pdf_compra" ||
                 $rutas[0] == "rpt_ventas_sunat" ||
                 $rutas[0] == "rpt_ventas_sunat_pdf" ||
                 $rutas[0] == "rpt_ventas_diarias" ||
                 $rutas[0] == "rpt_ventas_diarias_pdf" ||
                 $rutas[0] == "resumen_cpe" ||
                 $rutas[0] == "usuarios")
              {

                include "Modules/".$rutas[0].".php";

              }
              else
              {

                include "Modules/404.php";

              }

    }
     else
    {
        include "Modules/inicio.php";
    }

}
else
{
        include "Modules/login.php";
}


 ?>
