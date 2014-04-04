def init_faqs(committee_id)
  faqs = [
      Faq.new(question: 'Kiedy i gdzie wybiera się oferty?', answer: '<p>
  Oferty wybierane są po spełnieniu wszystkich wymagań:</p>
<ol>
  <li>
    logujemy się do systemu SOSO i wpisujemy swoje oceny końcowe w ubiegłego roku studi&oacute;w,</li>
  <li>
    przychodzimy do biura IAESTE z indeksem, żeby potwierdzić wpisane dane i oceny,</li>
  <li>
    zapisujemy się na termin egzaminu z języka oraz dokonujemy opłaty za ten egzamin,</li>
  <li>
    zdajemy egzamin,</li>
  <li>
    IAESTE ogłasza listę os&oacute;b nominowanych, kt&oacute;re mają możliwość wyboru ofert.</li>
</ol>
<p>
  Oferty pojawią się w SOSO 2 dni po Konferencji Krajowej IAESTE, kt&oacute;ra odbędzie się początkiem lutego.</p>'),
      Faq.new(question: 'Na liście wyboru specjalności w SOSO nie ma takiej, która bezpośrednio odpowiadałaby mojemu kierunkowi. Studiuję [...]. Czy nie ma ofert związanych z moim kierunkiem?', answer: '<p>
  Należy przesłać informację o takim przypadku i poczekać na aktualizację listy.</p>'),
      Faq.new(question: 'Studiuję [...], są to studia dwustopniowe. W poprzednim semestrze uzyskałam tytuł inżyniera, a teraz jestem na studiach magisterskich (to jest ich drugi semestr). Czy do systemu mam wpisać oceny tylko z tego jednego semestru, który skończyłam na magisterskich, czy z całego toku studiów?', answer: '<p>
  W takim przypadku wpisujemy oceny z dw&oacute;ch ostatnich semestr&oacute;w, tj. z pierwszego semestru studi&oacute;w drugiego stopnia oraz z ostatniego semestru studi&oacute;w pierwszego stopnia.</p>'),
      Faq.new(question: 'Jak dokładnie wygląda egzamin językowy w formie ustnej i kiedy on się odbywa?', answer: 'Egzaminy językowe odbywają się początkiem stycznia. Należy się na niego zapisać w SOSO (dokładne terminy zostaną wcześniej podane).'), Faq.new(question: 'Czy zdarzają się praktyki, na które mogą wyjechać dwie osoby z tego samego kierunku, razem?', answer: '<p>
  Jest taka możliwość, jednak to, kto i gdzie pojedzie, jest uzależnione od bardzo wielu czynnik&oacute;w. W tym przypadku najważniejszym jest to jakie dostaniemy oferty praktyk w danym roku, ponieważ to firma określa wymagania i ilość os&oacute;b, kt&oacute;re zechciałaby przyjąć.</p>'),
      Faq.new(question: 'Jaki jest termin praktyk zagranicznych? Czy odbywają się one podczas wakacji, czy w roku akademickim?', answer: 'IAESTE organizuje głównie praktyki odbywające się w wakacje. Oczywiście istnieje możliwość innego terminu, ale to jest zależne od wymagań firmy oraz możliwości czasowych praktykantów. '), Faq.new(question: 'Czy studenci kończący studia pierwszego stopnia w lutym także mogą starać się o możliwość odbycia praktyk zagranicznych ?', answer: 'Oczywiście, że tak. Warunkiem jest jednak dalesze posiadanie statusu studenta. '), Faq.new(question: 'Czy jest możliwość rekrutacji na praktyki dla osoby przebywającej obecnie na Erasmusie za granicą? Czy odpowiednie dokumenty można przesłać np. drogą elektroniczną, a do potwierdzenia ocen wysłać inną osobę?', answer: '<p>
  Można rekrutować się w ten spos&oacute;b. Warunkiem jest, aby osoba potwierdzająca oceny posiadała indeks osoby starającej się o praktykę. Ponadto obowiązkowe jest pojawienie się na naszym egzaminie językowym (bądź posiadanie certyfikatu zdawania tego egzaminu w latach wcześniejszych). Brak zdanego języka dyskwalifikuje z uczestnictwa w Pierwszym Obiegu. Możliwe jest jedynie aplikowanie w Drugim Obiegu. Wtedy wystarczy potwierdzenie z SJO o ukończeniu danego poziomu języka.</p>'),
      Faq.new(question: 'Jestem obecnie na Erasmusie. Czy mogę posłużyć się wnioskiem o stypendium naukowe oraz transkryptem ocen (zatwierdzonym przez dziekanat i Dziekana Wydziału [...]) w celu potwierdzenia przedmiotów z poprzedniego roku? Mam również pytanie odnośnie egzaminu językowego, kiedy i w jaki sposób mógłbym go zaliczyć? ', answer: '<p>
  Możesz w ten spos&oacute;b potwierdzić swoje oceny. Zeskanowane dokumenty prześlij do nas mailem. Jeżeli posiadasz certyfikat zdawania u nas egzaminu w poprzednich latach, to nie musisz zdawać go ponownie. Jeśli jednak nie masz takiego dokumentu i nie bedzie Cię na egzaminie językowym (organizowanym początkiem stycznia), to niestety nie możesz brać udziału w Pierwszym Obiegu ofert praktyk. Musisz poczekać na 2 obieg.</p>'),
      Faq.new(question: 'Na 3 roku moich studiów byłam na Erasmusie. Wtedy mój rok na AGH zdawał egzamin z jednego przedmiotu, który ja zdałam dopiero na 4 roku i wtedy też został mi on wpisany do Indeksu.
Teraz jestem na 5 roku i wpisuję do rankingu oceny z 4 roku. Czy mam wpisywać także ten przedmiot?', answer: '<p>
  Do rankingu wpisujemy wszystkie końcowe oceny z poprzedniego roku studi&oacute;w, kt&oacute;re widnieją w Indeksie. Jeżeli ten przedmiot formalnie wpisany jest u Ciebie na 3 rok, to nie wpisuj go do SOSO, jeżeli jednak jest wpisany na 4 rok- musisz to zrobić.</p>'),
      Faq.new(question: 'W poprzednim roku moich studiów byłam zwolniona z zajęć wychowania fizycznego. Czy jest to brane pod uwagę i ten przedmiot nie będzie liczony do średniej, czy wliczane będzie 0?', answer: '<p>
  Jeżeli w Indeksie jest wpisane zwolnienie z przedmiotu lub zamiast oceny wpisane jest tylko &bdquo;zal.&rdquo;, to nie wpisujemy tego przedmiotu do SOSO.</p>'),
      Faq.new(question: 'Czy przekroczenie terminu rejestracji zdyskwalifikuje mnie z Pierwszego Obiegu ofert praktyk? ', answer: '<p>
  Jeżeli rejestracja została ostatecznie zamknięta, to należy czekać na Drugi Obieg ofert praktyk.</p>'),
      Faq.new(question: 'Czy informacje o egzaminie z lat ubiegłych znajdują się gdzieś w SOSO?', answer: 'Tak – taka informacja jest w systemie.'), Faq.new(question: 'Czy jest możliwość uiszczania opłat przelewem?', answer: '<p>
  Nie ma możliwości dokonania płatności przelewem, ale nie musisz tego robić osobiście, może to zrobić w Twoim imieniu dowolna osoba.</p>'),
      Faq.new(question: 'Kiedy można wybierać datę i godzinę egzaminu z języka?', answer: '<p>
  Terminy egzamin&oacute;w pojawiają się w systemie po dokładnym ustaleniu ich ze szkołą językową. Będzie określony czas na zapisy, w czasie kt&oacute;rego można dowolnie zmieniać wybrany dzień i godzinę. Ostatni dzień zapis&oacute;w jest r&oacute;wnoznaczny z ostateczną możliwością wyboru terminu egzaminu. Należy się jednak liczyć z tym, że im bliżej do końca zapis&oacute;w, tym mniej możliwości wyboru dogodnego terminu, ponieważ na daną godzinę może się zapisać określona ilość os&oacute;b. Po przekroczeniu tej liczby, przy każdej pr&oacute;bie zapisania się kolejnej osoby, pojawi się komunikat że termin ten już jest niedostępny.</p>'),
      Faq.new(question: 'Studiuję na innej uczelni. Bardzo zależy mi, aby wyjechać na staż lub praktykę. Czy program praktyk zagranicznych IAESTE dotyczy jedynie AGH? Jeśli tak, to gdzie mogę się zwrócić o pomoc?', answer: '<p>
  Praktyki, kt&oacute;rymi zajmuje się nasz Komitet Lokalny, w Pierwszym Obiegu przeznaczone są jedynie dla student&oacute;w Akademii G&oacute;rniczo - Hutniczej w Krakowie. Możesz poczekać na Drugi Obieg albo poszukać odpowiedniego Komitetu Lokalnego IAESTE na Twojej uczelni (jeśli taki istnieje).</p>'),
      Faq.new(question: 'Czy będą inne terminy, w których można wpłacić pieniądze na egzamin?', answer: 'Staramy się zapewnić dostatecznie wiele możliwości uiszczania opłat i załatwiania innych formalności, o których informujemy z odpowiednim wyprzedzeniem, dlatego nie planujemy tworzyć kolejnych terminów. Istnieje także możliwość wysłania zastępstwa. W sytuacji, gdy ktoś nie dopełnił formalności będą rozpatrywane jedynie bardzo ważne przypadki losowe. '), Faq.new(question: 'Czy będą dodatkowe terminy zdawania egzaminu językowego w tym roku? Niestety nie odpowiada mi żaden z tych podanych?', answer: 'Terminy są ustalane przez szkołę i podane do wiadomości studentów odpowiednio wcześniej. KL IAESTE AGH nie odpowiada za brak możliwości uczestnictwa w egzaminie.'), Faq.new(question: 'W jakich terminach jest egzamin z języka i do kiedy trzeba się zapisać na konkretny termin?', answer: '<p>
  Jeżeli została dokonana opłata za egzamin, to po zalogowaniu w systemie SOSO w zakładce &quot;Zapisy na egzamin&quot; będą podane terminy i możliwość ich wyboru. Proszę zastosować się do wyznaczonych deadline&rsquo;&oacute;w.</p>'),
      Faq.new(question: 'Jak wygląda egzamin językowy, na co zwracać uwagę w części pisemnej i ustnej?', answer: 'Poziom jest porównywalny z egzaminem językowym na AGH, sprawdza praktyczne umiejętności użycia języka.'), Faq.new(question: 'Kiedy mniej więcej można spodziewać się wyników z egzaminu?', answer: '<p>
  Wyniki podane są zaraz po otrzymaniu ich od szkoły językowej.</p>'),
      Faq.new(question: 'Czy studiując na AGH, lecz nie będąc w IAESTE, mam w ogóle szansę na wyjazd na praktykę?', answer: '<p>
  Tak, jak najbardziej! O uzyskanie możliwości wyjechania na swoją wymarzoną praktykę może starać się każdy. Działanie w KL IAESTE AGH Krak&oacute;w nie jest wyznacznikiem otrzymania oferty.</p>'),
      Faq.new(question: 'Dlaczego członkowie IAESTE mają większe szanse na wyjazd niż zwykli studenci?', answer: '<p>
  Nie jest to powiedziane. Wszystko zależy ile dana osoba działająca w naszym KL-u otrzymała punkt&oacute;w za swoją działalność. Maksymalna ilość punkt&oacute;w, jaką każdy członek naszej organizacji może otrzymać za działalność w IAESTE, to 30 punkt&oacute;w. Należy jednak wspomnieć, iż taką ilość punkt&oacute;w dostają osoby, kt&oacute;re wybitnie przez ostatni rok działały, odznaczyły się ogromnym wkładem w działalność IAESTE (np. koordynowały Targi Pracy, Międzywydziałowe Igrzyska Studenckie, Konferencja Krajowa IAESTE, IAESTE Central European Meeting, International Day, Case Week, Targi Organizacji Studenckich, IAESTE Day, itp. (do 30 pkt.), organizowały rekrutację, egzaminy językowe, pracę biura, pojawiały się na spotkaniach krajowego IAESTE, zebraniach KL IAESTE AGH) oraz kierownicy grup, czy członkowie zarządu, czyli osoby w pełni na bonus punktowy w rankingu zasługujące.<br />
  <br />
  Jest także możliwość otrzymania dodatkowych punkt&oacute;w za działanie w tzw. &ldquo;Akcji Lato&rdquo; (do 20 pkt.) oraz Akcji Zbierania Ofert Praktyk (ilość punkt&oacute;w uzależniona od konkretnej oferty i podana w regulaminie kwalifikacji na praktykę).<br />
  <br />
  Dlatego bez obaw Drogi Studencie może się okazać, że ilość punkt&oacute;w, kt&oacute;rą otrzyma działacz IAESTE jesteś w stanie nadrobić swoją średnią ocen, czy też wynikiem egzaminu językowego.<br />
  <br />
  Należy r&oacute;wnież pamiętać iż członkowie IAESTE na takich samych zasadach zostają kwalifikowani do rankingu, brana jest pod uwagę ich średnia ocen, wynik egzaminu językowego &ndash; w tej kwestii nikt nie ma taryfy ulgowej .<br />
  <br />
  Poza tym możesz pom&oacute;c nam przy eventach i także otrzymać punkty :)</p>'),
      Faq.new(question: 'Ile ofert praktyk uzyskuje AGH?', answer: '<p>
  Ilość ofert praktyk, jakie napłyną do naszego KL&rsquo;u zależna jest od tego, ile ofert praktyk dla zagranicznych student&oacute;w jesteśmy w stanie zorganizować w Krakowie. Działa to na zasadzie ilościowej wymiany. Z roku na rok praktyk przybywa, a w skali kraju krakowski Komitet zajmuje drugie miejsce pod względem pozyskanych ofert praktyk.</p>'),
      Faq.new(question: 'Ile punktów mogę zdobyć w rankingu?', answer: '<p>
  Na ilość uzyskanych punkt&oacute;w składają się:</p>
<ul>
  <li>
    średnia ocen (max 5.0 x 10) np. mając średnią 3,9, otrzymujesz 39 punkt&oacute;w.</li>
  <li>
    wynik egzaminu (max. 5.0 x 5) np. otrzymałeś 4 z egzaminu, więc odpowiadająca tej ocenie ilość punkt&oacute;w to 20.</li>
  <li>
    dodatkowe punkty za działalność w IAESTE, pomoc w Akcji Lato i Akcji Pozyskiwania Ofert Praktyk.</li>
</ul>'),
      Faq.new(question: 'Studiuję politologię, iberystykę, filozofię wschodu, etc… Czy mam szansę na wyjazd?', answer: '<p>
  Jeśli nie jesteś studentem kierunku technicznego, inżynierskiego (otrzymasz tytuł inżyniera) lub ewentualnie związanym z ekonomią- niestety nie. IAESTE zajmuje się tylko praktykami technicznymi.</p>'),
      Faq.new(question: 'Czy mogę wyjechać na praktykę, jeśli studiuję w innym mieście?', answer: '<p>
  Niestety nie. Sprawdź, czy nie ma KL IAESTE na Twojej uczelni, jeśli nie pomyśl o założeniu takiego komitetu :)</p>'),
      Faq.new(question: 'Minimalna średnia ocen wymagana do aplikowania na praktyki wynosi 3,8. Po wypełnieniu arkusza ocenami okazało się, że moja średnia jest niższa. Czy dyskwalifikuje mnie to z rekrutacji?', answer: '<p>
  Wymagana jest średnia 3.8. Możesz jednak napisać podanie do Zarządu KL IAESTE AGH o akceptację Twojej średniej ocen, w kt&oacute;rym zaznaczysz, dlaczego zależy Ci na wyjeździe. Pomyśl nad argumentacją- być może Twoje podanie zostanie rozpatrzone pozytywnie :)</p>'),
      Faq.new(question: 'Mam warunek z matematyki z 2 roku, którego waga, to 5 punktów ECTS. Teraz jestem na 3 roku. Czy ja również mogę wyjechać?', answer: '<p>
  Tak. Pamiętaj, że oceny do rankingu brane są z poprzedniego roku studi&oacute;w. Do SOSO wpisujesz ocenę 2.0 i 5 pkt. ECTS z przedmiotu Matematyka, nawet jeśli w Indeksie nie masz wpisanej żadnej oceny. Średnia ocen będzie średnią ważoną uwzględniającą wszystkie punkty ECTS (łącznie z tymi 5 pkt. z przedmiotu niezaliczonego).</p>'),
      Faq.new(question: 'Mam warunek z Fizyki z 1 roku, którą zdałem na ocenę 3.0 na 2 roku studiów. Waga to 4 punktów ECTS. Teraz jestem na 3 roku. Czy ja również mogę wyjechać?', answer: '<p>
  Tak. Pamiętaj, że oceny do rankingu brane są z poprzedniego roku studi&oacute;w. Dlatego do SOSO wpisujesz ocenę 3.0 i 4 pkt. ECTS z przedmiotu Fizyka. Średnia ocen będzie średnią ważoną uwzględniające wszystkie dodatkowe punkty ECTS.</p>'),
      Faq.new(question: 'Biorę udział w procesie rekrutacji na praktyki organizowane przez Waszą organizację. Jednak wyjeżdżam za granicę w ramach programu Erasmus i nie będę mógł osobiście uczestniczyć w rekrutacji. Czy w moim imieniu będzie to mógł robić kolega? Jeśli tak, to czy jest jakiś formularz upoważniający go do przekazywania Wam moich dokumentów?', answer: '<p>
  Tak, w Twoim imieniu może zrobić to kolega. Wz&oacute;r formularza znajduje się na naszej stronie internetowej: <a href="http://www.iaeste.agh.edu.pl/">www.iaeste.agh.edu.pl.</a></p>'), Faq.new(question: 'Czy jeżeli w ubiegłym roku brałem udział w dodatkowych zajęciach (fakultet z projektowania w programie Inventor), to czy też uwzględniam tą ocenę do średniej?', answer: '<p>
  Jeżeli brałeś przedmioty dodatkowe i widnieją one w Twoim Indeksie, jako zdawane w roku studi&oacute;w, z kt&oacute;rego bierzemy oceny, to traktujesz go jako normalny przedmiot. Średnia ocen będzie średnią ważoną uwzględniające wszystkie dodatkowe punkty ECTS.</p>'),
      Faq.new(question: 'Studiuję na 2 kierunkach studiów. Czy do systemu wpisuje tylko przedmioty z jednego kierunku, czy wszystkie przedmioty (z 2 kierunków) jakie realizowałem w poprzednim roku akademickim?', answer: '<p>
  Oceny wpisuje się tylko z jednego kierunku studi&oacute;w. Najlepiej wpisać te, z kt&oacute;rych wyszła wyższa średnia ocen. Natomiast w wyborze specjalności (tych 3 po angielsku) możesz zaznaczać te związane z obydwoma kierunkami studi&oacute;w. A na przyszłość- Nie zapomnij pochwalić się swoimi kierukami w CV i Liście motywacyjnym :)</p>'),
      Faq.new(question: 'W poprzednich latach do rankingu wpisywaliśmy wszystkie oceny z ćwiczeń i egzaminów, bez ocen końcowych. W tym roku, w indeksach dostępne są tylko końcowe. Jakie oceny wpisujemy?', answer: '<p>
  W tym roku bierzemy do rankingu jedynie oceny końcowe. Przedstawione to zostało na prezentacji i w regulaminie kwalifikacji dostępnym do ściągnięcia w SOSO i na stronie KL IAESTE AGH.</p>'),
      Faq.new(question: 'Gdzie mogę znaleźć informacje o firmach, które współpracowały do tej pory z IAESTE?', answer: '<p>
  Taka informacja dostępna jest na naszej stronie w zakładce &quot;Dla wyjeżdżających&quot;. Jest tzw. Annual Review.</p>')
  ]
  faqs.each do |faq|
    faq.published = true
    faq.committee_id = committee_id
    faq.save
  end if Faq.count < faqs.size
end
