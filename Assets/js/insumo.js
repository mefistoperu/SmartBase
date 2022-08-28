
$(document).ready(function(){
	$(document).on('click', '.edit', function(){
		var id=$(this).val();
		var nombre=$('#nombre'+id).text();
		var idmarca=$('#idmarca'+id).text();
		var unidad=$('#unidad'+id).text();
		var precioc=$('#precio_compra'+id).text();
		var preciov=$('#stock'+id).text();
	
		$('#edit').modal('show');
		$('#update_id_insumo').val(id);
		$('#update_nombre').val(nombre);
		$('#update_precio_compra').val(precioc);
		$('#update_stock').val(preciov);
		$('#update_marca').val(idmarca).attr('selected', 'selected');
		$('#update_unidad').val(unidad).attr('selected', 'selected');
	});

	$(document).on('click', '.delete', function(){
		var id=$(this).val();
		
	
		$('#deleteInsumo').modal('show');
		$('#delete_id_insumo').val(id);
		
	});
});



function openModalDel()
{
	$('#ModalCategoriaDlete').modal('show');

	var arr = [];

	$('#datatable-responsive > tbody > tr').click(function()
		{
			arr = $(this).find('td').map(function()
				{
					return this.innerHTML;
				}).get();
			$('#delete_id').val(arr[1]);
			
		});
}
