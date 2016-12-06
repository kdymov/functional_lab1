import Developer
import ComputerClass
import WorkPlace
import Schedule
import Testing
import Database.HDBC.ODBC
import Database.HDBC
import System.IO
import System.Exit
import Control.Monad
import Data.Int
import Text.Printf

main = forever (printMenu >> readChoice >>= menuAction)

printMenu = do
    putStrLn "\nDeveloper section:"
    putStrLn " 1) insert developer"
    putStrLn " 2) update developer"
    putStrLn " 3) delete developer"
    putStrLn " 4) print all developers"
    putStrLn " 5) print developer by id"
    putStrLn "\nClass section:"
    putStrLn " 6) insert class"
    putStrLn " 7) update class"
    putStrLn " 8) delete class"
    putStrLn " 9) print all classes"
    putStrLn "10) print class by id"
    putStrLn "\nPlace section:"
    putStrLn "11) insert place"
    putStrLn "12) update place"
    putStrLn "13) delete place"
    putStrLn "14) print all places"
    putStrLn "15) print place by id"
    putStrLn "\nSchedule section:"
    putStrLn "16) insert lesson"
    putStrLn "17) update lesson"
    putStrLn "18) delete lesson"
    putStrLn "19) print full schedule"
    putStrLn "20) print lesson by id"
    putStrLn "\nTesting section:"
    putStrLn "21) insert test session"
    putStrLn "22) print all test sessions\n"
    putStrLn "23) exit"
    putStr "\nYour choice: " 
    hFlush stdout

readChoice = hSetBuffering stdin NoBuffering >> hSetEcho stdin True >> getLine

readInt32 = do
    s <- getLine
    return (read s :: Int32)

-- Menu actions

menuAction "1" = do
    putStrLn "Developer name:"
    nm <- getLine
    conn <- connectODBC "DSN=Lab1_MySQL"
    create Developer{developerId=1,developerName=nm} conn
    putStrLn "-- ok"

menuAction "2" = do
    putStrLn "Developer id:"
    tid <- readInt32
    putStrLn "Developer name:"
    nm <- getLine
    conn <- connectODBC "DSN=Lab1_MySQL"
    update Developer{developerId=tid,developerName=nm} conn
    putStrLn "-- ok"

menuAction "3" = do
    putStrLn "Developer id:"
    tid <- readInt32
    conn <- connectODBC "DSN=Lab1_MySQL"
    delete Developer{developerId=tid,developerName=""} conn
    putStrLn "-- ok"

menuAction "4" = do
    conn <- connectODBC "DSN=Lab1_MySQL"
    lst <- find_all conn :: IO[Developer]
    display lst
    putStrLn "-- end"

menuAction "5" = do
    putStrLn "Developer id:"
    tid <- readInt32
    conn <- connectODBC "DSN=Lab1_MySQL"
    lst <- find_id tid conn :: IO[Developer]
    display lst
    putStrLn "-- end"

menuAction "6" = do
    putStrLn "Class number:"
    nm <- readInt32
    putStrLn "Places quantity:"
    pl <- readInt32
    conn <- connectODBC "DSN=Lab1_MySQL"
    create ComputerClass{cclassId=1,cclassName=nm,cclassPlaces=pl} conn
    putStrLn "-- ok"

menuAction "7" = do
    putStrLn "Class id:"
    ccid <- readInt32
    putStrLn "Class number:"
    nm <- readInt32
    putStrLn "Places quantity:"
    pl <- readInt32
    conn <- connectODBC "DSN=Lab1_MySQL"
    update ComputerClass{cclassId=ccid,cclassName=nm,cclassPlaces=pl} conn
    putStrLn "-- ok"

menuAction "8" = do
    putStrLn "Class id:"
    ccid <- readInt32
    conn <- connectODBC "DSN=Lab1_MySQL"
    delete ComputerClass{cclassId=ccid,cclassName=0,cclassPlaces=0} conn
    putStrLn "-- ok"

menuAction "9" = do
    conn <- connectODBC "DSN=Lab1_MySQL"
    lst <- find_all conn :: IO[ComputerClass]
    display lst
    putStrLn "-- end"

menuAction "10" = do
    putStrLn "Class id:"
    ccid <- readInt32
    conn <- connectODBC "DSN=Lab1_MySQL"
    lst <- find_id ccid conn :: IO[ComputerClass]
    display lst
    putStrLn "-- end"

menuAction "11" = do
    putStrLn "Place number:"
    nm <- readInt32
    putStrLn "Class ID:"
    ccid <- readInt32
    conn <- connectODBC "DSN=Lab1_MySQL"
    create WorkPlace{workplaceId=1,workplaceNumber=nm,workplaceClassId=ccid} conn
    putStrLn "-- ok"

menuAction "12" = do
    putStrLn "Place id:"
    wpid <- readInt32
    putStrLn "Place number:"
    nm <- readInt32
    putStrLn "Class ID:"
    ccid <- readInt32
    conn <- connectODBC "DSN=Lab1_MySQL"
    update WorkPlace{workplaceId=wpid,workplaceNumber=nm,workplaceClassId=ccid} conn
    putStrLn "-- ok"

menuAction "13" = do
    putStrLn "Place id:"
    wpid <- readInt32
    conn <- connectODBC "DSN=Lab1_MySQL"
    delete WorkPlace{workplaceId=wpid,workplaceNumber=0,workplaceClassId=0} conn
    putStrLn "-- ok"

menuAction "14" = do
    conn <- connectODBC "DSN=Lab1_MySQL"
    lst <- find_all conn :: IO[WorkPlace]
    display lst
    putStrLn "-- end"

menuAction "15" = do
    putStrLn "Place id:"
    wpid <- readInt32
    conn <- connectODBC "DSN=Lab1_MySQL"
    lst <- find_id wpid conn :: IO[WorkPlace]
    display lst
    putStrLn "-- end"

menuAction "16" = do
    putStrLn "Day (2 letters, e.g. MO, TU, WD, TH, FR, SA, SU):"
    day <- getLine
    putStrLn "Lesson number:"
    num <- readInt32
    putStrLn "Lesson name:"
    name <- getLine
    putStrLn "Developer ID:"
    tid <- readInt32
    putStrLn "Class ID:"
    ccid <- readInt32
    conn <- connectODBC "DSN=Lab1_MySQL"
    create Schedule{scheduleId=1,scheduleDay=day,scheduleNumber=num,scheduleName=name,scheduleDeveloperId=tid,scheduleClassId=ccid} conn
    putStrLn "-- ok"

menuAction "17" = do
    putStrLn "Lesson id:"
    sid <- readInt32
    putStrLn "Day (2 letters, e.g. MO, TU, WD, TH, FR, SA, SU):"
    day <- getLine
    putStrLn "Lesson number:"
    num <- readInt32
    putStrLn "Lesson name:"
    name <- getLine
    putStrLn "Developer ID:"
    tid <- readInt32
    putStrLn "Class ID:"
    ccid <- readInt32
    conn <- connectODBC "DSN=Lab1_MySQL"
    update Schedule{scheduleId=sid,scheduleDay=day,scheduleNumber=num,scheduleName=name,scheduleDeveloperId=tid,scheduleClassId=ccid} conn
    putStrLn "-- ok"

menuAction "18" = do
    putStrLn "Lesson id:"
    sid <- readInt32
    conn <- connectODBC "DSN=Lab1_MySQL"
    delete Schedule{scheduleId=sid,scheduleDay="00",scheduleNumber=0,scheduleName="",scheduleDeveloperId=0,scheduleClassId=0} conn
    putStrLn "-- ok"

menuAction "19" = do
    conn <- connectODBC "DSN=Lab1_MySQL"
    lst <- find_all conn :: IO[Schedule]
    display lst
    putStrLn "-- end"

menuAction "20" = do
    putStrLn "Lesson id:"
    sid <- readInt32
    conn <- connectODBC "DSN=Lab1_MySQL"
    lst <- find_id sid conn :: IO[Schedule]
    display lst
    putStrLn "-- end"

menuAction "21" = do
    putStrLn "Lesson ID:"
    sid <- readInt32
    putStrLn "Place ID:"
    wpid <- readInt32
    conn <- connectODBC "DSN=Lab1_MySQL"
    create Testing{testingLessonId=sid,testingPlaceId=wpid} conn
    putStrLn "-- ok"

menuAction "22" = do
    conn <- connectODBC "DSN=Lab1_MySQL"
    lst <- find_all conn :: IO[Testing]
    display lst
    putStrLn "-- end"

menuAction "23" = exitSuccess

menuAction _ = hPutStrLn stderr "\nInvalid choice."