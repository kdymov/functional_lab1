module Developer(
    Developer(Developer),
    developerId,
    developerName,
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

type DeveloperID = Int32
type DeveloperName = String

data Developer = Developer {
    developerId :: Int32,
    developerName :: String
} deriving (Show)

instance Entity Developer where
    create teach conn = developer_create (developerName teach) conn
    update teach conn = developer_update (developerId teach) (developerName teach) conn
    delete teach conn = developer_delete (developerId teach) conn
    find_all conn = developer_all conn
    find_id id conn = developer_find_id id conn
    display lst = developer_display lst

developer_create :: IConnection a => DeveloperName -> a -> IO Bool
developer_create name conn = do
    withTransaction conn (developer_create' name)
developer_create' name conn = do
    commited <- run conn query [SqlString name]
    return $ commited == 1
    where
        query = "INSERT INTO developer (name) VALUES (?)"

developer_update :: IConnection a => DeveloperID -> DeveloperName -> a -> IO Bool
developer_update tid name conn = do
    withTransaction conn (developer_update' tid name)
developer_update' tid name conn = do
    commited <- run conn query [SqlString name, SqlInt32 tid]
    return $ commited == 1
    where
        query = "UPDATE developer SET name = ? WHERE id = ?"

developer_delete :: IConnection a => DeveloperID -> a -> IO Bool
developer_delete tid conn = do
    withTransaction conn (developer_delete' tid)
developer_delete' tid conn = do
    commited <- run conn query [SqlInt32 tid]
    return $ commited == 1
    where
        query = "DELETE FROM developer WHERE id = ?"

developer_all :: IConnection a => a -> IO [Developer]
developer_all conn = do
    rslt <- quickQuery conn query []
    return $ map unpuck rslt
    where
        query = "SELECT * FROM developer"
        unpuck [SqlInt32 id, SqlByteString name] = Developer{developerId=id,developerName=(BS.unpack name)}
        unpuck x = error $ "Unexpected result: " ++ show x

developer_find_id :: IConnection a => Int32 -> a -> IO [Developer]
developer_find_id id conn = do
    rslt <- quickQuery conn query []
    return $ map unpuck rslt
    where
        query = printf "SELECT * FROM developer WHERE id = %d" id
        unpuck [SqlInt32 id, SqlByteString name] = Developer{developerId=id,developerName=(BS.unpack name)}
        unpuck x = error $ "Unexpected result: " ++ show x

developer_display :: [Developer] -> IO[()]
developer_display lst = do
    sequence (map developer_display' lst)
developer_display' teach = do
    putStrLn ((printf "%d. " (developerId teach)) ++ (developerName teach))