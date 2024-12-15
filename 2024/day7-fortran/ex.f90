PROGRAM LerArquivo
  IMPLICIT NONE
  INTEGER :: iostat, unidade, numero_inicial, num1, num2, extra_num, i
  CHARACTER(LEN=100) :: linha
  CHARACTER(LEN=*) :: arquivo
  INTEGER, ALLOCATABLE :: numeros(:)
  INTEGER :: contador

  ! Nome do arquivo
  arquivo = "dados.txt"
  unidade = 10  ! Unidade lógica para o arquivo

  ! Abrir o arquivo para leitura
  OPEN(UNIT=unidade, FILE=arquivo, STATUS='OLD', ACTION='READ', IOSTAT=iostat)
  IF (iostat /= 0) THEN
     PRINT *, "Erro ao abrir o arquivo:", TRIM(arquivo)
     STOP
  END IF

  ! Ler cada linha do arquivo
  DO
     READ (unidade, '(A)', IOSTAT=iostat) linha
     IF (iostat /= 0) EXIT  ! Fim do arquivo ou erro de leitura

     ! Inicializar o contador para números extras
     contador = 0
     ALLOCATE(numeros(0))  ! Inicialmente sem números extras

     ! Extrair o primeiro número e os dois primeiros números adicionais
     READ (linha, '(I3, ":", I3, 1X, I3)', IOSTAT=iostat) numero_inicial, num1, num2
     IF (iostat /= 0) THEN
        PRINT *, "Erro ao processar a linha:", linha
        CYCLE
     END IF

     PRINT *, "Numero Inicial:", numero_inicial, "Num1:", num1, "Num2:", num2

     ! Processar números extras na linha (após os primeiros dois)
     DO
        READ (linha, *, IOSTAT=iostat) extra_num
        IF (iostat /= 0) EXIT  ! Se não há mais números, sair do loop
        contador = contador + 1
        CALL add_to_array(numeros, contador, extra_num)
     END DO

     ! Exibir os números extras, se houver
     IF (contador > 0) THEN
        PRINT *, "Números Extras:", (numeros(i), i=1, contador)
     ELSE
        PRINT *, "Sem números extras."
     END IF
  END DO

  ! Fechar o arquivo
  CLOSE(UNIT=unidade)

CONTAINS

  SUBROUTINE add_to_array(arr, size, value)
    INTEGER, ALLOCATABLE, INTENT(INOUT) :: arr(:)
    INTEGER, INTENT(IN) :: size, value
    INTEGER, ALLOCATABLE :: temp(:)

    ALLOCATE(temp(size))
    IF (SIZE(arr) > 0) temp(1:SIZE(arr)) = arr
    temp(size) = value
    DEALLOCATE(arr)
    ALLOCATE(arr(size))
    arr = temp
  END SUBROUTINE add_to_array

END PROGRAM LerArquivo

