function openModalDel()
{
	$('#ModalVentaDelete').modal('show');

	var arr = [];

	$('#tblistado > tbody > tr').click(function()
		{
			arr = $(this).find('td').map(function()
				{
					return this.innerHTML;
				}).get();
			$('#delete_id').val(arr[0]);

		});
}


function openModalOk()
{
	$('#ModalVentaAprobada').modal('show');

	var arr = [];

	$('#tblistado > tbody > tr').click(function()
		{
			arr = $(this).find('td').map(function()
				{
					return this.innerHTML;
				}).get();
			$('#aprobar_id').val(arr[0]);

		});
}


function openModalEnvia()
{
	$('#ModalVentaEnviada').modal('show');

	var arr = [];

	$('#tblistado > tbody > tr').click(function()
		{
			arr = $(this).find('td').map(function()
				{
					return this.innerHTML;
				}).get();
			$('#enviar_id').val(arr[0]);

		});
}



