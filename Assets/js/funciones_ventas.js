$(document).ready(function(){

//enviar para resumen de boletas

  $('#btnenviaResumenCpe').click(function(e){
	$('#cargando').modal('show');
	e.preventDefault();
	 var empresa = $('#empresa').val();
	 var f_ini = $('#f_ini').val();
	 var action = 'resumen_cpe';

	  $.ajax({
	  	url: base_url+'/Assets/ajax/ajax_venta1.php',
	  	type: "POST",
	  	async: true,
	  	data: {action:action,empresa:empresa,f_ini:f_ini},

	  	success: function(response)
	  	{
	  		$('#cargando').modal('hide');
	  		$('#exito').modal('show'); 
	  		 console.log(response);
	  		  location.reload(); 
	  	},
	  	error: function(response)
	  	{
	  		console.log(response);
	  	}
	  });
});



//cargar datos detalle nota de credito

$('#btnListar').click(function(e){
	e.preventDefault();
	 var id_venta_ref = $('#id_venta_ref').val();
	 var action = 'listarDetalle';

	  $.ajax({
	  	url: base_url+'/Assets/ajax/ajax_ventas.php',
	  	type: "POST",
	  	async: true,
	  	data: {action:action,id:id_venta_ref},

	  	success: function(response)
	  	{
	  		 var info = JSON.parse(response);
	  		 //console.log(info);
	  		 $('#detalleventa').html(info.detalle);
	  		 $("#btnListar").hide();
	  		 $("#btnGuardar").show();
	  	},
	  	error: function(response)
	  	{
	  		console.log(response);
	  	}
	  });
});



//buscar proveedor / cliente

		//$('#ruc_persona').keyup(function(e){
		$(document).on('keyup', '#ruc_persona', function(e)
		{	
			e.preventDefault();
			var cl = $(this).val();
			var action = 'buscarPersona';

			$.ajax({
				url  :  base_url+'/Assets/ajax/ajax_ventas.php',
				type : 'POST',
				async: true,
				data: {action:action,cliente:cl},

							success: function(response)
								
					{
						
						if(response == 0)
						{
							
							$('#id_ruc').val('');
							$('#razon_social').val('');
							
							$('#razon_direccion').val('');
							
							
						}
						else
						{
							console.log(response);
							var data = $.parseJSON(response);
							$('#id_ruc').val(data.id_persona);
							$('#ruc_persona').val(data.num_doc);
							$('#razon_social').val(data.nombre_persona);
							$('#razon_direccion').val(data.direccion_persona);
							

						}

					},
					error: function(error)
					{

					}
			});
		});


//agregar persona

	$('#form_add_cliente').submit(function(e)
	{
		$('#cargando').modal('show');
		e.preventDefault();
		$.ajax({
			url  :  base_url+'/Assets/ajax/ajax_ventas.php',
			type : "POST",
			async: true,
			data : $('#form_add_cliente').serialize(),

			success: function(response)
			{

			 if(response == 'existe')
			 {
			 	$('#cargando').modal('hide');
                $('#error').modal('show'); 
                console.log(response);
			 }
			 else
			 {
			 	$('#cargando').modal('hide');
			    $('#exito').modal('show'); 
			    $('#ModalClientes').modal('hide');
                      
            //location.reload(); 
            //console.log(response);
			        console.log(response);
					var data = $.parseJSON(response);
					$('#id_ruc').val(data.id_persona);
					$('#ruc_persona').val(data.num_doc);
					$('#razon_social').val(data.nombre_persona);
					$('#razon_direccion').val(data.direccion_persona);
			 }
			 
            
			},
			error: function(response)
			{
             $('#cargando').modal('hide');
			}

		});
	});

//funciones para jalar tipo doc dependiendo el tipo de cpe

	//Buscar serie
	$('#tip_cpe').change(function(e)
	{
		e.preventDefault();
		var cl = $(this).val();
    var user = $('#vendedor').val();
    var emp  = $('#empresa').val();
		var action = 'searchSerie';

		$.ajax({
			url  :  base_url+'/Assets/ajax/ajax_ventas.php',
			type: "POST",
			async: true,
			data: {action:action,cliente:cl,usuario:user,empresa:emp},
			success: function(response)
			{
			     console.log(response);
					var data = $.parseJSON(response);
					 if(response!='false')
					 {
					 	$('#serie').val(data.serie);
					 	$('#numero').val(data.numero);

					 }
					 else
					 {


					 }
			},
			error: function(error)
			{

			}
		});

	});
// agragar venta
  $('#venta_nueva').submit(function(e)
	{
		$('#cargando').modal('show');
		e.preventDefault();
		$.ajax({
			url  :  base_url+'/Assets/ajax/ajax_venta1.php',
			type : "POST",
			async: true,
			data : new FormData(this),
			contentType: false,
			cache: false,
			processData: false,

			success: function(response)
			{
       $('#cargando').modal('hide');
			 $('#exito').modal('show'); 	
        //window.location = "ventas";
         console.log(response);
         var data1 = $.parseJSON(response);
         //console.log(data);
         //window.location = base_url+'/ticket_factura/'+data;
         window.open(base_url+'/ticket_factura/'+data1, '_blank');
         window.location = "ventas";
         //location.reload();
			},
			error: function(response)
			{
          $('#cargando').modal('hide');
          $('#error').modal('show');
          location.reload(); 
			}

		});
	});


// agragar nota de credito
  $('#venta_nueva_nc').submit(function(e)
	{
		$('#cargando').modal('show');
		e.preventDefault();
		$.ajax({
			url  :  base_url+'/Assets/ajax/ajax_venta1.php',
			type : "POST",
			async: true,
			data : new FormData(this),
			contentType: false,
			cache: false,
			processData: false,

			success: function(response)
			{
       $('#cargando').modal('hide');
			 $('#exito').modal('show'); 	
        //window.location = "ventas";
         console.log(response);
         var data1 = $.parseJSON(response);
         //console.log(data);
         //window.location = base_url+'/ticket_factura/'+data;
         window.open(base_url+'/ticket_factura/'+data1, '_blank');
         window.location = "ventas";
         //location.reload();
			},
			error: function(response)
			{
          $('#cargando').modal('hide');
          $('#error').modal('show');
          location.reload(); 
			}

		});
	});


	// reenviar cpe a sunat
  $('#envia_venta').submit(function(e)
	{
		$('#cargando').modal('show');
		e.preventDefault();
		$.ajax({
			url  :  base_url+'/Assets/ajax/ajax_venta1.php',
			type : "POST",
			async: true,
			data : new FormData(this),
			contentType: false,
			cache: false,
			processData: false,

			success: function(response)
			{
       $('#cargando').modal('hide');
			 $('#exito').modal('show'); 	
        //window.location = "ventas";
         console.log(response);
         //var data1 = $.parseJSON(response);
         //console.log(data);
         //window.location = base_url+'/ticket_factura/'+data;
         //window.open(base_url+'/ticket_factura/'+data1, '_blank');
         window.location = "ventas";
         //location.reload();
			},
			error: function(response)
			{
          $('#cargando').modal('hide');
          $('#error').modal('show');
          location.reload(); 
			}

		});
	});


	// agragar nota venta
  $('#nota_nueva').submit(function(e)
	{
		$('#cargando').modal('show');
		e.preventDefault();
		$.ajax({
			url  :  base_url+'/Assets/ajax/ajax_venta1.php',
			type : "POST",
			async: true,
			data : new FormData(this),
			contentType: false,
			cache: false,
			processData: false,

			success: function(response)
			{
       $('#cargando').modal('hide');
			 $('#exito').modal('show'); 	
        //window.location = "ventas";
         console.log(response);
         var data1 = $.parseJSON(response);
         //console.log(data);
         //window.location = base_url+'/ticket_factura/'+data;
         window.open(base_url+'/ticket_factura/'+data1, '_blank');
         window.location = "nota_venta";
         //location.reload();
			},
			error: function(response)
			{
          $('#cargando').modal('hide');
          $('#error').modal('show');
          location.reload(); 
			}

		});
	});



});//end ready

/////////////////////////////////////////funciones para jalar datos del clente / proveedor /////////////////////////////////
  var parametro = '';
  function cliente()
  {
  parametro = $('#modalCliente').modal('show');

  parametro.document.getElementById('1').value = "id";
  parametro.document.getElementById('2').value = "doc";
  parametro.document.getElementById('3').value = "nom";
  parametro.document.getElementById('4').value = "dir";

  }


  function enviacliente(id,doc,nom,dir){

  document.venta_nueva.id_ruc.value = id;
  document.venta_nueva.ruc_persona.value = doc;
  document.venta_nueva.razon_social.value = nom;
  document.venta_nueva.razon_direccion.value = dir;
  
  $('#modalCliente').modal('hide');
  }


  /////////////en nota de credito

  
  function cliente1()
  {
  parametro = $('#modalCliente').modal('show');

  parametro.document.getElementById('1').value = "id";
  parametro.document.getElementById('2').value = "doc";
  parametro.document.getElementById('3').value = "nom";
  parametro.document.getElementById('4').value = "dir";

  }


  function enviacliente1(id,doc,nom,dir){

  document.venta_nueva_nc.id_ruc.value = id;
  document.venta_nueva_nc.ruc_persona.value = doc;
  document.venta_nueva_nc.razon_social.value = nom;
  document.venta_nueva_nc.razon_direccion.value = dir;
  
  $('#modalCliente').modal('hide');
  }


    function cliente2()
  {
  parametro = $('#modalCliente').modal('show');

  parametro.document.getElementById('1').value = "id";
  parametro.document.getElementById('2').value = "doc";
  parametro.document.getElementById('3').value = "nom";
  parametro.document.getElementById('4').value = "dir";

  }


  function enviacliente2(id,doc,nom,dir){

  document.nota_nueva.id_ruc.value = id;
  document.nota_nueva.ruc_persona.value = doc;
  document.nota_nueva.razon_social.value = nom;
  document.nota_nueva.razon_direccion.value = dir;
  
  $('#modalCliente').modal('hide');
  }

//////////////////////////////////////////////////////fin///////////////////////////////////

  //para detalle de venta


var cont=0;
var detalles=0;
var igv_unitario=0;
$("#btnGuardar").hide();
$("#btnListar").hide();
$("#btnPagar").hide();

function agregar(id,nombre,precio,afectacion,precio_compra,factor)
{

	if(afectacion==10)
	{
		$igv_unitario = 0.18;
	}

	else
	{
		$igv_unitario = 0.00;
	}

	cont++;
	detalles++;
	var cantidad = 0;
	var cantidadu = 0;

	var subtotal = (cantidadu*precio+cantidad*factor*precio).toFixed(2);
    var valor_unitario = (subtotal/(1+$igv_unitario)).toFixed(2);
    var igv_u = (valor_unitario*$igv_unitario).toFixed(2);
	var fila='<tr id="fila'+cont+'">'+
	         '<td><button type="button" class="btn btn-danger" onclick="eliminar('+cont+')"><i class="fa fa-trash"></i></button></td>'+
	         '<td>'+cont+'</td>'+
	          '<td><input type="hidden" name="itemarticulo[]" value="'+cont+'"><input type="hidden" name="idarticulo[]" value="'+id+'"><input type="hidden" name="nomarticulo[]" value="'+nombre+'">'+nombre+'</td>'+
	          '<td><input type="hidden" name="precio_compra[]" value="'+precio_compra+'"><input type="hidden" name="factor[]" value="'+factor+'"><input type="text" min="1" class="form-control input-sm" name="cantidad[]" id="cantidad[]" value="'+cantidad+'" onkeyup="modificarSubtotales()" required ></td>'+
	          '<td><input type="text" min="1" class="form-control input-sm" name="cantidadu[]" id="cantidadu[]" value="'+cantidadu+'" required onkeyup="modificarSubtotales()"></td>'+
	          '<td><input type="hidden" class="form-control input-sm" name="valor_unitario[]" id="valor_unitario[]" value="'+valor_unitario+'" readonly>'+
	          '<input type="hidden" class="form-control input-sm" name="igv_unitario[]" id="igv_unitario[]" value="'+igv_u+'" readonly>'+
	          '<input type="text" class="form-control input-sm" name="precio_venta[]" id="precio_venta[]" value="'+precio+'" readonly></td>'+
	         '<td><span id="subtotal'+cont+'" name="subtotal">'+subtotal+'</span><input type="hidden" id="afectacion'+cont+'" name="afectacion[]" class="form-control input-sm" value="'+afectacion+'"></td>'+
	         '</tr>';


	    $('#tabla').append(fila);
	    reordenar();
	    modificarSubtotales();
	    
}



function eliminar(id)
    {
		$('#fila'+id).remove();
		reordenar();
		detalles=detalles-1;

		if(detalles>0)
		{
			modificarSubtotales();
		}
		else
		{
			limpiarTotales();
		}

	}

function reordenar()
	{
		var num=1;
		$('#tabla tbody tr').each(function(){
			$(this).find('td').eq(1).text(num);
			num++;
		});
	}

function modificarSubtotales()
{

	var cant=document.getElementsByName("cantidad[]");
	var cantu=document.getElementsByName("cantidadu[]");
	var fac=document.getElementsByName("factor[]");
	var valu=document.getElementsByName("valor_unitario[]");
	var igvu=document.getElementsByName("igv_unitario[]");
	var prev=document.getElementsByName("precio_venta[]");
	var afec=document.getElementsByName("afectacion[]");
	var sub=document.getElementsByName("subtotal");

	for(var i=0; i< cant.length;i++)
	{
		var inpV=cant[i];
		var inpU=cantu[i];
		var inpF=fac[i];
		var inpVu=valu[i];
		var inpI=igvu[i];
		var inpP=prev[i];
		var inpA=afec[i];
		var inpS=sub[i];

		inpS.value = (inpV.value*inpP.value + inpU.value*inpP.value/inpF.value);
		document.getElementsByName("subtotal")[i].innerHTML=inpS.value.toFixed(2);

		if(inpA.value == '10')
		{
			$igv_unitario = 0.18;
		}
		else
		{
			$igv_unitario = 0.00;
		}

		inpVu.value = ((inpV.value*inpP.value*inpF.value +inpU.value*inpP.value)/(1+$igv_unitario)).toFixed(2);
		$('#valor_unitario').val(inpVu.value);

        inpI.value = (inpVu.value*$igv_unitario).toFixed(2);
        $('#igv_unitario').val(inpI.value);


	}
calcularTotales();
pagos();
}


function calcularTotales()
{
	var op_gravadas   = 0.00;
	var op_exoneradas = 0.00;
	var op_inafectas  = 0.00;
	var subtotal      = 0.00;
 	var igv           = 0.00;
 	var total         = 0.00;
 	var sog           = 0.00;
  var subt          = 0.00;
  var tot           = 0.00;
 	var sub           = document.getElementsByName("subtotal");
   var afec=document.getElementsByName("afectacion[]");
 	for(var i=0; i< sub.length; i++)
 	{
 	var inpA=afec[i];
      //var afe = document.getElementsByName("afectacion[]").value;

       if(inpA.value==10)
       {
       	op_gravadas +=  document.getElementsByName("subtotal")[i].value;
       }

       else if(inpA.value==20)
       {
       	op_exoneradas +=  document.getElementsByName("subtotal")[i].value;
       }
       else if(inpA.value==30)
       {
       	op_inafectas +=  document.getElementsByName("subtotal")[i].value;
       }

       sog = (op_gravadas/1.18).toFixed(2);
       igv = (sog*0.18).toFixed(2);
       $('#op_g').val(sog);
       $('#op_e').val(op_exoneradas);
       $('#op_i').val(op_inafectas);

       subt = ((op_gravadas/1.18) + op_exoneradas + op_inafectas).toFixed(2);
       $('#subt').val(subt);
       $('#igv').val(igv);
       tot = ((op_gravadas/1.18) + op_exoneradas + op_inafectas + (op_gravadas/1.18)*0.18).toFixed(2);
       $('#total').val(tot);
      $('#montopago').val(tot);
       evaluar();
 	}


}

function evaluar()
{
	if(detalles>0)
	{
		//$('#btnGuardar').show();
		$('#btnPagar').show();

	}
	else if(detalles=0)
	{
		//$('#btnGuardar').hide();
		$('#btnPagar').hide();

	}
}

function limpiarTotales()
{
	$('#op_g').val('0.00');
	$('#op_e').val('0.00');
	$('#op_i').val('0.00');
	$('#subtotal').val('0.00');
	$('#igv').val('0.00');
	$('#total').val('0.00');
	$('#btnGuardar').hide();
}

function pagos()
{ 
	var mpago = document.getElementById("montopago").value;
	var efectivo = document.getElementById("efectivo").value;
  var visa = document.getElementById("visa").value;

  var dif = 0.00;

  dif = (mpago - efectivo - visa).toFixed(2);

  if(dif>0)
  {
  	$('#saldo').val(dif);
  	$('#vuelto').val('0.00');
  	$('#btnGuardar').hide();
  }
  
  else
  {
  	$('#vuelto').val(dif);
  	$('#saldo').val('0.00');
  	$('#btnGuardar').show();
  }
}


/////////////////////////////////////funcion para jalar tipo de comprobante afectado por la nota de credito//////////////////////////////

  var par = '';
  function documentoref()
  {
  par = $('#modalDocref').modal('show');
  
  parametro.document.getElementById('1').value = "id";
  parametro.document.getElementById('2').value = "tip";
  parametro.document.getElementById('3').value = "nom";
  parametro.document.getElementById('4').value = "ser";
  parametro.document.getElementById('5').value = "num";
  parametro.document.getElementById('6').value = "ruc";
  parametro.document.getElementById('7').value = "raz";
  parametro.document.getElementById('8').value = "dir";
  parametro.document.getElementById('9').value = "opg";
  parametro.document.getElementById('10').value = "ope";
  parametro.document.getElementById('11').value = "opi";
  parametro.document.getElementById('12').value = "igv";
  parametro.document.getElementById('13').value = "tot";


  }


  function enviaclientenc(id,tip,nom,ser,num,ruc,raz,dir,opg,ope,opi,igv,tot){

  document.venta_nueva_nc.id_venta_ref.value = id;
  document.venta_nueva_nc.cod_doc_ref.value = tip;
  document.venta_nueva_nc.tip_ref.value = nom;
  document.venta_nueva_nc.serie_ref.value = ser;
  document.venta_nueva_nc.num_ref.value = num;
  document.venta_nueva_nc.ruc_persona.value = ruc;
  document.venta_nueva_nc.razon_social.value = raz;
  document.venta_nueva_nc.razon_direccion.value = dir;

  document.venta_nueva_nc.op_g.value = opg;
  document.venta_nueva_nc.op_e.value = ope;
  document.venta_nueva_nc.op_i.value = opi;
  document.venta_nueva_nc.igv.value = igv;
  document.venta_nueva_nc.total.value = tot;
  
  $('#modalDocref').modal('hide');
  }


function openModalEnvia()
{
	$('#ModalVentaEnviada').modal('show');

	var arr = [];

	$('#datatable-ventas > tbody > tr').click(function()
		{
			arr = $(this).find('td').map(function()
				{
					return this.innerHTML;
				}).get();
			$('#enviar_id').val(arr[0]);
			$('#ruc_id').val(arr[4]);

		});
}
