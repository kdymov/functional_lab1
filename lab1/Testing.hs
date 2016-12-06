module Testing(
    Testing(Testing),
    testingLessonId,
    testingPlaceId,
    create,
    update,
    delete,
    find_all,
    find_id,
    display
    ) where

import Entity
import Database.HDBC.ODBC
import Database.HDBC
import qualified Data.ByteString.Char8 as BS
import Data.Int
import Text.Printf

type TestingLessonID = Int32
type TestingPlaceID = Int32

data Testing = Testing {
    testingLessonId :: Int32,
    testingPlaceId :: Int32
} deriving (Show)

instance Entity Testing where
    create plcm conn = testing_create (testingLessonId plcm) (testingPlaceId plcm) conn
    find_all conn = testing_all conn
    display lst = testing_display lst

testing_create :: IConnection a => TestingLessonID -> TestingPlaceID -> a -> IO Bool
testing_create lid pid conn = do
    withTransaction conn (testing_create' lid pid)
testing_create' lid pid conn = do
    commited <- run conn query [SqlInt32 lid, SqlInt32 pid]
    return $ commited == 1
    where
        query = "INSERT INTO testing (testsession_id, place_id) VALUES (?, ?)"

testing_all :: IConnection a => a -> IO [Testing]
testing_all conn = do
    rslt <- quickQuery conn query []
    return $ map unpuck rslt
    where
        query = "SELECT * FROM testing"
        unpuck [SqlInt32 lid, SqlInt32 pid] = Testing{testingLessonId=lid,testingPlaceId=pid}
        unpuck x = error $ "Unexpected result: " ++ show x

testing_display :: [Testing] -> IO[()]
testing_display lst = do
    sequence (map testing_display' lst)
testing_display' plcm = do
    putStrLn (printf "test session %d - place %d is busy" (testingLessonId plcm) (testingPlaceId plcm))