<?php 

function base_url()
{
  return BASE_URL;
}

function media()
{
	return BASE_URL."/Assets";
}

function formatMoney($cantidad)
{
	$cantida = number_format($cantidad,2,SPD,SPM);
	return $cantidad;
}


function nombre()
{
    return  NOMBRE;
}

function empresa()
{
    return  EMPRESA;
}

?>