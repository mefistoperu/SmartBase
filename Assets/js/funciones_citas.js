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
	$('#form_nueva_cita').submit(function(e)
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
			url  :  base_url+'/assets/ajax/ajax_citas.php',
			type : "POST",
			async: true,
			data : $('#form_nueva_cita').serialize(),

			success: function(response)
			{
			
			          
             swal.fire({
        	 icon: "success",
        	 title: "Registro Actualizado con exito..!",
        	 showConfirmButton: true,
         	 confirmButtonText: "Cerrar"

		     });
		     console.log(response);

             //location.reload(); 
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