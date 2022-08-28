$(document).ready(function(){
//##################################CREAR CLIENTE##################################//
	$('#form_add_marca').submit(function(e)
	{
		$('#cargando').modal('show');
		
		e.preventDefault();
		$.ajax({
			url  :  base_url+'/Assets/ajax/ajax_marca.php',
			type : "POST",
			async: true,
			data : $('#form_add_marca').serialize(),

			success: function(response)
			{
				
             $('#cargando').modal('hide');
             $('#exito').modal('show'); 
             location.reload(); 
            
			},
			error: function(response)
			{
			 $('#error').modal('show'); 
             
			}

		});
	});
//##################################EDITAR CLIENTE##################################//
	$('#form_edi_marca').submit(function(e)
	{
		$('#cargando').modal('show');
		e.preventDefault();
		$.ajax({
			url  :  base_url+'/Assets/ajax/ajax_marca.php',
			type : "POST",
			async: true,
			data : $('#form_edi_marca').serialize(),

			success: function(response)
			{
				
             $('#cargando').modal('hide');
             $('#exito').modal('show'); 
             location.reload(); 
            
			},
			error: function(response)
			{
			 $('#error').modal('show'); 
             
			}

		});
	});

	//##################################ELIMINAR CATEGORIA##################################//
	$('#form_del_marca').submit(function(e)
	{
		$('#cargando').modal('show');
		e.preventDefault();
		$.ajax({
			url  :  base_url+'/Assets/ajax/ajax_marca.php',
			type : "POST",
			async: true,
			data : $('#form_del_marca').serialize(),

			success: function(response)
			{
				
             $('#cargando').modal('hide');
             $('#exito').modal('show'); 
             location.reload(); 
            
			},
			error: function(response)
			{
			 $('#error').modal('show'); 
             
			}

		});
	});
});