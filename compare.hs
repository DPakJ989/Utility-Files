import Hledger.Cli.Utils
import System.Exit
import System.Process
import Network.URL
import Data.Tuple.Select

data Browser = Browser { path :: FilePath
                       } deriving (Show)

main :: IO ()
main = do
    openURLInBrowser browser url >>= printResultMessage
    where  
        browser = Browser "C:/Program Files (x86)/Mozilla Firefox/firefox.exe"
        url = URL HostRelative "http://www.gamefaqs.com" []
    

printResultMessage :: ExitCode -> IO ()
printResultMessage ExitSuccess = putStrLn "Successfully opened browser"
printResultMessage (ExitFailure n) = putStrLn $ "Failed to open browser with ExitCode: " ++ show n

openURLInBrowser :: Browser -> URL -> IO ExitCode
openURLInBrowser browser url = 
    readProcessWithExitCode (path browser) [(url_path url)] "" >>= (\x -> return (sel1 x))

    
