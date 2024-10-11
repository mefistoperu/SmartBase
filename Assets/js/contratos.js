function openModalEdit1()
{
	$('#ModalCategoriaEdit').modal('show');

	var arr = [];

	$('#dataTable-1 > tbody > tr').click(function()
		{
			arr = $(this).find('td').map(function()
				{
					return this.innerHTML;
				}).get();
				
            var id = arr[1];
            
			
			var action = 'buscar_contratos';
              $.ajax({
	  	url: base_url+'/assets/ajax/ajax_contratos.php',
	  	type: "POST",
	  	async: true,
	  	data: {action:action,id:id},

	  	success: function(response)
	  	{
	  	    console.log(response);
	  	    var data = $.parseJSON(response);
	  		$('#update_id').val(data.id_contrato);
	  		$('#update_cliente').val(data.id_cliente).attr('selected', 'selected');
			$('#update_fcontrato').val(data.fecha_contrato);
			$('#update_finialquiler').val(data.fecha_inicio_alquiler);
			$('#update_fvencimiento').val(data.fecha_vencimiento);
			$('#update_moneda').val(data.moneda_alquiler);
			$('#update_tcambio').val(data.tipo_cambio);
			$('#update_importesoles').val(data.importe_alquiler_soles);
			$('#update_importedolar').val(data.importe_alquiler_dolares);
			$('#update_update_obs').val(data.observaciones);
			
	  	    
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

	$('#dataTable > tbody > tr').click(function()
		{
			arr = $(this).find('td').map(function()
				{
					return this.innerHTML;
				}).get();
			$('#delete_id').val(arr[1]);
			
		});
}
