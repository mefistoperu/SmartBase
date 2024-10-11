$(document).ready(function(){
//##################################CREAR CLIENTE##################################//
	$('#form_destino').submit(function(e)
	{
		$('#cargando').modal('show');
		e.preventDefault();
		$.ajax({
			url  :  base_url+'/assets/ajax/ajax_destino.php',
			type : "POST",
			async: true,
			data : $('#form_destino').serialize(),

			success: function(response)
			{
			 Swal.fire({
				  icon: 'success',
				  title: 'Procesado Correctamente...',
				  text: 'Exito...!',
				  
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
	$('#form_delete_destino').submit(function(e)
	{
		$('#cargando').modal('show');
		e.preventDefault();
		$.ajax({
			url  :  base_url+'/assets/ajax/ajax_destino.php',
			type : "POST",
			async: true,
			data : $('#form_delete_destino').serialize(),

			success: function(response)
			{
			 Swal.fire({
				  icon: 'success',
				  title: 'Procesado Correctamente...',
				  text: 'Exito...!',
				  
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
});