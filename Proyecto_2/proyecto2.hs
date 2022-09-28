-- Viviana Vargas Ortiz
-- Proyecto 2
-- Lenguajes de Programacion
-- 2019024030
-- Semestre II, 2022

{-# LANGUAGE OverloadedStrings #-}

import System.IO
import System.Exit
import Data.IORef
import Data.Text

{-import Control.Monad

-- CODIGO DE MENU OBTENIDO DE: https://stackoverflow.com/questions/2799588/simple-text-menu-in-haskell 
-}

-- Funcion Main que llama a printMenu1, que imprime el menu principal
main = printMenu1 

-- Funcion PrintMenu1 de tipo IO(). Esta imprime el menu principal, toma el input del usuario, y llama a otra funcion que imprime el menu correspondiente dependiendo de la eleccion 

printMenu1 :: IO()
printMenu1 = do
    putStr "\nBienvenido al sistema Bi-Quick. Escriba en consola el numero de la opcón que desea escoger\n 1) Menu Operativo\n 2) Menu Generales \n 3) Salir\nIngrese su eleccion: \n"
    choice <- getLine
    printMenuChoice (choice)


-- Funcion PrintMenuChoice. Recibe el String de la eleccion del usuariol, y retorna una funcion IO dependiendo de esta eleccion.

printMenuChoice :: String -> IO()
printMenuChoice n = case n of
    "1" -> printMenuOp
    "2" -> printMenuGen
    "3" -> exitSuccess
    _ -> incorrectChoice

-- Funcion incorrectChoice. Imprime un mensaje de valor incorrecto y llama a printMenu1 nuevamente.

incorrectChoice :: IO()
incorrectChoice = do
    putStr "Valor incorrecto. Ingrese un numero valido"
    printMenu1

-- MENU OPERATIVO --
-- Funcion printMenuOp. Imprime menu operacional.

printMenuOp :: IO()
printMenuOp = do
    putStr "\nMenu Operativo. Escriba en consola el numero de la opcón que desea escoger\n 1) Cargar Parqueos\n 2) Ver Parqueos \n 3) Mostrar Bicicletas\n 4) Cargar usuarios \n 5) Estadisticas \nIngrese su eleccion: \n"
    choice <- getLine
    printOpChoice (choice)

-- Funcion PrintOpChoice. Recibe el String de la eleccion del usuario, y retorna una funcion IO dependiendo de esta eleccion.

printOpChoice :: String -> IO()
printOpChoice n = case n of
    "1" -> cargarParqueos
    "2" -> verParqueos
    "3" -> mostrarBicis
    "4" -> cargarUsuarios
    "5" -> estadisticas
    _ -> incorrectOP

cargarParqueos :: IO()
cargarParqueos = do
    putStr "\n Ingrese el nombre del archivo desde el cual va a cargar la informacion de los parqueos (Ejemplo: misparqueos.txt) : \n"
    file <- getLine
    cargarDataAFile file "parqueos.txt"

verParqueos :: IO()
verParqueos = do
    putStr "\nParqueos disponibles:\n"
    readAFile "parqueos.txt"

mostrarBicis :: IO()
mostrarBicis = do
    putStr "\nBicicletas disponibles:\n"
    readAFile "bicicletasdisponibles.txt"

cargarUsuarios :: IO()
cargarUsuarios = do
    putStr "\n Ingrese el nombre del archivo desde el cual va a cargar la informacion de los usuarios (Ejemplo: misusuarios.txt) : \n"
    file <- getLine
    cargarDataAFile file "usuariosregistrados.txt"

-- ESTADISTICAS --

estadisticas :: IO()
estadisticas = do
    putStr "\nEscoja la opcion de las estadisticas que desea ver: \n 1) Top 5 de usuarios con más viajes \n 2) Top 5 de parqueos con más viajes \n 3) Top 3 de bicicletas con más kilómetros recorridos \n 4) Resumen:  total de viajes, total de kilómetros y total facturado \n Ingrese su eleccion: \n"
        choice <- getLine
        cargarDataAFile file "parqueos.txt"

printStatChoice :: String -> IO()
printStatChoice n = case n of
    "1" -> top5users
    "2" -> top5parqueos
    "3" -> top3bicis
    "4" -> resumen
    _ -> incorrectStatC

incorrectStatC :: IO()
incorrectStatC = do
    putStr "Valor incorrecto. Ingrese un numero valido"
    estadisticas

top5users :: IO()
top5users = do
    putStr "\nTop 5 Usuarios con mas viajes\n"

top5parqueos :: IO()
top5parqueos = do
    putStr "\nTop 5 parqueos con mas viajes\n"

top3bicis :: IO()
top5parqueos = do
    putStr "\nTop 3 bicicletas con kilometros recorridos\n"

resumen :: IO()
resumen = do
    putStr "\nResumen:  total de viajes, total de kilómetros y total facturado\n"

incorrectOP :: IO()
incorrectOP = do
    putStr "Valor incorrecto. Ingrese un numero valido"
    printMenuOp

-- MENU GENERAL
-- Funcion printMenuGen. Imprime menu de opciones generales.

printMenuGen :: IO()
printMenuGen = do
    putStr "\nMenu General\n"

{- FUNCIONES DE WRITE Y READ CONSEGUIDAS DE: New Think Tank. (D. Banas, 2015). Learn Haskell In One Video. URL: https://www.newthinktank.com/2015/08/learn-haskell-one-video/-}

-- File IO
-- Write to a file 
writeToFile = do
 
    -- Open the file using WriteMode
    theFile <- openFile "test.txt" WriteMode
    
    -- Put the text in the file
    hPutStrLn theFile ("Random line of text")
    
    -- Close the file
    hClose theFile
    
cargarDataAFile file1 file2 = do
 
    -- Open the file using ReadMode
    theFile2 <- openFile file1 ReadMode
    
    -- Get the contents of the file
    contents <- hGetContents theFile2
    
    theFile <- openFile file2 WriteMode
    
    -- Put the text in the file
    hPutStrLn theFile (contents)
    
    -- Close the file
    hClose theFile

    -- Close the file
    hClose theFile2

readAFile file1 = do
 
    -- Open the file using ReadMode
    theFile2 <- openFile file1 ReadMode
    
    -- Get the contents of the file
    contents <- hGetContents theFile2
    putStr contents
    
    -- Close the file
    hClose theFile2