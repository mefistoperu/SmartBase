$(document).ready(function(){
    

//################CARGAR DESDE EXCEL PRODUCTOS##################################//
	$('#cargarConceptoGasto').submit(function(e)
	{
		Swal.fire({
				  icon: 'success',
				  title: 'Procesando...',
				  text: 'Espere un momento...!',
				  
				});
		
		e.preventDefault();
		$.ajax({
			url  :  base_url+'/assets/ajax/ajax_concepto_gasto.php',
			type : "POST",
			async: true,
			data: new FormData(this),
			contentType: false,
			cache: false,
			processData: false,

			success: function(response)
			{
			 Swal.fire({
				  icon: 'success',
				  title: response,
				  text: 'ok...!',
				  
				});
             console.log(response);
             //location.reload(); 
			},
			error: function(response)
			{
             $('#error').modal('show'); 
             console.log(response);
			}

		});
	});    
    
    
//##################################CREAR CLIENTE##################################//
	$('#addConceptoGasto').submit(function(e)
	{
		swal.fire({
					title: "Cargando...",
					text: "Por favor espere",
					imageUrl: base_url+'/assets/js/ajax.gif',
					showConfirmButton: false,
					allowOutsideClick: false
					});
		e.preventDefault();
		$.ajax({
			url  :  base_url+'/assets/ajax/ajax_concepto_gasto.php',
			type : "POST",
			async: true,
			data : $('#addConceptoGasto').serialize(),

			success: function(response)
			{
		
             Swal.fire({
                    title: "Procesado..!",
                    text: "Guardado con exito...!",
                    icon: "success"
                    });
            console.log(response);
             //location.reload(); 
			},
			error: function(response)
			{
             Swal.fire({
                  icon: "error",
                  title: "Oops...",
                  text: "No se pudo guardar",
                  footer: '<a href="#">Why do I have this issue?</a>'
                });
			}

		});
	});
	
//##################################EDITAR CLIENTE##################################//
	$('#ediConceptoGasto').submit(function(e)
	{
			swal.fire({
					title: "Cargando...",
					text: "Por favor espere",
					imageUrl: base_url+'/assets/js/ajax.gif',
					showConfirmButton: false,
					allowOutsideClick: false
					});
		e.preventDefault();
		$.ajax({
			url  :  base_url+'/assets/ajax/ajax_concepto_gasto.php',
			type : "POST",
			async: true,
			data : $('#ediConceptoGasto').serialize(),

			success: function(response)
			{
					swal.fire({
        	 icon: "success",
        	 title: "Registro agregado con exito..!",
        	 showConfirmButton: true,
         	 confirmButtonText: "Cerrar"

		     }); 
             console.log(response);
             location.reload(); 
			},
			error: function(response)
			{
                         swal.fire({
        	 type: "error",
        	 title: "No se pudo agregar el registro"+ response,
        	 showConfirmButton: true,
        	 confirmButtonText: "Cerrar"

             })
			}

		});
	});

	//##################################ELIMINAR CONCEPTO GASTO##################################//
	$('#delConceptoGasto').submit(function(e)
	{
		swal.fire({
					title: "Cargando...",
					text: "Por favor espere",
					imageUrl: base_url+'/assets/js/ajax.gif',
					showConfirmButton: false,
					allowOutsideClick: false
					});
		e.preventDefault();
		$.ajax({
			url  :  base_url+'/assets/ajax/ajax_concepto_gasto.php',
			type : "POST",
			async: true,
			data : $('#delConceptoGasto').serialize(),

			success: function(response)
			{
			
            swal.fire({
        	 icon: "success",
        	 title: "Registro agregado con exito..!",
        	 showConfirmButton: true,
         	 confirmButtonText: "Cerrar"

		     });
		     console.log(response);
            location.reload(); 
			},
			error: function(response)
			{
             swal.fire({
        	 type: "error",
        	 title: "No se pudo agregar el registro"+response,
        	 showConfirmButton: true,
        	 confirmButtonText: "Cerrar"

             })
			}

		});
	});
});// en ready





function openModalEditGasto()
{
	$('#ModalConceptoGastoEdit').modal('show');

	var arr = [];

	$('#dataTable-1 > tbody > tr').click(function()
		{
			arr = $(this).find('td').map(function()
				{
					return this.innerHTML;
				}).get();
			$('#update_id').val(arr[1]);
			$('#update_descripcion').val(arr[2]);
			$('#update_cuenta').val(arr[3]);
			
		});
}

function openModalDelGasto()
{
	$('#ModalConceptoGastoDel').modal('show');

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
