<?php
function classifyAttendances($concepts, $attendanceIn, $attendanceOut) {

    $resultado = ['HO' => 0, 'HED' => 0, 'HEN' => 0];
    

    $minutosEntrada = convertirAMinutos($attendanceIn);
    $minutosSalida = convertirAMinutos($attendanceOut);
    

    if ($minutosSalida < $minutosEntrada) {
        $minutosSalida += 24 * 60;
    }
    
    foreach ($concepts as $concepto) {
        $inicioConcepto = convertirAMinutos($concepto['start']);
        $finConcepto = convertirAMinutos($concepto['end']);
        
    
        if ($finConcepto < $inicioConcepto) {
            $finConcepto += 24 * 60;
        }
        
    
        $inicioCoincidencia = max($minutosEntrada, $inicioConcepto);
        $finCoincidencia = min($minutosSalida, $finConcepto);
        
    
        if ($inicioCoincidencia <= $finCoincidencia) {
            $minutos = $finCoincidencia - $inicioCoincidencia;
            $horas = $minutos / 60;
            $resultado[$concepto['id']] = round($horas, 2);
        }
    }
    
    $resultadoFinal = [];
    foreach (['HO', 'HED', 'HEN'] as $tipo) {
        if ($resultado[$tipo] > 0) {
            $resultadoFinal[$tipo] = $resultado[$tipo];
        }
    }
    
    return $resultadoFinal;
}

function convertirAMinutos($hora) {
    list($horas, $minutos) = explode(':', $hora);
    return $horas * 60 + $minutos;
}
?>