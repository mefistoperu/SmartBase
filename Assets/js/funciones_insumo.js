$(document).ready(function(){
//##################################CREAR CLIENTE##################################//
	$('#form_insumo').submit(function(e)
	{
		$('#cargando').modal('show');
		e.preventDefault();
		$.ajax({
			url  :  base_url+'/assets/ajax/ajax_insumo.php',
			type : "POST",
			async: true,
			data : $('#form_insumo').serialize(),

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
//##################################EDITAR CLIENTE##################################//
	$('#form_insumo_editar').submit(function(e)
	{
		$('#cargando').modal('show');
		e.preventDefault();
		$.ajax({
			url  :  base_url+'/assets/ajax/ajax_insumo.php',
			type : "POST",
			async: true,
			data : $('#form_insumo_editar').serialize(),

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

	//##################################ELIMINAR CATEGORIA##################################//
	$('#form_delete_insumo').submit(function(e)
	{
		$('#cargando').modal('show');
		e.preventDefault();
		$.ajax({
			url  :  base_url+'/assets/ajax/ajax_insumo.php',
			type : "POST",
			async: true,
			data : $('#form_delete_insumo').serialize(),

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