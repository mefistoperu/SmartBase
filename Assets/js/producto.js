
$(document).ready(function(){
	$(document).on('click', '.edit', function(){
		var id=$(this).val();
		var nombre=$('#nombre'+id).text();
		var descripcion=$('#descripcion'+id).text();
		var afectacion=$('#afectacion'+id).text();
		var idmarca=$('#idmarca'+id).text();
		var unidad=$('#unidad'+id).text();		
		var preciov=$('#precio_venta'+id).text();
		var preciov2=$('#precio_venta2'+id).text();

		var costo=$('#costo'+id).text();
		var factor=$('#factor'+id).text();
		var por1=$('#factor'+id).text();
		var por1=$('#por1'+id).text();
		var por2=$('#por2'+id).text();


	
		$('#edit').modal('show');
		$('#update_id').val(id);
		$('#update_nombre').val(nombre);
		$('#update_descripcion').val(descripcion);
		$('#update_precio_venta').val(preciov);
		$('#update_precio_venta2').val(preciov2);
		$('#update_por_gan1').val(por1);
		$('#update_por_gan2').val(por2);

		$('#update_precio_compra').val(costo);

		$('#update_factor').val(factor);

		$('#update_marca').val(idmarca).attr('selected', 'selected');
		$('#update_unidad').val(unidad).attr('selected', 'selected');
		$('#update_afectacion').val(afectacion).attr('selected', 'selected');
	});



	$(document).on('click', '.delete', function(){
		var id=$(this).val();
		
	
		$('#deleteProducto').modal('show');
		$('#delete_id').val(id);
		
	});
});


function calcula_costo()
{
    var costo   = 0.00;
	var gpv     = 0.00;
	var pv      = 0.00;
	var gpvm    = 0.00;
 	var pvm     = 0.00;
 	var fac     = 0.00;


 	costo = document.getElementById("precio_compra").value;
 	gpv   = document.getElementById("por_gan1").value;
 	pv    = document.getElementById("precio_venta").value;
 	gpvm  = document.getElementById("por_gan2").value;
 	pvm   = document.getElementById("precio_venta2").value;
 	fac   = document.getElementById("factor").value;

    
    pv  = (fac*(parseFloat(costo) + (parseFloat(gpv)*parseFloat(costo)/100))).toFixed(2);
    pvm = (fac*(parseFloat(costo) + (parseFloat(gpvm)*parseFloat(costo)/100))).toFixed(2);

    $('#precio_venta').val(pv);
    $('#precio_venta2').val(pvm);
 	


}

function calcula_costo1()
{
    var costo   = 0.00;
	var gpv     = 0.00;
	var pv      = 0.00;
	var gpvm    = 0.00;
 	var pvm     = 0.00;
 	var fac     = 0.00;


 	costo = document.getElementById("update_precio_compra").value;
 	gpv   = document.getElementById("update_por_gan1").value;
 	pv    = document.getElementById("update_precio_venta").value;
 	gpvm  = document.getElementById("update_por_gan2").value;
 	pvm   = document.getElementById("update_precio_venta2").value;
 	fac   = document.getElementById("update_factor").value;

    
    pv  = (fac*(parseFloat(costo) + (parseFloat(gpv)*parseFloat(costo)/100))).toFixed(2);
    pvm = (fac*(parseFloat(costo) + (parseFloat(gpvm)*parseFloat(costo)/100))).toFixed(2);

    $('#update_precio_venta').val(pv);
    $('#update_precio_venta2').val(pvm);
 	


}

