
$(document).ready(function(){
	$(document).on('click', '.delete', function(){
		var id=$(this).val();
		
	
		$('#deleteReceta').modal('show');
		$('#delete_id_receta').val(id);
		
	});
});


