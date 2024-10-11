function openModalEdit()
{
	$('#ModalClientesEdit').modal('show');

	var arr = [];

	$('#dataTable-2 > tbody > tr').click(function()
		{
			arr = $(this).find('td').map(function()
				{
					return this.innerHTML;
				}).get();

			

			$('#update_id').val(arr[1]);
			$('#update_doc').val(arr[4]);
			$('#update_razon').val(arr[2]);
			$('#update_direccion').val(arr[5]);
			$('#update_departamento').val(arr[6]);
            $('#update_provincia').val(arr[7]);
            $('#update_distrito').val(arr[8]);
			$('#update_correo').val(arr[9]);
		});
}


function openModalEdit1()
{
	$('#ModalClientesEdit').modal('show');

	var arr = [];

	$('#dataTable-2 > tbody > tr').click(function()
		{
			arr = $(this).find('td').map(function()
				{
					return this.innerHTML;
				}).get();

			var id      = arr[1];
			var action  = 'busca_cli';
			
			$.ajax({
	  	url: base_url+'/assets/ajax/ajax_persona.php',
	  	type: "POST",
	  	async: true,
	  	data: {action:action,id:id},

	  	success: function(response)
	  	{
	  		console.log(response);
	  		var data = $.parseJSON(response);
	  		$('#update_id').val(data.id_empresa);
			$('#update_direccion').val(data.direccion);
			$('#update_departamento').val(data.departamento);
			$('#update_provincia').val(data.provincia);
			$('#update_distrito').val(data.distrito);
			$('#update_correo').val(data.correo);
			$('#update_fechaa').val(data.fecha_inicio);
			$('#update_fechav').val(data.fecha_vencimiento);

			

             	
	  		 
	  		 //location.reload(); 
	  	},
	  	error: function(response)
	  	{
	  		console.log(response);
	  	}
	  	});
	});
}


