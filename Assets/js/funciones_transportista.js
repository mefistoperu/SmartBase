$(document).ready(function(){
//##################################CREAR CLIENTE##################################//
	$('#form_add_transportista').submit(function(e)
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
			url  :  base_url+'/assets/ajax/ajax_transportista.php',
			type : "POST",
			async: true,
			data : $('#form_add_transportista').serialize(),

			success: function(response)
			{
			 Swal.fire({
				  icon: 'success',
				  title: 'Procesado con exito...',
				  text: 'ok...!',
				  
				}); 
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
	$('#form_edi_transportista').submit(function(e)
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
			url  :  base_url+'/assets/ajax/ajax_transportista.php',
			type : "POST",
			async: true,
			data : $('#form_edi_transportista').serialize(),

			success: function(response)
			{
			 Swal.fire({
				  icon: 'success',
				  title: 'Procesado con exito...',
				  text: 'ok...!',
				  
				}); 
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
	$('#form_del_transportista').submit(function(e)
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
			url  :  base_url+'/assets/ajax/ajax_transportista.php',
			type : "POST",
			async: true,
			data : $('#form_del_transportista').serialize(),

			success: function(response)
			{
			 Swal.fire({
				  icon: 'success',
				  title: 'Procesado con exito...',
				  text: 'ok...!',
				  
				}); 
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

