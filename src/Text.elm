module Text exposing (Package, package)

import Dict


type alias Package =
    { title : String
    , score : String
    , reset : String
    , help : String
    , helpText : String
    , setScore : String
    }


dePackage : Package
dePackage =
    { title = "Klira"
    , score = "Deine Punkte"
    , reset = "Punkte setzen"
    , help = "Hilfe"
    , helpText = """
        Die Klira app kann Dich motivieren im Alltag etwas für Nachhaltigkeit, Klimaschutz und Artenvielfalt zu tun.
        Immer wenn Du Dich für eine gute Tat entscheidest, drückst Du den + button und gibst Dir einen Punk.
           
        Du kannst selbst entscheiden für was und wie viele Punkte Du Dir geben magst.
        Zum Beispiel vegetarisches Essen, öffentliche Verkehrsmittel, Verpackungen vermeiden, ...
            
        Diese App gibt es nur als Webseite in Deinem Browser. Auch nur dort werden deine Punkte gespeichert.
        Falls Du die App auf einem andren Gerät oder Browser mit Deinen Punkten öffnen willst, dann schickte/kopiere die URL aus dem Adressfeld Deines Browsers.
        """
    , setScore = "Hier kannst Du Deine Punkte setzen"
    }

enPackage : Package
enPackage =
    { title = "Klira"
    , score = "Your points"
    , reset = "Set points"
    , help = "Help"
    , helpText = """
        The Klira app can motivate you to do something for sustainability, climate protection and biodiversity in your everyday life.
        Whenever you decide to do a good deed, you press the + button and give yourself a point.
           
        You can decide for yourself what and how many points you want to give yourself.
        For example, vegetarian food, public transportation, avoiding packaging, ...
            
        This app is only available as a website in your browser. Your points are also only saved there.
        If you want to open the app on another device or browser with your points, then send/copy the URL from the address field of your browser.
        """
    , setScore = "You can set your points here"
    }



defaultPackage : Package
defaultPackage =
    enPackage


packages : Dict.Dict String Package
packages =
    Dict.fromList
        [ ( "de", dePackage ),
          ( "en", enPackage )
        ]


package : String -> Package
package lang =
    case Dict.get lang packages of
        Just p ->
            p

        Nothing ->
            defaultPackage
