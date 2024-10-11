$(document).ready(function(){
//##################################CREAR CLIENTE##################################//
	$('#form_add_articulo').submit(function(e)
	{
		$('.ajaxgif').removeClass('hide');
		e.preventDefault();
		$.ajax({
			url  :  base_url+'/assets/ajax/ajax_articulo.php',
			type : "POST",
			async: true,
			data : $('#form_add_articulo').serialize(),

			success: function(response)
			{
				
		            
             swal.fire({
        	 icon: "success",
        	 title: "Registro agregado con exito..!",
        	 showConfirmButton: true,
         	 confirmButtonText: "Cerrar"

		     });
            //location.reload(); 
            window.location = 'articulos'
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
	$('#form_edi_articulo').submit(function(e)
	{
		$('.ajaxgif').removeClass('hide');
		e.preventDefault();
		$.ajax({
			url  :  base_url+'/assets/ajax/ajax_articulo.php',
			type : "POST",
			async: true,
			data : $('#form_edi_articulo').serialize(),

			success: function(response)
			{
				
		             
             swal.fire({
        	 icon: "success",
        	 title: "Registro Actualizado con exito..!",
        	 showConfirmButton: true,
         	 confirmButtonText: "Cerrar"

		     });

            window.location = 'articulos';
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
	$('#form_del_articulo').submit(function(e)
	{
		$('.ajaxgif').removeClass('hide');
		e.preventDefault();
		$.ajax({
			url  :  base_url+'/assets/ajax/ajax_articulo.php',
			type : "POST",
			async: true,
			data : $('#form_del_articulo').serialize(),

			success: function(response)
			{
				
			$('#ModalMarcaDelete').modal('hide');

             location.reload(); 
             swal.fire({
        	 icon: "success",
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