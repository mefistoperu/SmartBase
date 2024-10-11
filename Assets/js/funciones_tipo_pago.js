$(document).ready(function(){
//##################################CREAR CLIENTE##################################//
	$('#form_add_mpago').submit(function(e)
	{
		swal.fire({
					title: "Cargando...",
					text: "Por favor espere",
					imageUrl: base_url+'/assets/js/ajax.gif',
					showConfirmButton: false,
					allowOutsideClick: false
					});
		e.preventDefault();
		$.ajax({
			url  :  base_url+'/assets/ajax/ajax_tpago.php',
			type : "POST",
			async: true,
			data : $('#form_add_mpago').serialize(),

			success: function(response)
			{
			 
             $('#exito').modal('show'); 
             console.log(response);
             location.reload(); 
			},
			error: function(response)
			{
             $('#error').modal('show'); 
			}

		});
	});
	
//##################################EDITAR CLIENTE##################################//
$('#form_edi_mpago').submit(function(e)
{
		swal.fire({
					title: "Cargando...",
					text: "Por favor espere",
					imageUrl: base_url+'/assets/js/ajax.gif',
					showConfirmButton: false,
					allowOutsideClick: false
					});
		e.preventDefault();
		$.ajax({
			url  :  base_url+'/assets/ajax/ajax_tpago.php',
			type : "POST",
			async: true,
			data : $('#form_edi_mpago').serialize(),

			success: function(response)
			{
			 
             $('#exito').modal('show'); 
             console.log(response);
             location.reload(); 
			},
			error: function(response)
			{
             $('#error').modal('show'); 
			}

		});
});

	//##################################ELIMINAR CATEGORIA##################################//
	$('#form_del_mpago').submit(function(e)
	{
		swal.fire({
					title: "Cargando...",
					text: "Por favor espere",
					imageUrl: base_url+'/assets/js/ajax.gif',
					showConfirmButton: false,
					allowOutsideClick: false
					});
		e.preventDefault();
		$.ajax({
			url  :  base_url+'/assets/ajax/ajax_tpago.php',
			type : "POST",
			async: true,
			data : $('#form_del_mpago').serialize(),

			success: function(response)
			{
			 
             $('#exito').modal('show'); 
             console.log(response);
             location.reload(); 
			},
			error: function(response)
			{
             $('#error').modal('show'); 
			}

		});
	});
});// en ready


