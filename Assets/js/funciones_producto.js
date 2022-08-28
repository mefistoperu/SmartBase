$(document).ready(function(){
//##################################CREAR CLIENTE##################################//
	$('#form_producto').submit(function(e)
	{
		$('#cargando').modal('show');
		e.preventDefault();
		$.ajax({
			url  :  base_url+'/Assets/ajax/ajax_producto.php',
			type : "POST",
			async: true,
			data : $('#form_producto').serialize(),

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
	$('#form_producto_edit').submit(function(e)
	{
		$('#cargando').modal('show');
		e.preventDefault();
		$.ajax({
			url  :  base_url+'/Assets/ajax/ajax_producto.php',
			type : "POST",
			async: true,
			data : $('#form_producto_edit').serialize(),

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
	$('#form_delete_producto').submit(function(e)
	{
		$('#cargando').modal('show');
		e.preventDefault();
		$.ajax({
			url  :  base_url+'/Assets/ajax/ajax_producto.php',
			type : "POST",
			async: true,
			data : $('#form_delete_producto').serialize(),

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