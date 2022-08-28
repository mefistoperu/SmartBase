$(document).ready(function()
{
			//################################## editar datos de empresa##################################//
	$('#datos_empresa').submit(function(e)
	{
		$('#cargando').modal('show');
		
		e.preventDefault();
		
		$.ajax({
			url  :  base_url+'/Assets/ajax/ajax.php',
			type : "POST",
			async: true,
			//data : $('#datos_empresa').serialize(),
			data: new FormData(this),
			contentType: false,
			cache: false,
			processData: false,

			success: function(response)
			{ 
			 $('#cargando').modal('hide');
			 $('#exito').modal('show'); 		            
             console.log(response);
             location.reload(); 

			},
			error: function(response)
			{
			  $('#cargando').modal('hide');
              $('#error').modal('show');
              location.reload(); 
			}

		});
	});
			//################################## editar almacen##################################//
	$('#form_delete_almacen').submit(function(e)
	{
		$('#cargando').modal('show');
		
		e.preventDefault();
		
		$.ajax({
			url  :  base_url+'/Assets/ajax/ajax.php',
			type : "POST",
			async: true,
			data : $('#form_delete_almacen').serialize(),

			success: function(response)
			{ 
			 $('#cargando').modal('hide');
			 $('#exito').modal('show'); 		            
             console.log(response);
             location.reload(); 
			},
			error: function(response)
			{
			  $('#cargando').modal('hide');
              $('#error').modal('show');
              location.reload(); 
			}

		});
	});
		//################################## editar almacen##################################//
	$('#form_almacen_editar').submit(function(e)
	{
		$('#cargando').modal('show');
		
		e.preventDefault();
		
		$.ajax({
			url  :  base_url+'/Assets/ajax/ajax.php',
			type : "POST",
			async: true,
			data : $('#form_almacen_editar').serialize(),

			success: function(response)
			{ 
			 $('#cargando').modal('hide');
			 $('#exito').modal('show'); 		            
             console.log(response);
             location.reload(); 
			},
			error: function(response)
			{
			  $('#cargando').modal('hide');
              $('#error').modal('show');
              location.reload(); 
			}

		});
	});
	//################################## nuevo almacen##################################//
	$('#form_almacen').submit(function(e)
	{
		$('#cargando').modal('show');
		
		e.preventDefault();
		
		$.ajax({
			url  :  base_url+'/Assets/ajax/ajax.php',
			type : "POST",
			async: true,
			data : $('#form_almacen').serialize(),

			success: function(response)
			{ 
			 $('#cargando').modal('hide');
			 $('#exito').modal('show'); 		            
             console.log(response);
             location.reload(); 
			},
			error: function(response)
			{
			  $('#cargando').modal('hide');
              $('#error').modal('show');
              location.reload(); 
			}

		});
	});
	//################################## nuevo serie  - usuario##################################//
	$('#form_serie_usuario').submit(function(e)
	{
		$('#cargando').modal('show');
		
		e.preventDefault();
		
		$.ajax({
			url  :  base_url+'/Assets/ajax/ajax.php',
			type : "POST",
			async: true,
			data : $('#form_serie_usuario').serialize(),

			success: function(response)
			{ 
			 $('#cargando').modal('hide');
			 $('#exito').modal('show'); 		            
             console.log(response);
             location.reload(); 
			},
			error: function(response)
			{
			  $('#cargando').modal('hide');
              $('#error').modal('show');
              location.reload(); 
			}

		});
	});
	//################################## delete serie  - usuario##################################//
	$('#form_series_usuario_delete').submit(function(e)
	{
		$('#cargando').modal('show');
		
		e.preventDefault();
		$.ajax({
			url  :  base_url+'/Assets/ajax/ajax.php',
			type : "POST",
			async: true,
			data : $('#form_series_usuario_delete').serialize(),

			success: function(response)
			{ 
			 $('#cargando').modal('hide');
			 $('#exito').modal('show'); 		            
             console.log(response);
             location.reload(); 
			},
			error: function(response)
			{
			  $('#cargando').modal('hide');
              $('#error').modal('show');
              location.reload(); 
			}

		});
	});
	//################################## delete serie ##################################//
	$('#form_series_delete').submit(function(e)
	{
		$('#cargando').modal('show');
		e.preventDefault();
		$.ajax({
			url  :  base_url+'/Assets/ajax/ajax.php',
			type : "POST",
			async: true,
			data : $('#form_series_delete').serialize(),

			success: function(response)
			{ 
			 $('#cargando').modal('hide');
			 $('#exito').modal('show'); 		            
             console.log(response);
             location.reload(); 
			},
			error: function(response)
			{
			  $('#cargando').modal('hide');
              $('#error').modal('show');
              location.reload(); 
			}

		});
	});
	//################################## editar serie ##################################//
	$('#form_series_update').submit(function(e)
	{
		$('#cargando').modal('show');
		e.preventDefault();
		$.ajax({
			url  :  base_url+'/Assets/ajax/ajax.php',
			type : "POST",
			async: true,
			data : $('#form_series_update').serialize(),

			success: function(response)
			{ 
			 $('#cargando').modal('hide');
			 $('#exito').modal('show'); 		            
             console.log(response);
             location.reload(); 
			},
			error: function(response)
			{
			  $('#cargando').modal('hide');
              $('#error').modal('show');
              location.reload(); 
			}

		});
	});
	//################################## nuevo serie ##################################//
	$('#form_series').submit(function(e)
	{
		$('#cargando').modal('show');
		e.preventDefault();
		$.ajax({
			url  :  base_url+'/Assets/ajax/ajax.php',
			type : "POST",
			async: true,
			data : $('#form_series').serialize(),

			success: function(response)
			{ 
			 $('#cargando').modal('hide');
			 $('#exito').modal('show'); 		            
             console.log(response);
             location.reload(); 
			},
			error: function(response)
			{
			  $('#cargando').modal('hide');
              $('#error').modal('show');
              location.reload(); 
			}

		});
	});
	//################################## editar usuario ##################################//
	$('#update_usuario').submit(function(e)
	{
		$('#cargando').modal('show');
		e.preventDefault();
		$.ajax({
			url  :  base_url+'/Assets/ajax/ajax.php',
			type : "POST",
			async: true,
			data : $('#update_usuario').serialize(),

			success: function(response)
			{ 
			 $('#cargando').modal('hide');
			 $('#exito').modal('show'); 		            
             console.log(response);
             location.reload(); 
			},
			error: function(response)
			{
			  $('#cargando').modal('hide');
              $('#error').modal('show');
              location.reload(); 
			}

		});
	});
	//################################## delete usuario ##################################//
	$('#delete_usuario').submit(function(e)
	{
		$('#cargando').modal('show');
		e.preventDefault();
		$.ajax({
			url  :  base_url+'/Assets/ajax/ajax.php',
			type : "POST",
			async: true,
			data : $('#delete_usuario').serialize(),

			success: function(response)
			{ 
			 $('#cargando').modal('hide');
			 $('#exito').modal('show'); 		            
             console.log(response);
             location.reload(); 
			},
			error: function(response)
			{
			  $('#cargando').modal('hide');
              $('#error').modal('show');
              location.reload(); 
			}

		});
	});

	//################################## nuevo usuario ##################################//
	$('#form_usuario').submit(function(e)
	{
		$('#cargando').modal('show');
		e.preventDefault();
		$.ajax({
			url  :  base_url+'/Assets/ajax/ajax.php',
			type : "POST",
			async: true,
			data : $('#form_usuario').serialize(),

			success: function(response)
			{ 
			 $('#cargando').modal('hide');
			 $('#exito').modal('show'); 		            
             console.log(response);
             location.reload(); 
			},
			error: function(response)
			{
			  $('#cargando').modal('hide');
              $('#error').modal('show');
              location.reload(); 
			}

		});
	});
});/*fin ready*/
/****************************funciones*************************************/
function delusuario()
{
	$('#deleteUsuario').modal('show');

	var arr = [];

	$('#datatable-responsive > tbody > tr').click(function()
		{
			arr = $(this).find('td').map(function()
				{
					return this.innerHTML;
				}).get();
			$('#delete_id').val(arr[1]);
			
		});
}

function ediusuario()
{
	$('#updateUsuario').modal('show');

	var arr = [];

	$('#datatable-responsive > tbody > tr').click(function()
		{
			arr = $(this).find('td').map(function()
				{
					return this.innerHTML;
				}).get();
			$('#id_update').val(arr[1]);
			$('#nombre_update').val(arr[2]);
			$('#apellido_update').val(arr[3]);
			$('#user_update').val(arr[4]);
			
		});
}

function ediserie()
{
	$('#updateSerie').modal('show');

	var arr = [];

	$('#datatable-responsive > tbody > tr').click(function()
		{
			arr = $(this).find('td').map(function()
				{
					return this.innerHTML;
				}).get();
			$('#update_id_serie').val(arr[1]);
			$('#update_serie').val(arr[4]);
			$('#update_correlativo').val(arr[5]);
			
		});
}


function delserie()
{
	$('#deleteSerie').modal('show');

	var arr = [];

	$('#datatable-responsive > tbody > tr').click(function()
		{
			arr = $(this).find('td').map(function()
				{
					return this.innerHTML;
				}).get();
			$('#delete_id_serie').val(arr[1]);
			
			
		});
}

function delserieusuario()
{
	$('#deleteSerieUsuario').modal('show');

	var arr = [];

	$('#datatable-responsive > tbody > tr').click(function()
		{
			arr = $(this).find('td').map(function()
				{
					return this.innerHTML;
				}).get();
			$('#delete_id_serie_usuario').val(arr[1]);
			
			
		});
}

/////////////////////almacenes


function edialmacen()
{
	$('#editarAlmacen').modal('show');

	var arr = [];

	$('#datatable-responsive > tbody > tr').click(function()
		{
			arr = $(this).find('td').map(function()
				{
					return this.innerHTML;
				}).get();
			$('#update_id_almacen').val(arr[1]);
			$('#update_nombre').val(arr[2]);
			$('#update_direccion').val(arr[3]);
			
		});
}


function delalmacen()
{
	$('#deleteAlmacen').modal('show');

	var arr = [];

	$('#datatable-responsive > tbody > tr').click(function()
		{
			arr = $(this).find('td').map(function()
				{
					return this.innerHTML;
				}).get();
			$('#delete_id_almacen').val(arr[1]);
			
			
		});
}

