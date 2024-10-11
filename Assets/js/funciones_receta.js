$(document).ready(function(){
//##################################CREAR CLIENTE##################################//
	$('#form_receta').submit(function(e)
	{
		$('#cargando').modal('show');
		e.preventDefault();
		$.ajax({
			url  :  base_url+'/assets/ajax/ajax_receta.php',
			type : "POST",
			async: true,
			data : $('#form_receta').serialize(),

			success: function(response)
			{
			 Swal.fire({
				  icon: 'success',
				  title: 'Procesado Correctament...',
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
	$('#form_delete_receta').submit(function(e)
	{
		$('#cargando').modal('show');
		e.preventDefault();
		$.ajax({
			url  :  base_url+'/assets/ajax/ajax_receta.php',
			type : "POST",
			async: true,
			data : $('#form_delete_receta').serialize(),

			success: function(response)
			{
			 $('#cargando').modal('hide');
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
});