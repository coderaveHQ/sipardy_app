-- [FUNCTION] to update the updated_at timestamp
CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at := NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- [TABLE] for the game questions
CREATE TABLE public.game_questions (
    id UUID NOT NULL DEFAULT gen_random_uuid(),
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT NOW(),
    category public.game_category NOT NULL,
    points INTEGER NOT NULL,
    question TEXT NOT NULL,
    answer TEXT NOT NULL,
    CONSTRAINT game_questions_pkey PRIMARY KEY (id)
) TABLESPACE pg_default;

-- [COMMENT] on game_questions
COMMENT ON TABLE public.game_questions IS 'The game questions.';

-- Enable RLS for game_questions
ALTER TABLE public.game_questions ENABLE ROW LEVEL SECURITY;

-- [POLICY] Allow selects to everyone
CREATE POLICY "public_game_questions_select" ON "public"."game_questions" FOR
SELECT USING (true);

-- [TRIGGER] to update the updated_at timestamp
CREATE TRIGGER update_game_questions_updated_at_trigger
AFTER UPDATE ON public.game_questions
FOR EACH ROW
EXECUTE FUNCTION update_updated_at();

-- Questions for the "animals" category
INSERT INTO public.game_questions (category, points, question, answer) VALUES
('animals', 1, 'Wie viele Beine hat eine Spinne?', '8'),
('animals', 1, 'Welches Tier ist das größte Landraubtier der Welt?', 'Eisbär'),
('animals', 1, 'Welches Tier ist bekannt für seine Fähigkeit, Netze zu spinnen?', 'Spinne'),
('animals', 1, 'Wie nennt man einen weiblichen Elefanten?', 'Kuh'),
('animals', 2, 'Welches Tier hat einen Beutel und springt?', 'Känguru'),
('animals', 2, 'Welches Tier kann seine Farbe ändern, um sich zu tarnen?', 'Chamäleon'),
('animals', 2, 'Wie nennt man die Gruppe von Tieren, die Federn haben?', 'Vögel'),
('animals', 2, 'Welcher Vogel ist für seine Fähigkeit bekannt, Werkzeuge zu benutzen?', 'Krähe'),
('animals', 3, 'Welches Tier hat die längste Lebensspanne?', 'Grönlandhai'),
('animals', 3, 'Wie nennt man die Haut, die Schlangen regelmäßig abwerfen?', 'Häutung'),
('animals', 3, 'Welches Tier hat Streifen und lebt in Afrika?', 'Zebra'),
('animals', 3, 'Wie heißt der schnellste Landläufer der Welt?', 'Gepard'),
('animals', 4, 'Welches Säugetier legt Eier?', 'Schnabeltier'),
('animals', 4, 'Wie nennt man die Wissenschaft, die sich mit Insekten beschäftigt?', 'Entomologie'),
('animals', 4, 'Welches Tier kann im Wasser und an Land leben?', 'Amphibien'),
('animals', 4, 'Wie nennt man die Gruppe von Tieren, die ausschließlich Pflanzen fressen?', 'Herbivoren'),
('animals', 5, 'Welches Tier hat das größte Gehirn im Verhältnis zu seiner Körpergröße?', 'Ameise'),
('animals', 5, 'Wie nennt man die Struktur, die die Haut von Reptilien schützt?', 'Schuppen'),
('animals', 5, 'Welches Tier kann mit seinen Ohren seine Körpertemperatur regulieren?', 'Afrikanischer Elefant'),
('animals', 5, 'Welches Tier ist für seine unglaubliche Navigationsfähigkeit über große Entfernungen bekannt?', 'Lederbackschildkröte');

-- Questions for the "architecture" category
INSERT INTO public.game_questions (category, points, question, answer) VALUES
('architecture', 1, 'Welches Gebäude wurde von Gustave Eiffel entworfen?', 'Eiffelturm'),
('architecture', 1, 'Wie nennt man die senkrechten tragenden Elemente eines Gebäudes?', 'Säulen'),
('architecture', 1, 'Welcher Baustil ist für hohe Fenster und Spitzbögen bekannt?', 'Gotik'),
('architecture', 1, 'In welcher Stadt befindet sich der schiefe Turm von Pisa?', 'Pisa'),
('architecture', 2, 'Welches berühmte Bauwerk wurde als Grabstätte in Indien errichtet?', 'Taj Mahal'),
('architecture', 2, 'Wie nennt man das Gewölbe, das typisch für römische Architektur ist?', 'Tonnengewölbe'),
('architecture', 2, 'Welcher Baustil folgte auf die Gotik?', 'Renaissance'),
('architecture', 2, 'Wie nennt man den oberen Abschluss einer Säule?', 'Kapitel'),
('architecture', 3, 'Wie heißt das weltberühmte Opernhaus in Sydney?', 'Sydney Opera House'),
('architecture', 3, 'Welcher Baustil ist für seine massiven, steinernen Bögen bekannt?', 'Romanik'),
('architecture', 3, 'Wie nennt man die Technik, mit der eine Kuppel gebaut wird?', 'Kragtechnik'),
('architecture', 3, 'Welches Gebäude in New York war lange Zeit das höchste der Welt?', 'Empire State Building'),
('architecture', 4, 'Welcher Architekt entwarf das Guggenheim-Museum in Bilbao?', 'Frank Gehry'),
('architecture', 4, 'Wie nennt man den offenen Innenhof in römischen Villen?', 'Atrium'),
('architecture', 4, 'Welcher Baustil ist bekannt für dekorative Schnitzereien und üppige Verzierungen?', 'Barock'),
('architecture', 4, 'Wie nennt man einen freistehenden Glockenturm?', 'Campanile'),
('architecture', 5, 'Welche Pyramide ist die größte der Welt?', 'Die Cheops-Pyramide'),
('architecture', 5, 'Wie nennt man die Konstruktion, bei der Steine ohne Mörtel aufeinandergelegt werden?', 'Trockenmauerwerk'),
('architecture', 5, 'Wie heißt der berühmte Architekt der Sagrada Familia?', 'Antoni Gaudí'),
('architecture', 5, 'Welche Brücke in San Francisco ist weltberühmt?', 'Golden Gate Bridge');

-- Questions for the "art" category
INSERT INTO public.game_questions (category, points, question, answer) VALUES
('art', 1, 'Welcher Maler ist für die Mona Lisa bekannt?', 'Leonardo da Vinci'),
('art', 1, 'Wie nennt man das Werkzeug, mit dem ein Maler Farben mischt?', 'Palette'),
('art', 1, 'Welche Kunstform besteht aus geschnitzten oder gemeißelten Figuren?', 'Skulptur'),
('art', 1, 'Welcher Stil ist bekannt für kräftige Farben und einfache Formen?', 'Fauvismus'),
('art', 2, 'Wer malte das Werk „Die Sternennacht“?', 'Vincent van Gogh'),
('art', 2, 'Wie nennt man die Epoche, die Michelangelo und Raffael prägten?', 'Renaissance'),
('art', 2, 'Was bedeutet der Begriff „Stillleben“ in der Kunst?', 'Darstellung unbewegter Gegenstände'),
('art', 2, 'Welcher Künstler ist bekannt für seine Gemälde von Seerosen?', 'Claude Monet'),
('art', 3, 'Welcher Stil brach mit der traditionellen Perspektive und zeigte Objekte aus mehreren Blickwinkeln?', 'Kubismus'),
('art', 3, 'Wie nennt man das Festhalten von Momenten und Emotionen in der Malerei?', 'Impressionismus'),
('art', 3, 'Welcher Künstler schuf Werke wie die „Campbell’s Soup Cans“?', 'Andy Warhol'),
('art', 3, 'Was ist das größte Kunstmuseum der Welt?', 'Louvre'),
('art', 4, 'Welches berühmte Gemälde zeigt eine Frau mit einem Perlenohrring?', 'Das Mädchen mit dem Perlenohrring'),
('art', 4, 'Welcher Künstler ist für seine Schmelzenden Uhren bekannt?', 'Salvador Dalí'),
('art', 4, 'Wie nennt man Wandmalereien, die direkt auf frischen Putz aufgetragen werden?', 'Fresko'),
('art', 4, 'Welcher Künstler wurde wegen seiner Schöpfung des Petersdoms berühmt?', 'Michelangelo'),
('art', 5, 'Welcher Künstler schuf den David?', 'Michelangelo'),
('art', 5, 'Wie nennt man den Stil, der für seine Detailverliebtheit in der Darstellung von Alltagsszenen bekannt ist?', 'Realismus'),
('art', 5, 'Welcher niederländische Künstler ist für seine optischen Täuschungen bekannt?', 'M. C. Escher'),
('art', 5, 'Wie heißt die Epoche, die auf die Gotik folgte und die Antike wiederentdeckte?', 'Renaissance');

-- Questions for the "board_games" category
INSERT INTO public.game_questions (category, points, question, answer) VALUES
('board_games', 1, 'Welches Brettspiel basiert auf dem Kauf und Verkauf von Immobilien?', 'Monopoly'),
('board_games', 1, 'Wie viele Spielfiguren hat jeder Spieler bei „Mensch ärgere Dich nicht“?', '4'),
('board_games', 1, 'Welches Brettspiel verwendet Buchstabenplättchen, um Wörter zu legen?', 'Scrabble'),
('board_games', 1, 'Wie viele Felder hat ein Schachbrett?', '64'),
('board_games', 2, 'In welchem Spiel baut man Straßen, Siedlungen und Städte?', 'Die Siedler von Catan'),
('board_games', 2, 'Wie nennt man das Spiel, bei dem man aus 7 Steinen Brücken und andere Formen legen muss?', 'Tangram'),
('board_games', 2, 'Welches Strategiespiel basiert auf der Eroberung der Welt?', 'Risiko'),
('board_games', 2, 'Welche Spielfigur startet bei „Cluedo“ im Arbeitszimmer?', 'Professor Bloom'),
('board_games', 3, 'Welches Spiel verwendet farbige Blöcke, die auf einem Turm gestapelt werden?', 'Jenga'),
('board_games', 3, 'Wie heißt das Spiel, bei dem man Zahlenplättchen auf einer Reihe kombinieren muss?', 'Rummikub'),
('board_games', 3, 'Welches Spiel erfordert es, kleine Plastikstöcke durch eine Röhre zu ziehen, ohne Kugeln fallen zu lassen?', 'Mikado'),
('board_games', 3, 'Wie viele Schiffe hat jeder Spieler bei „Schiffe versenken“?', '5'),
('board_games', 4, 'Welches Spiel basiert auf dem Roman „Dune“ von Frank Herbert?', 'Dune: Das Brettspiel'),
('board_games', 4, 'Wie viele Siegbedingungen gibt es in „Terraforming Mars“?', '3'),
('board_games', 4, 'Welches kooperative Spiel handelt von der Bekämpfung von Seuchen?', 'Pandemie'),
('board_games', 4, 'Welcher Begriff wird im Schach verwendet, wenn der König keinen Zug mehr machen kann?', 'Schachmatt'),
('board_games', 5, 'Wie heißt das komplexe Spiel, das Ressourcenmanagement und den Bau einer mittelalterlichen Stadt kombiniert?', 'Carcassonne'),
('board_games', 5, 'Welches Brettspiel simuliert eine Weltraumexpedition und verwendet Würfel als Raumschiffe?', 'Galaxy Trucker'),
('board_games', 5, 'Welches Fantasy-Brettspiel hat die Erweiterung „Die Legenden von Andor“?', 'Andor'),
('board_games', 5, 'Welches Strategiespiel basiert auf der Kolonialisierung des Weltraums und wird auch „Twilight Imperium“ genannt?', 'Twilight Imperium');

-- Questions for the "capitals" category
INSERT INTO public.game_questions (category, points, question, answer) VALUES
('capitals', 1, 'Was ist die Hauptstadt von Deutschland?', 'Berlin'),
('capitals', 1, 'Welche Stadt ist die Hauptstadt von Frankreich?', 'Paris'),
('capitals', 1, 'Wie heißt die Hauptstadt von Spanien?', 'Madrid'),
('capitals', 1, 'Was ist die Hauptstadt von Italien?', 'Rom'),
('capitals', 2, 'Welche Stadt ist die Hauptstadt von Kanada?', 'Ottawa'),
('capitals', 2, 'Wie heißt die Hauptstadt von Australien?', 'Canberra'),
('capitals', 2, 'Was ist die Hauptstadt von Brasilien?', 'Brasília'),
('capitals', 2, 'Welche Stadt ist die Hauptstadt von Ägypten?', 'Kairo'),
('capitals', 3, 'Wie heißt die Hauptstadt von Neuseeland?', 'Wellington'),
('capitals', 3, 'Welche Stadt ist die Hauptstadt von Südafrika?', 'Pretoria'),
('capitals', 3, 'Was ist die Hauptstadt von Thailand?', 'Bangkok'),
('capitals', 3, 'Wie heißt die Hauptstadt von Schweden?', 'Stockholm'),
('capitals', 4, 'Welche Stadt ist die Hauptstadt von Finnland?', 'Helsinki'),
('capitals', 4, 'Wie heißt die Hauptstadt von Norwegen?', 'Oslo'),
('capitals', 4, 'Was ist die Hauptstadt von Südkorea?', 'Seoul'),
('capitals', 4, 'Welche Stadt ist die Hauptstadt von Argentinien?', 'Buenos Aires'),
('capitals', 5, 'Was ist die Hauptstadt von Usbekistan?', 'Taschkent'),
('capitals', 5, 'Wie heißt die Hauptstadt von Kasachstan?', 'Astana'),
('capitals', 5, 'Was ist die Hauptstadt von Bhutan?', 'Thimphu'),
('capitals', 5, 'Welche Stadt ist die Hauptstadt von Montenegro?', 'Podgorica');

-- Questions for the "chemistry" category
INSERT INTO public.game_questions (category, points, question, answer) VALUES
('chemistry', 1, 'Was ist das chemische Symbol für Sauerstoff?', 'O'),
('chemistry', 1, 'Welche Farbe hat Kupfersulfat, wenn es hydratisiert ist?', 'Blau'),
('chemistry', 1, 'Wie viele Elektronen hat ein Heliumatom?', '2'),
('chemistry', 1, 'Was ist das chemische Symbol für Wasserstoff?', 'H'),
('chemistry', 2, 'Wie lautet die chemische Formel für Wasser?', 'H2O'),
('chemistry', 2, 'Was ist das chemische Symbol für Kohlenstoff?', 'C'),
('chemistry', 2, 'Welche Säure ist in Zitronen enthalten?', 'Zitronensäure'),
('chemistry', 2, 'Was ist der pH-Wert von neutralem Wasser?', '7'),
('chemistry', 3, 'Wie heißt der Prozess, bei dem Pflanzen Sonnenlicht in Energie umwandeln?', 'Photosynthese'),
('chemistry', 3, 'Was ist die chemische Formel für Salzsäure?', 'HCl'),
('chemistry', 3, 'Welcher Wissenschaftler entwickelte das Periodensystem?', 'Dmitri Mendelejew'),
('chemistry', 3, 'Wie nennt man die chemische Bindung, bei der Elektronen geteilt werden?', 'Kovalente Bindung'),
('chemistry', 4, 'Was ist die chemische Formel für Schwefelsäure?', 'H2SO4'),
('chemistry', 4, 'Welches chemische Element hat das Symbol „Fe“?', 'Eisen'),
('chemistry', 4, 'Wie nennt man den Vorgang, bei dem ein Feststoff direkt in Gas übergeht?', 'Sublimation'),
('chemistry', 4, 'Welches chemische Element hat die Ordnungszahl 79?', 'Gold'),
('chemistry', 5, 'Was ist das chemische Symbol für Silber?', 'Ag'),
('chemistry', 5, 'Welches Gas ist das häufigste in der Erdatmosphäre?', 'Stickstoff'),
('chemistry', 5, 'Wie lautet die chemische Formel für Methan?', 'CH4'),
('chemistry', 5, 'Welche Chemikalie wird oft als Bleichmittel verwendet?', 'Natriumhypochlorit');

-- Questions for the "coding" category
INSERT INTO public.game_questions (category, points, question, answer) VALUES
('coding', 1, 'Was bedeutet HTML?', 'HyperText Markup Language'),
('coding', 1, 'Welches Symbol wird in der Programmiersprache Python für Listen verwendet?', 'Eckige Klammern []'),
('coding', 1, 'Wie nennt man eine Variable, die innerhalb einer Funktion definiert ist?', 'Lokale Variable'),
('coding', 1, 'Welche Programmiersprache wird hauptsächlich für iOS-Entwicklung verwendet?', 'Swift'),
('coding', 2, 'Was ist die Hauptaufgabe eines Compilers?', 'Übersetzen von Quellcode in Maschinensprache'),
('coding', 2, 'Wie beginnt ein Kommentar in der Programmiersprache Python?', '#'),
('coding', 2, 'Welche Schleife wird in den meisten Programmiersprachen verwendet, um Code mehrmals auszuführen?', 'For-Schleife'),
('coding', 2, 'Wie nennt man eine Funktion, die sich selbst aufruft?', 'Rekursive Funktion'),
('coding', 3, 'Was bedeutet OOP in der Programmierung?', 'Objektorientierte Programmierung'),
('coding', 3, 'Wie nennt man einen Fehler, der zur Laufzeit eines Programms auftritt?', 'Laufzeitfehler'),
('coding', 3, 'Welche Datenstruktur funktioniert nach dem Prinzip „First In, First Out“?', 'Queue'),
('coding', 3, 'Welche Programmiersprache basiert auf der JVM und wurde für bessere Produktivität als Java entwickelt?', 'Kotlin'),
('coding', 4, 'Welche SQL-Abfrage wird verwendet, um Daten in einer Tabelle zu aktualisieren?', 'UPDATE'),
('coding', 4, 'Wie nennt man das Prinzip, bei dem Funktionen und Daten in einer Klasse gekapselt werden?', 'Encapsulation'),
('coding', 4, 'Was ist der Unterschied zwischen „==“ und „===“ in JavaScript?', '„===“ prüft auch den Typ, „==“ nicht'),
('coding', 4, 'Wie nennt man eine Struktur, in der Daten in einer Baumform gespeichert sind?', 'Binärer Baum'),
('coding', 5, 'Wie nennt man das Problem, wenn ein Algorithmus immer wieder in den gleichen Zustand zurückkehrt?', 'Endlosschleife'),
('coding', 5, 'Welche Big-O-Notation repräsentiert die beste Laufzeitkomplexität?', 'O(1)'),
('coding', 5, 'Was ist der Zweck von Unit-Tests?', 'Testen einzelner Funktionen oder Module'),
('coding', 5, 'Welches Konzept in der Programmierung ermöglicht es, Verhalten durch Ableiten einer Basisklasse zu erben?', 'Vererbung');

-- Questions for the "comics" category
INSERT INTO public.game_questions (category, points, question, answer) VALUES
('comics', 1, 'Wie heißt der Alter Ego von Spider-Man?', 'Peter Parker'),
('comics', 1, 'Welcher Superheld trägt einen Schild mit einem Stern?', 'Captain America'),
('comics', 1, 'Wie heißt Batmans Stadt?', 'Gotham City'),
('comics', 1, 'Welcher Superheld hat als Markenzeichen einen grünen Ring?', 'Green Lantern'),
('comics', 2, 'Welche Superheldengruppe besteht aus vier Mitgliedern und hat den Spitznamen „Die Fantastischen Vier“?', 'Fantastic Four'),
('comics', 2, 'Wer ist der Schurke, der als „Clown Prince of Crime“ bekannt ist?', 'Joker'),
('comics', 2, 'Wie heißt die Amazonenprinzessin, die als Superheldin bekannt ist?', 'Wonder Woman'),
('comics', 2, 'Welcher Superheld hat den Spitznamen „Man of Steel“?', 'Superman'),
('comics', 3, 'Wie heißt das Unternehmen, das Spider-Man und Iron Man geschaffen hat?', 'Marvel Comics'),
('comics', 3, 'Wer ist der Erzfeind von Flash und hat die Fähigkeit, sich superschnell zu bewegen?', 'Reverse Flash'),
('comics', 3, 'Welcher Schurke hat eine Vergangenheit als Wissenschaftler namens Victor Fries?', 'Mr. Freeze'),
('comics', 3, 'Wie heißt das Alien, das Superman adoptiert hat?', 'Krypto'),
('comics', 4, 'Welcher Superheld hat als Waffe einen magischen Hammer?', 'Thor'),
('comics', 4, 'Wie nennt man den Erzfeind von Black Panther?', 'Killmonger'),
('comics', 4, 'Welches Team wird von Charles Xavier geleitet?', 'X-Men'),
('comics', 4, 'Welcher Schurke kämpft häufig gegen die Fantastic Four und ist als Victor von Doom bekannt?', 'Dr. Doom'),
('comics', 5, 'Wie heißt der Superheld, der von Alan Moore in „Watchmen“ geschaffen wurde und Zeit und Raum manipulieren kann?', 'Dr. Manhattan'),
('comics', 5, 'Welcher Superheld hat den Namen „The Dark Knight Returns“ in einer berühmten Graphic Novel?', 'Batman'),
('comics', 5, 'Welcher Schurke in den Comics hat eine symbiotische Verbindung mit Spider-Man?', 'Venom'),
('comics', 5, 'Welcher Superheld ist bekannt für seinen schwarzen Anzug und ist der Erzfeind von Spider-Man?', 'Venom');

-- Questions for the "culture" category
INSERT INTO public.game_questions (category, points, question, answer) VALUES
('culture', 1, 'Was ist die traditionelle Kleidung in Japan, die häufig bei Festen getragen wird?', 'Kimono'),
('culture', 1, 'Welches Land ist bekannt für seine Flamenco-Musik und Tänze?', 'Spanien'),
('culture', 1, 'Wie nennt man das traditionelle Fest, das das Ende des Ramadan markiert?', 'Eid al-Fitr'),
('culture', 1, 'Welche US-amerikanische Stadt ist für ihre Jazzmusik bekannt?', 'New Orleans'),
('culture', 2, 'Was ist die bekannteste Oper in Italien?', 'La Scala'),
('culture', 2, 'Wie nennt man die traditionelle indische Kleidung, die von Frauen getragen wird?', 'Sari'),
('culture', 2, 'Welche Religion feiert das Lichterfest Diwali?', 'Hinduismus'),
('culture', 2, 'Welches Land ist bekannt für das Oktoberfest?', 'Deutschland'),
('culture', 3, 'Wie heißt das traditionelle Maskenfestival in Venedig?', 'Karneval von Venedig'),
('culture', 3, 'Welche Sprache wird in Brasilien gesprochen?', 'Portugiesisch'),
('culture', 3, 'Wie nennt man die hawaiianische Tradition des Blumenkettengebens?', 'Lei'),
('culture', 3, 'Welches Land ist berühmt für seine Samurai und Geishas?', 'Japan'),
('culture', 4, 'Welche Religion hat die meisten Anhänger weltweit?', 'Christentum'),
('culture', 4, 'Wie nennt man die mexikanische Feier zu Ehren der Toten?', 'Día de los Muertos'),
('culture', 4, 'In welchem Land entstand der Tango?', 'Argentinien'),
('culture', 4, 'Welche Stadt ist bekannt für ihren Karneval mit Samba-Tänzern?', 'Rio de Janeiro'),
('culture', 5, 'Welches Land ist bekannt für das chinesische Neujahrsfest?', 'China'),
('culture', 5, 'Wie heißt die indische Gottheit mit dem Elefantenkopf?', 'Ganesha'),
('culture', 5, 'Wie nennt man die traditionelle Kunst des Papierfaltens aus Japan?', 'Origami'),
('culture', 5, 'Welche Kultur ist bekannt für ihre Totempfähle?', 'Indigene Völker Nordamerikas');

-- Questions for the "economics" category
INSERT INTO public.game_questions (category, points, question, answer) VALUES
('economics', 1, 'Was ist das Bruttoinlandsprodukt (BIP)?', 'Der Gesamtwert aller produzierten Güter und Dienstleistungen eines Landes in einem Jahr.'),
('economics', 1, 'Wie nennt man den allgemeinen Anstieg des Preisniveaus über einen Zeitraum?', 'Inflation'),
('economics', 1, 'Welches Konzept beschreibt die Kosten einer entgangenen Alternative?', 'Opportunitätskosten'),
('economics', 1, 'Welcher Begriff beschreibt eine Situation, in der es nur einen Anbieter auf dem Markt gibt?', 'Monopol'),
('economics', 2, 'Welche Organisation ist verantwortlich für die Überwachung des globalen Handels?', 'Welthandelsorganisation (WTO)'),
('economics', 2, 'Wie nennt man das Gegenteil von Inflation, bei dem das Preisniveau sinkt?', 'Deflation'),
('economics', 2, 'Welches Gesetz beschreibt das Verhältnis zwischen Angebot und Nachfrage?', 'Gesetz von Angebot und Nachfrage'),
('economics', 2, 'Wie heißt die Theorie, die den freien Markt als effizient betrachtet?', 'Marktwirtschaftstheorie'),
('economics', 3, 'Was ist der Unterschied zwischen nominalem und realem BIP?', 'Das reale BIP ist inflationsbereinigt, das nominale nicht.'),
('economics', 3, 'Welche Art von Steuer wird direkt auf das Einkommen erhoben?', 'Einkommensteuer'),
('economics', 3, 'Welche Organisation kontrolliert die Geldpolitik in der Eurozone?', 'Europäische Zentralbank (EZB)'),
('economics', 3, 'Wie nennt man eine Periode wirtschaftlichen Rückgangs über mindestens zwei aufeinanderfolgende Quartale?', 'Rezession'),
('economics', 4, 'Welche Wirtschaftstheorie wurde von John Maynard Keynes entwickelt?', 'Keynesianismus'),
('economics', 4, 'Was bedeutet der Begriff „Marktversagen“?', 'Eine Situation, in der der Markt Ressourcen ineffizient verteilt.'),
('economics', 4, 'Wie nennt man den maximalen Preis, der gesetzlich für ein Produkt festgelegt werden kann?', 'Höchstpreis'),
('economics', 4, 'Welches Konzept beschreibt die zusätzliche Befriedigung, die durch den Konsum einer weiteren Einheit eines Gutes entsteht?', 'Grenznutzen'),
('economics', 5, 'Was ist die Theorie der komparativen Vorteile?', 'Die Theorie, dass Länder sich auf die Produktion von Gütern spezialisieren sollten, bei denen sie die geringsten Opportunitätskosten haben.'),
('economics', 5, 'Was bedeutet „Quantitative Lockerung“?', 'Eine Geldpolitik, bei der die Zentralbank Anleihen kauft, um die Wirtschaft zu stimulieren.'),
('economics', 5, 'Wie heißt der Prozess, bei dem staatliche Unternehmen in private Hände übergehen?', 'Privatisierung'),
('economics', 5, 'Was ist das Hauptziel der Geldpolitik?', 'Die Stabilisierung der Währung und Kontrolle der Inflation.');

-- Questions for the "famous_people" category
INSERT INTO public.game_questions (category, points, question, answer) VALUES
('famous_people', 1, 'Wer sagte den berühmten Satz „Ich habe einen Traum“?', 'Martin Luther King Jr.'),
('famous_people', 1, 'Wer war der erste Präsident der Vereinigten Staaten?', 'George Washington'),
('famous_people', 1, 'Wer ist bekannt als der Entdecker Amerikas im Jahr 1492?', 'Christoph Kolumbus'),
('famous_people', 1, 'Wer hat die Relativitätstheorie entwickelt?', 'Albert Einstein'),
('famous_people', 2, 'Wer war die erste Frau, die einen Nobelpreis erhielt?', 'Marie Curie'),
('famous_people', 2, 'Wer malte die Mona Lisa?', 'Leonardo da Vinci'),
('famous_people', 2, 'Welcher britische Premierminister führte das Vereinigte Königreich durch den Zweiten Weltkrieg?', 'Winston Churchill'),
('famous_people', 2, 'Wer schrieb „Romeo und Julia“?', 'William Shakespeare'),
('famous_people', 3, 'Wer leitete die Bürgerrechtsbewegung in Indien und war bekannt für gewaltfreien Widerstand?', 'Mahatma Gandhi'),
('famous_people', 3, 'Welcher Physiker wird als Vater der modernen Wissenschaft bezeichnet?', 'Galileo Galilei'),
('famous_people', 3, 'Welcher Künstler schnitt sich das Ohr ab?', 'Vincent van Gogh'),
('famous_people', 3, 'Wer entdeckte die Penicillin?', 'Alexander Fleming'),
('famous_people', 4, 'Wer war der erste Mensch auf dem Mond?', 'Neil Armstrong'),
('famous_people', 4, 'Wer war die erste afroamerikanische Frau im US-Senat?', 'Carol Moseley Braun'),
('famous_people', 4, 'Wer ist der Erfinder des Telefons?', 'Alexander Graham Bell'),
('famous_people', 4, 'Wer war der Führer der Sowjetunion während des Kalten Krieges?', 'Joseph Stalin'),
('famous_people', 5, 'Wer schrieb die „Divina Commedia“?', 'Dante Alighieri'),
('famous_people', 5, 'Welcher antike Philosoph war der Lehrer von Alexander dem Großen?', 'Aristoteles'),
('famous_people', 5, 'Wer war die erste Frau, die einen Raumflug unternahm?', 'Valentina Tereshkova'),
('famous_people', 5, 'Welcher Physiker ist für die Quantenmechanik bekannt und formulierte die Schrödinger-Gleichung?', 'Erwin Schrödinger');

-- Questions for the "food_and_drinks" category
INSERT INTO public.game_questions (category, points, question, answer) VALUES
('food_and_drinks', 1, 'Was ist das Hauptgetreide in Sushi?', 'Reis'),
('food_and_drinks', 1, 'Welche Frucht ist bekannt als „König der Früchte“?', 'Durian'),
('food_and_drinks', 1, 'Welches Getränk wird aus fermentierten Trauben hergestellt?', 'Wein'),
('food_and_drinks', 1, 'Was ist das wichtigste Gewürz in der indischen Küche?', 'Kurkuma'),
('food_and_drinks', 2, 'Welches Land ist bekannt für seinen Parmesan-Käse?', 'Italien'),
('food_and_drinks', 2, 'Wie heißt das französische Gericht aus geschichteten Kartoffeln mit Sahne und Käse?', 'Gratin Dauphinois'),
('food_and_drinks', 2, 'Welches Getränk wird in Japan traditionell warm serviert?', 'Sake'),
('food_and_drinks', 2, 'Wie nennt man das spanische Gericht aus Reis, Meeresfrüchten und Gewürzen?', 'Paella'),
('food_and_drinks', 3, 'Wie heißt die japanische Kunst des Schneidens und Servierens von rohem Fisch?', 'Sashimi'),
('food_and_drinks', 3, 'Welches Gewürz ist das teuerste der Welt?', 'Safran'),
('food_and_drinks', 3, 'Welches Land ist bekannt für Kimchi?', 'Südkorea'),
('food_and_drinks', 3, 'Welches Getränk wird durch Röstung von Bohnen hergestellt?', 'Kaffee'),
('food_and_drinks', 4, 'Wie nennt man die Technik, Speisen unter Vakuum und bei niedrigen Temperaturen zu garen?', 'Sous-vide'),
('food_and_drinks', 4, 'Wie heißt die italienische Vorspeise aus rohem Rindfleisch?', 'Carpaccio'),
('food_and_drinks', 4, 'Welches Getränk wird aus Hopfen, Gerste und Hefe hergestellt?', 'Bier'),
('food_and_drinks', 4, 'Wie nennt man das spanische Gericht aus kalter Tomatensuppe?', 'Gazpacho'),
('food_and_drinks', 5, 'Wie nennt man das Verfahren, mit dem Weinbrand hergestellt wird?', 'Destillation'),
('food_and_drinks', 5, 'Welches Land ist für Foie Gras bekannt?', 'Frankreich'),
('food_and_drinks', 5, 'Wie nennt man die Technik, Speisen in einem mit Wein oder Brühe verschlossenen Tongefäß zu garen?', 'Schmortopf'),
('food_and_drinks', 5, 'Welches alkoholische Getränk wird traditionell in Schottland destilliert?', 'Whisky');

-- Questions for the "geography" category
INSERT INTO public.game_questions (category, points, question, answer) VALUES
('geography', 1, 'Wie heißt der längste Fluss der Welt?', 'Nil'),
('geography', 1, 'Welcher Kontinent ist der größte der Erde?', 'Asien'),
('geography', 1, 'In welchem Land befinden sich die Pyramiden von Gizeh?', 'Ägypten'),
('geography', 1, 'Welcher Berg ist der höchste der Welt?', 'Mount Everest'),
('geography', 2, 'Wie heißt die Hauptstadt von Australien?', 'Canberra'),
('geography', 2, 'Welcher Fluss fließt durch Paris?', 'Seine'),
('geography', 2, 'In welchem Land liegt die Stadt Venedig?', 'Italien'),
('geography', 2, 'Welches Land hat die meisten Nachbarländer?', 'China'),
('geography', 3, 'Wie nennt man die Landmasse, auf der sich Europa und Asien befinden?', 'Eurasien'),
('geography', 3, 'In welchem Land befinden sich die Rocky Mountains?', 'USA'),
('geography', 3, 'Welches Land hat die längste Küstenlinie?', 'Kanada'),
('geography', 3, 'Wie heißt die Wüste, die den größten Teil Nordafrikas bedeckt?', 'Sahara'),
('geography', 4, 'In welchem Land liegt der Baikalsee?', 'Russland'),
('geography', 4, 'Wie heißt die Hauptstadt von Südafrika?', 'Pretoria, Kapstadt und Bloemfontein'),
('geography', 4, 'Welches Land hat die meisten aktiven Vulkane?', 'Indonesien'),
('geography', 4, 'Welcher Fluss ist der längste in Europa?', 'Wolga'),
('geography', 5, 'Wie nennt man den Ort, an dem sich die Grenzen von Norwegen, Schweden und Finnland treffen?', 'Dreiländereck Lappland'),
('geography', 5, 'Welches Land besteht aus über 17.000 Inseln?', 'Indonesien'),
('geography', 5, 'Wie heißt das größte Korallenriff der Welt?', 'Great Barrier Reef'),
('geography', 5, 'Welche Stadt wird auch „Stadt der sieben Hügel“ genannt?', 'Rom');

-- Questions for the "history" category
INSERT INTO public.game_questions (category, points, question, answer) VALUES
('history', 1, 'Wann begann der Zweite Weltkrieg?', '1939'),
('history', 1, 'Wer war der erste römische Kaiser?', 'Augustus'),
('history', 1, 'In welchem Jahr fiel die Berliner Mauer?', '1989'),
('history', 1, 'Wer war der berühmteste Pharao des Alten Ägyptens?', 'Tutanchamun'),
('history', 2, 'Was war der Name des Schiffs, das 1620 die Pilgerväter nach Amerika brachte?', 'Mayflower'),
('history', 2, 'Wer schrieb die „95 Thesen“ und leitete damit die Reformation ein?', 'Martin Luther'),
('history', 2, 'In welchem Jahr wurde die Französische Revolution ausgelöst?', '1789'),
('history', 2, 'Wie hieß der Vertrag, der den Ersten Weltkrieg beendete?', 'Vertrag von Versailles'),
('history', 3, 'Welches Land war im Mittelalter für seine Samurai-Kultur bekannt?', 'Japan'),
('history', 3, 'Wer war der Anführer der Mongolen, der ein riesiges Reich errichtete?', 'Dschingis Khan'),
('history', 3, 'Welches historische Ereignis wird als „Schwarzer Tod“ bezeichnet?', 'Die Pestpandemie im Mittelalter'),
('history', 3, 'Welcher britische König war bekannt für seine sechs Ehefrauen?', 'Heinrich VIII.'),
('history', 4, 'Wer entdeckte Amerika 1492?', 'Christoph Kolumbus'),
('history', 4, 'Wie hieß der Vertrag, der 1648 den Dreißigjährigen Krieg beendete?', 'Westfälischer Friede'),
('history', 4, 'In welchem Jahr wurde die UN gegründet?', '1945'),
('history', 4, 'Wie hieß das deutsche Kriegsschiff, das im Ersten Weltkrieg bekannt wurde?', 'Bismarck'),
('history', 5, 'Wer war der erste Präsident der Vereinigten Staaten?', 'George Washington'),
('history', 5, 'Welches Land wurde 1867 Teil des Deutschen Kaiserreichs?', 'Elsass-Lothringen'),
('history', 5, 'Wie hieß die alte Handelsroute zwischen China und Europa?', 'Seidenstraße'),
('history', 5, 'Welcher Krieg dauerte 116 Jahre?', 'Hundertjähriger Krieg');

-- Questions for the "languages" category
INSERT INTO public.game_questions (category, points, question, answer) VALUES
('languages', 1, 'Welche Sprache wird in Brasilien gesprochen?', 'Portugiesisch'),
('languages', 1, 'Wie viele Buchstaben hat das englische Alphabet?', '26'),
('languages', 1, 'Welche Sprache hat die meisten Muttersprachler?', 'Mandarin'),
('languages', 1, 'In welchem Land wird hauptsächlich Hindi gesprochen?', 'Indien'),
('languages', 2, 'Wie viele Fälle gibt es in der deutschen Sprache?', 'Vier'),
('languages', 2, 'Was ist die Amtssprache von Argentinien?', 'Spanisch'),
('languages', 2, 'Wie nennt man die Wissenschaft der Sprache?', 'Linguistik'),
('languages', 2, 'Welche Sprache verwendet das Kyrillische Alphabet?', 'Russisch'),
('languages', 3, 'Wie viele Amtssprachen hat die Schweiz?', 'Vier'),
('languages', 3, 'Was bedeutet das Wort „Bonjour“ auf Deutsch?', 'Guten Tag'),
('languages', 3, 'Welches Land hat zwei Amtssprachen: Französisch und Englisch?', 'Kanada'),
('languages', 3, 'Welche Sprache wird als „Sprache der Liebe“ bezeichnet?', 'Französisch'),
('languages', 4, 'Wie heißt das Schriftsystem, das in Japan verwendet wird?', 'Kanji'),
('languages', 4, 'Was ist die offizielle Sprache in Äthiopien?', 'Amharisch'),
('languages', 4, 'Wie nennt man eine Sprache, die in einer bestimmten Region gesprochen wird?', 'Dialekt'),
('languages', 4, 'Welches Land ist für die Sprache Swahili bekannt?', 'Tansania'),
('languages', 5, 'Was ist die älteste bekannte Schriftsprache der Welt?', 'Sumerisch'),
('languages', 5, 'Welche Sprache wird hauptsächlich in Iran gesprochen?', 'Persisch (Farsi)'),
('languages', 5, 'Wie heißt das Schriftsystem des alten Ägyptens?', 'Hieroglyphen'),
('languages', 5, 'Welche Sprache hat das längste Alphabet der Welt?', 'Khmer (Kambodscha)');

-- Questions for the "league_of_legends" category
INSERT INTO public.game_questions (category, points, question, answer) VALUES
('league_of_legends', 1, 'Wie viele Champions gab es bei der Veröffentlichung von League of Legends?', '40'),
('league_of_legends', 1, 'Was ist der Name des Hauptentwicklers von League of Legends?', 'Riot Games'),
('league_of_legends', 1, 'Wie heißt die Währung, mit der Spieler Champions kaufen können?', 'Blue Essence'),
('league_of_legends', 1, 'Welcher Champion ist bekannt als der „Krakenpriester“?', 'Illaoi'),
('league_of_legends', 2, 'Wie viele Lanes gibt es auf der Standardkarte „Kluft der Beschwörer“?', 'Drei'),
('league_of_legends', 2, 'Wie heißt der Drache, der Bonuseffekte wie zusätzlichen Schaden bietet?', 'Elementardrache'),
('league_of_legends', 2, 'Was ist der Name der Region, aus der Jinx stammt?', 'Zhaun'),
('league_of_legends', 2, 'Welcher Champion wird oft als „Blinder Mönch“ bezeichnet?', 'Lee Sin'),
('league_of_legends', 3, 'Welche Rolle spielt Thresh üblicherweise?', 'Support'),
('league_of_legends', 3, 'Was ist der Name des epischen Monsters in der Mitte der Karte?', 'Baron Nashor'),
('league_of_legends', 3, 'Welcher Champion ist für seine ultimative Fähigkeit „Realm Warp“ bekannt?', 'Ryze'),
('league_of_legends', 3, 'Welcher Champion kann durch das Töten von Vasallen Bonusleben sammeln?', 'Cho''Gath'),
('league_of_legends', 4, 'Wie heißt die Fähigkeit, die es Champions erlaubt, über die Karte zu teleportieren?', 'Beschwörerzauber „Teleport“'),
('league_of_legends', 4, 'Was ist die maximale Stufe, die ein Champion im Spiel erreichen kann?', '18'),
('league_of_legends', 4, 'Welche Fähigkeit gibt Yasuo eine Schildaufladung?', 'Way of the Wanderer (Passiv)'),
('league_of_legends', 4, 'Welches Item gibt kritischen Treffer und Angriffstempo?', 'Phantomtänzer'),
('league_of_legends', 5, 'Wie viele Spieler sind in einem Standard-5v5-Spiel?', 'Zehn'),
('league_of_legends', 5, 'Welcher Champion wird oft mit dem Zitat „Demacia!“ assoziiert?', 'Garen'),
('league_of_legends', 5, 'Welcher Gegenstand reduziert die Heilung von Gegnern?', 'Morellonomicon'),
('league_of_legends', 5, 'Wie viele verschiedene Drachenseelen gibt es?', 'Vier');

-- Questions for the "literature" category
INSERT INTO public.game_questions (category, points, question, answer) VALUES
('literature', 1, 'Wer schrieb „Die Verwandlung“?', 'Franz Kafka'),
('literature', 1, 'Welches Buch beginnt mit dem Satz „Es war die beste aller Zeiten, es war die schlechteste aller Zeiten“?', 'Eine Geschichte aus zwei Städten (Charles Dickens)'),
('literature', 1, 'Welches Werk wird oft als das erste moderne Roman bezeichnet?', 'Don Quijote von Miguel de Cervantes'),
('literature', 1, 'Wer schrieb „Stolz und Vorurteil“?', 'Jane Austen'),
('literature', 2, 'Welches Buch erzählt die Geschichte von Bilbo Beutlin?', 'Der Hobbit'),
('literature', 2, 'Wer ist der Autor von „1984“?', 'George Orwell'),
('literature', 2, 'Welcher deutsche Autor schrieb „Faust“?', 'Johann Wolfgang von Goethe'),
('literature', 2, 'Wer schrieb „Die Odyssee“?', 'Homer'),
('literature', 3, 'Welcher Autor schrieb „Der Herr der Ringe“?', 'J.R.R. Tolkien'),
('literature', 3, 'Welches Buch von Mark Twain erzählt die Geschichte eines Jungen und eines entlaufenen Sklaven?', 'Die Abenteuer von Huckleberry Finn'),
('literature', 3, 'Wie heißt die Hauptfigur in „Moby Dick“?', 'Kapitän Ahab'),
('literature', 3, 'Wer schrieb „Der kleine Prinz“?', 'Antoine de Saint-Exupéry'),
('literature', 4, 'Welches berühmte Werk wurde von Gabriel García Márquez geschrieben?', 'Hundert Jahre Einsamkeit'),
('literature', 4, 'Wer schrieb die Tragödie „Macbeth“?', 'William Shakespeare'),
('literature', 4, 'Wie lautet der Nachname der Autorin der „Harry Potter“-Reihe?', 'Rowling'),
('literature', 4, 'Welches Werk beschreibt die dystopische Welt von „Big Brother“?', '1984'),
('literature', 5, 'Wer ist die Autorin von „Frankenstein“?', 'Mary Shelley'),
('literature', 5, 'Welches Werk wird als „der erste Science-Fiction-Roman“ angesehen?', 'Frankenstein'),
('literature', 5, 'Welches Werk ist ein berühmtes Beispiel für mittelalterliche Dichtung?', 'Die Göttliche Komödie von Dante Alighieri'),
('literature', 5, 'Wer schrieb „Krieg und Frieden“?', 'Leo Tolstoi');

-- Questions for the "math" category
INSERT INTO public.game_questions (category, points, question, answer) VALUES
('math', 1, 'Was ist 2 + 2?', '4'),
('math', 1, 'Wie viele Seiten hat ein Quadrat?', 'Vier'),
('math', 1, 'Wie nennt man eine gerade Linie, die eine Kurve berührt?', 'Tangente'),
('math', 1, 'Was ist das Ergebnis von 10 geteilt durch 2?', '5'),
('math', 2, 'Wie viele Grade hat ein rechtwinkliges Dreieck?', '90 Grad'),
('math', 2, 'Was ist der Wert von Pi bis zwei Dezimalstellen?', '3,14'),
('math', 2, 'Was ist 5 × 5?', '25'),
('math', 2, 'Wie nennt man den längsten Durchmesser eines Kreises?', 'Durchmesser'),
('math', 3, 'Was ist die Quadratwurzel von 81?', '9'),
('math', 3, 'Wie lautet die Formel für den Umfang eines Kreises?', '2 × Pi × Radius'),
('math', 3, 'Wie nennt man eine sechsseitige Figur?', 'Hexagon'),
('math', 3, 'Was ist 7 × 8?', '56'),
('math', 4, 'Was ist der Wert von 2 hoch 10?', '1024'),
('math', 4, 'Was ist der Unterschied zwischen einer Parabel und einer Hyperbel?', 'Eine Parabel hat einen Brennpunkt, eine Hyperbel zwei.'),
('math', 4, 'Wie lautet die Formel für die Fläche eines Dreiecks?', '0,5 × Basis × Höhe'),
('math', 4, 'Wie lautet die Formel für die Berechnung der mittleren Geschwindigkeit?', 'Strecke ÷ Zeit'),
('math', 5, 'Was ist die Ableitung von x²?', '2x'),
('math', 5, 'Was ist der natürliche Logarithmus von e?', '1'),
('math', 5, 'Wie lautet die Formel für den Satz des Pythagoras?', 'a² + b² = c²'),
('math', 5, 'Was ist die Determinante einer 2x2-Matrix mit Werten a, b, c, d?', 'ad - bc');

-- Questions for the "movies" category
INSERT INTO public.game_questions (category, points, question, answer) VALUES
('movies', 1, 'Wer spielte die Hauptrolle in „Forrest Gump“?', 'Tom Hanks'),
('movies', 1, 'In welchem Film sagt Darth Vader: „Ich bin dein Vater“?', 'Das Imperium schlägt zurück'),
('movies', 1, 'Welcher Film gewann den Oscar für den besten Film im Jahr 1997?', 'Titanic'),
('movies', 1, 'Wie heißt der sprechende Waschbär in „Guardians of the Galaxy“?', 'Rocket'),
('movies', 2, 'Wer führte Regie bei „Pulp Fiction“?', 'Quentin Tarantino'),
('movies', 2, 'Wie lautet der Name des Rings in „Der Herr der Ringe“?', 'Der Eine Ring'),
('movies', 2, 'Welcher Film handelt von einem Highschool-Schüler namens Marty McFly?', 'Zurück in die Zukunft'),
('movies', 2, 'Wie heißt der Bösewicht im Film „The Dark Knight“?', 'Joker'),
('movies', 3, 'In welchem Film reist Dorothy nach Oz?', 'Der Zauberer von Oz'),
('movies', 3, 'Welcher Animationsfilm spielt in einem Land voller Erinnerungen und verstorbener Seelen?', 'Coco'),
('movies', 3, 'Wie heißt der Regisseur von „Schindlers Liste“?', 'Steven Spielberg'),
('movies', 3, 'Welcher Film hat den Slogan „In space no one can hear you scream“?', 'Alien'),
('movies', 4, 'Welcher Film gewann den Oscar für den besten Film im Jahr 2020?', 'Parasite'),
('movies', 4, 'Wer spielte den Joker in „The Dark Knight“?', 'Heath Ledger'),
('movies', 4, 'In welchem Film gibt es ein Raumschiff namens Nostromo?', 'Alien'),
('movies', 4, 'Wie lautet der Name der Filmreihe mit John Wick?', 'John Wick'),
('movies', 5, 'Wie viele Filme umfasst die ursprüngliche „Star Wars“-Trilogie?', 'Drei'),
('movies', 5, 'Wer führte Regie bei „Inception“?', 'Christopher Nolan'),
('movies', 5, 'Welcher Film von Studio Ghibli hat eine Figur namens Totoro?', 'Mein Nachbar Totoro'),
('movies', 5, 'Wie lautet der Name des Films, der auf Stephen Kings „The Shining“ basiert?', 'The Shining');

-- Questions for the "music" category
INSERT INTO public.game_questions (category, points, question, answer) VALUES
('music', 1, 'Wer ist als „King of Pop“ bekannt?', 'Michael Jackson'),
('music', 1, 'Welche Farbe hat das Album „The White Album“ von den Beatles?', 'Weiß'),
('music', 1, 'Welches Instrument spielt man bei einem Klavierkonzert?', 'Klavier'),
('music', 1, 'Wer schrieb „Für Elise“?', 'Ludwig van Beethoven'),
('music', 2, 'Wie lautet der Künstlername von Marshall Mathers?', 'Eminem'),
('music', 2, 'Welches berühmte Festival fand 1969 statt?', 'Woodstock'),
('music', 2, 'Welche Band hat den Song „Bohemian Rhapsody“ veröffentlicht?', 'Queen'),
('music', 2, 'Wer sang den Hit „Rolling in the Deep“?', 'Adele'),
('music', 3, 'Wie heißt das Musikinstrument mit sechs Saiten?', 'Gitarre'),
('music', 3, 'Welche klassische Komposition wird oft als „Beethovens Fünfte“ bezeichnet?', 'Symphonie Nr. 5 in c-Moll'),
('music', 3, 'Wie heißt die südkoreanische Band, die für „Dynamite“ bekannt ist?', 'BTS'),
('music', 3, 'Wer ist der Komponist der Oper „Die Zauberflöte“?', 'Wolfgang Amadeus Mozart'),
('music', 4, 'Welches musikalische Genre wurde mit Bob Marley populär?', 'Reggae'),
('music', 4, 'Wie lautet der Nachname des Komponisten Johann Sebastian?', 'Bach'),
('music', 4, 'Welche Band veröffentlichte das Album „Dark Side of the Moon“?', 'Pink Floyd'),
('music', 4, 'Welcher deutsche Komponist schrieb „Carmina Burana“?', 'Carl Orff'),
('music', 5, 'Wer ist bekannt für die Symphonie „Die Neunte“?', 'Ludwig van Beethoven'),
('music', 5, 'Welcher Künstler veröffentlichte das Album „Thriller“?', 'Michael Jackson'),
('music', 5, 'Wer schrieb das berühmte Stück „Clair de Lune“?', 'Claude Debussy'),
('music', 5, 'Welcher Musiker wird oft als „Der Boss“ bezeichnet?', 'Bruce Springsteen');

-- Questions for the "mythology" category
INSERT INTO public.game_questions (category, points, question, answer) VALUES
('mythology', 1, 'Wer ist der Gott des Donners in der nordischen Mythologie?', 'Thor'),
('mythology', 1, 'Wie heißt die griechische Göttin der Liebe?', 'Aphrodite'),
('mythology', 1, 'Wer ist der Hauptgott in der griechischen Mythologie?', 'Zeus'),
('mythology', 1, 'Wie heißt der Fluss, der in der griechischen Mythologie die Unterwelt umfließt?', 'Styx'),
('mythology', 2, 'Wie heißt das geflügelte Pferd in der griechischen Mythologie?', 'Pegasus'),
('mythology', 2, 'Wer ist der römische Gott des Krieges?', 'Mars'),
('mythology', 2, 'Wie heißen die Götter, die auf dem Olymp wohnen?', 'Olympier'),
('mythology', 2, 'Wer tötete den Minotaurus in der griechischen Mythologie?', 'Theseus'),
('mythology', 3, 'Wie heißt der Gott der Unterwelt in der griechischen Mythologie?', 'Hades'),
('mythology', 3, 'Welche Göttin ist bekannt als Beschützerin der Jagd?', 'Artemis'),
('mythology', 3, 'Wer ist der Vater von Herkules?', 'Zeus'),
('mythology', 3, 'Wie heißt die Göttin des Sieges in der griechischen Mythologie?', 'Nike'),
('mythology', 4, 'Wie heißt der Allvater der nordischen Mythologie?', 'Odin'),
('mythology', 4, 'Wer war der Hauptgegner der Götter in der griechischen Mythologie?', 'Titanen'),
('mythology', 4, 'Wie heißt die nordische Welt der Götter?', 'Asgard'),
('mythology', 4, 'Wie heißt die griechische Göttin der Weisheit?', 'Athene'),
('mythology', 5, 'Wer ist der ägyptische Gott der Toten?', 'Anubis'),
('mythology', 5, 'Wie heißt die nordische Schlange, die die Welt umspannt?', 'Jörmungandr'),
('mythology', 5, 'Welche Göttin war die Gemahlin von Hades?', 'Persephone'),
('mythology', 5, 'Wer war der griechische Held, der die Stadt Troja eroberte?', 'Odysseus');

-- Questions for the "nature" category
INSERT INTO public.game_questions (category, points, question, answer) VALUES
('nature', 1, 'Wie nennt man die Wissenschaft der Pflanzen?', 'Botanik'),
('nature', 1, 'Welches ist das größte Tier der Welt?', 'Blauwal'),
('nature', 1, 'Wie viele Beine hat eine Spinne?', 'Acht'),
('nature', 1, 'Welcher Baum produziert Eicheln?', 'Eiche'),
('nature', 2, 'Welches ist das schnellste Landtier der Welt?', 'Gepard'),
('nature', 2, 'Wie lautet der Begriff für die Lehre von den Vögeln?', 'Ornithologie'),
('nature', 2, 'Welches Tier ist bekannt für das Bauen von Dämmen?', 'Biber'),
('nature', 2, 'Welches ist das höchste Gebirge der Welt?', 'Himalaya'),
('nature', 3, 'Wie viele Herzen hat ein Tintenfisch?', 'Drei'),
('nature', 3, 'Wie lautet der wissenschaftliche Name des Menschen?', 'Homo sapiens'),
('nature', 3, 'Welches Tier hat einen blauen Blutkreislauf?', 'Hufeisenkrebs'),
('nature', 3, 'Welcher Vogel kann rückwärts fliegen?', 'Kolibri'),
('nature', 4, 'Wie heißt die größte Wüste der Erde?', 'Antarktische Wüste'),
('nature', 4, 'Welches Tier hat den längsten Lebenszyklus?', 'Grönlandhai'),
('nature', 4, 'Wie viele Kontinente gibt es?', 'Sieben'),
('nature', 4, 'Welches Gas ist am häufigsten in der Erdatmosphäre vorhanden?', 'Stickstoff'),
('nature', 5, 'Welcher Baum kann über 2000 Jahre alt werden?', 'Mammutbaum'),
('nature', 5, 'Welches Tier legt die größten Eier der Welt?', 'Strauß'),
('nature', 5, 'Wie nennt man Tiere, die nachts aktiv sind?', 'Nachtaktiv'),
('nature', 5, 'Welcher Planet wird auch als „Roter Planet“ bezeichnet?', 'Mars');

-- Questions for the "physics" category
INSERT INTO public.game_questions (category, points, question, answer) VALUES
('physics', 1, 'Welche Einheit misst elektrische Stromstärke?', 'Ampere'),
('physics', 1, 'Was ist der häufigste Zustand der Materie im Universum?', 'Plasma'),
('physics', 1, 'Was fällt schneller: Eine Feder oder ein Stein im Vakuum?', 'Beide gleich schnell'),
('physics', 1, 'Wie lautet die Formel für Geschwindigkeit?', 'Strecke ÷ Zeit'),
('physics', 2, 'Wie lautet der Name des Physikers, der die Relativitätstheorie entwickelte?', 'Albert Einstein'),
('physics', 2, 'Was ist die Einheit für Energie?', 'Joule'),
('physics', 2, 'Wie lautet die Formel für Kraft?', 'Masse × Beschleunigung'),
('physics', 2, 'Was ist der dritte Newtonsche Bewegungssatz?', 'Aktion = Reaktion'),
('physics', 3, 'Welches Teilchen hat eine negative Ladung?', 'Elektron'),
('physics', 3, 'Was ist der Name des Geräts, das Schallwellen sichtbar macht?', 'Oszilloskop'),
('physics', 3, 'Wie lautet die Lichtgeschwindigkeit im Vakuum?', '299.792.458 m/s'),
('physics', 3, 'Welche Physikdisziplin beschäftigt sich mit Wärme und Temperatur?', 'Thermodynamik'),
('physics', 4, 'Was ist der Hauptunterschied zwischen Masse und Gewicht?', 'Masse ist unabhängig von der Schwerkraft, Gewicht nicht.'),
('physics', 4, 'Was misst ein Barometer?', 'Luftdruck'),
('physics', 4, 'Wie heißt der Effekt, der Licht in einem Prisma aufspaltet?', 'Dispersion'),
('physics', 4, 'Wie nennt man die kleinstmögliche Energieeinheit?', 'Quanten'),
('physics', 5, 'Was ist die Heisenbergsche Unschärferelation?', 'Man kann Ort und Impuls eines Teilchens nicht gleichzeitig genau bestimmen.'),
('physics', 5, 'Wie lautet die Formel für die kinetische Energie?', '0,5 × Masse × Geschwindigkeit²'),
('physics', 5, 'Welches Teilchen vermittelt die elektromagnetische Kraft?', 'Photon'),
('physics', 5, 'Welcher Wissenschaftler entdeckte die Gravitation?', 'Isaac Newton');

-- Questions for the "politics" category
INSERT INTO public.game_questions (category, points, question, answer) VALUES
('politics', 1, 'Wer ist die Bundeskanzlerin von Deutschland im Jahr 2021?', 'Angela Merkel'),
('politics', 1, 'Wie viele Sterne hat die Flagge der Europäischen Union?', 'Zwölf'),
('politics', 1, 'Welcher US-Präsident ist auf der 1-Dollar-Note abgebildet?', 'George Washington'),
('politics', 1, 'Welches Land hat das älteste noch bestehende Parlament der Welt?', 'Island'),
('politics', 2, 'Wer ist der derzeitige Generalsekretär der Vereinten Nationen?', 'António Guterres'),
('politics', 2, 'Wie lautet der Name des Parlaments in Großbritannien?', 'House of Commons'),
('politics', 2, 'Welcher Vertrag legte den Grundstein für die Europäische Union?', 'Vertrag von Maastricht'),
('politics', 2, 'Welches Land wird von einem Premierminister regiert?', 'Kanada'),
('politics', 3, 'Wie viele Mitglieder hat der US-Senat?', '100'),
('politics', 3, 'Wer ist für die Überprüfung der Verfassungsmäßigkeit von Gesetzen in Deutschland zuständig?', 'Bundesverfassungsgericht'),
('politics', 3, 'Welches politische System basiert auf der Herrschaft des Volkes?', 'Demokratie'),
('politics', 3, 'Wie lautet der Name des US-Präsidenten im Jahr 2008?', 'Barack Obama'),
('politics', 4, 'Welche Revolution führte zur Errichtung der Sowjetunion?', 'Oktoberrevolution'),
('politics', 4, 'Was ist der Zweck des Nordatlantikvertrags (NATO)?', 'Kollektive Verteidigung'),
('politics', 4, 'Welches Land hat den „Premierminister“ als Regierungschef?', 'Vereinigtes Königreich'),
('politics', 4, 'Wie lautet die Amtszeit eines deutschen Bundespräsidenten?', 'Fünf Jahre'),
('politics', 5, 'Welches Land führt regelmäßig Volksabstimmungen zu Gesetzesfragen durch?', 'Schweiz'),
('politics', 5, 'Welcher Vertrag beendete den Ersten Weltkrieg?', 'Vertrag von Versailles'),
('politics', 5, 'Wie viele Bundesländer hat Deutschland?', '16'),
('politics', 5, 'Welche Organisation hat den Slogan „Frieden und Sicherheit“?', 'Vereinte Nationen');

-- Questions for the "science" category
INSERT INTO public.game_questions (category, points, question, answer) VALUES
('science', 1, 'Was ist die chemische Formel für Wasser?', 'H2O'),
('science', 1, 'Wie viele Planeten gibt es im Sonnensystem?', 'Acht'),
('science', 1, 'Was ist der chemische Prozess, bei dem Pflanzen Licht in Energie umwandeln?', 'Photosynthese'),
('science', 1, 'Was ist die kleinste Einheit der Materie?', 'Atom'),
('science', 2, 'Wie heißt die Theorie, die die Entstehung des Universums beschreibt?', 'Urknalltheorie'),
('science', 2, 'Welches Element ist das häufigste im Universum?', 'Wasserstoff'),
('science', 2, 'Was ist der Unterschied zwischen Geschwindigkeit und Beschleunigung?', 'Geschwindigkeit ist der Abstand pro Zeit, Beschleunigung ist die Änderung der Geschwindigkeit pro Zeit'),
('science', 2, 'Wie heißt die Krankheit, die durch das HI-Virus verursacht wird?', 'AIDS'),
('science', 3, 'Was ist das Hauptorgan des menschlichen Kreislaufsystems?', 'Herz'),
('science', 3, 'Was passiert mit dem Blut, wenn es den Körper verlässt?', 'Es gerinnt'),
('science', 3, 'Wie nennt man den Prozess, bei dem Licht von einem Objekt reflektiert wird?', 'Reflexion'),
('science', 3, 'Was ist der Unterschied zwischen einer offenen und einer geschlossenen Zelle?', 'Offene Zellen können Energie und Materie austauschen, geschlossene Zellen nicht'),
('science', 4, 'Was beschreibt das Heisenbergsche Unschärfeprinzip?', 'Es ist unmöglich, sowohl den genauen Ort als auch den Impuls eines Teilchens gleichzeitig zu messen'),
('science', 4, 'Wie nennt man das Verhalten von Wellen, die sich überlagern?', 'Interferenz'),
('science', 4, 'Was ist die häufigste Quelle von Magnetismus?', 'Bewegte Elektronen'),
('science', 4, 'Was ist der Unterschied zwischen einer Exothermen und einer Endothermen Reaktion?', 'Exotherme Reaktionen setzen Wärme frei, Endotherme Reaktionen nehmen Wärme auf'),
('science', 5, 'Was ist die Bedeutung von „E = mc²“?', 'Es beschreibt die Äquivalenz von Energie und Masse'),
('science', 5, 'Wer entwickelte die Theorie der Relativität?', 'Albert Einstein'),
('science', 5, 'Was passiert bei einer Kernfusion?', 'Atomkerne verschmelzen zu einem neuen Kern, wobei Energie freigesetzt wird'),
('science', 5, 'Wie nennt man die Entstehung von DNA aus RNA?', 'Transkription');

-- Questions for the "soccer" category
INSERT INTO public.game_questions (category, points, question, answer) VALUES
('soccer', 1, 'Welches Land gewann die Fußball-Weltmeisterschaft 2014?', 'Deutschland'),
('soccer', 1, 'Wer ist der meistgeholte Torschütze der Fußball-Weltmeisterschaften?', 'Miroslav Klose'),
('soccer', 1, 'Welche Farbe hat die Fußballkarte, die für eine harte Bestrafung vergeben wird?', 'Rot'),
('soccer', 1, 'In welchem Land wurde die erste Fußball-Weltmeisterschaft ausgetragen?', 'Uruguay'),
('soccer', 2, 'Wie viele Spieler befinden sich bei einem Standard-Fußballspiel auf dem Feld?', 'Elf'),
('soccer', 2, 'Wer ist der Rekordtorschütze der deutschen Nationalmannschaft?', 'Miroslav Klose'),
('soccer', 2, 'Welcher Verein gewann die Champions League 2020?', 'Bayern München'),
('soccer', 2, 'Welcher Fußballer ist auch als „CR7“ bekannt?', 'Cristiano Ronaldo'),
('soccer', 3, 'Welches Land hat die meisten Fußball-Weltmeisterschaften gewonnen?', 'Brasilien'),
('soccer', 3, 'Wer gewann den Ballon d''Or 2020?', 'Die Auszeichnung wurde wegen der Pandemie nicht vergeben.'),
('soccer', 3, 'Wer ist der erfolgreichste Trainer der Premier League?', 'Sir Alex Ferguson'),
('soccer', 3, 'Welcher Verein spielt im „Camp Nou“?', 'FC Barcelona'),
('soccer', 4, 'Wie viele Tore erzielte Pelé in seiner Karriere für die brasilianische Nationalmannschaft?', '77 Tore'),
('soccer', 4, 'Wie viele Mannschaften nehmen an der FIFA-Weltmeisterschaft 2022 teil?', '32 Mannschaften'),
('soccer', 4, 'Welche Mannschaft gewann den ersten „goldenen Ball“ bei einer WM?', 'Karl-Heinz Rummenigge für Deutschland, 1982'),
('soccer', 4, 'Wer ist der jüngste Spieler, der jemals ein Tor bei einer WM erzielte?', 'Pelé'),
('soccer', 5, 'Wer hält den Rekord für die meisten Tore in einer einzigen Bundesliga-Saison?', 'Gerd Müller'),
('soccer', 5, 'Welcher Spieler hielt den Rekord für die meisten Tore in einem einzigen Champions-League-Wettbewerb?', 'Cristiano Ronaldo'),
('soccer', 5, 'In welchem Jahr fand die erste FIFA-Weltmeisterschaft statt?', '1930'),
('soccer', 5, 'Welcher Spieler gewann 2019 den Ballon d''Or?', 'Lionel Messi');

-- Questions for the "space" category
INSERT INTO public.game_questions (category, points, question, answer) VALUES
('space', 1, 'Welcher Planet ist der vierte von der Sonne?', 'Mars'),
('space', 1, 'Wie heißt der erste Mensch, der den Mond betrat?', 'Neil Armstrong'),
('space', 1, 'Wie nennt man das Gerät, das Astronomen nutzen, um das Universum zu beobachten?', 'Teleskop'),
('space', 1, 'Welche Galaxie ist die der Erde am nächsten?', 'Andromedagalaxie'),
('space', 2, 'Was ist der größte Planet im Sonnensystem?', 'Jupiter'),
('space', 2, 'Was ist die größte bekannte Struktur im Universum?', 'Laniakea Supercluster'),
('space', 2, 'Welche Raumsonde besuchte Pluto im Jahr 2015?', 'New Horizons'),
('space', 2, 'Wie viele Monde hat der Planet Saturn?', '82'),
('space', 3, 'Was ist die wichtigste Energiequelle für die Sonne?', 'Kernfusion'),
('space', 3, 'Wie viele Planeten gibt es in unserem Sonnensystem?', 'Acht'),
('space', 3, 'Welche Sonde erreichte als erste den interstellaren Raum?', 'Voyager 1'),
('space', 3, 'Welche Wissenschaft beschäftigt sich mit dem Weltraum?', 'Astronomie'),
('space', 4, 'Wie heißt der bekannte Astronom, der das Teleskop revolutionierte?', 'Galileo Galilei'),
('space', 4, 'Was ist der „Event Horizon“ eines Schwarzen Lochs?', 'Der Punkt, ab dem nichts mehr entweichen kann'),
('space', 4, 'Wie heißt das Teleskop, das 1990 ins All geschickt wurde?', 'Hubble-Weltraumteleskop'),
('space', 4, 'Was bezeichnet man als „Blaue Zone“ im Universum?', 'Ein Bereich mit vielen Galaxien'),
('space', 5, 'Wie alt ist das Universum?', 'Etwa 13,8 Milliarden Jahre'),
('space', 5, 'Wie nennt man die Theorie, die die Entstehung des Universums beschreibt?', 'Urknalltheorie'),
('space', 5, 'Welche Marsmission landete 2021 erfolgreich auf dem Mars?', 'Perseverance'),
('space', 5, 'Was ist der „Schwarze Riese“?', 'Ein Stern, der durch die Schockwellen eines Supernovae kollabiert');

-- Questions for the "sports" category
INSERT INTO public.game_questions (category, points, question, answer) VALUES
('sports', 1, 'Welches Land gewann die Fußball-Weltmeisterschaft 2018?', 'Frankreich'),
('sports', 1, 'Wie viele Spieler hat eine Basketballmannschaft auf dem Feld?', 'Fünf'),
('sports', 1, 'Wie viele Runden dauert ein Boxkampf in der Regel?', 'Zwölf'),
('sports', 1, 'Welches ist das älteste Turnier im Tennis?', 'Wimbledon'),
('sports', 2, 'Wer gewann die Formel-1-Weltmeisterschaft 2020?', 'Lewis Hamilton'),
('sports', 2, 'In welchem Jahr wurde die erste Tour de France ausgetragen?', '1903'),
('sports', 2, 'Welches Land hat die meisten Olympischen Goldmedaillen gewonnen?', 'Vereinigte Staaten'),
('sports', 2, 'Wer gewann den Super Bowl 2020?', 'Kansas City Chiefs'),
('sports', 3, 'Wer hält den Rekord für die meisten Tore in der NBA?', 'Kareem Abdul-Jabbar'),
('sports', 3, 'In welchem Jahr wurden die ersten modernen Olympischen Spiele abgehalten?', '1896'),
('sports', 3, 'Wie viele Grand Slam-Titel hat Roger Federer gewonnen?', '20'),
('sports', 3, 'Wie viele Spieler hat eine Fußballmannschaft auf dem Feld?', 'Elf'),
('sports', 4, 'Wer hat den Weltrekord im 100-Meter-Lauf?', 'Usain Bolt'),
('sports', 4, 'Wie viele Siege hat Michael Schumacher in der Formel 1 erzielt?', '91'),
('sports', 4, 'Welches Land hat die meisten Weltmeistertitel im Handball?', 'Frankreich'),
('sports', 4, 'Wie viele Punkte gibt ein Touchdown im American Football?', 'Sechs'),
('sports', 5, 'Wer war der erste Mensch, der einen offiziellen Marathon in unter zwei Stunden lief?', 'Eliud Kipchoge'),
('sports', 5, 'Wie viele Tore hat Cristiano Ronaldo in seiner gesamten Karriere erzielt?', 'Über 800 Tore'),
('sports', 5, 'Welches Land hat die meisten Olympischen Goldmedaillen in der Geschichte?', 'Vereinigte Staaten'),
('sports', 5, 'Wer gewann die Fußball-Weltmeisterschaft 1998?', 'Frankreich');

-- Questions for the "technology" category
INSERT INTO public.game_questions (category, points, question, answer) VALUES
('technology', 1, 'Was ist die Abkürzung für „Künstliche Intelligenz“?', 'KI'),
('technology', 1, 'Welches Unternehmen hat das iPhone erfunden?', 'Apple'),
('technology', 1, 'Welche Programmiersprache wurde für die Entwicklung von Android verwendet?', 'Java'),
('technology', 1, 'Was ist die Bedeutung der Abkürzung „USB“?', 'Universal Serial Bus'),
('technology', 2, 'Welche Firma entwickelte die erste Festplatte?', 'IBM'),
('technology', 2, 'Was ist der Begriff für ein kleines, tragbares Speichermedium?', 'USB-Stick'),
('technology', 2, 'Wie nennt man die Geschwindigkeit, mit der Daten über das Internet übertragen werden?', 'Bandbreite'),
('technology', 2, 'Welches Unternehmen entwickelte das erste personalisierte Web-Browser?', 'Netscape'),
('technology', 3, 'Was bezeichnet man als das „Internet der Dinge“?', 'Verbindung von Alltagsgeräten mit dem Internet'),
('technology', 3, 'Was ist der Unterschied zwischen RAM und ROM?', 'RAM ist flüchtig, ROM ist nicht flüchtig'),
('technology', 3, 'Was bedeutet die Abkürzung „HTML“?', 'HyperText Markup Language'),
('technology', 3, 'Wer ist der Gründer von Microsoft?', 'Bill Gates'),
('technology', 4, 'Welche Programmiersprache wird hauptsächlich für die Webentwicklung genutzt?', 'JavaScript'),
('technology', 4, 'Was ist die Hauptfunktion eines Routers?', 'Verbindung und Weiterleitung von Daten zwischen Netzwerken'),
('technology', 4, 'Was ist der Unterschied zwischen IPv4 und IPv6?', 'IPv6 bietet mehr IP-Adressen als IPv4'),
('technology', 4, 'Was ist das größte soziale Netzwerk weltweit?', 'Facebook'),
('technology', 5, 'Wer entwickelte das erste „neuronale Netzwerk“?', 'Warren McCulloch und Walter Pitts'),
('technology', 5, 'Was ist Blockchain-Technologie?', 'Dezentrale, sichere digitale Datenbank'),
('technology', 5, 'Welche Technologie verwendet Bitcoin?', 'Blockchain'),
('technology', 5, 'Was ist der Zweck von „Cloud Computing“?', 'Speicherung und Verarbeitung von Daten über das Internet');

-- Questions for the "tv_shows" category
INSERT INTO public.game_questions (category, points, question, answer) VALUES
('tv_shows', 1, 'In welcher TV-Show lebt die Familie Simpson?', 'Die Simpsons'),
('tv_shows', 1, 'Welcher berühmte Detektiv ist die Hauptfigur in „Sherlock“?', 'Sherlock Holmes'),
('tv_shows', 1, 'In welcher Show kämpfen Teilnehmer in einem großen Haus gegeneinander?', 'Big Brother'),
('tv_shows', 1, 'Wie heißt die Hauptfigur in der Serie „Breaking Bad“?', 'Walter White'),
('tv_shows', 2, 'Wie heißt die Familie in der Serie „Family Guy“?', 'Griffin'),
('tv_shows', 2, 'In welcher Serie wird ein Hotel von einer Familie betrieben?', 'Hotel Transylvania'),
('tv_shows', 2, 'Welcher Schauspieler spielt die Hauptrolle in „The Mandalorian“?', 'Pedro Pascal'),
('tv_shows', 2, 'In welchem Land spielt die Serie „Dark“?', 'Deutschland'),
('tv_shows', 3, 'Was ist der Titel der Prequel-Serie von „Game of Thrones“?', 'House of the Dragon'),
('tv_shows', 3, 'Wie heißt der „Onkel“ in der Serie „The Fresh Prince of Bel-Air“?', 'Onkel Phil'),
('tv_shows', 3, 'Welcher Schauspieler spielte den „Doctor“ in der Serie „Doctor Who“?', 'David Tennant'),
('tv_shows', 3, 'Wie heißt die fiktive Stadt in „Stranger Things“?', 'Hawkins'),
('tv_shows', 4, 'Welche Serie wurde als die „beste Fernsehserie aller Zeiten“ bezeichnet?', 'Breaking Bad'),
('tv_shows', 4, 'Wie heißt der Hauptcharakter in „The Witcher“?', 'Geralt von Riva'),
('tv_shows', 4, 'In welcher TV-Serie ist „The Upside Down“ ein zentrales Element?', 'Stranger Things'),
('tv_shows', 4, 'Wie heißt der Berater in der Serie „House of Cards“?', 'Frank Underwood'),
('tv_shows', 5, 'Welche Serie ist für ihre komplexe Erzählweise und Zeitsprünge bekannt?', 'Westworld'),
('tv_shows', 5, 'Welche Serie wurde im „Marvel Cinematic Universe“ angesiedelt?', 'Loki'),
('tv_shows', 5, 'Wie heißt die Hauptfigur in der Serie „The Office“?', 'Michael Scott'),
('tv_shows', 5, 'Welche Serie wurde als „The Simpsons der 2000er Jahre“ bezeichnet?', 'Archer');

-- Questions for the "video_games" category
INSERT INTO public.game_questions (category, points, question, answer) VALUES
('video_games', 1, 'Welches ist das bekannteste Spiel von Nintendo?', 'Super Mario'),
('video_games', 1, 'In welchem Spiel muss man eine Prinzessin namens Zelda retten?', 'The Legend of Zelda'),
('video_games', 1, 'In welchem Spiel spielen Spieler als ein Charakter namens „Master Chief“?', 'Halo'),
('video_games', 1, 'Welches Spiel hat das berühmte Battle Royale-Modus namens „Warzone“?', 'Call of Duty'),
('video_games', 2, 'Wer ist der Erfinder der Spielreihe „Super Mario“?', 'Shigeru Miyamoto'),
('video_games', 2, 'Welches Unternehmen entwickelte das Spiel „Fortnite“?', 'Epic Games'),
('video_games', 2, 'Wie viele Pokémon gibt es in der ersten Generation?', '151'),
('video_games', 2, 'In welchem Spiel reist der Spieler durch das „Wasteland“?', 'Fallout'),
('video_games', 3, 'Wie heißt der Entwickler von „Minecraft“?', 'Mojang'),
('video_games', 3, 'Welches Spiel ist als „League of Legends“ bekannt?', 'League of Legends'),
('video_games', 3, 'Wie heißt der Hauptcharakter in der „Uncharted“-Reihe?', 'Nathan Drake'),
('video_games', 3, 'Was ist das Ziel im Spiel „Tetris“?', 'Blocke so anordnen, dass sie eine horizontale Linie ohne Lücken bilden'),
('video_games', 4, 'In welchem Spiel muss man als „Kratos“ gegen griechische Götter kämpfen?', 'God of War'),
('video_games', 4, 'Welches Spiel wurde durch die „Hunger Games“-Filme inspiriert?', 'PUBG (PlayerUnknown''s Battlegrounds)'),
('video_games', 4, 'Welches Spiel ist bekannt für seine „Vorkriegswelt“ und seinen offenen Spielbereich?', 'The Elder Scrolls V: Skyrim'),
('video_games', 4, 'Was ist die Hauptaufgabe im Spiel „Dark Souls“?', 'Die Herausforderungen des Spiels zu meistern und gegen schwierige Bosse zu kämpfen'),
('video_games', 5, 'Wie nennt man die virtuelle Welt, in der Spieler in „World of Warcraft“ interagieren?', 'Azeroth'),
('video_games', 5, 'Welches Spiel ist als der „erfolgreichste Horror-Shooter“ bekannt?', 'Resident Evil 4'),
('video_games', 5, 'In welchem Spiel geht es um das Überleben in einer von Zombies infizierten Welt?', 'The Last of Us'),
('video_games', 5, 'Welche Spielreihe ist bekannt für den legendären Satz „It''s dangerous to go alone! Take this“?', 'The Legend of Zelda');