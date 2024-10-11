$(function()
	
{
	$('#botonsire').on('click',function(e)
		{
			swal.fire({
					title: "Cargando...",
					text: "Por favor espere",
					imageUrl: base_url+'/assets/js/ajax.gif',
					showConfirmButton: false,
					allowOutsideClick: false
					});
			e.preventDefault();
			var periodo = $('#periodo').val();
			var anio = $('#anio').val();
			var empresa = $('#empresa').val();
			var action = 'sunat_sire';
			var url = 'assets/ajax/ajax_sire.php';

			$.ajax(
				{
					type:'POST',
					url:url,
					data:'periodo='+periodo+'&anio='+anio+'&empresa='+empresa+'&action='+action,

					success: function(datos_sire)
					{
						swal.fire({
					title: "Exito...",
					text: "Procesado correctamente",
					showConfirmButton: true,
					allowOutsideClick: false
					});
						/*if(datos_sire!='')
						{
							var datos = eval(datos_sire);
						}*/
                    console.log(datos_sire);
					},
					error: function(datos_sire)
					{

					}

				});
			return false;

			
		});
});
