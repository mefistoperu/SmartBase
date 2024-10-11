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

			var tdoc = arr[4];
			$('#update_id').val(arr[1]);
			$('#update_nombre').val(arr[2]);
			$('#update_apellido').val(arr[3]);
			//$('#update_tdoc').val(arr[4]);			
			$('#update_tdoc').val(tdoc).attr('selected', 'selected');
			$('#update_ndoc').val(arr[5]);
			$('#update_direccion').val(arr[6]);
			$('#update_telefono').val(arr[7]);
			$('#update_licencia').val(arr[8]);
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
