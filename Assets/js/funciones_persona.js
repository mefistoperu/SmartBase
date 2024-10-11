$(document).ready(function(){
//##################################CREAR CLIENTE##################################//
	$('#form_add_cliente').submit(function(e)
	{
		$('#cargando').modal('show');
		e.preventDefault();
		$.ajax({
			url  :  base_url+'/assets/ajax/ajax_persona.php',
			type : "POST",
			async: true,
			data : $('#form_add_cliente').serialize(),

			success: function(response)
			{

			 if(response == 'existe')
			 {
			 	Swal.fire({
				  icon: 'success',
				  title: 'Procesando contribuyente...',
				  text: response,
				  
				});
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
             console.log(response);
			}

		});
	});
//##################################EDITAR CLIENTE##################################//

	$('#form_edi_cliente').submit(function(e)
	{
		Swal.fire({
				  icon: 'success',
				  title: 'Procesando...',
				  text: 'Espere un momento...!',
				  
				});
		e.preventDefault();
		$.ajax({
			url  :  base_url+'/assets/ajax/ajax_persona.php',
			type : "POST",
			async: true,
			data : $('#form_edi_cliente').serialize(),

			success: function(response)
			{
			    Swal.fire({
				  icon: 'success',
				  title: 'Procesando...',
				  text: response,
				  
				});
                location.reload(); 
                console.log(response);

            
			},
			error: function(response)
			{
              $('#error').modal('show'); 
			}

		});
	});




//##################################CREAR EMPRESA NUEVA##################################//
	$('#form_add_cliente_empresa').submit(function(e)
	{
		Swal.fire({
				  icon: 'success',
				  title: 'Procesando...',
				  text: 'Espere un momento...!',
				  
				});
		e.preventDefault();
		$.ajax({
			url  :  base_url+'/assets/ajax/ajax_persona.php',
			type : "POST",
			async: true,
			data : $('#form_add_cliente_empresa').serialize(),

			success: function(response)
			{
			    Swal.fire({
				  icon: 'success',
				  title: 'Procesado con exito...',
				  text: response,
				  
				});
                location.reload(); 
                console.log(response);

            
			},
			error: function(response)
			{
              $('#error').modal('show'); 
			}

		});
	});

//##################################CREAR EMPRESA NUEVA##################################//
	$('#form_edi_cliente_empresa').submit(function(e)
	{
		Swal.fire({
				  icon: 'success',
				  title: 'Procesando...',
				  text: 'Espere un momento...!',
				  
				});
		e.preventDefault();
		$.ajax({
			url  :  base_url+'/assets/ajax/ajax_persona.php',
			type : "POST",
			async: true,
			data : $('#form_edi_cliente_empresa').serialize(),

			success: function(response)
			{
			    Swal.fire({
				  icon: 'success',
				  title: 'Procesado con exito...',
				  text: 'ok...!',
				  
				});
                location.reload(); 
                console.log(response);

            
			},
			error: function(response)
			{
              $('#error').modal('show'); 
			}

		});
	});

//################CARGAR DESDE EXCEL PRODUCTOS##################################//
	$('#cargarCliente').submit(function(e)
	{
		Swal.fire({
				  icon: 'success',
				  title: 'Procesando...',
				  text: 'Espere un momento...!',
				  
				});
		
		e.preventDefault();
		$.ajax({
			url  :  base_url+'/assets/ajax/ajax_persona.php',
			type : "POST",
			async: true,
			data: new FormData(this),
			contentType: false,
			cache: false,
			processData: false,

			success: function(response)
			{
			 Swal.fire({
				  icon: 'success',
				  title: response,
				  text: 'ok...!',
				  
				});
             console.log(response);
             //location.reload(); 
			},
			error: function(response)
			{
             $('#error').modal('show'); 
             console.log(response);
			}

		});
	});
});