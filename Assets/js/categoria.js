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
			$('#update_nombre').val(arr[2]);
			$('#update_cuenta_compra').val(arr[3]);
			$('#update_cuenta_venta').val(arr[4]);
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
