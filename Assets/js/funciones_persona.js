$(document).ready(function(){
//##################################CREAR CLIENTE##################################//
	$('#form_add_cliente').submit(function(e)
	{
		$('#cargando').modal('show');
		e.preventDefault();
		$.ajax({
			url  :  base_url+'/Assets/ajax/ajax_persona.php',
			type : "POST",
			async: true,
			data : $('#form_add_cliente').serialize(),

			success: function(response)
			{

			 if(response == 'existe')
			 {
			 	$('#cargando').modal('hide');
                $('#error').modal('show'); 
                alert(response);
                console.log(response);
			 }
			 else
			 {
			 	$('#cargando').modal('hide');
			    $('#exito').modal('show'); 
			    $('#ModalClientes').modal('hide');
                      
            location.reload(); 
            console.log(response);
			 }
			 
            
			},
			error: function(response)
			{
             $('#cargando').modal('hide');
			}

		});
	});
//##################################EDITAR CLIENTE##################################//
	$('#form_edi_cliente').submit(function(e)
	{
		$('#cargando').modal('show');
		e.preventDefault();
		$.ajax({
			url  :  base_url+'/Assets/ajax/ajax_persona.php',
			type : "POST",
			async: true,
			data : $('#form_edi_cliente').serialize(),

			success: function(response)
			{
			    $('#cargando').modal('hide');
                $('#exito').modal('show'); 
                console.log(response);

            
			},
			error: function(response)
			{
              $('#error').modal('show'); 
			}

		});
	});
});