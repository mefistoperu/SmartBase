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

			
			$('#update_id').val(arr[1]);
			$('#update_ruc').val(arr[2]);
			$('#update_razon').val(arr[3]);
			$('#update_direccion').val(arr[4]);
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
