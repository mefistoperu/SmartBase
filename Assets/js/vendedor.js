function openModalEdit()
{

	$('#ModalCategoriaEdit').modal('show');

	var arr = [];

	$('#dataTable-1 > tbody > tr').click(function()
		{
			arr = $(this).find('td').map(function()
				{
					return this.innerHTML;
				}).get();
			/*$('#update_id').val(arr[1]);
			$('#update_nombrev').val(arr[2]);
			$('#update_apellidov').val(arr[3]);
			$('#update_dniv').val(arr[4]);
			$('#update_localv').val(arr[5]);*/
			

			var id = arr[1];
			var action = 'buscar_vendedorx';
        $.ajax({
				  	url: base_url+'/assets/ajax/ajax_vendedor.php',
				  	type: "POST",
				  	async: true,
				  	data: {action:action,id:id},

				  	success: function(response)
				  	{
				  		console.log(response);
				  		var data = $.parseJSON(response);
				  		$('#update_id').val(data.id);
						$('#update_nombrev').val(data.nombre);
						$('#update_apellidov').val(data.apellido);
						$('#update_dniv').val(data.dni);
						
						$('#update_localv').val(data.idlocal).attr('selected', 'selected');
			           
				  	},
				  	error: function(response)
				  	{
				  		console.log(response);
				  	}
		  	 });



			
		});
}



function openModalDel()
{
	$('#ModalCategoriaDlete').modal('show');

	var arr = [];

	$('#dataTable-1 > tbody > tr').click(function()
		{
			arr = $(this).find('td').map(function()
				{
					return this.innerHTML;
				}).get();
			$('#delete_id').val(arr[1]);
			
		});
}
