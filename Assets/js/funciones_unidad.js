$(document).ready(function(){
//##################################CREAR CLIENTE##################################//
	$('#form_add_unidad').submit(function(e)
	{
		$('.ajaxgif').removeClass('hide');
		e.preventDefault();
		$.ajax({
			url  :  base_url+'/assets/ajax/ajax_unidad.php',
			type : "POST",
			async: true,
			data : $('#form_add_unidad').serialize(),

			success: function(response)
			{
				
			$('#ModalUnidad').modal('hide');

             
             swal.fire({
        	 type: "success",
        	 title: "Registro agregado con exito..!",
        	 showConfirmButton: true,
         	 confirmButtonText: "Cerrar"

		     });
            location.reload(); 
            
			},
			error: function(response)
			{
             swal.fire({
        	 type: "error",
        	 title: "No se pudo agregar el registro",
        	 showConfirmButton: true,
        	 confirmButtonText: "Cerrar"

             })
			}

		});
	});
//##################################EDITAR CLIENTE##################################//
	$('#form_edi_unidad').submit(function(e)
	{
		$('.ajaxgif').removeClass('hide');
		e.preventDefault();
		$.ajax({
			url  :  base_url+'/assets/ajax/ajax_unidad.php',
			type : "POST",
			async: true,
			data : $('#form_edi_unidad').serialize(),

			success: function(response)
			{
				
			$('#ModalUnidadEdit').modal('hide');

             location.reload(); 
             swal.fire({
        	 type: "success",
        	 title: "Registro Actualizado con exito..!",
        	 showConfirmButton: true,
         	 confirmButtonText: "Cerrar"

		     });

            
			},
			error: function(response)
			{
             swal.fire({
        	 type: "error Actualizar el registro",
        	 showConfirmButton: true,
        	 confirmButtonText: "Cerrar"

             })
			}

		});
	});

	//##################################ELIMINAR CATEGORIA##################################//
	$('#form_del_unidad').submit(function(e)
	{
		$('.ajaxgif').removeClass('hide');
		e.preventDefault();
		$.ajax({
			url  :  base_url+'/assets/ajax/ajax_unidad.php',
			type : "POST",
			async: true,
			data : $('#form_del_unidad').serialize(),

			success: function(response)
			{
				
			$('#ModalUnidadDelete').modal('hide');

             location.reload(); 
             swal.fire({
        	 type: "success",
        	 title: "Registro Actualizado con exito..!",
        	 showConfirmButton: true,
         	 confirmButtonText: "Cerrar"

		     });

            
			},
			error: function(response)
			{
             swal.fire({
        	 type: "error Actualizar el registro",
        	 showConfirmButton: true,
        	 confirmButtonText: "Cerrar"

             })
			}

		});
	});
});