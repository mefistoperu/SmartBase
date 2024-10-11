function openModalEdit()
{

	$('#EditGarantia').modal('show');

	var arr = [];

	$('#dataTable-1 > tbody > tr').click(function()
		{
			arr = $(this).find('td').map(function()
				{
					return this.innerHTML;
				}).get();
			$('#update_id').val(arr[1]);
			$('#update_soles').val(arr[2]);
			$('#update_dolares').val(arr[3]);
			$('#update_fecha').val(arr[4]);
			$('#update_meses').val(arr[5]);
		});
}



function openModalDel()
{
	$('#DeleteGarantia').modal('show');

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
