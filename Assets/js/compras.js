function modalDt()

{
	$('#exampleModal').modal('show');

	var arr = [];

	$('#datatable-ventas > tbody > tr').click(function()
		{
			arr = $(this).find('td').map(function()
				{
					return this.innerHTML;
				}).get();
			
            $('#id_ven').val(arr[0]);
			var id = arr[0];
			var action = 'buscar_dt';
              $.ajax({
	  	url: base_url+'/assets/ajax/ajax_compra.php',
	  	type: "POST",
	  	async: true,
	  	data: {action:action,id:id},

	  	success: function(response)
	  	{
	  		var data = $.parseJSON(response);
	  		$('#num_det').val(data.num_det);
	  		$('#fec_det').val(data.fecha_det);
	  		$('#id_com').val(data.idventa);	
	  		 $('#id_ven').val(arr[0]);
	  	    //$('#id_ven').val(data.id);		
	  		 console.log(response);
	  		 //location.reload(); 
	  	},
	  	error: function(response)
	  	{
	  		console.log(response);
	  	}
	  });

		});
	
}
