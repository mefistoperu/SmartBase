function openModalEdit()
{

	$('#ModalTpagoEdit').modal('show');

	var arr = [];

	$('#dataTable-1 > tbody > tr').click(function()
		{
			arr = $(this).find('td').map(function()
				{
					return this.innerHTML;
				}).get();

			var id     = arr[1];
			var action = 'buscar_tpago';
			$.ajax({
	  	url: base_url+'/assets/ajax/ajax_tpago.php',
	  	type: "POST",
	  	async: true,
	  	data: {action:action,id:id},

	  	success: function(response)
	  	{
	  		console.log(response);
	  		var data = $.parseJSON(response);
	  		$('#update_nombre').val(data.nombre);
	  		$('#update_cuenta').val(data.cuenta);
	  		$('#update_tpago').val(data.mpago).attr('selected', 'selected');
	  		
	  		$('#update_id').val(data.id);		
	  		 
	  		 //location.reload(); 
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
	$('#ModalTpagoDelete').modal('show');

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
